Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5713EC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC202072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC202072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izS7H-0007TF-Bm
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1izS6c-0006vv-VD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1izS6b-0007Of-LR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:21:06 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:51229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1izS6b-0006yg-DJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:21:05 -0500
Received: from player762.ha.ovh.net (unknown [10.108.42.5])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1D6A112EBF0
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 22:21:02 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 87B06F0B5EB5;
 Wed,  5 Feb 2020 21:20:54 +0000 (UTC)
Date: Wed, 5 Feb 2020 22:20:52 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 2/2] ppc/pnv: Fix PCI_EXPRESS dependency
Message-ID: <20200205222052.1a5cdea5@bahia.lan>
In-Reply-To: <20200205204115.555212-3-lvivier@redhat.com>
References: <20200205204115.555212-1-lvivier@redhat.com>
 <20200205204115.555212-3-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3584302353548286246
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrhedugddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.44
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJp?= =?UTF-8?B?Yw==?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  5 Feb 2020 21:41:15 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> When PHB4 bridge has been added, the dependencies to PCIE_PORT has been
> added to XIVE_SPAPR and indirectly to PSERIES.
> The build of the PowerNV machine is fine while we also build the PSERIES
> machine.
> If we disable the PSERIES machine, the PowerNV build fails because the
> PCI Express files are not built:
> 
> /usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power8_pic_print_info':
> .../hw/ppc/pnv.c:623: undefined reference to `pnv_phb3_msi_pic_print_info'
> /usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power9_pic_print_info':
> .../hw/ppc/pnv.c:639: undefined reference to `pnv_phb4_pic_print_info'
> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_write_config':
> .../hw/usb/hcd-ehci-pci.c:129: undefined reference to `pci_default_write_config'
> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_realize':
> .../hw/usb/hcd-ehci-pci.c:68: undefined reference to `pci_allocate_irq'
> /usr/bin/ld: .../hw/usb/hcd-ehci-pci.c:72: undefined reference to `pci_register_bar'
> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
> 
> This patch fixes the problem by adding needed dependencies to POWERNV.
> 
> Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 354828bf132f..3e11d0b53e11 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -29,6 +29,10 @@ config POWERNV
>      select XICS
>      select XIVE
>      select FDT_PPC
> +    select PCI

Is it needed since PCI_EXPRESS already selects PCI in hw/pci/Kconfig ?

Apart from that:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    select PCI_EXPRESS
> +    select MSI_NONBROKEN
> +    select PCIE_PORT
>  
>  config PPC405
>      bool
> @@ -135,8 +139,6 @@ config XIVE_SPAPR
>      default y
>      depends on PSERIES
>      select XIVE
> -    select PCI
> -    select PCIE_PORT
>  
>  config XIVE_KVM
>      bool


