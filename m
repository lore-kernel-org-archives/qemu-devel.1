Received: from eggs.gnu.org ([2001:4830:134:3::10]:58533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dn1fi-0007m2-O4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dn1fd-0001ma-KJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dn1fd-0001lS-EP
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:00:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C326B5A1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:00:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-5-marcandre.lureau@redhat.com>
Date: Wed, 30 Aug 2017 14:00:03 +0200
In-Reply-To: <20170825105913.4060-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 25 Aug 2017 12:59:03 +0200")
Message-ID: <87val5gta4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/14] qlit: remove compound literals
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

> They are not considered constant expressions in C, producing an error
> when compiling a const QLit.

A const QLit?  Do you mean a non-const one?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index a4ad91321b..f1d6eed317 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -36,13 +36,13 @@ struct QLitDictEntry {
>  };
>=20=20
>  #define QLIT_QNUM(val) \
> -    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
> +    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
>  #define QLIT_QSTR(val) \
> -    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
> +    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
>  #define QLIT_QDICT(val) \
> -    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
> +    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
>  #define QLIT_QLIST(val) \
> -    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
> +    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>=20=20
>  int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
