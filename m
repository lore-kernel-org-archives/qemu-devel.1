Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F33C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 04:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414D5206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 04:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="KrrJvxQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414D5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jODSX-0003qw-Bd
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 00:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jODRm-0003LS-Ge
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 00:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jODRk-0005gz-Ij
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 00:45:18 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:52048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jODRk-0005dc-AH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 00:45:16 -0400
Received: from flygoat-x1e (unknown [IPv6:240e:390:49e:92c0::d68])
 by vultr.net.flygoat.com (Postfix) with ESMTPSA id C3D3E20C23;
 Tue, 14 Apr 2020 04:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
 t=1586839514; bh=fiBXmk7zQ1jWSQ3x6kAoQtu9VO+WgvkkjUzmqBTQUYE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KrrJvxQ6GJ/L9QJCz9Dw8SY8+mtDwUMtxRfi3VnNkQFE4K8OiQK0dPRHWtSCny+cA
 AS3l+bzOrUlHXZ5YrAKkFANdGA+hh9cXGknajEk8v4o+cbUv7qKjUg+C57Ewit9wSC
 4VZi2WIP9ZySxzCaFnLBbe4y1CfnnXWw/5sXXVdjBivnzpc3dmp+njG/nqDNmQn2WH
 xfcJHb9GesmmN2o3j6lMPd3Y/a9QeLsFYVFPuXySOk947xfp9CzpiOvoWJjAPWrV+R
 JZs1gMYKEpBYEibIW+cj/PKQGJPehLPbj00tRau4oCj9nOaDWnfwjm8TdVqZCv+H63
 JcZy+OuK0X1Mw==
Date: Tue, 14 Apr 2020 12:44:58 +0800
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: maobibo <maobibo@loongson.cn>
Subject: Re: [PATCH 0/15] KVM: MIPS: Add Loongson-3 support (Host Side)
Message-ID: <20200414124458.4675125b@flygoat-x1e>
In-Reply-To: <bbbeb507-5692-5969-c320-57d04823edc7@loongson.cn>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
 <20200413161842.57ad8be4@flygoat-x1e>
 <bbbeb507-5692-5969-c320-57d04823edc7@loongson.cn>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 149.28.68.211
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>, Fuxin Zhang <zhangfx@lemote.com>,
 linux-mips@vger.kernel.org, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, lixing@loongson.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 09:40:26 +0800
maobibo <maobibo@loongson.cn> wrote:

> On 04/13/2020 04:18 PM, Jiaxun Yang wrote:
> > On Mon, 13 Apr 2020 15:30:09 +0800
> > Huacai Chen <chenhc@lemote.com> wrote:
> >   
> >> We are preparing to add KVM support for Loongson-3. VZ extension is
> >> fully supported in Loongson-3A R4+, and we will not care about old
> >> CPUs (at least now). We already have a full functional Linux kernel
> >> (based on Linux-5.4.x LTS) and QEMU (based on 5.0.0-rc2) and their
> >> git repositories are here:
> >>
> >> QEMU: https://github.com/chenhuacai/qemu
> >> Kernel: https://github.com/chenhuacai/linux
> >>
> >> Of course these two repositories need to be rework and not suitable
> >> for upstream (especially the commits need to be splitted). We show
> >> them here is just to tell others what we have done, and how
> >> KVM/Loongson will look like.
> >>
> >> Our plan is make the KVM host side be upstream first, and after
> >> that, we will make the KVM guest side and QEMU emulator be
> >> upstream.  
> > 
> > + Aleksandar as QEMU/MIPS mainatiner
> > 
> > I was involved in KVM/Loongson development a bit and also intend to
> > help with mainline these works.
> > 
> > After dealing with basic LS7A PCH kernel support, I'm going to
> > cooperate with Huacai and anyone who interested in to deal with
> > following stuff:
> > 
> > - Basic QEMU/TCG support for Loongson64 instructions.
> > 	Well, it seems unrelated with KVM, but that would make
> > 	development easier with cross ISA emulation. I'm not going
> > to implement all the features like Loongson's page table fast walk
> > 	extension and binary translation extension but I'll ensure
> > any binary compiled with march=loongson3a can run flawlessly on
> > 	TCG.
> > 
> > - Design of Loongson-VIRT QEMU machine
> > 	It is nearly impossible to bring a real Loongson system into
> > 	QEMU. Both RS780E and LS7A PCH have tons of unreasonable
> > design that would make the emulation extremely complex, Loongson
> > 	company's KVM implementation[1] has already proofed that,
> > 	thay're now in the hell. So we all agreed that we should
> > build a machine from draft. I think we should reuse existing infra
> > as far as possible to reduce our work load. I'm planing to use
> > 	pci-host-cam-generic together with VIRTIO PCI devices and a
> > 	a strip down version of loongson,liointc-1.0a to build a
> > pure PCI based system. But if any one have better idea please just
> > 	tell us, I'm still considering how to implement SMP-IPI and
> > ACPI stuff.  

Hi Bibo,
Thanks for your response.

+ Xing Li as I heard he is in charge of KVM from Loongson's news post.

> It is a good job to add kvm virtualization support on loongson64
> platform. I agree that we should define common virt machine hardware
> system, however the compiled kernel binary should be the same with
> host system, else it will bring out trouble for customers to
> differentiate them between guest system and host system.

I'm planing to use DeviceTree to pass device information between QEMU
and guest kernel. So we can upgrade VM design at any moment without
breaking Host Guest kernel compatibility.

 
> For pci host bridge emulation, I suggest that gpex pcie host bridge
> should be used, since it supports pcie hotplug and arm/riscv uses
> this pcie host bridge.


gpex is basically a pci-host-cam-generic at kernel point of view. I'm
planing to reuse it too.

> 
> For virtual interrupt controller, it should support MSI/MSIX
> interrupt, irqchip in kernel, IRQFD, vhost/vfio etc. I have no idea
> how to define virtual interrupt controller now.

Yes, APIC from x86 and GIC from Arm are all bonded closely with their
architecture so we can't reuse them. Probably what we need is a
modified version of EXTIOI from Loongson-3A4000.

Does Loongson have a plan to implement hardware virtual irqchip? If so
we must align with it's design.

My plan is we can firstly implement a very simple IRQCHIP instead of
complex one which only handle UART and PCI INTx. That is enough to make
the system work. After that we can sit and discuss how to implement a
complicated version to archive more features.

> 
> 
> regards
> bibo,mao
> 
[...]

