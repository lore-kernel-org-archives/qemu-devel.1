Received: from eggs.gnu.org ([209.51.188.92]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyi1Q-0007JJ-AI
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyhra-0001bE-BY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:54:00 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyhrY-0001Ur-Hk
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:53:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id q81so11241024oic.5
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20190220235017.1060-1-richard.henderson@linaro.org>
	<20190220235017.1060-3-richard.henderson@linaro.org>
	<CAFEAcA_e4aGCi=uYe-Jy5GG7-VuxbRMagiTqT_mfFBS3c4SCpw@mail.gmail.com>
	<0e8a6ca6-c041-cbc3-c8d4-ad68bc329036@linaro.org>
In-Reply-To: <0e8a6ca6-c041-cbc3-c8d4-ad68bc329036@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 18:53:40 +0000
Message-ID: <CAFEAcA8AHA81F_y_ZfanJQNQQJ+aSvi-ST3SafswJA9jn9EvZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Implement ARMv8.0-PredRes
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

On Tue, 26 Feb 2019 at 18:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/26/19 10:44 AM, Peter Maydell wrote:
> > On Wed, 20 Feb 2019 at 23:50, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This is named "Execution and Data prediction restriction instructions"
> >> within the ARMv8.5 manual, and given the name "PredRes" by binutils.
> >
> > The official name is v8.0-PredInv.
> > (You can see this used in the xml descriptions for the new insns, eg:
> > https://developer.arm.com/docs/ddi0595/b/aarch64-system-instructions/cfp-rctx )
>
> Thanks.  I may file a bug against binutils.  ;-)
>
> >> +
> >> +    /* All v8.0-a cpus support aarch64.  */
> >
> > True, but why is it relevant here ?
> >
> >> +    if (cpu_isar_feature(aa64_specres, cpu)) {
> >> +        define_arm_cp_regs(cpu, specres_reginfo);
> >> +    }
>
> The context, I think, is that we're in a function that handles a32,
> and I am not checking arm_feature(cpu, ARM_FEATURE_AARCH64) before
> checking cpu_isar_feature(aa64_specres, cpu).
>
> At least that's my recollection.

Ah, so in theory if we had a v8.0 CPU which was AArch32 only
it would not have those ID bits set and fail to register
these registers. I'm pretty sure it would also not work in
a bunch of other ways too...

thanks
-- PMM
