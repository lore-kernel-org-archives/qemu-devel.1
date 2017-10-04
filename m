Received: from eggs.gnu.org ([2001:4830:134:3::10]:47185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgrO-0005B7-GI
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgrN-0004fj-Mr
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:25:02 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgrN-0004eW-JA
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:25:01 -0400
Received: by mail-oi0-x242.google.com with SMTP id s145so6797036oie.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:25:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-7-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-7-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:24:59 +0200
Message-ID: <CAJ+F1CKsqdHKuHNJqVhc1qdRWSrxp37WbY_DOxwk6F8ne=SgMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] qapi2texi: Clean up texi_sections()
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
> Repurposing the function parameter doc for stepping through
> doc.sections.__str__() is not nice.  Use new variable @text instead.
>
> While there, eliminate variables name and func.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi2texi.py | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index a317526e51..f876d9a174 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -180,16 +180,14 @@ def texi_sections(doc):
>      """Format additional sections following arguments"""
>      body =3D ''
>      for section in doc.sections:
> -        name, doc =3D (section.name, str(section))
> -        func =3D texi_format
> -        if name.startswith('Example'):
> -            func =3D texi_example
> -
> -        if name:
> +        if section.name:
>              # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
> -            body +=3D '\n\n@b{%s:}\n' % name
> -
> -        body +=3D func(doc)
> +            body +=3D '\n\n@b{%s:}\n' % section.name
> +        text =3D str(section)
> +        if section.name.startswith('Example'):
> +            body +=3D texi_example(text)
> +        else:
> +            body +=3D texi_format(text)
>      return body
>
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
