Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223FFC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB32F218D4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB32F218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaay-0003Ha-8V
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqaah-0002rO-7u
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqaaf-0005Ps-DC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:03:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqaaf-0005PF-86
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:03:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so48533846qtq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GaUXWdE7fDHJB8kj4RpxMegH7TRCMRGCsWuhf2PreY0=;
 b=AbnErzJvAncQLodsbFshBeOg15q/FWHkRULQgOp0yv373Z2+kNu/GJI9P67NO8m9ZQ
 gsrPEPl3JkTkZY2j7nd85ARz542T8Mk+61zzLmMdRtG/YKm3FjTbYxjYBTwd+Rb1JCxq
 jHtRQAqVRE1MOUluUFnErwV+mkXkSJmcGNSP1JXQNUY2LJbzuLvZZ38vwKHcIexh/Oht
 8BUgwajA9Yvy8NBGXK/mFca2iMpAuudZ2AEPNhn3TL3PH7CtTO9PwRIwDyk71ZwVXdsA
 GTQGm8fSlXcXpeS9kswrTG2chElzKRAkaz095gO0EVxVkjfAKBfNKr7+z3DHvJdLhonB
 95Gg==
X-Gm-Message-State: APjAAAV+F/OT8FSn0TqNeIONBCEm3MgMOk0PIl6daIwyU1qPskajKZW6
 mRWSIfCHW3mm8q4UNrAOU2WJiQ==
X-Google-Smtp-Source: APXvYqzIo6OpA/ALv2NR7by77fgoDxPN70bfNiz6mslNxOFtxgCubUj6mGRL/xYHMVHb60l1a5Dm4Q==
X-Received: by 2002:aed:34a6:: with SMTP id x35mr61201520qtd.187.1564048991621; 
 Thu, 25 Jul 2019 03:03:11 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 b23sm30041627qte.19.2019.07.25.03.03.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 03:03:10 -0700 (PDT)
Date: Thu, 25 Jul 2019 06:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725060105-mutt-send-email-mst@kernel.org>
References: <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com>
 <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>, "Montes,
 Julio" <julio.montes@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 01:14:35PM +0200, Paolo Bonzini wrote:
