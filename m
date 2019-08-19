Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB2C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6132087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6132087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaIi-00065V-RE
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hzXzJ-0002gR-P1
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hzXzG-0002sD-1g
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:33140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hzXzF-0002rN-Sd
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:05:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hzXzD-00023b-RC
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 03:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C27E22E8070
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 03:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2019 02:56:44 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug-Tags: arm usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aditya-govardhan andrew-pennebaker kraxel-redhat
 pmaydell vortelf weberkai
X-Launchpad-Bug-Reporter: George (vortelf)
X-Launchpad-Bug-Modifier: Weber Kai (weberkai)
References: <152673688616.9061.7617411809661975686.malonedeb@chaenomeles.canonical.com>
Message-Id: <156618340459.22324.2948520356642462313.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 21ed8b390b20154206c2ed93a1d6d23d6139317c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 19 Aug 2019 01:29:33 -0400
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
From: Weber Kai via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Bug 1772165 <1772165@bugs.launchpad.net>
Cc: Weber Kai <weberkai@yahoo.com.br>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I've googled: "usb" "designware" "otg" "datasheet"

I think this is the kernel driver for this device:
https://github.com/torvalds/linux/tree/master/drivers/usb/dwc3

Maybe it should be possible to use this as a reference? Maybe try to
redirect the proprietary drivers system calls? I don't know...

I've also found theses docs, which explains the device a little bit:
http://www.infradead.org/~mchehab/kernel_docs_pdf/driver-api.pdf
https://media.digikey.com/pdf/Data%20Sheets/Austriamicrosystems%20PDFs/AS35=
24.pdf
https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb=
/arria-10/a10_54018.pdf

Thanks.

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

