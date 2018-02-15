Received: from eggs.gnu.org ([2001:4830:134:3::10]:44942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJeZ-0002RC-Lu
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJeV-00035k-R5
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:32:47 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:41544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emJeV-00035X-LW
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:32:43 -0500
Received: by mail-oi0-x236.google.com with SMTP id t145so1217058oif.8
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:32:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211205848.4568-1-richard.henderson@linaro.org>
References: <20180211205848.4568-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:32:22 +0000
Message-ID: <CAFEAcA8J6D2Cq5D27eL9vB5jfUG4QYirzgvCNz9Y5yhWKpX+nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] target/arm: More SVE prep work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 February 2018 at 20:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes for v2:
> Include signal frames and PR_SVE_SET/GET_VL.
>
>
> Blurb for v1:
> First, we had noted that ARM_CP_64BIT needed to be removed from
> the ZCR_EL registers, but the patch set was applied without
> actually fixing that.
>
> Second, there's an existing bug by which the FPCR/FPSR registers
> are not properly trapped when FP is disabled.  Fix that with a
> translation-time check.
>
> Third, my attempt at using .accessfn for ZCR_EL fails to take
> into account the two different exception syndromes that must be
> raised.  Although they probably aren't as important as FPCR/FPSR,
> handle them at translation time too.
>
> Fourth, when writing to an AdvSIMD register, zero the rest of
> the SVE register.
>
>
> r~
>
>
> Richard Henderson (7):
>   target/arm: Remove ARM_CP_64BIT from ZCR_EL registers
>   target/arm: Enforce FP access to FPCR/FPSR
>   target/arm: Suppress TB end for FPCR/FPSR
>   target/arm: Enforce access to ZCR_EL at translation
>   target/arm: Handle SVE registers when using clear_vec_high
>   linux-user: Support SVE in aarch64 signal frames
>   linux-user: Implement aarch64 PR_SVE_SET/GET_VL

Hi; I've applied patches 1..5 to target-arm.next, and left
review comments for 6 and 7.

thanks
-- PMM
