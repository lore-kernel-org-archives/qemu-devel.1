Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFzGM-000270-Pg
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFzGL-00009b-V2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:50:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFzGL-000092-M1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:50:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id k17-v6so27795190oih.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 02:50:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504175529.23064-1-peter.maydell@linaro.org>
References: <20180504175529.23064-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 10:50:03 +0100
Message-ID: <CAFEAcA_e7z5FOW8GzVHZJ+SahY4HcDTVDW9UQF6qwxMB7yMpOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 4 May 2018 at 18:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> v2: fixed format string errors in trace messages.
>
> -- PMM
>
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180504-1
>
> for you to fetch changes up to e24e3454829579eb815ec95d7b3679b0f65845b4:
>
>   hw/arm/virt: Introduce the iommu option (2018-05-04 18:52:58 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Emulate the SMMUv3 (IOMMU); one will be created in the 'virt' board
>    if the commandline includes "-machine iommu=smmuv3"
>  * target/arm: Implement v8M VLLDM and VLSTM
>  * hw/arm: Don't fail qtest due to missing SD card in -nodefaults mode
>  * Some fixes to silence Coverity false-positives
>  * arm: boot: set boot_info starting from first_cpu
>    (fixes a technical bug not visible in practice)
>  * hw/net/smc91c111: Convert away from old_mmio
>  * hw/usb/tusb6010: Convert away from old_mmio
>  * hw/char/cmsdk-apb-uart.c: Accept more input after character read
>  * target/arm: Make MPUIR write-ignored on OMAP, StrongARM
>  * hw/arm/virt: Add linux,pci-domain property
>

Applied, thanks.

-- PMM
