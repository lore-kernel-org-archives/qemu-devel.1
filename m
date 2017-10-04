Received: from eggs.gnu.org ([2001:4830:134:3::10]:44111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgid-0006mi-4x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgic-00046X-9p
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:15:59 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:48541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgic-00046Q-5r
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:15:58 -0400
Received: by mail-qt0-x231.google.com with SMTP id d13so17464981qta.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:15:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-4-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:15:57 +0200
Message-ID: <CAJ+F1CJhfp-OLnuXSgu0yNcADqo+kT=ReMSG7uy+gzY1PiamRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] qapi: Eliminate
 QAPISchemaParser.__init__()'s local fname
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
>  scripts/qapi.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index dc92bca620..6c8001e96d 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -261,8 +261,7 @@ class QAPISchemaParser(object):
>
>      def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
>          abs_fname =3D os.path.abspath(fp.name)
> -        fname =3D fp.name
> -        self.fname =3D fname
> +        self.fname =3D fp.name
>          previously_included.append(abs_fname)
>          self.incl_info =3D incl_info
>          self.src =3D fp.read()
> @@ -277,7 +276,7 @@ class QAPISchemaParser(object):
>          self.accept()
>
>          while self.tok is not None:
> -            info =3D {'file': fname, 'line': self.line,
> +            info =3D {'file': self.fname, 'line': self.line,
>                      'parent': self.incl_info}
>              if self.tok =3D=3D '#':
>                  self.reject_expr_doc()
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
