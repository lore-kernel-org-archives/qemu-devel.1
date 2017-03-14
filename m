Received: from eggs.gnu.org ([2001:4830:134:3::10]:46250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhrJ-0006oZ-Um
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhrI-00021E-Tf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:31:09 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnhrI-00020S-IM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:31:08 -0400
Received: by mail-lf0-x244.google.com with SMTP id r36so13572022lfi.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-5-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:30:56 +0000
Message-ID: <CAJ+F1CKjmef7WT3H-b94V3u9Mc5MY-yUA+5Oqgj5tkcV0WGLtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 04/47] docs/qapi-code-gen.txt: Drop
 confusing reference to 'gen'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Mon, Mar 13, 2017 at 10:20 AM Markus Armbruster <armbru@redhat.com>
wrote:

> Section "Commands" qualifies its rules on permitted argument and
> return types "with one exception noted below when 'gen' is used".  The
> note went away in commit 2d21291.  Clean up the dangling references.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/qapi-code-gen.txt | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
> index 88de5c7..d9c1f91 100644
> --- a/docs/qapi-code-gen.txt
> +++ b/docs/qapi-code-gen.txt
> @@ -555,22 +555,20 @@ The 'data' argument maps to the "arguments"
> dictionary passed in as
>  part of a Client JSON Protocol command.  The 'data' member is optional
>  and defaults to {} (an empty dictionary).  If present, it must be the
>  string name of a complex type, or a dictionary that declares an
> -anonymous type with the same semantics as a 'struct' expression, with
> -one exception noted below when 'gen' is used.
> +anonymous type with the same semantics as a 'struct' expression.
>
>  The 'returns' member describes what will appear in the "return" member
>  of a Client JSON Protocol reply on successful completion of a command.
>  The member is optional from the command declaration; if absent, the
>  "return" member will be an empty dictionary.  If 'returns' is present,
>  it must be the string name of a complex or built-in type, a
> -one-element array containing the name of a complex or built-in type,
> -with one exception noted below when 'gen' is used.  Although it is
> -permitted to have the 'returns' member name a built-in type or an
> -array of built-in types, any command that does this cannot be extended
> -to return additional information in the future; thus, new commands
> -should strongly consider returning a dictionary-based type or an array
> -of dictionaries, even if the dictionary only contains one member at the
> -present.
> +one-element array containing the name of a complex or built-in type.
> +Although it is permitted to have the 'returns' member name a built-in
> +type or an array of built-in types, any command that does this cannot
> +be extended to return additional information in the future; thus, new
> +commands should strongly consider returning a dictionary-based type or
> +an array of dictionaries, even if the dictionary only contains one
> +member at the present.
>
>  All commands in Client JSON Protocol use a dictionary to report
>  failure, with no way to specify that in QAPI.  Where the error return
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
