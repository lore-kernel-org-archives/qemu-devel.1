Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC8C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E83B20692
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="vgL/gYJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E83B20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNuKC-0005g5-Iz
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 04:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jNuJZ-0005FM-Ke
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 04:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jNuJX-0000L6-DY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 04:19:33 -0400
Received: from vultr.net.flygoat.com
 ([2001:19f0:6001:3633:5400:2ff:fe8c:553]:33176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jNuJW-0000FO-4s
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 04:19:31 -0400
Received: from flygoat-x1e (unknown [IPv6:240e:390:49e:92c0::d68])
 by vultr.net.flygoat.com (Postfix) with ESMTPSA id 1680920CF2;
 Mon, 13 Apr 2020 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
 t=1586765960; bh=4oWYtlgTtO0X4LB3G6OgFIKhhJH7k9TnuQnTQzRB24o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vgL/gYJXeBGHG1mziH4t6cGyVwTKL3Fd8sATYRT5Y5Y5qLRFdPZrkpLT0ZzvJ2FoZ
 hzL398788Qe1tgyx1pfiaUWRRX+05cKSO7N5e1EK+AOqtstAvz1povGiZy39PSbqbq
 bx3SpCHz3hzJQjG0fV7jh7g5MbeK0iF1Mf2Z+zRD5jeRt6DMHbBv2L7L61+OKfrR75
 5iaPJljwdBn3NfBzqzNBByprnt29vTlWqcf9Pj6FpAoEqTEc10hDRaO4GEIJhE0D68
 +rb+cCjt7Zx/Goas7c4nUaPQBsm2HSwn3obSkn2fzM8qkIMSNNCWXOc4ay5NXf9lmr
 TgbZYXUbC1fgQ==
Date: Mon, 13 Apr 2020 16:18:42 +0800
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH 0/15] KVM: MIPS: Add Loongson-3 support (Host Side)
Message-ID: <20200413161842.57ad8be4@flygoat-x1e>
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:19f0:6001:3633:5400:2ff:fe8c:553
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
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 linux-mips@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Apr 2020 15:30:09 +0800
Huacai Chen <chenhc@lemote.com> wrote:

> We are preparing to add KVM support for Loongson-3. VZ extension is
> fully supported in Loongson-3A R4+, and we will not care about old
> CPUs (at least now). We already have a full functional Linux kernel
> (based on Linux-5.4.x LTS) and QEMU (based on 5.0.0-rc2) and their git
> repositories are here:
> 
> QEMU: https://github.com/chenhuacai/qemu
> Kernel: https://github.com/chenhuacai/linux
> 
> Of course these two repositories need to be rework and not suitable
> for upstream (especially the commits need to be splitted). We show
> them here is just to tell others what we have done, and how
> KVM/Loongson will look like.
> 
> Our plan is make the KVM host side be upstream first, and after that,
> we will make the KVM guest side and QEMU emulator be upstream.

+ Aleksandar as QEMU/MIPS mainatiner

I was involved in KVM/Loongson development a bit and also intend to
help with mainline these works.

After dealing with basic LS7A PCH kernel support, I'm going to
cooperate with Huacai and anyone who interested in to deal with
following stuff:

- Basic QEMU/TCG support for Loongson64 instructions.
	Well, it seems unrelated with KVM, but that would make
	development easier with cross ISA emulation. I'm not going to
	implement all the features like Loongson's page table fast walk
	extension and binary translation extension but I'll ensure any
	binary compiled with march=loongson3a can run flawlessly on
	TCG.

- Design of Loongson-VIRT QEMU machine
	It is nearly impossible to bring a real Loongson system into
	QEMU. Both RS780E and LS7A PCH have tons of unreasonable design
	that would make the emulation extremely complex, Loongson
	company's KVM implementation[1] has already proofed that,
	thay're now in the hell. So we all agreed that we should build
	a machine from draft. I think we should reuse existing infra as
	far as possible to reduce our work load. I'm planing to use
	pci-host-cam-generic together with VIRTIO PCI devices and a
	a strip down version of loongson,liointc-1.0a to build a pure
	PCI based system. But if any one have better idea please just
	tell us, I'm still considering how to implement SMP-IPI and ACPI
	stuff.

- BIOS in VM
	This has a lower priority. But BIOS is required to make a
	emulated machine looks like a real machine. Loongson have their
	open-sourced PMON and close-sourced UEFI(Based on tianocore).
	I'd really with Loongson or Lemote will open-source their UEFI
	but PMON is also a option.

Any kind of feedback is appreciated.

Thanks.

Wish you good health :-)


[1]: http://cgit.loongnix.org/cgit/linux-3.10/ &
http://cgit.loongnix.org/cgit/qemu-2.7.0/

Btw: I think Cc qemu-devel for the whole series is a little bit
disturb, probably we should only Cc qemu-devel for the cover letter.

> 
> Mike Rapoport(1):
>  mips: define pud_index() regardless of page table folding
> 
> Xing Li(2):
>  KVM: MIPS: Define KVM_ENTRYHI_ASID to cpu_asid_mask(&boot_cpu_data)
>  KVM: MIPS: Fix VPN2_MASK definition for variable cpu_vmbits
> 
> Huacai Chen(12):
>  KVM: MIPS: Increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16
>  KVM: MIPS: Add EVENTFD support which is needed by VHOST
>  KVM: MIPS: Use lddir/ldpte instructions to lookup gpa_mm.pgd
>  KVM: MIPS: Introduce and use cpu_guest_has_ldpte
>  KVM: MIPS: Use root tlb to control guest's CCA for Loongson-3
>  KVM: MIPS: Let indexed cacheops cause guest exit on Loongson-3
>  KVM: MIPS: Add more types of virtual interrupts
>  KVM: MIPS: Add Loongson-3 Virtual IPI interrupt support
>  KVM: MIPS: Add CPUCFG emulation for Loongson-3
>  KVM: MIPS: Add CONFIG6 and DIAG registers emulation
>  KVM: MIPS: Add more MMIO load/store instructions emulation
>  KVM: MIPS: Enable KVM support for Loongson-3
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/Kconfig                    |   1 +
>  arch/mips/include/asm/cpu-features.h |   3 +
>  arch/mips/include/asm/kvm_host.h     |  50 +++-
>  arch/mips/include/asm/mipsregs.h     |   7 +
>  arch/mips/include/asm/pgtable-64.h   |   4 +-
>  arch/mips/include/uapi/asm/inst.h    |  11 +
>  arch/mips/kernel/cpu-probe.c         |   2 +
>  arch/mips/kvm/Kconfig                |   1 +
>  arch/mips/kvm/Makefile               |   5 +-
>  arch/mips/kvm/emulate.c              | 461
> ++++++++++++++++++++++++++++++++++- arch/mips/kvm/entry.c
>    |  19 +- arch/mips/kvm/interrupt.c            |  93 +------
>  arch/mips/kvm/interrupt.h            |  14 +-
>  arch/mips/kvm/loongson_ipi.c         | 215 ++++++++++++++++
>  arch/mips/kvm/mips.c                 |  49 +++-
>  arch/mips/kvm/tlb.c                  |  39 +++
>  arch/mips/kvm/trap_emul.c            |   3 +
>  arch/mips/kvm/vz.c                   | 204 +++++++++++-----
>  18 files changed, 1013 insertions(+), 168 deletions(-)
>  create mode 100644 arch/mips/kvm/loongson_ipi.c
> --
> 2.7.0


