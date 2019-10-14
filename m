Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66097C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 20:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A9F2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 20:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jefwxsbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK6yq-0007To-9Z
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 16:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <incredible.tack@gmail.com>) id 1iK6xk-0006fy-TZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 16:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <incredible.tack@gmail.com>) id 1iK6xj-0006iM-FU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 16:29:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <incredible.tack@gmail.com>)
 id 1iK6xj-0006hf-6q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 16:29:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id h4so21189578wrv.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=74FU2wgeq8Tz9l2TgC2P08Izi2uA7upveMAbzTmL84g=;
 b=jefwxsbnzdzOMqtWOJXpCd8vReylRs5eEVVusP0zxWtuUoUBEqjTqK0tm1CxlUl56+
 /iLyLdsD5AMdTB0jiuy6NNch7Fs99E3CntjYDIpBuwDI+AwoAxgIbfyGZVgm8G6X9bMf
 I+sbbBBurQraUplxsNZiilIYGoAuhb4SzMmUSApNHs3pB0uco6oyq/91WiKa9z8IciBI
 GCTpVnwf2mVdFSpHeIQLQ4oySqmibLorRV+XYfKGNkXew3nLpTCsqwFyVLx3Zu01E9+Q
 dRtEdnuhEiyMQyafXDntQ4+dPXP87mde+ulK3X+nAu20xUdBWN4/iQCCfTRxyNI4g1PP
 Z0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=74FU2wgeq8Tz9l2TgC2P08Izi2uA7upveMAbzTmL84g=;
 b=nRisab4+9s+BWzGCL+VrWR7H0WNEOgxEhFWK/dDoo8hAkylqBTbJWXxUbtcwbkjqJY
 Hj8OBqn8eJPVnTENDE5l02jsKV1S82VHtjROqC0Ssbq0w2aRfMSpZjJPkgfiTL+xu4TD
 vw84gd9+uO1NugS/8sFcUAaLkEACxYgXJFEvt46tsLhb6c0Rt+dY6gBASTpiWbE5yMdk
 C0+guDLCAK4o4qJxAorcvzEifeR1/u33P1tKvRbB4nhJ6UO/Sem6KnsJG1Lsd5LdyEz1
 EB2Wr1hRQTnd6AFzcvJ5pgUtZz0H//MzhRlb3WX2iUoenWRa7cuMMvFmw25DfCq5tRF7
 QczA==
X-Gm-Message-State: APjAAAVbtjvGUsYa5kfow2f3SPiDHSIsN8UaPbScrMcElGpq6t/wd5z4
 EAK7XS9Rq8n/Z7vIzU7tpVsJm2aOeLuVG7YPiylZe61r
X-Google-Smtp-Source: APXvYqyLPcrbjDuIbLdADeVHejkb0qT/XrMuQGfeAyKZMhZa1ydqoSfWh7vOdhv89GizcIHrd2052tfUtUtVEwtISkw=
X-Received: by 2002:a5d:6449:: with SMTP id d9mr28697981wrw.246.1571084940716; 
 Mon, 14 Oct 2019 13:29:00 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <incredible.tack@gmail.com>
Date: Mon, 14 Oct 2019 13:28:49 -0700
Message-ID: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
Subject: Using virtual IOMMU in guest hypervisors other than KVM and Xen?
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm trying to pass through a physical network device to a nested VM
using virtual IOMMU. While I was able to do it successfully using KVM
and Xen guest hypervisors running in a VM respectively, I couldn't do
it with Hyper-V as I described below. I wonder if anyone have
successfully used virtual IOMMU in other hypervisors other than KVM
and Xen? (like Hyper-V or VMware)

The issue I have with Hyper-V is that Hyper-V gives an error that the
underlying hardware is not capable of doing passthrough. The exact
error message is as follows.

Windows Power-shell > (Get-VMHost).IovSupportReasons
The chipset on the system does not do DMA remapping, without which
SR-IOV cannot be supported.

I'm pretty sure that Hyper-V recognizes virtual IOMMU, though; I have
enabled iommu in windows boot loader[1], and I see differences when
booing a Windows VM with and without virtual IOMMU. I also checked
that virtual IOMMU traces are printed.

I have tried multiple KVM/QEMU versions including the latest ones
(kernel v5.3, QEMU 4.1.0) as well as two different Windows servers
(2016 and 2019), but I see the same result. [4]

I'd love to hear if somebody is using virtual IOMMU in Hyper-V or
VMware successfully, especially for passthrough. I also appreciate if
somebody can point out any configuration errors I have.

Here's the qemu command line I use, basically from the QEMU vt-d
page[2] and Hyper-v on KVM from kvmforum [3].

./qemu/x86_64-softmmu/qemu-system-x86_64 -device
intel-iommu,intremap=on,caching-mode=on -smp 6 -m 24G -M
q35,accel=kvm,kernel-irqchip=split -cpu
host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -drive
if=none,file=/vm/guest0.img,id=vda,cache=none,format=raw -device
virtio-blk-pci,drive=vda --nographic -qmp
unix:/var/run/qmp,server,nowait -serial
telnet:127.0.0.1:4444,server,nowait -netdev
user,id=net0,hostfwd=tcp::2222-:22 -device
virtio-net-pci,netdev=net0,mac=de:ad:be:ef:f2:12 -netdev
tap,id=net1,vhost=on,helper=/srv/vm/qemu/qemu-bridge-helper -device
virtio-net-pci,netdev=net1,disable-modern=off,disable-legacy=on,mac=de:ad:be:ef:f2:11
-device vfio-pci,host=0000:06:10.0,id=net2 -monitor stdio -usb -device
usb-tablet -rtc base=localtime,clock=host -vnc 127.0.0.1:4 --cdrom
win19.iso --drive file=virtio-win.iso,index=3,media=cdrom

Thanks,
Jintack

[1] https://social.technet.microsoft.com/Forums/en-US/a7c2940a-af32-4dab-8b31-7a605e8cf075/a-hypervisor-feature-is-not-available-to-the-user?forum=WinServerPreview
[2] https://wiki.qemu.org/Features/VT-d
[3] https://www.linux-kvm.org/images/6/6a/HyperV-KVM.pdf
[4] https://www.mail-archive.com/qemu-devel@nongnu.org/msg568963.html

