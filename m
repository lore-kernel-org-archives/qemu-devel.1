Received: from eggs.gnu.org ([2001:4830:134:3::10]:37765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelKy-0007PP-Cg
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelKx-0006DR-Bc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:29:20 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:38329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eelKx-0006Cw-6Z
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:29:19 -0500
Received: by mail-oi0-x22e.google.com with SMTP id m65so5754485oig.5
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:29:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-1-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 17:28:58 +0000
Message-ID: <CAFEAcA_vBo8Y3R0-oWE3Zav=KzppRAqNFLx6FVz3Axmj3Jg3UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 00/20] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Richard Henderson (21):
>   tcg: Allow multiple word entries into the constant pool
>   tcg: Add types and basic operations for host vectors
>   tcg: Standardize integral arguments to expanders
>   tcg: Add generic vector expanders
>   tcg: Loosen vec_gen_op* typecheck rules
>   tcg: Add generic vector ops for constant shifts
>   tcg: Add generic vector ops for comparisons
>   tcg: Add generic vector ops for multiplication
>   tcg: Add generic helpers for saturating arithmetic
>   tcg: Add generic vector helpers with a scalar operand
>   tcg/optimize: Handle vector opcodes during optimize
>   target/arm: Align vector registers
>   target/arm: Use vector infrastructure for aa64 add/sub/logic
>   target/arm: Use vector infrastructure for aa64 mov/not/neg
>   target/arm: Use vector infrastructure for aa64 dup/movi
>   target/arm: Use vector infrastructure for aa64 constant shifts
>   target/arm: Use vector infrastructure for aa64 compares
>   target/arm: Use vector infrastructure for aa64 multiplies
>   target/arm: Use vector infrastructure for aa64 orr/bic immediate
>   tcg/i386: Add vector operations
>   tcg/aarch64: Add vector operations

I've reviewed the arm frontend patches, at least. The tcg backend
stuff is a combination of huge patches and not an area of the
code I'm familiar with, so I've left those in the hope that
somebody else will look at them...

thanks
-- PMM
