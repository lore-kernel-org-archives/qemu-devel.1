Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYHUa-0003GR-7f
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYHUZ-0005Sf-7u
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:19:56 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYHUZ-0005SH-3Y
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:19:55 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 35so257369450uak.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 11:19:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130181634.13934-2-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
	<20170130181634.13934-2-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 19:19:34 +0000
Message-ID: <CAFEAcA_V-whern5JBdwHJXz3=q-qKpxNXQU3asFEoGOHB1DZNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 01/16] softfloat: define 680x0 specific
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 30 January 2017 at 18:16, Laurent Vivier <laurent@vivier.eu> wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> +#elif defined(TARGET_M68K)
> +static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
> +                   flag aIsLargerSignificand)
> +{
> +    /* If either operand, but not both operands, of an operation is a
> +     * nonsignaling NAN, then that NAN is returned as the result. If both
> +     * operands are nonsignaling NANs, then the destination operand
> +     * nonsignaling NAN is returned as the result.
> +     */
> +
> +    if (aIsSNaN) {
> +        return 0;
> +    } else if (bIsSNaN) {
> +        return 1;
> +    } else if (bIsQNaN) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}

This function doesn't seem to quite do what the comment says (in
particular the comment doesn't say anything about handling
of signaling NaNs but the code makes decisions based on
which inputs are signaling).

PS: NaN is conventionally capitalized with a lowercase 'a'.

thanks
-- PMM
