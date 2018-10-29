Received: from eggs.gnu.org ([2001:4830:134:3::10]:34706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9MV-0000fH-Ar
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9MR-0003lk-Hh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:49 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH9MM-0003kL-2g
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id i10-v6so7405404oik.8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:21:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WJ7hRd8RfM2OTQBPcryUVDOJkFbRzb69xWTM-yNBLmA@mail.gmail.com>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-5-richard.henderson@linaro.org>
	<CAFEAcA_WJ7hRd8RfM2OTQBPcryUVDOJkFbRzb69xWTM-yNBLmA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:21:20 +0000
Message-ID: <CAFEAcA_zK8n0Bkwn-4x8M-CFduOviCmUGS-uSfw45SzRriE9Rg@mail.gmail.com>
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

On 29 October 2018 at 15:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 24 October 2018 at 12:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/kvm32.c | 33 ++++++++++++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
>> +    /*
>> +     * FIXME: There is not yet a way to read MVFR2.
>> +     * Fortunately there is not yet anything in there that affects migration.
>> +     */
>
> We should bring that up with the KVM folks (cc'd)...
>
> Presumably KVM_REG_ARM_VFP_MVFR2 should be 0x1005 and the code
> in the kernel for handling this bit of the get/set-one-reg
> ioctls needs to have code for it (including returning 0
> for v7 CPUs, where this VMRS register encoding was UNPREDICTABLE).

There's an argument for "fail the ioctl on v7 CPUs" rather than
"return 0"; I don't think I have a strong opinion, since in
practice userspace needs to handle the "doesn't exist" case
when it's running on an older kernel anyway.

thanks
-- PMM
