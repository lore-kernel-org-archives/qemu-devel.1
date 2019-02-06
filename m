Received: from eggs.gnu.org ([209.51.188.92]:48786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grRue-0003xU-EW
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grRud-00070x-FY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:27:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grRud-00070Y-AY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:27:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so8930428qtm.13
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 10:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-2-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Feb 2019 19:26:55 +0100
Message-ID: <CAMxuvayO536vfOhV5RSmy7zca=XzM2OdZZekH=HrqBA2vCF0dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/17] qapi: Belatedly document modular
 code generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> We generate code for built-ins and sub-modules into separate files
> since commit cdb6610ae42 and 252dc3105fc (v2.12.0).  Both commits
> neglected to update documentation.  Do that now.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/devel/qapi-code-gen.txt | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 87183d3a09..b91bde647c 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1113,6 +1113,19 @@ Example:
>
>  [Uninteresting stuff omitted...]
>
> +For a modular QAPI schema (see section Include directives), code for
> +each sub-module SUBDIR/SUBMODULE.json is actually generated into
> +
> +SUBDIR/$(prefix)qapi-types-SUBMODULE.h
> +SUBDIR/$(prefix)qapi-types-SUBMODULE.c
> +
> +If qapi-gen.py is run with option --builtins, additional files are
> +created:
> +
> +qapi-builtin-types.h - C types corresponding to built-in types
> +
> +qapi-builtin-types.c - Cleanup functions for the above C types
> +
>  =3D=3D=3D Code generated for visiting QAPI types =3D=3D=3D
>
>  These are the visitor functions used to walk through and convert
> @@ -1244,6 +1257,19 @@ Example:
>
>  [Uninteresting stuff omitted...]
>
> +For a modular QAPI schema (see section Include directives), code for
> +each sub-module SUBDIR/SUBMODULE.json is actually generated into
> +
> +SUBDIR/$(prefix)qapi-visit-SUBMODULE.h
> +SUBDIR/$(prefix)qapi-visit-SUBMODULE.c
> +
> +If qapi-gen.py is run with option --builtins, additional files are
> +created:
> +
> +qapi-builtin-visit.h - Visitor functions for built-in types
> +
> +qapi-builtin-visit.c - Declarations for these visitor functions
> +
>  =3D=3D=3D Code generated for commands =3D=3D=3D
>
>  These are the marshaling/dispatch functions for the commands defined
> @@ -1342,6 +1368,12 @@ Example:
>
>  [Uninteresting stuff omitted...]
>
> +For a modular QAPI schema (see section Include directives), code for
> +each sub-module SUBDIR/SUBMODULE.json is actually generated into
> +
> +SUBDIR/$(prefix)qapi-commands-SUBMODULE.h
> +SUBDIR/$(prefix)qapi-commands-SUBMODULE.c
> +
>  =3D=3D=3D Code generated for events =3D=3D=3D
>
>  This is the code related to events defined in the schema, providing
> @@ -1402,6 +1434,12 @@ Example:
>
>  [Uninteresting stuff omitted...]
>
> +For a modular QAPI schema (see section Include directives), code for
> +each sub-module SUBDIR/SUBMODULE.json is actually generated into
> +
> +SUBDIR/$(prefix)qapi-events-SUBMODULE.h
> +SUBDIR/$(prefix)qapi-events-SUBMODULE.c
> +
>  =3D=3D=3D Code generated for introspection =3D=3D=3D
>
>  The following files are created:
> --
> 2.17.2
>
