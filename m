Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC6EFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A19D218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id8jpQ7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A19D218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKrNG-0000zN-Gi
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 18:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <incredible.tack@gmail.com>) id 1iKrMP-0000Vm-KG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <incredible.tack@gmail.com>) id 1iKrMO-0002oU-6c
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:01:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <incredible.tack@gmail.com>)
 id 1iKrMN-0002oC-V4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:01:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id o18so29678039wrv.13
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yTf2cKEGSgtpM0CdnbYL8M/XD+QtqvoTZ9y7pEowYZ8=;
 b=Id8jpQ7hbPVXO5Tu8yhJReby0UwGlvUKwyHZmKQyE+6q4VjvFUSkqjEQOH59xvbbWI
 kaQtjU4IDDSq3N//MyQTk8yo8FUN5l/qFVWtM9JiYDLFBWaIc3qaxSsgvir1YUpQPJzN
 gqOH/+YcQbFt3ePCcgRZ0bnVQtqnfVj9K/rit6Qsw4TEPtvMATbTeleDpL2PktHLht2h
 R6UDmtYsG58mGCh8yCLmeyJNRshLaavMGyGAdbjyGXzksqRbhsd32ryPp9YHlDNJ5Kud
 wGOAUE74yc891VQ+XI9hG6XUojyk3ds84EdvOTervsE9Yd3l/iYVv6tjSPTL4v/0x0ww
 dlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yTf2cKEGSgtpM0CdnbYL8M/XD+QtqvoTZ9y7pEowYZ8=;
 b=JVToggtgsVJUqTPdF11CM9csptlpF2aKCXdWvMzMQ05xrHN0Sbz9nm6EdvH+P1ShbP
 bTXnILCDeHmPcIhm3kkQK4A64U5LCMc6yeynyXW+JI/t9aEA2b/xnu7oiTstYuVbGxD+
 9zXguJZT6kVQAjVA5iIYtz0fEIxymp41Tpki0zYbutI2wrrFoM0XZXJNRnUsSshfFrna
 N1nHx7TKokZ5wFkR8yb3h6x/3Fqu+wP2/udy+OqVWFmDk28A50vcIlTk1ra4WDGZrAbI
 kTaYhhdZY+/mRASavjdZH74t/mihpLfT7jdJeDOggAXfntSvA2dSWajxd8/v5mCuioFo
 3Ldg==
X-Gm-Message-State: APjAAAWWfW3zEVUOhOIdJalUJJoItcrA7ozhFrmfbsNJAcc/1Fq1FXiw
 qOUhP7Akcdirg9+xcN1ILLYbkczeZpMHYxL61g0=
X-Google-Smtp-Source: APXvYqx6bbS0LYIbsmwxRKOYTaspah8MDFOhGcznxNZz4csxBxpkWDS/1WcEx6VYTfdoFrtxyR8kI4Wj+HxSO+YpThc=
X-Received: by 2002:adf:f685:: with SMTP id v5mr74364wrp.246.1571263294001;
 Wed, 16 Oct 2019 15:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
 <20191015024947.GC8666@xz-x1>
In-Reply-To: <20191015024947.GC8666@xz-x1>
From: Jintack Lim <incredible.tack@gmail.com>
Date: Wed, 16 Oct 2019 15:01:22 -0700
Message-ID: <CAHyh4xgzqMuWR7moxPfWZarED5HtPcu3LmnTHMe7CpwScHa4Eg@mail.gmail.com>
Subject: Re: Using virtual IOMMU in guest hypervisors other than KVM and Xen?
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 7:50 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 14, 2019 at 01:28:49PM -0700, Jintack Lim wrote:
> > Hi,
>
> Hello, Jintack,
>
Hi Peter,

> >
> > I'm trying to pass through a physical network device to a nested VM
> > using virtual IOMMU. While I was able to do it successfully using KVM
> > and Xen guest hypervisors running in a VM respectively, I couldn't do
> > it with Hyper-V as I described below. I wonder if anyone have
> > successfully used virtual IOMMU in other hypervisors other than KVM
> > and Xen? (like Hyper-V or VMware)
> >
> > The issue I have with Hyper-V is that Hyper-V gives an error that the
> > underlying hardware is not capable of doing passthrough. The exact
> > error message is as follows.
> >
> > Windows Power-shell > (Get-VMHost).IovSupportReasons
> > The chipset on the system does not do DMA remapping, without which
> > SR-IOV cannot be supported.
> >
> > I'm pretty sure that Hyper-V recognizes virtual IOMMU, though; I have
> > enabled iommu in windows boot loader[1], and I see differences when
> > booing a Windows VM with and without virtual IOMMU. I also checked
> > that virtual IOMMU traces are printed.
>
> What traces have you checked?  More explicitly, have you seen DMAR
> enabled and page table setup for that specific device to be
> pass-throughed?

Thanks for the pointers. I checked that DMAR is NOT enabled. The only
registers that Windows guest accessed were Version Register,
Capability Register, and Extended Capability Register. On the other
hand, a Linux guest accessed other registers and enabled DMAR.
Here's a link to the trace I got using QEMU 4.1.0. Do you see anything
interesting there?
http://paste.ubuntu.com/p/YcSyxG9Z3x/

>
> >
> > I have tried multiple KVM/QEMU versions including the latest ones
> > (kernel v5.3, QEMU 4.1.0) as well as two different Windows servers
> > (2016 and 2019), but I see the same result. [4]
> >
> > I'd love to hear if somebody is using virtual IOMMU in Hyper-V or
> > VMware successfully, especially for passthrough. I also appreciate if
> > somebody can point out any configuration errors I have.
> >
> > Here's the qemu command line I use, basically from the QEMU vt-d
> > page[2] and Hyper-v on KVM from kvmforum [3].
> >
> > ./qemu/x86_64-softmmu/qemu-system-x86_64 -device
> > intel-iommu,intremap=on,caching-mode=on -smp 6 -m 24G -M
>
> Have you tried to use 4-level IOMMU page table (aw-bits=48 on latest
> QEMU, or x-aw-bits=48 on some old ones)?  IIRC we've encountered
> issues when trying to pass the SVVP Windows test with this, in which
> 4-level is required.  I'm not sure whether whether that is required in
> general usages of vIOMMU in Windows.

I just tried the option you mentioned, but it didn't change anything.
BTW, what version of Windows was it?

>
> > q35,accel=kvm,kernel-irqchip=split -cpu
> > host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -drive
> > if=none,file=/vm/guest0.img,id=vda,cache=none,format=raw -device
> > virtio-blk-pci,drive=vda --nographic -qmp
> > unix:/var/run/qmp,server,nowait -serial
> > telnet:127.0.0.1:4444,server,nowait -netdev
> > user,id=net0,hostfwd=tcp::2222-:22 -device
> > virtio-net-pci,netdev=net0,mac=de:ad:be:ef:f2:12 -netdev
> > tap,id=net1,vhost=on,helper=/srv/vm/qemu/qemu-bridge-helper -device
> > virtio-net-pci,netdev=net1,disable-modern=off,disable-legacy=on,mac=de:ad:be:ef:f2:11
> > -device vfio-pci,host=0000:06:10.0,id=net2 -monitor stdio -usb -device
> > usb-tablet -rtc base=localtime,clock=host -vnc 127.0.0.1:4 --cdrom
> > win19.iso --drive file=virtio-win.iso,index=3,media=cdrom
>
> --
> Peter Xu
>

