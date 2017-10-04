Received: from eggs.gnu.org ([2001:4830:134:3::10]:48044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziLh-0002mG-24
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziLa-0005AF-Mc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:00:24 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:45300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dziLa-00059k-F4
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:00:18 -0400
Received: by mail-oi0-x22a.google.com with SMTP id f3so19144631oia.2
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 05:00:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-17-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-17-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 14:00:16 +0200
Message-ID: <CAJ+F1CKtPHPrAXvPiN00-A5jihVNxskkTDUH0B+WcVFcmMT5rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 16/32] qapi: Factor out
 _make_implicit_wrapper_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 248d650858..4871eb7740 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1552,6 +1552,11 @@ class QAPISchema(object):
>                                                    members, None))
>          return name
>
> +    def _make_implicit_wrapper_type(self, typ, info):
> +        return self._make_implicit_object_type(
> +            typ, info, None, 'wrapper',
> +            [self._make_member('data', typ, info)])
> +
>      def _def_enum_type(self, expr, info, doc):
>          name =3D expr['enum']
>          data =3D expr['data']
> @@ -1588,8 +1593,7 @@ class QAPISchema(object):
>          if isinstance(typ, list):
>              assert len(typ) =3D=3D 1
>              typ =3D self._make_array_type(typ[0], info)
> -        typ =3D self._make_implicit_object_type(
> -            typ, info, None, 'wrapper', [self._make_member('data', typ, =
info)])
> +        typ =3D self._make_implicit_wrapper_type(typ, info)
>          return QAPISchemaObjectTypeVariant(case, typ)
>
>      def _def_union_type(self, expr, info, doc):
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
