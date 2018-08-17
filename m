Received: from eggs.gnu.org ([2001:4830:134:3::10]:43171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqeww-0007OY-K7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqewv-0007dT-Sb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:37:58 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqewv-0007cv-JZ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:37:57 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so13976113oiw.8
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 06:37:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 14:37:36 +0100
Message-ID: <CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 25 July 2018 at 06:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware, for supporting
> firmware and OS development for pysical Aarch64 machines.
>
> This patch introduces new machine type 'Enterprise' with main features:
>  - Based on 'virt' machine type.
>  - Re-designed memory map.
>  - EL2 and EL3 are enabled by default.
>  - GIC version 3 by default.
>  - AHCI controller attached to system bus, and then CDROM and hard disc
>    can be added to it.
>  - EHCI controller attached to system bus, with USB mouse and key board
>    installed by default.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>  - No virtio functions enabled, since this is to emulate real hardware.
>  - No paravirtualized fw_cfg device either.
>
> Arm Trusted Firmware and UEFI porting to this are done accordingly.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
> Changes since v1:
>  - rebase on v3.0.0-rc0
>  - introduce another auxillary patch as 1/2, so this is 2/2
>  - rename 'sbsa' to 'enterprise'
>  - remove paravirualized fw_cfg
>  - set gic_vertion to 3 instead of 2
>  - edit commit message to describe purpose of this platform

Hi; there's been a lot of discussion on this thread. I'm going
to assume that you don't need any further review commentary for
the moment, and will wait for a v3. If there are any specific
questions you want guidance on to produce that v3, let me know.

thanks
-- PMM
