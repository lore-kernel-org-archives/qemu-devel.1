Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C1F2072A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C1F2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igeO6-0003Ts-4u
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 19:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1igeNX-00034u-C1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1igeNW-0006Ej-74
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:36:51 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35288)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1igeNW-0006Ak-3X; Sun, 15 Dec 2019 19:36:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7030023F85;
 Sun, 15 Dec 2019 19:36:44 -0500 (EST)
Date: Mon, 16 Dec 2019 11:36:41 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, 
 Herve Poussineau <hpoussin@reactos.org>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
In-Reply-To: <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1.1912160906420.11@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
 <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
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
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 15 Dec 2019, Finn Thain wrote:

> I test the qemu build like this,
> 
> qemu-system-m68k -M q800 -m 512M -serial none -serial mon:stdio -g 800x600x4
> -net nic,model=dp83932,addr=00:00:00:01:02:03
> -net bridge,helper=/opt/qemu/libexec/qemu-bridge-helper,br=br0
> -append "fbcon=font:ProFont6x11 console=tty0 console=ttyS0 ignore_loglevel"
> -kernel vmlinux-4.14.157-mac-backport+
> -initrd /mnt/loop/install/cdrom/initrd.gz
> 
> You can obtain this kernel binary from the linux-mac68k project on 
> sourceforge. (I usually use a mainline Linux build but it makes no 
> difference.)
> 

One difficulty with testing these patches with Linux guests is some old 
bugs in drivers/net/ethernet/natsemi/sonic.c that can cause tx watchdog 
timeouts on real hardware.

I have some patches for that driver which may be useful when testing 
QEMU's hw/net/dp8393x.c device. (I've pushed those patches to my github 
repo.)

The second obstacle I have involves testing the dp8393x device with a 
bridge device on a Linux/i686 host.

Running tcpdump in the Linux/m68k guest showed these two ping packets from 
the host,

00:15:28.480164 IP 192.168.66.1 > 192.168.66.111: ICMP echo request, id 23957, seq 11, length 64
        0x0000:  0800 0702 0304 fe16 d9ae 6943 0800 4500  ..........iC..E.
        0x0010:  0054 ff4d 4000 4001 359a c0a8 4201 c0a8  .T.M@.@.5...B...
        0x0020:  426f 0800 4243 5d95 000b a0cc f65d cfee  Bo..BC]......]..
        0x0030:  0600 0809 0a0b 0c0d 0e0f 1011 1213 1415  ................
        0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
        0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
        0x0060:  3637 33e0 14c7                           673...
00:15:29.341601 IP truncated-ip - 52 bytes missing! 192.168.66.1 > 192.168.66.111: ICMP echo request, id 23957, seq 12, length 64
        0x0000:  0800 0702 0304 fe16 d9ae 6943 0800 4500  ..........iC..E.
        0x0010:  0054 ff4e 4000 4001 3599 c0a8 4201 c0a8  .T.N@.@.5...B...
        0x0020:  426f 0800 d61a 5d95 000c a0cc f65d        Bo....]......]

Sniffing br0 on the host shows no sign of the truncated packet at all 
which leaves a gap in the packet sequence numbers captured on the host. 
Weird.

When I log the calls to,

static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
                               size_t pkt_size)

the corresponding pkt_size values look like this,

pkt_size 98
pkt_size 42

So this seems to show that the bug is not in dp8393x. Possibly not in 
QEMU?

I don't see any options in 'man brctl' that might explain why the host and 
guest see different packets. I guess I'll have to find a way to avoid 
using bridge interfaces (?)

