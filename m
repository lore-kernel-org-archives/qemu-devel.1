Received: from eggs.gnu.org ([2001:4830:134:3::10]:49410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOfst-000661-8M
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOfss-0005vr-HV
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:58:07 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOfss-0005vA-0U
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:58:06 -0400
Received: by mail-ot0-x244.google.com with SMTP id t1-v6so28442976ott.13
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 01:58:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531203906.GA12424@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9bYdwByseqCMKSVtWV59mNruT3jJfWWLju1koCnwSb=Q@mail.gmail.com>
	<20180417142318.GO24561@codeaurora.org>
	<CAFEAcA8RwC7DSbo+mMqYUS6tL5UwfQGMa_r5AnAkJqm7v63HWw@mail.gmail.com>
	<20180517193104.GB4771@codeaurora.org>
	<CAFEAcA-+sO3oUqfQXHcHRBu2i-WFzvFKObcBz26qeLS_0+3s2Q@mail.gmail.com>
	<20180531203906.GA12424@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 09:57:44 +0100
Message-ID: <CAFEAcA_2z-2utCiPQM0DtZGXgiE2qbVsB=Nn81j9DP7Z8keRqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/22] target/arm: Add ARM_FEATURE_V7VE
 for v7 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 31 May 2018 at 21:39, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On May 31 15:18, Peter Maydell wrote:
>>    if (arm_feature(env, ARM_FEATURE_V7VE) {
>>        /* v7 Virtualization Extensions. In real hardware this implies
>>         * EL2 and also the presence of the Security Extensions.
>>         * For QEMU, for backwards-compatibility we implement some
>>         * CPUs or CPU configs which have no actual EL2 or EL3 but do
>>         * include the various other features that V7VE implies.
>>         * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>>         * Security Extensions is ARM_FEATURE_EL3.
>>         */
>>        set_feature(env, ARM_FEATURE_ARM_DIV);
>
> Is it safe to assume from your comment above regarding keeping ARM_DIV
> separate from V7VE that the inclusion of it here is an oversight and
> that only LPAE and V7 should be set if V7VE is? (and that V8 should
> now directly imply both V7VE and ARM_DIV?)

No; V7VE always implies ARM_DIV. (ARM_DIV doesn't imply V7VE,
though, which is why it is a separate feature bit.)

thanks
-- PMM
