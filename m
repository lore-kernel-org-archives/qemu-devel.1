Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB10F22D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB10F22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03qt-0004Q5-Aj
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i03qG-00041Z-5D
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i03qE-0000xW-Vl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:06:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:48524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i03qE-0000xF-Qc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:06:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i03qD-0007E8-6S
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:06:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2F8942E8075
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:06:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Aug 2019 12:59:22 -0000
From: Davide Bacilieri <1772165@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug-Tags: arm usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aditya-govardhan andrew-pennebaker clemd davbac
 kraxel-redhat pmaydell vortelf weberkai
X-Launchpad-Bug-Reporter: George (vortelf)
X-Launchpad-Bug-Modifier: Davide Bacilieri (davbac)
References: <152673688616.9061.7617411809661975686.malonedeb@chaenomeles.canonical.com>
Message-Id: <156630596295.22623.9042286816878299731.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: dcc9adf33173ee561a9c6ef817ac944b3f72411c
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

Right now with =

`qemu-system-arm -kernel kernel7.img -dtb bcm2709-rpi-2-b.dtb -cpu arm1176 =
-M raspi2 -hda 2018-11-13-raspbian-stretch-full.img`
I can access the serial console using `Ctrl+Alt+3` in the QEMU window.
Using raspbian via this serial console is (as far as I can see) the same as=
 using the Lite version.
The main display doesn't accept any mouse/ keyboard input, and `-device usb=
-mouse` generates a `qemu-system-arm: -device usb-mouse: No 'usb-bus' bus f=
ound for device 'usb-mouse` error, even after the `-machine usb=3Don` comma=
nd

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

