Received: from eggs.gnu.org ([2001:4830:134:3::10]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eORRq-0005wX-TB
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eORRm-0001cq-R7
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:00:58 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:37555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eORRm-0001cB-Kb
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:00:54 -0500
Received: by mail-pf0-x235.google.com with SMTP id n6so11985984pfa.4
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:00:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
Date: Mon, 11 Dec 2017 09:00:49 -0800
MIME-Version: 1.0
In-Reply-To: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11?] target/arm: Generate UNDEF for
 32-bit Thumb2 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Emilio G . Cota" <cota@braap.org>

On 12/11/2017 07:42 AM, Peter Maydell wrote:
> The refactoring of commit 296e5a0a6c3935 has a nasty bug:
> it accidentally dropped the generation of code to raise
> the UNDEF exception when disas_thumb2_insn() returns nonzero.
> This means that 32-bit Thumb2 instruction patterns that
> ought to UNDEF just act like nops instead. This is likely
> to break any number of things, including the kernel's "disable
> the FPU and use the UNDEF exception to identify when to turn
> it back on again" trick.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is the smallest possible fix that will correct the
> bug, for possible inclusion in 2.11; for 2.12 we should
> fix the asymmetry where disas_thumb() generates its own
> exception-raising code but disas_thumb2() wants the caller
> to do it. (This asymmetry is why we didn't notice the
> problem in code review.)
> 
> I'm not sure whether this should go into 2.11 or not --
> this time last week it would have been an easy "yes".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
