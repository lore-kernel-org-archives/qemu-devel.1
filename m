Received: from eggs.gnu.org ([2001:4830:134:3::10]:53870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXNSD-0004DD-QV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXNSC-0003T4-Nk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:06:33 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXNSC-0003Sc-Ia
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:06:32 -0400
Received: by mail-ot0-x244.google.com with SMTP id i17-v6so3380107otl.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 02:06:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmQWvCczwh0Yto=9s2j7d00ULokZ0=VrxykAyXBvvHzQaUEMA@mail.gmail.com>
References: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8Bx7b_0zUxbdxFgtANFycVkUiSiemAwHpr0wpyxuLKmw@mail.gmail.com>
	<CAHmQWvCczwh0Yto=9s2j7d00ULokZ0=VrxykAyXBvvHzQaUEMA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 10:06:11 +0100
Message-ID: <CAFEAcA90hDS17L64YZ5H_B-kYkMaMV+ofBtdD=TEKgsnT+wUqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix psci conduit in acpi when
 el3 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 June 2018 at 05:06, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> Hi Peter,
> Yes, your considerations reasonable.
> But in practice of hardware platforms, programmer checks that Arm TF
> is using SMC for PSCI call conduit, then fix it manually in the ACPI
> table, reason may be that Arm TF is lack of ACPI support, if device
> tree used, there should be no such thing because Arm TF can support
> it.
> On QEMU, I just mimic the situation, if a complete reasonable
> solution, further efforts are needed to figure it out.

I'm afraid I don't really understand what you're saying
here. Could you try rephrasing it?

If we're running at EL3 and booting firmware, then QEMU doesn't
provide PSCI. The firmware we're booting is the only thing that
can know if that firmware has implemented PSCI. So only it can
decide whether the ACPI tables and DTB should say that PSCI is
present.

thanks
-- PMM
