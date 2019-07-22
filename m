Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD06C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7E8218F0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7E8218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpezZ-0007dx-Qw
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 16:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hpezN-0007En-2n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hpezL-0004xB-Px
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:32:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:38918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hpezL-0004w6-Jf
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:32:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hpezK-0005OJ-CT
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 20:32:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 570092E80CE
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 20:32:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jul 2019 20:19:32 -0000
From: Aditya Govardhan <1772165@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug-Tags: arm usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aditya-govardhan andrew-pennebaker kraxel-redhat
 pmaydell vortelf
X-Launchpad-Bug-Reporter: George (vortelf)
X-Launchpad-Bug-Modifier: Aditya Govardhan (aditya-govardhan)
References: <152673688616.9061.7617411809661975686.malonedeb@chaenomeles.canonical.com>
Message-Id: <156382677264.18580.4665024954209828293.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 537bc78831575f4a06dfa7ef48477818e8e9d2e7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1772165] Re: arm raspi2/raspi3 emulation has no
 USB support
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
Reply-To: Bug 1772165 <1772165@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After reading change logs, I believe USB support for raspi2/raspi3 is
not added yet. Which means host internet network can't be accessed by
emulated machine.

I would be glad to help in documentation of differences between real
Raspberry Pi devices and QEMU emulated raspi2/raspi3 since I have seen a
lot of tutorials on internet trying to use QEMU for emulating raspberry
pi. These tutorials most of the times are just hacks, like using
versatilepb or using custom kernel instead of the Raspbian OS.

I have gathered as much info as possible over the last week through
these tutorials, QEMU raspi code and change logs, and believe a good
documentation of this info could help future users trying to emulate
raspi.

Finally, I am able to run latest Raspbian OS (2019-07-10) lite version
on raspi2 using the following command where I have extracted kernel
image and dtb file from second partition:

qemu-system-arm -M raspi2 -kernel bootpart/kernel7l.img -dtb
bootpart/bcm2709-rpi-2-b.dtb -drive file=3D2019-07-10-raspbian-buster-
lite.img,format=3Draw,if=3Dsd -append "rw console=3DttyAMA0 loglevel=3D8
root=3D/dev/mmcblk0p2 fsck.repair=3Dyes rootwait memtest=3D1" -serial stdio

I am not able to connect network devices, not able to use images other
than lite image (https://bugs.launchpad.net/qemu/+bug/1837347) and
unsure why this command is showing Hardware name as BCM2835 when the
QEMU raspi code has BCM2836 associated with raspi2
(https://github.com/qemu/qemu/blob/59c58f96b270f5edd4ad10954c3a96556cb3a728=
/hw/arm/bcm2836.c#L31).

I highly appreciate the support provided for raspi2 and raspi3 till now.

Thank you.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772165

Title:
  arm raspi2/raspi3 emulation has no USB support

Status in QEMU:
  Confirmed

Bug description:
  Using Qemu 2.12.0 on ArchLinux.

  Trying to emulate arm device with `qemu-system-arm` and attach usb
  device for unput using

  ` -usb -device usb-host,bus=3D001,vendorid=3D0x1d6b,productid=3D0x0002 `

  # lsusb returns

  Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
  Bus 001 Device 014: ID 13d3:3487 IMC Networks =

  Bus 001 Device 004: ID 0457:11af Silicon Integrated Systems Corp. =

  Bus 001 Device 003: ID 0bda:57e6 Realtek Semiconductor Corp. =

  Bus 001 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card=
 Reader Controller
  Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

  # qemu returns
  qemu-system-arm: -device usb-host,bus=3D001,vendorid=3D0x1d6b,productid=
=3D0x0002: Bus '001' not found

  =

  Tried with connecting external usb keyboard but that didn't seem to work =
either.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772165/+subscriptions

