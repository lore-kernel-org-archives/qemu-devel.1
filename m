Received: from eggs.gnu.org ([2001:4830:134:3::10]:55662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxPy-0006tH-8D
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxPu-0001h9-RX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cpxPu-0001gQ-Ma
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:32:10 -0400
Date: Mon, 20 Mar 2017 09:32:08 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1870195462.9856771.1490016728266.JavaMail.zimbra@redhat.com>
In-Reply-To: <1490015515-25851-7-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-7-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 6/6] qapi2texi: Fix translation of
 *strong* and _emphasized_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre lureau <marcandre.lureau@redhat.com>, eblake@redhat.com, mdroth@linux.vnet.ibm.com



----- Original Message -----
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

weird this disparity went so far unnoticed

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi2texi.py            | 4 ++--
>  tests/qapi-schema/doc-good.texi | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 5c4db78..9e01500 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -35,12 +35,12 @@ EXAMPLE_FMT =3D """@example
> =20
>  def subst_strong(doc):
>      """Replaces *foo* by @strong{foo}"""
> -    return re.sub(r'\*([^*\n]+)\*', r'@emph{\1}', doc)
> +    return re.sub(r'\*([^*\n]+)\*', r'@strong{\1}', doc)
> =20
> =20
>  def subst_emph(doc):
>      """Replaces _foo_ by @emph{foo}"""
> -    return re.sub(r'\b_([^_\n]+)_\b', r' @emph{\1} ', doc)
> +    return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
> =20
> =20
>  def subst_vars(doc):
> diff --git a/tests/qapi-schema/doc-good.texi
> b/tests/qapi-schema/doc-good.texi
> index 1160aaf..c410626 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -2,7 +2,7 @@
> =20
>  @subsection Subsection
> =20
> -@emph{strong}  @emph{with emphasis}
> +@strong{strong} @emph{with emphasis}
>  @code{var} @{in braces@}
>  @itemize @bullet
>  @item
> @@ -67,7 +67,7 @@ Example:
>  Examples:
>  @itemize @minus
>  @item
> -@emph{verbatim}
> +@strong{verbatim}
>  @item
>  @{braces@}
>  @end itemize
> @@ -76,12 +76,12 @@ Examples:
> =20
>  @deftp {Enum} Enum
> =20
> -@subsection Produces @emph{invalid} texinfo
> +@subsection Produces @strong{invalid} texinfo
> =20
>  @b{Values:}
>  @table @asis
>  @item @code{one}
> -The  @emph{one}  @{and only@}
> +The @emph{one} @{and only@}
>  @item @code{two}
>  Not documented
>  @end table
> --
> 2.7.4
>=20
>=20
