Received: from eggs.gnu.org ([2001:4830:134:3::10]:47646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziKl-0001ym-1B
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziKj-0004O9-Pl
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:59:27 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dziKj-0004Nt-Kh
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:59:25 -0400
Received: by mail-oi0-x242.google.com with SMTP id h200so670181oib.1
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 04:59:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-19-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-19-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 13:59:23 +0200
Message-ID: <CAJ+F1CLv6C-Ov1OfRucjrNHC7Wh4KsLTT9eVJP0H3jDVBGYw8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 18/32] docs/devel/qapi-code-gen.txt:
 Rewrite section on schema syntax
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
> Section "QMP/Guest agent schema" is one big paragraph, encumbered with
> more detail than necessary.  It also claims JSON null isn't supported,
> which is untrue since commit e53188a, v2.4.0.  Rewrite it.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/devel/qapi-code-gen.txt | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index f5b7659caf..3186c36460 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -25,24 +25,24 @@ how the schemas, scripts, and resulting code are used=
.
>
>  =3D=3D QMP/Guest agent schema =3D=3D
>
> -A QAPI schema file is designed to be loosely based on JSON
> -(http://www.ietf.org/rfc/rfc7159.txt) with changes for quoting style
> -and the use of comments; a QAPI schema file is then parsed by a python
> -code generation program.  A valid QAPI schema consists of a series of
> -top-level expressions, with no commas between them.  Where
> -dictionaries (JSON objects) are used, they are parsed as python
> -OrderedDicts so that ordering is preserved (for predictable layout of
> -generated C structs and parameter lists).  Ordering doesn't matter
> -between top-level expressions or the keys within an expression, but
> -does matter within dictionary values for 'data' and 'returns' members
> -of a single expression.  QAPI schema input is written using 'single
> -quotes' instead of JSON's "double quotes" (in contrast, Client JSON
> -Protocol uses no comments, and while input accepts 'single quotes' as
> -an extension, output is strict JSON using only "double quotes").  As
> -in JSON, trailing commas are not permitted in arrays or dictionaries.
> -Input must be ASCII (although QMP supports full Unicode strings, the
> -QAPI parser does not).  At present, there is no place where a QAPI
> -schema requires the use of JSON numbers or null.
> +Schema syntax is based on JSON (RFC 7159), with the following
> +differences:
> +
> +* Comments (see below)
> +
> +* No JSON numbers
> +
> +* Strings use 'single quotes' instead of "double quotes"
> +
> +* The input character set is plain ASCII
> +
> +  Unicode characters need to be escaped.  In contrast, the Client JSON
> +  Protocol uses UTF-8.
> +
> +A QAPI schema consists of a sequence of JSON values (top-level
> +expressions), with no commas between them.  The order of top-level
> +expressions doesn't matter.  The order of keys in JSON objects is
> +generally relevant.
>
>
>  =3D=3D=3D Comments =3D=3D=3D
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
