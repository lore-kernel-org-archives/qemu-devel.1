Received: from eggs.gnu.org ([2001:4830:134:3::10]:52295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUuFT-00036H-1O
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUuFN-0007CV-GT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:03:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUuFN-0007C2-B3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:03:21 -0500
Received: by mail-oi1-x241.google.com with SMTP id j21so429729oii.8
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 06:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 14:03:08 +0000
Message-ID: <CAFEAcA9BF_+AgXYkZVv1ukRSgQo_sDP3dZ2yNZZKQjTf0M7GBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/10] target/arm: LOR, HPD, AA32HPD
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

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Three relatively simple post-8.0 extensions.
>
> Changes since v1:
>   * Add TLOR access checks for LOR registers.
>   * Clean up access to HCR_EL2.
>   * Clean up setting of SCR_EL3.
>   * Other changes as noted within each patch.

I've taken patches 1,2,3,4,7,9,10 into target-arm.next:

>   target/arm: Move id_aa64mmfr* to ARMISARegisters
>   target/arm: Add HCR_EL2 bits up to ARMv8.5
>   target/arm: Add SCR_EL3 bits up to ARMv8.5
>   target/arm: Fix HCR_EL2.TGE check in arm_phys_excp_target_el
>   target/arm: Tidy scr_write
>   target/arm: Implement the ARMv8.1-HPD extension
>   target/arm: Implement the ARMv8.2-AA32HPD extension

leaving 5,6,8 as needing rework:
>   target/arm: Introduce arm_hcr_el2_eff
>   target/arm: Use arm_hcr_el2_eff more places
>   target/arm: Implement the ARMv8.1-LOR extension

thanks
-- PMM
