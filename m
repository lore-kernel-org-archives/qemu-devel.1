Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D3C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC012084D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC012084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaA6-0007pg-H4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hqa9v-0007Q7-4d
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hqa9t-0006Yb-KF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:35:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hqa9t-0006Y5-DC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:35:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so50044268wrm.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Ntmdf2d/F+FKRdeZIN+l51HgwuVWLbble7/laCiWoEk=;
 b=eozok3boIHjAtYtqIfo/iCxAxZJIkFp9qYtXXf3JzvP01TXB8bNZaggZg/U5hma+bW
 JTQNwXFG+7m/3eWoZukeDzMNDZi/nez0mAP9BZpoF+lJIUY95HQxGzaHJI+aXnV2Etrz
 HYftqBNBugBqH9Y8pxCp/7VqrNdY+2cqOoceI685cr3CTSs3TPESZ8WoMl+NNik8NImG
 ovnXGb1OI+IMZpAvGkxEjiRvpylfYZdDcf24EgrNwl7fRhgQVHLSvNlrUD6peKVn2zk7
 R9vlwTSo3tVmoB0+GqkPn8PNP+VoJZDcq+1yO48HNbWYDyFqBaPHMdjT9pY68Kf92UBg
 J2Jw==
X-Gm-Message-State: APjAAAX83wro1/3b3Xb8U2FpvQmzMQ1fb36bumXPjclTfHf6WIF1BtaT
 8sQP4BppKjgu9PDBz2mIxiHhDA==
X-Google-Smtp-Source: APXvYqw8sLvBsnal0I9VhS3+AR9IZhQdrdjB2TiXuHcUE8HXDZMAaz7QvpiawE1+OBwjafN6lTJfpQ==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr13649404wrs.88.1564047331669; 
 Thu, 25 Jul 2019 02:35:31 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id o24sm54956058wmh.2.2019.07.25.02.35.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 02:35:30 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain> <87d0i7tlkl.fsf@redhat.com>
 <20190719102915.GG18585@stefanha-x1.localdomain> <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
Date: Thu, 25 Jul 2019 11:35:28 +0200
Message-ID: <87imrqqwwv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "Montes, Julio" <julio.montes@intel.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/07/19 12:01, Paolo Bonzini wrote:
>> The number of buses is determined by the firmware, not by QEMU, so
>> fw_cfg would not be the right interface.  In fact (as I have just
>> learnt) lastbus is an x86-specific option that overrides the last bus
>> returned by SeaBIOS's handle_1ab101.
>>=20
>> So the next step could be to figure out what is the lastbus returned by
>> handle_1ab101 and possibly why it isn't zero.
>
> Some update:
>
> - for 64-bit, PCIBIOS (and thus handle_1ab101) is not called.  PCIBIOS is
> only used by 32-bit kernels.  As a side effect, PCI expander bridges do n=
ot
> work on 32-bit kernels with ACPI disabled, because they are located beyond
> pcibios_last_bus (with ACPI enabled, the DSDT exposes them).
>
> - for -M pc, pcibios_last_bus in Linux remains -1 and no "legacy scanning=
" is done.
>
> - for -M q35, pcibios_last_bus in Linux is set based on the size of the=20
> MMCONFIG aperture and Linux ends up scanning all 32*255 (bus,dev) pairs=20
> for buses above 0.
>
> Here is a patch that only scans devfn=3D=3D0, which should mostly remove =
the need
> for pci=3Dlastbus=3D0.  (Testing is welcome).

I just gave it a try. These are the results (avg on 10 consecutive runs):

 - Unpatched kernel:

Avg
 qemu_init_end: 75.207386
 linux_start_kernel: 115.056767 (+39.849381)
 linux_start_user: 241.020113 (+125.963346)

 - Unpatched kernel with pci=3Dlastbus=3D0:

Avg
 qemu_init_end: 75.468282
 linux_start_kernel: 115.189322 (+39.72104)
 linux_start_user: 192.404823 (+77.215501)

 - Patched kernel (without pci=3Dlastbus=3D0):

Avg
 qemu_init_end: 75.605627
 linux_start_kernel: 115.656557 (+40.05093)
 linux_start_user: 192.857655 (+77.201098)

Looks fine to me. There must an extra cost in the patched kernel
vs. using pci=3Dlastbus=3D0, but it's so low that's hard to catch on the
average numbers.

> Actually, KVM could probably avoid the scanning altogether.  The only "hi=
dden" root
> buses we expect are from PCI expander bridges and if you found an MMCONFI=
G area
> through the ACPI MCFG table, you can also use the DSDT to find PCI expand=
er bridges.
> However, I am being conservative.
>
> A possible alternative could be a mechanism whereby the vmlinuz real mode=
 entry
> point, or the 32-bit PVH entry point, fetch lastbus and they pass it to t=
he
> kernel via the vmlinuz or PVH boot information structs.  However, I don't=
 think
