Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE04C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7B720724
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7B720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igGey-0006pV-UR
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 18:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1igGeC-0006Fy-FJ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 18:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1igGeB-0003bq-51
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 18:16:28 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55270)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1igGeB-0003UP-0s; Sat, 14 Dec 2019 18:16:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5F5F923F85;
 Sat, 14 Dec 2019 18:16:21 -0500 (EST)
Date: Sun, 15 Dec 2019 10:16:18 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
In-Reply-To: <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Herve Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 14 Dec 2019, Aleksandar Markovic wrote:

> On Saturday, December 14, 2019, Finn Thain <fthain@telegraphics.com.au>
> wrote:
> 
> > Hi All,
> >
> > There is a bug in the DP8393X emulation that can stop packet reception.
> >
> >
> Can you provide the details of your test scenario?
> 
> Thanks,
> Aleksandar
> 

I test the qemu build like this,

qemu-system-m68k -M q800 -m 512M -serial none -serial mon:stdio -g 800x600x4
-net nic,model=dp83932,addr=00:00:00:01:02:03
-net bridge,helper=/opt/qemu/libexec/qemu-bridge-helper,br=br0
-append "fbcon=font:ProFont6x11 console=tty0 console=ttyS0 ignore_loglevel"
-kernel vmlinux-4.14.157-mac-backport+
-initrd /mnt/loop/install/cdrom/initrd.gz

You can obtain this kernel binary from the linux-mac68k project on 
sourceforge. (I usually use a mainline Linux build but it makes no 
difference.)

I normally use a disk image with Debian/m68k SID rootfs but in this 
example I've used the initrd that you can find on the Debian/m68k 
installer ISO.

Once the guest starts, switch to a different virtual console and bring up 
the SONIC:

<ctrl>-<a> <ctrl>-<a> <2>
# ip addr add dev eth0 192.168.65.2/24
# ip link set dev eth0 up

On the host, send a ping flood (with preload) to the guest:

# ifconfig br0 192.168.65.1/24
# ping 192.168.65.2 -f -l 20

The packet reception ("deaf sonic") issue is reproduced immediately.

This has been observed in both qemu-m68k and mainline qemu. See also,
https://github.com/vivier/qemu-m68k/commit/0a45280c9fa40da8d5f30b1bb3d0513db91c3909


