Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD35C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 09:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F48214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 09:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv9753Jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F48214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQ6N4-0007Y6-6L
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 05:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jQ6MK-0006lk-VB
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jQ6MJ-0004Q5-Ih
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:35:28 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jQ6MJ-0004NE-3f
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:35:27 -0400
Received: by mail-io1-xd43.google.com with SMTP id i3so7384625ioo.13
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2020 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ifCEXwwU8W7gVbM6yZO1vYxfict7Lt94AKxJJRZLIg=;
 b=fv9753Jt8E8fPX/Ee7CMAhH/Emin1tEn2NOk49yzIwHiMFzWg0Vn8rsrIhdssC2oGD
 jLRY9VgNZ+pYhLFA88zNer3PwSy57GTZhwwuF/9rmy76plHV8fxCdFpEh5QGLx+PEJUo
 4+bwta5w82/90/C6bfVmrO1SqBSNBuZiItdYtetSyVnuRiTBZVMcTxHvd1VKQOOqQOHU
 lpf0heU0etTJz0WtwkDvOFdolKehNfJpoGhGLtp8rlURjfk5pufbvk5sDl2De02ncH5B
 aWVYuZXcHzD2Ewub/JkKhZ8/dTE7G1gKeEDs9S2E2+ufFLedt8uGPjyqm0wroxYwv+yM
 +Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ifCEXwwU8W7gVbM6yZO1vYxfict7Lt94AKxJJRZLIg=;
 b=FJHy13JUxjxqSKu1GVuvqbPcnYvahqfktdNbnwSfMIT+SRpXVfw1vGBbpSiPNi+Xo+
 DjpnPxDHXbhT+guo5pljBUuZfEumx4EfXSG7e5WK7ttG22hWWiXXP80eAOOa7rpzFtws
 yr6P9m005251ebBkzpAhnV8j9dJPl8uAfFZRCFQgeO4PvixBU9kghv0aCr3GoBO6cfDq
 OY8rftDUJYcNWiYB00IleNuhfpUdbcTcI2z6ldlHtyTiTtA2HKs/F45ibY6k3hHa/vqi
 4l/8j2DwvUHpWmy091vtSH3689XOWnriq6laZPqytbfKMj5kEpjRxrpdjcthuu0TQxKG
 n1Tg==
X-Gm-Message-State: AGi0PubKeB9AtPtDq2dEchnTrjd3jj2ARcyO8peHEP2D1b2rQCvHZmIN
 BEqWT0Eliwut5QIb5YVRkkw5WxeedEHdvssnBcA=
X-Google-Smtp-Source: APiQypKrODPQCvtX30O5GZ0mt2fmmNk2aWstL6sC8lTi8uw9h0nbE9KVpREkCas6LhnruyKIKeUsPLHVLVLwrNCajUY=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr11081929ioj.42.1587288925427; 
 Sun, 19 Apr 2020 02:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
 <20200413161842.57ad8be4@flygoat-x1e>
 <bbbeb507-5692-5969-c320-57d04823edc7@loongson.cn>
 <20200414124458.4675125b@flygoat-x1e>
In-Reply-To: <20200414124458.4675125b@flygoat-x1e>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 19 Apr 2020 17:42:44 +0800
Message-ID: <CAAhV-H70-n3zaVH789k8hnNYEaQ8sT36=+BbRZ0vZQSgKrxT7w@mail.gmail.com>
Subject: Re: [PATCH 0/15] KVM: MIPS: Add Loongson-3 support (Host Side)
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
 "open list:MIPS" <linux-mips@vger.kernel.org>, maobibo <maobibo@loongson.cn>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, all,