> that's very useful, and there is some risk of breaking real hardware too.
>
> Paolo
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x8=
6.h
> index 73bb404f4d2a..17012aa60d22 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -61,6 +61,7 @@ enum pci_bf_sort_state {
>  extern struct pci_ops pci_root_ops;
>=20=20
>  void pcibios_scan_specific_bus(int busn);
> +void pcibios_scan_bus_by_device(int busn);
>=20=20
>  /* pci-irq.c */
>=20=20
> @@ -216,8 +217,10 @@ static inline void mmio_config_writel(void __iomem *=
pos, u32 val)
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
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_i=
nit.h
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
>=20=20
> +static void jailhouse_pci_scan_bus_by_function(int busn)
> +{
> +        int devfn;
> +        u32 l;
> +
> +        for (devfn =3D 0; devfn < 256; devfn++) {
> +                if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) =
&&
> +                    l !=3D 0x0000 && l !=3D 0xffff) {
> +                        DBG("Found device at %02x:%02x [%04x]\n", busn, =
devfn, l);
> +                        pr_info("PCI: Discovered peer bus %02x\n", busn);
> +                        pcibios_scan_root(busn);
> +                        return;
> +                }
> +        }
> +}
> +
>  static void __init jailhouse_init_platform(void)
>  {
>  	u64 pa_data =3D boot_params.hdr.setup_data;
> @@ -153,6 +171,7 @@ static void __init jailhouse_init_platform(void)
>  	x86_platform.legacy.rtc		=3D 0;
>  	x86_platform.legacy.warm_reset	=3D 0;
>  	x86_platform.legacy.i8042	=3D X86_LEGACY_I8042_PLATFORM_ABSENT;
> +	x86_platform.pci_scan_bus	=3D jailhouse_pci_scan_bus_by_function;
>=20=20
>  	legacy_pic			=3D &null_legacy_pic;
>=20=20
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
>=20=20
>  static int kvmapf =3D 1;
>=20=20
> @@ -621,10 +623,31 @@ static void kvm_flush_tlb_others(const struct cpuma=
sk *cpumask,
>  	native_flush_tlb_others(flushmask, info);
>  }
>=20=20
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
> +	    l !=3D 0x0000 && l !=3D 0xffff) {
> +		pr_info("PCI: Discovered peer bus %02x\n", busn);
> +		pcibios_scan_root(busn);
> +        }
> +}
> +#endif
> +
>  static void __init kvm_guest_init(void)
>  {
>  	int i;
>=20=20
> +#ifdef CONFIG_PCI
> +	x86_platform.pci_scan_bus =3D kvm_pci_scan_bus;
> +#endif
> +
>  	if (!kvm_para_available())
>  		return;
>=20=20
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 50a2b492fdd6..19e1cc2cb6e0 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -118,6 +118,7 @@ struct x86_platform_ops x86_platform __ro_after_init =
=3D {
>  	.get_nmi_reason			=3D default_get_nmi_reason,
>  	.save_sched_clock_state 	=3D tsc_save_sched_clock_state,
>  	.restore_sched_clock_state 	=3D tsc_restore_sched_clock_state,
> +	.pci_scan_bus			=3D x86_default_pci_scan_bus,
>  	.hyper.pin_vcpu			=3D x86_op_int_noop,
>  };
>=20=20
> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
> index 467311b1eeea..6214dbce26d3 100644
> --- a/arch/x86/pci/legacy.c
> +++ b/arch/x86/pci/legacy.c
> @@ -36,14 +36,19 @@ int __init pci_legacy_init(void)
>=20=20
>  void pcibios_scan_specific_bus(int busn)
>  {
> -	int stride =3D jailhouse_paravirt() ? 1 : 8;
> -	int devfn;
> -	u32 l;
> -
>  	if (pci_find_bus(0, busn))
>  		return;
>=20=20
> -	for (devfn =3D 0; devfn < 256; devfn +=3D stride) {
> +	x86_platform.pci_scan_bus(busn);
> +}
> +EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
> +
> +void pcibios_scan_bus_by_device(int busn)
> +{
> +	int devfn;
> +	u32 l;
> +
> +	for (devfn =3D 0; devfn < 256; devfn +=3D 8) {
>  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
>  		    l !=3D 0x0000 && l !=3D 0xffff) {
>  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> @@ -53,7 +58,6 @@ void pcibios_scan_specific_bus(int busn)
>  		}
>  	}
>  }
> -EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
>=20=20
>  static int __init pci_subsys_init(void)
>  {


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl05d+AACgkQ9GknjS8M
AjW6KQ/+LVInvMtw2Q1gFORhNaXjU2hT8UNySHsiXljN8HEQSbfcQ3Ovs64yLf4s
PzZ7NM+jxW41Zom7/8SbCQew5peo31X3p/uOtoU+UcMu4RXul+/Ao49MdmxGmKbb
rEz7ziCQdEAZswsZomIcpv59PSGT2cf6UTqYM7qlVGl5QByeN1gmTQWfJp8Vxd4V
FdNCuhXc+Y5xHQcQ5nJeibV+cVfHR+5O0aN2+q9oK/eSo01wE4JbJC25aQnasQZ2
2loSWvzPYl7OiJgTpkbF/zwqIOTIJcgxrK/FBsT5fR9mrEZdi9PpoYZ9pD0R8tvy
shvcq2vDSQGU4xlbCQ9WEpCr9wUzBRbIeZFJTN4TF3XBUQL0UqdgcQbP73iMwU+5
QdfIc8GiTIa0Pu1ArpGKT/zUx/SuYVT321yq+PLmrnUw0sYgVlMJ3MlUIVSjmbSq
fTU/7XS4chxl2fKPOOcXji9WMWhzRt1CCgKIMFJMDQU4gYUY8CieXwjAdm0RquQZ
+Zz44A8qpkEBy8ZineXC8ZBrfXbSi5g+lrhPdCG4Y2HSf3J4VAY3aH6zIq8a9WUX
kNmCKr7ZW6RlxDzGtH9axZJrAWfCANUIX7Eiktrk89TNhKIa5Eav31HUq31OKrsA
I9xBX/QYAlB3T5e5JNcZYQtbzNkdcjZeNW0bUdfFrLvSOk6EFlQ=
=KQIj
-----END PGP SIGNATURE-----
--=-=-=--

