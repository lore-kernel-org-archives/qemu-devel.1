Received: from eggs.gnu.org ([2001:4830:134:3::10]:53995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8Dd-0008F8-1v
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8DX-0008RC-09
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl8DW-0008QL-QO
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E9F381DFB
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 06:35:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-6-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 08:35:38 +0200
In-Reply-To: <20170824103350.16400-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 24 Aug 2017 12:33:41 +0200")
Message-ID: <87r2w02lz9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/14] qlit: rename compare_litqobj_to_qobj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Use qlit_ prefix.

Let's spell it out:=20

    qlit: rename compare_litqobj_to_qobj() to qlit_equal_qobject()

By the way, not only is your name shorter, it's also more precise:
"compare" suggests -1, 0, +1 for less than, equal and greater than,
equal suggests non-zero for equal, zero for unequal.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h |  2 +-
>  qobject/qlit.c          |  6 +++---
>  tests/check-qjson.c     | 14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index 1e9696988a..e299e8fab0 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -44,6 +44,6 @@ struct QLitDictEntry {
>  #define QLIT_QLIST(val) \
>      { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>=20=20
> -int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
> +int qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
>=20=20
>  #endif /* QLIT_H_ */

Let's use this opportunity to change the return value to bool.

With those changes:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
