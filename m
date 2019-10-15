Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99ECC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 02:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E4F20673
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 02:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnX1DyRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E4F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKCv8-0000iR-Qj
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 22:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKCuR-00008o-PB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 22:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKCuP-0005iD-Id
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 22:50:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33482
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKCuP-0005ha-49
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 22:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571107800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1q44dWch4chfz0/BsROQCNrRh9wkklOqnNPCufE6xI4=;
 b=MnX1DyReuFUfUcYGzkQRgEbSbuqVI7zi7neCwXPDUhf8Pkon8xhY1awMJxZKL1YJpgl66V
 0YdAS0Kxeqi27eVsrgcCMl4hyncq/o+2/EFFStEjy6WIjtjb2P1BnjkPWbdCoA52D6oGA6
 TfGdCQIoRYabOuLqm6f4WNNJQo1J/9U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-o00AI00oM4qrZX-ssrr9lg-1; Mon, 14 Oct 2019 22:49:58 -0400
Received: by mail-pf1-f200.google.com with SMTP id 22so14834538pfx.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 19:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nCarGdQEOA5aO4fVamgUVJ0MfIo/QbgBHqgPzPiuRT4=;
 b=dYmQl3V8x2VEXbWIYoF40IRve19C5zFN7164+sBEo5f9mqrCNUxSPRioOyuJY0lWr4
 SxPE3dDuPle0LrCuLZv7xUS3hdfHXjd5GWqNu3byH22tfkOKL/H8XRfHNde1ves6JwES
 43eIJZtXsBU3fb9qIyqr2AbhcOinXQGrQoGBPE6GGiZhHhhGbd/+7l+pGqZGVpIh/26f
 QweqFbTgmgryPJncZ3zEiHrZ3D0OZ+uT0Lag1GsV6PH+TVIHuy9fvxuFWlb690rFBGRe
 rtsKo7xq3Z0vjKmdRM0jYxijrRjvdrvPRwDu78tPCnLJXftogRZjIsMs/lQ7wUEHRYFJ
 VeWg==
X-Gm-Message-State: APjAAAUrJCCVe1TzDqp+QJfK6I3a/Nw0CVHbyZgQ2c3F3bnn8t7N1y5q
 /mu4hxtyhMBKNRth8CBBBWYlu5VbAI7SpDwVabic9aY8kHTKeWjzHG7havPdobwcXC4u9t1k6WU
 exCKsxGnR/ysQm/w=
X-Received: by 2002:a63:5022:: with SMTP id e34mr19826495pgb.400.1571107796828; 
 Mon, 14 Oct 2019 19:49:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZnGrvaQVdoPbIm1USKObWqZfAkFAhGHnZBLW9Zc+ByutHoJlBtO63o1J4JMu8GzzqjbUjAQ==
X-Received: by 2002:a63:5022:: with SMTP id e34mr19826472pgb.400.1571107796382; 
 Mon, 14 Oct 2019 19:49:56 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p66sm19250476pfg.127.2019.10.14.19.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 19:49:55 -0700 (PDT)
Date: Tue, 15 Oct 2019 10:49:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Jintack Lim <incredible.tack@gmail.com>
Subject: Re: Using virtual IOMMU in guest hypervisors other than KVM and Xen?
Message-ID: <20191015024947.GC8666@xz-x1>
References: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: o00AI00oM4qrZX-ssrr9lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Mon, Oct 14, 2019 at 01:28:49PM -0700, Jintack Lim wrote:
> Hi,

Hello, Jintack,

>=20
> I'm trying to pass through a physical network device to a nested VM
> using virtual IOMMU. While I was able to do it successfully using KVM
> and Xen guest hypervisors running in a VM respectively, I couldn't do
> it with Hyper-V as I described below. I wonder if anyone have
> successfully used virtual IOMMU in other hypervisors other than KVM
> and Xen? (like Hyper-V or VMware)
>=20
> The issue I have with Hyper-V is that Hyper-V gives an error that the
> underlying hardware is not capable of doing passthrough. The exact
> error message is as follows.
>=20
> Windows Power-shell > (Get-VMHost).IovSupportReasons
> The chipset on the system does not do DMA remapping, without which
> SR-IOV cannot be supported.
>=20
> I'm pretty sure that Hyper-V recognizes virtual IOMMU, though; I have
> enabled iommu in windows boot loader[1], and I see differences when
> booing a Windows VM with and without virtual IOMMU. I also checked
> that virtual IOMMU traces are printed.

What traces have you checked?  More explicitly, have you seen DMAR
enabled and page table setup for that specific device to be
pass-throughed?

>=20
> I have tried multiple KVM/QEMU versions including the latest ones
> (kernel v5.3, QEMU 4.1.0) as well as two different Windows servers
> (2016 and 2019), but I see the same result. [4]
>=20
> I'd love to hear if somebody is using virtual IOMMU in Hyper-V or
> VMware successfully, especially for passthrough. I also appreciate if
> somebody can point out any configuration errors I have.
>=20
> Here's the qemu command line I use, basically from the QEMU vt-d
> page[2] and Hyper-v on KVM from kvmforum [3].
>=20
> ./qemu/x86_64-softmmu/qemu-system-x86_64 -device
> intel-iommu,intremap=3Don,caching-mode=3Don -smp 6 -m 24G -M

Have you tried to use 4-level IOMMU page table (aw-bits=3D48 on latest
QEMU, or x-aw-bits=3D48 on some old ones)?  IIRC we've encountered
issues when trying to pass the SVVP Windows test with this, in which
4-level is required.  I'm not sure whether whether that is required in
general usages of vIOMMU in Windows.

> q35,accel=3Dkvm,kernel-irqchip=3Dsplit -cpu
> host,hv_relaxed,hv_spinlocks=3D0x1fff,hv_vapic,hv_time -drive
> if=3Dnone,file=3D/vm/guest0.img,id=3Dvda,cache=3Dnone,format=3Draw -devic=
e
> virtio-blk-pci,drive=3Dvda --nographic -qmp
> unix:/var/run/qmp,server,nowait -serial
> telnet:127.0.0.1:4444,server,nowait -netdev
> user,id=3Dnet0,hostfwd=3Dtcp::2222-:22 -device
> virtio-net-pci,netdev=3Dnet0,mac=3Dde:ad:be:ef:f2:12 -netdev
> tap,id=3Dnet1,vhost=3Don,helper=3D/srv/vm/qemu/qemu-bridge-helper -device
> virtio-net-pci,netdev=3Dnet1,disable-modern=3Doff,disable-legacy=3Don,mac=
=3Dde:ad:be:ef:f2:11
> -device vfio-pci,host=3D0000:06:10.0,id=3Dnet2 -monitor stdio -usb -devic=
e
> usb-tablet -rtc base=3Dlocaltime,clock=3Dhost -vnc 127.0.0.1:4 --cdrom
> win19.iso --drive file=3Dvirtio-win.iso,index=3D3,media=3Dcdrom

--=20
Peter Xu