On Tue, Apr 14, 2020 at 12:45 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> On Tue, 14 Apr 2020 09:40:26 +0800
> maobibo <maobibo@loongson.cn> wrote:
>
> > On 04/13/2020 04:18 PM, Jiaxun Yang wrote:
> > > On Mon, 13 Apr 2020 15:30:09 +0800
> > > Huacai Chen <chenhc@lemote.com> wrote:
> > >
> > >> We are preparing to add KVM support for Loongson-3. VZ extension is
> > >> fully supported in Loongson-3A R4+, and we will not care about old
> > >> CPUs (at least now). We already have a full functional Linux kernel
> > >> (based on Linux-5.4.x LTS) and QEMU (based on 5.0.0-rc2) and their
> > >> git repositories are here:
> > >>
> > >> QEMU: https://github.com/chenhuacai/qemu
> > >> Kernel: https://github.com/chenhuacai/linux
> > >>
> > >> Of course these two repositories need to be rework and not suitable
> > >> for upstream (especially the commits need to be splitted). We show
> > >> them here is just to tell others what we have done, and how
> > >> KVM/Loongson will look like.
> > >>
> > >> Our plan is make the KVM host side be upstream first, and after
> > >> that, we will make the KVM guest side and QEMU emulator be
> > >> upstream.
> > >
> > > + Aleksandar as QEMU/MIPS mainatiner
> > >
> > > I was involved in KVM/Loongson development a bit and also intend to
> > > help with mainline these works.
> > >
> > > After dealing with basic LS7A PCH kernel support, I'm going to
> > > cooperate with Huacai and anyone who interested in to deal with
> > > following stuff:
> > >
> > > - Basic QEMU/TCG support for Loongson64 instructions.
> > >     Well, it seems unrelated with KVM, but that would make
> > >     development easier with cross ISA emulation. I'm not going
> > > to implement all the features like Loongson's page table fast walk
> > >     extension and binary translation extension but I'll ensure
> > > any binary compiled with march=loongson3a can run flawlessly on
> > >     TCG.
> > >
> > > - Design of Loongson-VIRT QEMU machine
> > >     It is nearly impossible to bring a real Loongson system into
> > >     QEMU. Both RS780E and LS7A PCH have tons of unreasonable
> > > design that would make the emulation extremely complex, Loongson
> > >     company's KVM implementation[1] has already proofed that,
> > >     thay're now in the hell. So we all agreed that we should
> > > build a machine from draft. I think we should reuse existing infra
> > > as far as possible to reduce our work load. I'm planing to use
> > >     pci-host-cam-generic together with VIRTIO PCI devices and a
> > >     a strip down version of loongson,liointc-1.0a to build a
> > > pure PCI based system. But if any one have better idea please just
> > >     tell us, I'm still considering how to implement SMP-IPI and
> > > ACPI stuff.
>
> Hi Bibo,
> Thanks for your response.
>
> + Xing Li as I heard he is in charge of KVM from Loongson's news post.
>
> > It is a good job to add kvm virtualization support on loongson64
> > platform. I agree that we should define common virt machine hardware
> > system, however the compiled kernel binary should be the same with
> > host system, else it will bring out trouble for customers to
> > differentiate them between guest system and host system.
>
> I'm planing to use DeviceTree to pass device information between QEMU
> and guest kernel. So we can upgrade VM design at any moment without
> breaking Host Guest kernel compatibility.
>
>
> > For pci host bridge emulation, I suggest that gpex pcie host bridge
> > should be used, since it supports pcie hotplug and arm/riscv uses
> > this pcie host bridge.
>
>
> gpex is basically a pci-host-cam-generic at kernel point of view. I'm
> planing to reuse it too.
I agree to use GPEX, and the qemu in github is updated to use GPEX.

>
> >
> > For virtual interrupt controller, it should support MSI/MSIX
> > interrupt, irqchip in kernel, IRQFD, vhost/vfio etc. I have no idea
> > how to define virtual interrupt controller now.
>
> Yes, APIC from x86 and GIC from Arm are all bonded closely with their
> architecture so we can't reuse them. Probably what we need is a
> modified version of EXTIOI from Loongson-3A4000.
>
> Does Loongson have a plan to implement hardware virtual irqchip? If so
> we must align with it's design.
>
> My plan is we can firstly implement a very simple IRQCHIP instead of
> complex one which only handle UART and PCI INTx. That is enough to make
> the system work. After that we can sit and discuss how to implement a
> complicated version to archive more features.
>
> >
> >
> > regards
> > bibo,mao
> >
> [...]

