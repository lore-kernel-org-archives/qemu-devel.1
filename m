Received: from eggs.gnu.org ([2001:4830:134:3::10]:51160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzh22-00052z-Ok
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzh21-0007uT-Sc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:36:02 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzh21-0007tK-Ow
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:36:01 -0400
Received: by mail-oi0-x243.google.com with SMTP id n82so11598764oig.3
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:36:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-12-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-12-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:35:59 +0200
Message-ID: <CAJ+F1CLMMLgMCUpNBhf=+puoJN2XF1EAoyu9-+0VyiYvKPTpAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/11] qapi2texi: De-duplicate code to add
 blank line before symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, Oct 2, 2017 at 4:13 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi2texi.py | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 58add26c11..92e2af2cd6 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -206,8 +206,6 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
>
>      def visit_enum_type(self, name, info, values, prefix):
>          doc =3D self.cur_doc
> -        if self.out:
> -            self.out +=3D '\n'
>          self.out +=3D TYPE_FMT(type=3D'Enum',
>                               name=3Ddoc.symbol,
>                               body=3Dtexi_entity(doc, 'Values',
> @@ -217,16 +215,12 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
>          doc =3D self.cur_doc
>          if base and base.is_implicit():
>              base =3D None
> -        if self.out:
> -            self.out +=3D '\n'
>          self.out +=3D TYPE_FMT(type=3D'Object',
>                               name=3Ddoc.symbol,
>                               body=3Dtexi_entity(doc, 'Members', base, va=
riants))
>
>      def visit_alternate_type(self, name, info, variants):
>          doc =3D self.cur_doc
> -        if self.out:
> -            self.out +=3D '\n'
>          self.out +=3D TYPE_FMT(type=3D'Alternate',
>                               name=3Ddoc.symbol,
>                               body=3Dtexi_entity(doc, 'Members'))
> @@ -234,8 +228,6 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
>      def visit_command(self, name, info, arg_type, ret_type,
>                        gen, success_response, boxed):
>          doc =3D self.cur_doc
> -        if self.out:
> -            self.out +=3D '\n'
>          if boxed:
>              body =3D texi_body(doc)
>              body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
> @@ -249,13 +241,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
>
>      def visit_event(self, name, info, arg_type, boxed):
>          doc =3D self.cur_doc
> -        if self.out:
> -            self.out +=3D '\n'
>          self.out +=3D MSG_FMT(type=3D'Event',
>                              name=3Ddoc.symbol,
>                              body=3Dtexi_entity(doc, 'Arguments'))
>
>      def symbol(self, doc, entity):
> +        if self.out:
> +            self.out +=3D '\n'
>          self.cur_doc =3D doc
>          entity.visit(self)
>          self.cur_doc =3D None
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
