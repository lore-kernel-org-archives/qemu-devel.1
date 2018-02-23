Received: from eggs.gnu.org ([2001:4830:134:3::10]:53967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ep9kQ-0007qi-Pd
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ep9kN-0005uR-Kx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:34:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ep9kN-0005tm-FK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:34:31 -0500
References: <1519372288-20791-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5009934-13c3-6e86-2618-9935837d3b8d@redhat.com>
Date: Fri, 23 Feb 2018 10:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <1519372288-20791-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/uri.c: add brackets to `if`
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

On 23.02.2018 08:51, Su Hang wrote:
> Add brackets that wrap `if`, `else`, `while` that hold single
> statements.
>=20
> In order to do this, I write a simple python regex script.
>=20
> Since then, all complaints rised by checkpatch.pl has been suppressed.
>=20
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  util/uri.c | 462 ++++++++++++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 291 insertions(+), 171 deletions(-)
>=20
> diff --git a/util/uri.c b/util/uri.c
> index 278e876ab8b1..48f7298787b1 100644
> --- a/util/uri.c
> +++ b/util/uri.c
> @@ -105,18 +105,18 @@ static void uri_clean(URI *uri);
>   */
> =20
>  #define IS_UNWISE(p)                                                  =
         \
> -      (((*(p) =3D=3D '{')) || ((*(p) =3D=3D '}')) || ((*(p) =3D=3D '|'=
)) ||                \
> -       ((*(p) =3D=3D '\\')) || ((*(p) =3D=3D '^')) || ((*(p) =3D=3D '[=
')) ||               \
> -       ((*(p) =3D=3D ']')) || ((*(p) =3D=3D '`')))
> +    (((*(p) =3D=3D '{')) || ((*(p) =3D=3D '}')) || ((*(p) =3D=3D '|'))=
 ||                  \
> +     ((*(p) =3D=3D '\\')) || ((*(p) =3D=3D '^')) || ((*(p) =3D=3D '[')=
) ||                 \
> +     ((*(p) =3D=3D ']')) || ((*(p) =3D=3D '`')))
>  /*
>   * reserved =3D ";" | "/" | "?" | ":" | "@" | "&" | "=3D" | "+" | "$" =
| "," |
>   *            "[" | "]"
>   */
> =20
>  #define IS_RESERVED(x) (((x) =3D=3D ';') || ((x) =3D=3D '/') || ((x) =3D=
=3D '?') ||        \
> -        ((x) =3D=3D ':') || ((x) =3D=3D '@') || ((x) =3D=3D '&') || ((=
x) =3D=3D '=3D') ||        \
> -        ((x) =3D=3D '+') || ((x) =3D=3D '$') || ((x) =3D=3D ',') || ((=
x) =3D=3D '[') ||        \
> -        ((x) =3D=3D ']'))
> +      ((x) =3D=3D ':') || ((x) =3D=3D '@') || ((x) =3D=3D '&') || ((x)=
 =3D=3D '=3D') ||          \
> +      ((x) =3D=3D '+') || ((x) =3D=3D '$') || ((x) =3D=3D ',') || ((x)=
 =3D=3D '[') ||          \
> +      ((x) =3D=3D ']'))

The above whitespace changes should ideally be done in the first patch in=
stead.

>  /*
>   * unreserved =3D alphanum | mark
> @@ -211,15 +211,17 @@ static int rfc3986_parse_scheme(URI *uri, const c=
har **str)
>  {
>      const char *cur;
> =20
> -    if (str =3D=3D NULL)
> +    if (str =3D=3D NULL) {
>          return -1;
> +    }
> =20
>      cur =3D *str;
> -    if (!ISA_ALPHA(cur))
> +    if (!ISA_ALPHA(cur)) {
>          return 2;
> +    }
>      cur++;
> -    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) ||
> -           (*cur =3D=3D '+') || (*cur =3D=3D '-') || (*cur =3D=3D '.')=
)
> +    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || (*cur =3D=3D '+') || (*=
cur =3D=3D '-') ||
> +           (*cur =3D=3D '.'))
>          cur++;

You've changed the while statement, but checkpatch.pl apparently does not
complain about missing curly braces here ... that's strange, I thought we=
'd
also wanted to enforce curly braces for while loops. Anyway, could you pl=
ease
add curly braces around the "*cur++;" here, too?

> @@ -1437,15 +1503,18 @@ done_cd:
>          /* string will overlap, do not use strcpy */
>          tmp =3D cur;
>          segp +=3D 3;
> -        while ((*tmp++ =3D *segp++) !=3D 0)
> +        while ((*tmp++ =3D *segp++) !=3D 0) {
>              ;
> +        }

A bikeshed-painting-friday question for everybody on qemu-devel:
Should there be a single semicolon inside curly braces in this case, or n=
ot?

>          /* If there are no previous segments, then keep going from her=
e.  */
>          segp =3D cur;
> -        while ((segp > path) && ((--segp)[0] =3D=3D '/'))
> +        while ((segp > path) && ((--segp)[0] =3D=3D '/')) {
>              ;

(dito)

> -        if (segp =3D=3D path)
> +        }
> +        if (segp =3D=3D path) {
>              continue;
> +        }
> =20
>          /* "segp" is pointing to the end of a previous segment; find i=
t's
>           * start.  We need to back up to the previous segment and star=
t
[...]
> @@ -1491,8 +1562,9 @@ done_cd:
>  static int is_hex(char c)
>  {
>      if (((c >=3D '0') && (c <=3D '9')) || ((c >=3D 'a') && (c <=3D 'f'=
)) ||
> -        ((c >=3D 'A') && (c <=3D 'F')))
> +        ((c >=3D 'A') && (c <=3D 'F'))) {
>          return 1;
> +    }
>      return 0;
>  }

Not related to your patch, but an idea for a future clean-up patch:
We've already got qemu_isxdigit(), so there is no real need for this
separate is_hex() function.

[...]
> @@ -2020,17 +2127,19 @@ char *uri_resolve_relative(const char *uri, con=
st char *base)
>           */
>          if (bptr[pos] !=3D ref->path[pos]) { /* check for trivial URI =
=3D=3D base */
>              for (; bptr[ix] !=3D 0; ix++) {
> -                if (bptr[ix] =3D=3D '/')
> +                if (bptr[ix] =3D=3D '/') {
>                      nbslash++;
> +                }
>              }
>          }
>          len =3D strlen(uptr) + 1;
>      }
> =20
>      if (nbslash =3D=3D 0) {
> -        if (uptr !=3D NULL)
> +        if (uptr !=3D NULL) {
>              /* exception characters from uri_to_string */
> -            val =3D uri_string_escape(uptr, "/;&=3D+$,");
> +        }
> +        val =3D uri_string_escape(uptr, "/;&=3D+$,");

That's a bug: uri_string_escape() should be within the curly braces inste=
ad.

By the way, found that one with the following trick: Compare the disassem=
blies
before and after you're changes:

 git checkout master
 make util/uri.o
 strip util/uri.o
 objdump -Drx util/uri.o > /tmp/uri-master.txt
 git checkout cleanupbranch
 make util/uri.o
 strip util/uri.o
 objdump -Drx util/uri.o > /tmp/uri-cleanup.txt
 diff -u /tmp/uri-*.txt

Since you're only doing coding style clean-up, there should not be
any diff in the resulting assembler code.

 Cheers,
  Thomas
