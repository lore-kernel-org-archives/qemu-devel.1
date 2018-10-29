Received: from eggs.gnu.org ([2001:4830:134:3::10]:60058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9EM-0002Sz-3R
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9EL-0007HY-D0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:13:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH9EI-0007GD-MW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:13:23 -0400
Received: by mail-ot1-x343.google.com with SMTP id o14so7888004oth.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:13:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024113709.16599-5-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:13:00 +0000
Message-ID: <CAFEAcA_WJ7hRd8RfM2OTQBPcryUVDOJkFbRzb69xWTM-yNBLmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] target/arm: Fill in ARMISARegisters
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>

On 24 October 2018 at 12:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm32.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> +    /*
> +     * FIXME: There is not yet a way to read MVFR2.
> +     * Fortunately there is not yet anything in there that affects migration.
> +     */

We should bring that up with the KVM folks (cc'd)...

Presumably KVM_REG_ARM_VFP_MVFR2 should be 0x1005 and the code
in the kernel for handling this bit of the get/set-one-reg
ioctls needs to have code for it (including returning 0
for v7 CPUs, where this VMRS register encoding was UNPREDICTABLE).

thanks
-- PMM
