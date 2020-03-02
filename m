Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87518C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 03:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B90246B4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 03:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B90246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8biA-0002JE-BL
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 22:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j8Yt6-0007yv-VD
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j8Yt5-0007WS-IU
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:24:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:39028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j8Yt5-0007W7-DO
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:24:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j8Yt3-0008IB-Hn
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 00:24:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B18FE2E80D0
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 00:24:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Mar 2020 00:13:42 -0000
From: ruthan <ruthan@email.cz>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=debian; sourcepackage=qemu-kvm; component=main; 
 status=Fix Released; importance=Unknown; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bradh claunia danielbair erkki-laasonen g478ba6
 j-etcheverria khlebnikov lightbit8 nerobat2004 ruthan slash-ac wrtaff
X-Launchpad-Bug-Reporter: Kusanagi Kouichi (slash-ac)
X-Launchpad-Bug-Modifier: ruthan (ruthan)
References: <20100215030826.24686.26277.malonedeb@palladium.canonical.com>
Message-Id: <158310802305.6506.2646789118411431495.malone@chaenomeles.canonical.com>
Subject: [Bug 521994] Re: Windows 98 doesn't detect mouse on qemu and SeaBIOS.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d7e6c5eb3e8bf5bb79acc2cc52baf00998d3f588
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sun, 01 Mar 2020 22:25:06 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 521994 <521994@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Im using Mint 19.3 based on Ubuntu 18.04 with QEMU 2.11 from repository, ke=
yboard is working but mouse not in Win98.
  =

  Could someone else to restest it?

  Here is my Qemu starting script:
qemu-system-x86_64 -m 512 \
-machine type=3Dpc-i440fx-bionic \
-smp 1,sockets=3D1,cores=3D1,threads=3D1 \
-vga cirrus \
-rtc clock=3Dhost,base=3Dlocaltime \
-parallel none \
-balloon none \
-mem-prealloc \
-serial none \
-parallel none \
-L . \
-soundhw sb16,adlib,pcspk \
-boot order=3Dcd \
-no-acpi \
-hda ./Win98-System.vmdk \
-cdrom ./Win98SE-ENG.iso \
-k en-us \
-net nic,model=3Drtl8139 -net user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/521994

Title:
  Windows 98 doesn't detect mouse on qemu and SeaBIOS.

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Debian:
  Fix Released

Bug description:
  A windows 98 guest doesn't detect mouse on recent qemu. I bisected and
  the result is

  fd646122418ecefcde228d43821d07da79dd99bb is the first bad commit
  commit fd646122418ecefcde228d43821d07da79dd99bb
  Author: Anthony Liguori <aliguori@us.ibm.com>
  Date:   Fri Oct 30 09:06:09 2009 -0500

      Switch pc bios from pc-bios to seabios

      SeaBIOS is a port of pc-bios to GCC.  Besides using a more modern too=
l chain,
      SeaBIOS introduces a number of new features including PMM support, be=
tter
      BEV and BCV support, and better PnP support.

      Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

  I got following messages with DEBUG_BIOS

  Start bios (version 0.5.1-20100111_132716-squirrel.codemonkey.ws)
  Ram Size=3D0x08000000 (0x0000000000000000 high)
  CPU Mhz=3D2271
  Found 1 cpu(s) max supported 1 cpu(s)
  PIIX3/PIIX4 init: elcr=3D00 0c
  PCI: bus=3D0 devfn=3D0x00: vendor_id=3D0x8086 device_id=3D0x1237
  PCI: bus=3D0 devfn=3D0x08: vendor_id=3D0x8086 device_id=3D0x7000
  PCI: bus=3D0 devfn=3D0x09: vendor_id=3D0x8086 device_id=3D0x7010
  region 4: 0x0000c000
  PCI: bus=3D0 devfn=3D0x0b: vendor_id=3D0x8086 device_id=3D0x7113
  PCI: bus=3D0 devfn=3D0x10: vendor_id=3D0x1013 device_id=3D0x00b8
  region 0: 0xe0000000
  region 1: 0xe2000000
  region 6: 0xe2010000
  MP table addr=3D0x000f89b0 MPC table addr=3D0x000f89c0 size=3D224
  SMBIOS ptr=3D0x000f8990 table=3D0x07fffef0
  ACPI tables: RSDP=3D0x000f8960 RSDT=3D0x07ffde30
  Scan for VGA option rom
  Running option rom at c000:0003
  VGABios $Id$
  Turning on vga console
  Starting SeaBIOS (version 0.5.1-20100111_132716-squirrel.codemonkey.ws)

  Found 0 lpt ports
  Found 0 serial ports
  ATA controller 0 at 1f0/3f4/c000 (irq 14 dev 9)
  ATA controller 1 at 170/374/c008 (irq 15 dev 9)
  ps2 irq but no data.
  ata0-0: PCHS=3D812/16/63 translation=3Dnone LCHS=3D812/16/63
  ata0-1: PCHS=3D1152/16/56 translation=3Dnone LCHS=3D1024/16/56
  ps2_recvbyte timeout
  keyboard initialized
  Scan for option roms
  Returned 53248 bytes of ZoneHigh
  e820 map has 6 items:
    0: 0000000000000000 - 000000000009f400 =3D 1
    1: 000000000009f400 - 00000000000a0000 =3D 2
    2: 00000000000f0000 - 0000000000100000 =3D 2
    3: 0000000000100000 - 0000000007ffd000 =3D 1
    4: 0000000007ffd000 - 0000000008000000 =3D 2
    5: 00000000fffc0000 - 0000000100000000 =3D 2
  enter handle_19:
    NULL
  Booting from Hard Disk...
  Booting from 0000:7c00
  pnp call arg1=3D5
  pnp call arg1=3D0
  ps2_recvbyte timeout
  ps2_recvbyte timeout
  ps2_recvbyte timeout
  ps2_recvbyte timeout

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/521994/+subscriptions

