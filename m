Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333C821527
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333C821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlbC2-0004kz-Gs
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlbA6-00029Z-Op
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:43:42 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:47821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlbA4-0005PQ-5J
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:43:42 -0400
Received: from player779.ha.ovh.net (unknown [10.110.103.118])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5F554219A67
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 18:43:38 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 48A32137231AA;
 Wed, 17 Jun 2020 16:43:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005247dbfc7-cd3e-4924-9b56-6fc4f98f6ba9,ABECD89738EEB0C75E5395B338997A57DB3A3EEE)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 12/12] docs/system: Add Nuvoton machine documentation
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org,
 joel@jms.id.au
References: <20200611223016.259837-1-hskinnemoen@google.com>
 <20200611223016.259837-13-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ac8dcb91-6c91-3b1c-578d-5f9cb830bea6@kaod.org>
Date: Wed, 17 Jun 2020 18:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611223016.259837-13-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5204472319721835433
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeutdeuueeltdfghfevveeugffgvdfghfejgeejkeeigefhudehvdduledvhfffnecuffhomhgrihhnpehnuhhvohhtohhnrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.56.136; envelope-from=clg@kaod.org;
 helo=1.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 12:43:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 12:30 AM, Havard Skinnemoen wrote:
> Change-Id: I88e437cb22a8441e0c0e672dfb57568ac81172d8
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  docs/system/arm/nuvoton.rst | 89 +++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst  |  1 +
>  2 files changed, 90 insertions(+)
>  create mode 100644 docs/system/arm/nuvoton.rst
> 
> diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
> new file mode 100644
> index 0000000000..1ca34c0051
> --- /dev/null
> +++ b/docs/system/arm/nuvoton.rst
> @@ -0,0 +1,89 @@
> +Nuvoton iBMC boards (``npcm750-evb``, ``quanta-gsj``)
> +=====================================================
> +
> +The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
> +designed to be used as Baseboard Management Controllers (BMCs) in various
> +servers. They all feature one or two ARM Cortex A9 CPU cores, as well as an
> +assortment of peripherals targeted for either Enterprise or Data Center /
> +Hyperscale applications. The former is a superset of the latter, so NPCM750 has
> +all the peripherals of NPCM730 and more.
> +
> +.. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
> +
> +The NPCM750 SoC has two Cortex A9 cores and is targeted for the Enterprise
> +segment. The following machines are based on this chip :
> +
> +- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board
> +
> +The NPCM730 SoC has two Cortex A9 cores and is targeted for Data Center and
> +Hyperscale applications. The following machines are based on this chip :
> +
> +- ``quanta-gsj``        Quanta GSJ server BMC
> +
> +There are also two more SoCs, NPCM710 and NPCM705, which are single-core
> +variants of NPCM750 and NPCM730, respectively. These are currently not
> +supported by QEMU.
> +
> +Supported devices
> +-----------------
> +
> + * SMP (Dual Core Cortex-A9)
> + * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private Timer
> +   and Watchdog.
> + * SRAM, ROM and DRAM mappings
> + * System Global Control Registers (GCR)
> + * Clock and reset controller (CLK)
> + * Timer controller (TIM)
> + * Serial ports (16550-based)
> + * DDR4 memory controller (dummy interface indicating memory training is done)
> + * OTP controllers (no protection features)
> + * Flash Interface Unit (FIU; no protection features)
> +
> +Missing devices
> +---------------
> +
> + * GPIO controller
> + * LPC/eSPI host-to-BMC interface, including
> +
> +   * Keyboard and mouse controller interface (KBCI)
> +   * Keyboard Controller Style (KCS) channels
> +   * BIOS POST code FIFO
> +   * System Wake-up Control (SWC)
> +   * Shared memory (SHM)
> +   * eSPI slave interface
> +
> + * Ethernet controllers (GMAC and EMC)
> + * USB host (USBH)
> + * USB device (USBD)
> + * SMBus controller (SMBF)
> + * Peripheral SPI controller (PSPI)
> + * Analog to Digital Converter (ADC)
> + * SD/MMC host
> + * Random Number Generator (RNG)
> + * PECI interface
> + * Pulse Width Modulation (PWM)
> + * Tachometer
> + * PCI and PCIe root complex and bridges
> + * VDM and MCTP support
> + * Serial I/O expansion
> + * LPC/eSPI host
> + * Coprocessor
> + * Graphics
> + * Video capture
> + * Encoding compression engine
> + * Security features
> +
> +Boot options
> +------------
> +
> +The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
> +a kernel using the ``-kernel`` option.
> +
> +Booting a full firmware image requires a Boot ROM specified via the ``-bios``
> +option to QEMU. The firmware image should be attached as an MTD drive. Example :
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -machine quanta-gsj -nographic \
> +      -bios npcm7xx_bootrom.bin \
> +      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 1bd477a293..38a9daa9b9 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
>     arm/aspeed
>     arm/musicpal
>     arm/nseries
> +   arm/nuvoton
>     arm/orangepi
>     arm/palm
>     arm/xscale
> 


