Received: from eggs.gnu.org ([2001:4830:134:3::10]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMuf-0002nH-3K
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMuX-0005e2-By
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:49:17 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMuU-0005Mh-TY
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:49:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id a203-v6so17645949oib.0
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:49:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:48:48 +0100
Message-ID: <CAFEAcA-3b_Zkg+bWGHyL1RdvDvrr_74bGbw+WCDozwyJZsd=YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] target/arm: Rely on id regs
 instead of features
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

On 8 October 2018 at 22:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This edition fixes a number of conflicts with master, and adds
> a few field definitions from ARMv8.5, courtesy of Philippe.
>
> It also fixes a big think-o in a last-minute change to the
> sve system mode patch set that was applied to master today.
> That would be patch 1.  Sorry for not testing the original
> more thoroughly.
>
>
> r~
>
>
> Richard Henderson (10):
>   target/arm: Fix aarch64_sve_change_el wrt EL0
>   target/arm: Define fields of ISAR registers
>   target/arm: Align cortex-r5 id_isar0
>   target/arm: Fix cortex-a7 id_isar0

I'm applying these patches (1,2,4,5) to target-arm.next.

thanks
-- PMM
