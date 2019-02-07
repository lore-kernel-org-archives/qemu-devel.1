Received: from eggs.gnu.org ([209.51.188.92]:55093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grk7S-0004x0-PW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grk7P-000338-OU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:53:34 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grk7G-0002uh-2v
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:53:27 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so18283121oth.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 05:53:11 -0800 (PST)
MIME-Version: 1.0
References: <1549545296-18903-1-git-send-email-thuth@redhat.com>
	<1549545296-18903-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1549545296-18903-2-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 13:52:59 +0000
Message-ID: <CAFEAcA8ROQPX5SXFOTEzpdmx+RQXbQTN_Cj3JcUHZ3RbSGwq=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-deprecated: Remove -virtioconsole
 and -no-frame for good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On Thu, 7 Feb 2019 at 13:15, Thomas Huth <thuth@redhat.com> wrote:
>
> The two sections have accidentally been added again during the
> merge of Paolo's and Gerd's trees.
>
> Fixes: 3e29da9fd81002a0c03041aaa26dea6d9dd9bd65
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-deprecated.texi | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 80b0702..90e5860 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -37,18 +37,6 @@ would automatically enable USB support on the machine type.
>  If using the new syntax, USB support must be explicitly
>  enabled via the ``-machine usb=on'' argument.
>
> -@subsection -virtioconsole (since 3.0.0)
> -
> -Option @option{-virtioconsole} has been replaced by
> -@option{-device virtconsole}.
> -
> -@subsection -no-frame (since 2.12.0)
> -
> -The @code{--no-frame} argument works with SDL 1.2 only. The other user
> -interfaces never implemented this in the first place. So this will be
> -removed together with SDL 1.2 support.
> ->>>>>>> remotes/bonzini/tags/for-upstream
> -
>  @subsection -clock (since 3.0.0)
>
>  The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
> --

This was a mismerge on my part -- particularly egregious since
I left the >>>>> conflict marker in...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

PS: do we have a document where we list the options that have
entirely gone away, so that when a user of QEMU 4.1 tries
"-virtioconsole" and it doesn't work they know what the replacement is ?

thanks
-- PMM
