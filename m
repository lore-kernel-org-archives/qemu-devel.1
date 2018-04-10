Received: from eggs.gnu.org ([2001:4830:134:3::10]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5qqN-0000dx-79
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5qqJ-0003VL-B4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:49:40 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5qqJ-0003Up-4q
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:49:39 -0400
Received: by mail-ot0-x242.google.com with SMTP id o9-v6so12190532otj.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 03:49:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410003558.2470-1-richard.henderson@linaro.org>
References: <20180410003558.2470-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 11:49:17 +0100
Message-ID: <CAFEAcA-tq3+iqDpTN17SB_urEuZcqL2TRYWUEQ7VRy2SwnQ6Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] tcg: Introduce
 tcg_set_insn_start_param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 10 April 2018 at 01:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The parameters for tcg_gen_insn_start are target_ulong, which may be split
> into two TCGArg parameters for storage in the opcode on 32-bit hosts.
>
> Fixes the ARM target and its direct use of tcg_set_insn_param, which would
> set the wrong argument in the 64-on-32 case.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: alarson@ddci.com
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Peter, I'm not sure what the reproducer is for this reported problem.

It's a standalone binary, which was attached to this email:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05995.html

I've checked and this patch does indeed fix it.

Applied to target-arm.next, thanks.

-- PMM
