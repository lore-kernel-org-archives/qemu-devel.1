Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2157CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A979120659
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A979120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQFY7-0007k8-R4
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 14:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iQFWp-0006ke-Ez
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iQFWo-0004mf-86
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:50:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:57090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iQFWo-0004lA-2c
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:50:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iQFWm-0001OV-4V
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 18:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1FA872E8076
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 18:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2019 18:39:11 -0000
From: John Canada <1850570@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: johncanada programmingkidx
X-Launchpad-Bug-Reporter: John Canada (johncanada)
X-Launchpad-Bug-Modifier: John Canada (johncanada)
References: <157240001496.28481.10507378472210680134.malonedeb@chaenomeles.canonical.com>
Message-Id: <157254715118.3076.2379100780378521691.malone@gac.canonical.com>
Subject: [Bug 1850570] Re: Cannot use usb-host on Mac OS
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fa45987e26d3890febad1058912e8cecde429952
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1850570 <1850570@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, I tried running as root.  I also tried it on a different computer
that is running Mac OS 10.13, and it gave the same errors.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1850570

Title:
  Cannot use usb-host on Mac OS

Status in QEMU:
  New

Bug description:
  Usb-host will not work on Mac OS 10.15.  Qemu runs, though it gives
  these errors and the drive does not show up.  Also, when Qemu is
  starting the drive ejects and remounts twice. Qemu built with
  ./configure --target-list=3Di386-softmmu,x86_64-softmmu --enable-sdl
  --disable-cocoa --enable-sdl-image.

  qemu-system-i386 image.qcow -usb -device usb-kbd  -device usb-host,vendor=
id=3D0x0781,productid=3D0x5571
  libusb: error [darwin_claim_interface] USBInterfaceOpen: another process =
has device opened for exclusive access
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] USBInterfaceOpen: another process =
has device opened for exclusive access
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found
  libusb: error [darwin_claim_interface] interface not found

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1850570/+subscriptions