> On 23/07/19 12:01, Paolo Bonzini wrote:
> > The number of buses is determined by the firmware, not by QEMU, so
> > fw_cfg would not be the right interface.  In fact (as I have just
> > learnt) lastbus is an x86-specific option that overrides the last bus
> > returned by SeaBIOS's handle_1ab101.
> > 
> > So the next step could be to figure out what is the lastbus returned by
> > handle_1ab101 and possibly why it isn't zero.
> 
> Some update:
> 
> - for 64-bit, PCIBIOS (and thus handle_1ab101) is not called.  PCIBIOS is
> only used by 32-bit kernels.  As a side effect, PCI expander bridges do not
> work on 32-bit kernels with ACPI disabled, because they are located beyond
> pcibios_last_bus (with ACPI enabled, the DSDT exposes them).
> 
> - for -M pc, pcibios_last_bus in Linux remains -1 and no "legacy scanning" is done.
> 
> - for -M q35, pcibios_last_bus in Linux is set based on the size of the 
> MMCONFIG aperture and Linux ends up scanning all 32*255 (bus,dev) pairs 
> for buses above 0.
> 
> Here is a patch that only scans devfn==0, which should mostly remove the need
> for pci=lastbus=0.  (Testing is welcome).
> 
> Actually, KVM could probably avoid the scanning altogether.  The only "hidden" root
> buses we expect are from PCI expander bridges and if you found an MMCONFIG area
> through the ACPI MCFG table, you can also use the DSDT to find PCI expander bridges.
> However, I am being conservative.
> 
> A possible alternative could be a mechanism whereby the vmlinuz real mode entry
> point, or the 32-bit PVH entry point, fetch lastbus and they pass it to the
> kernel via the vmlinuz or PVH boot information structs.  However, I don't think
> that's very useful, and there is some risk of breaking real hardware too.
> 
> Paolo
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 73bb404f4d2a..17012aa60d22 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -61,6 +61,7 @@ enum pci_bf_sort_state {
>  extern struct pci_ops pci_root_ops;
>  
>  void pcibios_scan_specific_bus(int busn);
> +void pcibios_scan_bus_by_device(int busn);
>  
>  /* pci-irq.c */
>  
> @@ -216,8 +217,10 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>  # endif
>  # define x86_default_pci_init_irq	pcibios_irq_init
>  # define x86_default_pci_fixup_irqs	pcibios_fixup_irqs
> +# define x86_default_pci_scan_bus	pcibios_scan_bus_by_device
>  #else
>  # define x86_default_pci_init		NULL
>  # define x86_default_pci_init_irq	NULL
>  # define x86_default_pci_fixup_irqs	NULL
> +# define x86_default_pci_scan_bus      NULL
>  #endif
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index b85a7c54c6a1..4c3a0a17a600 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -251,6 +251,7 @@ struct x86_hyper_runtime {
>   * @save_sched_clock_state:	save state for sched_clock() on suspend
>   * @restore_sched_clock_state:	restore state for sched_clock() on resume
>   * @apic_post_init:		adjust apic if needed
> + * @pci_scan_bus:		scan a PCI bus
>   * @legacy:			legacy features
>   * @set_legacy_features:	override legacy features. Use of this callback
>   * 				is highly discouraged. You should only need
> @@ -273,6 +274,7 @@ struct x86_platform_ops {
>  	void (*save_sched_clock_state)(void);
>  	void (*restore_sched_clock_state)(void);
>  	void (*apic_post_init)(void);
> +	void (*pci_scan_bus)(int busn);
>  	struct x86_legacy_features legacy;
>  	void (*set_legacy_features)(void);
>  	struct x86_hyper_runtime hyper;
> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
> index 6857b4577f17..b248d7036dd3 100644
> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -11,12 +11,14 @@
>  #include <linux/acpi_pmtmr.h>
>  #include <linux/kernel.h>
>  #include <linux/reboot.h>
> +#include <linux/pci.h>
>  #include <asm/apic.h>
>  #include <asm/cpu.h>
>  #include <asm/hypervisor.h>
>  #include <asm/i8259.h>
>  #include <asm/irqdomain.h>
>  #include <asm/pci_x86.h>
> +#include <asm/pci.h>
>  #include <asm/reboot.h>
>  #include <asm/setup.h>
>  #include <asm/jailhouse_para.h>
> @@ -136,6 +138,22 @@ static int __init jailhouse_pci_arch_init(void)
>  	return 0;
>  }
>  
> +static void jailhouse_pci_scan_bus_by_function(int busn)
> +{
> +        int devfn;
> +        u32 l;
> +
> +        for (devfn = 0; devfn < 256; devfn++) {
> +                if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
> +                    l != 0x0000 && l != 0xffff) {
> +                        DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> +                        pr_info("PCI: Discovered peer bus %02x\n", busn);
> +                        pcibios_scan_root(busn);
> +                        return;
> +                }
> +        }
> +}
> +
>  static void __init jailhouse_init_platform(void)
>  {
>  	u64 pa_data = boot_params.hdr.setup_data;
> @@ -153,6 +171,7 @@ static void __init jailhouse_init_platform(void)
>  	x86_platform.legacy.rtc		= 0;
>  	x86_platform.legacy.warm_reset	= 0;
>  	x86_platform.legacy.i8042	= X86_LEGACY_I8042_PLATFORM_ABSENT;
> +	x86_platform.pci_scan_bus	= jailhouse_pci_scan_bus_by_function;
>  
>  	legacy_pic			= &null_legacy_pic;
>  
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 82caf01b63dd..59f7204ed8f3 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -24,6 +24,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/nmi.h>
>  #include <linux/swait.h>
> +#include <linux/pci.h>
>  #include <asm/timer.h>
>  #include <asm/cpu.h>
>  #include <asm/traps.h>
> @@ -33,6 +34,7 @@
>  #include <asm/apicdef.h>
>  #include <asm/hypervisor.h>
>  #include <asm/tlb.h>
> +#include <asm/pci.h>
>  
>  static int kvmapf = 1;
>  
> @@ -621,10 +623,31 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
>  	native_flush_tlb_others(flushmask, info);
>  }
>  
> +#ifdef CONFIG_PCI
> +static void kvm_pci_scan_bus(int busn)
> +{
> +        u32 l;
> +
> +	/*
> +	 * Assume that there are no "hidden" buses, i.e. all PCI root buses
> +	 * have a host bridge at device 0, function 0.
> +	 */
> +	if (!raw_pci_read(0, busn, 0, PCI_VENDOR_ID, 2, &l) &&
> +	    l != 0x0000 && l != 0xffff) {
> +		pr_info("PCI: Discovered peer bus %02x\n", busn);
> +		pcibios_scan_root(busn);
> +        }
> +}
> +#endif
> +
>  static void __init kvm_guest_init(void)
>  {
>  	int i;
>  
> +#ifdef CONFIG_PCI
> +	x86_platform.pci_scan_bus = kvm_pci_scan_bus;
> +#endif
> +
>  	if (!kvm_para_available())
>  		return;
>  

Shouldn't this happen after kvm_para_available?
In fact, let's add a CPU ID flag for this, so it's
easy to tell guest whether to scan extra buses.
What do you say?

> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 50a2b492fdd6..19e1cc2cb6e0 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -118,6 +118,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
>  	.get_nmi_reason			= default_get_nmi_reason,
>  	.save_sched_clock_state 	= tsc_save_sched_clock_state,
>  	.restore_sched_clock_state 	= tsc_restore_sched_clock_state,
> +	.pci_scan_bus			= x86_default_pci_scan_bus,
>  	.hyper.pin_vcpu			= x86_op_int_noop,
>  };
>  
> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
> index 467311b1eeea..6214dbce26d3 100644
> --- a/arch/x86/pci/legacy.c
> +++ b/arch/x86/pci/legacy.c
> @@ -36,14 +36,19 @@ int __init pci_legacy_init(void)
>  
>  void pcibios_scan_specific_bus(int busn)
>  {
> -	int stride = jailhouse_paravirt() ? 1 : 8;
> -	int devfn;
> -	u32 l;
> -
>  	if (pci_find_bus(0, busn))
>  		return;
>  
> -	for (devfn = 0; devfn < 256; devfn += stride) {
> +	x86_platform.pci_scan_bus(busn);
> +}
> +EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
> +
> +void pcibios_scan_bus_by_device(int busn)
> +{
> +	int devfn;
> +	u32 l;
> +
> +	for (devfn = 0; devfn < 256; devfn += 8) {
>  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
>  		    l != 0x0000 && l != 0xffff) {
>  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> @@ -53,7 +58,6 @@ void pcibios_scan_specific_bus(int busn)
>  		}
>  	}
>  }
> -EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
>  
>  static int __init pci_subsys_init(void)
>  {

