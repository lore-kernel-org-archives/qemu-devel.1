Received: from eggs.gnu.org ([2001:4830:134:3::10]:52298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g1aJU-0001Eb-9w
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 12:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g1aJT-0001Fz-FL
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 12:54:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g1aJT-0001Ez-32
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 12:54:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id h26-v6so9020725otl.9
	for <qemu-devel@nongnu.org>; Sun, 16 Sep 2018 09:54:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <881b6194-237c-5797-794a-e8d4c415950a@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
	<20180915161738.25257-2-richard.henderson@linaro.org>
	<CAFEAcA_e9i232hWsMCjQh6RHnNjEBj=Ng6nGuC2aNU4SSfiY-A@mail.gmail.com>
	<881b6194-237c-5797-794a-e8d4c415950a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Sep 2018 17:54:02 +0100
Message-ID: <CAFEAcA_zed7=k_N8E9w7ts9s=zzVe1sJg2rr_dhBTM-73A04WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/13] target/arm: Add ARM_FEATURE_SWP
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

On 16 September 2018 at 16:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 9/15/18 6:32 PM, Peter Maydell wrote:
>> We want to arrange to have SWP work anyway on linux-user,
>> I think, since the kernel will typically trap-and-emulate
>> it assuming it was built with CONFIG_SWP_EMULATE. (I don't
>> know if those kernels will advertise swp in the hwcaps,
>> but I guess not.)
>
> Ah, I did not know about SWP_EMULATE.  It appears to be
> specific to armv7+ (though we don't support the pre-v4
> cpus for which it might otherwise be relevant).

Yes, it's intended to allow older userspace binaries to continue
to work on newer CPUs without SWP, not to try to run new binaries
on older CPUs. (Anything compiled for a CPU new enough for SWP
probably uses other newer insns that some pre-v4 CPU doesn't have
anyway.)

> It does appear that HWCAP_SWP is advertised anyway:
>
> mm/proc-v7.S:   .long   HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT

Interesting. I might ask some random kernel person what the semantics
of hwcap are -- is it "will work even if a terrible plan" or "it makes
sense to use this"?

thanks
-- PMM
