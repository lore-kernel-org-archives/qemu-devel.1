Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgpR-00042Q-WD
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgpQ-0002iT-Sb
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:23:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgpQ-0002hu-Lz
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:23:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id s145so6794449oie.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:23:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-6-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-6-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:22:58 +0200
Message-ID: <CAJ+F1CLBHFpVj0j99LYKDjq4GZd5TM+mHfqY4B9uFG5=u1EUhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] tests/qapi-schema/doc-bad-section:
 New, factored out of doc-good
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
> A negative test case crept into doc-good.json: invalid use of section
> markup we currently fail to reject.  Move this into its own
> doc-bad-section.json.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/Makefile.include                 |  3 ++-
>  tests/qapi-schema/doc-bad-section.err  |  0
>  tests/qapi-schema/doc-bad-section.exit |  1 +
>  tests/qapi-schema/doc-bad-section.json | 11 +++++++++++
>  tests/qapi-schema/doc-bad-section.out  | 13 +++++++++++++
>  tests/qapi-schema/doc-good.json        |  1 -
>  tests/qapi-schema/doc-good.out         |  2 +-
>  tests/qapi-schema/doc-good.texi        |  2 +-
>  8 files changed, 29 insertions(+), 4 deletions(-)
>  create mode 100644 tests/qapi-schema/doc-bad-section.err
>  create mode 100644 tests/qapi-schema/doc-bad-section.exit
>  create mode 100644 tests/qapi-schema/doc-bad-section.json
>  create mode 100644 tests/qapi-schema/doc-bad-section.out
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index abc6707ef2..de4a713c25 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -412,6 +412,7 @@ qapi-schema +=3D command-int.json
>  qapi-schema +=3D comments.json
>  qapi-schema +=3D doc-bad-alternate-member.json
>  qapi-schema +=3D doc-bad-command-arg.json
> +qapi-schema +=3D doc-bad-section.json
>  qapi-schema +=3D doc-bad-symbol.json
>  qapi-schema +=3D doc-bad-union-member.json
>  qapi-schema +=3D doc-before-include.json
> @@ -429,10 +430,10 @@ qapi-schema +=3D doc-invalid-end2.json
>  qapi-schema +=3D doc-invalid-return.json
>  qapi-schema +=3D doc-invalid-section.json
>  qapi-schema +=3D doc-invalid-start.json
> -qapi-schema +=3D doc-missing.json
>  qapi-schema +=3D doc-missing-colon.json
>  qapi-schema +=3D doc-missing-expr.json
>  qapi-schema +=3D doc-missing-space.json
> +qapi-schema +=3D doc-missing.json
>  qapi-schema +=3D doc-no-symbol.json
>  qapi-schema +=3D double-data.json
>  qapi-schema +=3D double-type.json
> diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/do=
c-bad-section.err
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/doc-bad-section.exit b/tests/qapi-schema/d=
oc-bad-section.exit
> new file mode 100644
> index 0000000000..573541ac97
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-section.exit
> @@ -0,0 +1 @@
> +0
> diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/d=
oc-bad-section.json
> new file mode 100644
> index 0000000000..560df4b087
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-section.json
> @@ -0,0 +1,11 @@
> +# =3D section within an expression comment
> +# BUG: not rejected
> +
> +##
> +# @Enum:
> +# =3D=3D Produces *invalid* texinfo
> +# @one: The _one_ {and only}
> +#
> +# @two is undocumented
> +##
> +{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
> diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
> new file mode 100644
> index 0000000000..6fce84dd34
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-section.out
> @@ -0,0 +1,13 @@
> +enum Enum ['one', 'two']
> +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
> +    prefix QTYPE
> +object q_empty
> +doc symbol=3DEnum
> +    body=3D
> +=3D=3D Produces *invalid* texinfo
> +    arg=3Done
> +The _one_ {and only}
> +    arg=3Dtwo
> +
> +    section=3D
> +@two is undocumented
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
> index cfdc0a8a81..97ab4625ff 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -51,7 +51,6 @@
>
>  ##
>  # @Enum:
> -# =3D=3D Produces *invalid* texinfo
>  # @one: The _one_ {and only}
>  #
>  # @two is undocumented
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index 63ca25a8b9..c55e394e8a 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -77,7 +77,7 @@ Examples:
>  - {braces}
>  doc symbol=3DEnum
>      body=3D
> -=3D=3D Produces *invalid* texinfo
> +
>      arg=3Done
>  The _one_ {and only}
>      arg=3Dtwo
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
> index c410626e4a..a331349756 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -76,7 +76,7 @@ Examples:
>
>  @deftp {Enum} Enum
>
> -@subsection Produces @strong{invalid} texinfo
> +
>
>  @b{Values:}
>  @table @asis
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
