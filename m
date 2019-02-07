Received: from eggs.gnu.org ([209.51.188.92]:56373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnsF-0000HC-TO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnsD-0000DD-RB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:54:07 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grnsA-0000Bp-20
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:54:04 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so1242137otk.9
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<CAFEAcA8XTc5RTxifOA-cYb2FfRaC5ZMBh3AEcxL8LZqh7qxo7Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8XTc5RTxifOA-cYb2FfRaC5ZMBh3AEcxL8LZqh7qxo7Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:53:48 +0000
Message-ID: <CAFEAcA9ecJu19JjSgHrNK9n7tHmjJRkGrRvJZ5MYNLdRCfk-VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/17] target/arm: Implement ARMv8.5-MemTag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Will Deacon <will.deacon@arm.com>, Dave P Martin <dave.martin@arm.com>, szabolcs.nagy@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>

On Tue, 5 Feb 2019 at 19:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> I'm working through review of this, but feel free to rebase on
> current master (which has now got a pile of your other patches
> in it, since I've just merged target-arm.next) without waiting
> for me to finish going through it.

OK, I've now finished review of it. I haven't looked at the
last few patches which are linux-user, because it doesn't
seem worth doing much review on them until we have at least
a proposed Linux userspace ABI for MemTag to compare them
against. (If we do want to do an implementation that precedes
the ABI being nailed down, we need to hide it behind a
defaults-to-off x-property.)

thanks
-- PMM
