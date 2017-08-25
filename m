Received: from eggs.gnu.org ([2001:4830:134:3::10]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8Xy-0007QR-6i
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8Xv-0001Y2-1M
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:56:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl8Xu-0001Xa-Qx
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5B9AC058EB4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 06:56:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-8-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 08:56:42 +0200
In-Reply-To: <20170824103350.16400-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 24 Aug 2017 12:33:43 +0200")
Message-ID: <878ti816fp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/14] qlit: make qlit_equal_qobject() take
 const arguments
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 2 +-
>  qobject/qlit.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index 2e22d0f73c..8882016199 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -44,6 +44,6 @@ struct QLitDictEntry {
>  #define QLIT_QLIST(val) \
>      { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>=20=20
> -bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
> +bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
>=20=20
>  #endif /* QLIT_H_ */
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index a2975bef3f..ae2787ef35 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -41,7 +41,7 @@ static void compare_helper(QObject *obj, void *opaque)
>          qlit_equal_qobject(&helper->objs[helper->index++], obj);
>  }
>=20=20
> -bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
> +bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
>  {
>      int64_t val;

Could be squashed into the previous patch, but since you got the two
split, let's leave them split and save us the trouble of wording the
squash's commit message.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
