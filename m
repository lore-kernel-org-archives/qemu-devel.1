Received: from eggs.gnu.org ([2001:4830:134:3::10]:46337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e26j0-0000TY-8C
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e26iv-0000pi-76
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:26:22 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:54464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e26iv-0000p3-0s
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:26:17 -0400
Received: by mail-pf0-x234.google.com with SMTP id m28so346948pfi.11
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 19:26:16 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aae6c2ea-a4ac-bf51-17c0-c49cc4151eab@linaro.org>
Date: Tue, 10 Oct 2017 19:26:13 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] target-arm: Simplify
 insn_crosses_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 10/09/2017 06:48 AM, Peter Maydell wrote:
> Recent changes have left insn_crosses_page() more complicated
> than it needed to be:
>  * it's only called from thumb_tr_translate_insn() so we know
>    for certain that we're looking at a Thumb insn
>  * the caller's check for dc->pc >= dc->next_page_start - 3
>    means that dc->pc can't possibly be 4 aligned, so there's
>    no need to check that (the check was partly there to ensure
>    that we didn't treat an ARM insn as Thumb, I think)
>  * we now have thumb_insn_is_16bit() which lets us do a precise
>    check of the length of the next insn, rather than opencoding
>    an inaccurate check
> 
> Simplify it down to just loading the first half of the insn
> and calling thumb_insn_is_16bit() on it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
