Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54EC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7254A20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7254A20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyas2-0000cm-L4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyaqu-00085E-Iw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:01:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:43844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyaqr-0000XH-Uk
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:01:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jyaqo-00081O-Fb
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 13:01:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0A2D62E80ED
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 13:01:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2020 12:50:57 -0000
From: Lorenzo Gatti <1888663@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mouse msmouse serial
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gattilorenz
X-Launchpad-Bug-Reporter: Lorenzo Gatti (gattilorenz)
X-Launchpad-Bug-Modifier: Lorenzo Gatti (gattilorenz)
Message-Id: <159550865727.2767.17464111511631671280.malonedeb@gac.canonical.com>
Subject: [Bug 1888663] [NEW] msmouse not recognized in guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f877c5162b568393e2d07ce948459ba0abc456fe";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 72bbd9b7d52203609499089c05b0887e7a489158
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 07:31:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1888663 <1888663@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The msmouse option for emulating a serial mouse does not seem to work in
a DOS guest.

I'm on Windows 10 X64, I have tried launching qemu (commit d0cc248164961a7b=
a9d43806feffd76f9f6d7f41 but also way older) with:
./qemu-system-i386 -serial msmouse -fda mousetest.img
./qemu-system-i386 -chardev msmouse,id=3Dmsmouse -device isa-serial,chardev=
=3Dmsmouse -fda mousetest.img
./qemu-system-i386 -chardev msmouse,id=3Dmsmouse -device pci-serial,chardev=
=3Dmsmouse -chardev msmouse,id=3Dmsmouse -fda mousetest.img

Then I boot FreeDOS (but regular DOS shows same behavior), start the CuteMo=
use driver and force the scan of a serial mouse with CTM /S.
The mouse is never found. With other drivers (in the attachment), the mouse=
 is probably not found but the driver is installed anyway, but it does not =
work (there's a MOUSETST in the same floppy; it works iwth CTM and PS/2 mou=
se emulation).

Using a serial port sniffer inside the guest, it would seem that data is
indeed transmitted. Setting a few printf in msmouse.c also confirms that
the mouse gets initilized and starts transmitting data. However, it does
not work...

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: mouse msmouse serial

** Attachment added: "FreeDOS image with multiple mouse drivers and mouse t=
est program"
   https://bugs.launchpad.net/bugs/1888663/+attachment/5395214/+files/mouse=
test.img

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888663

Title:
  msmouse not recognized in guest

Status in QEMU:
  New

Bug description:
  The msmouse option for emulating a serial mouse does not seem to work
  in a DOS guest.

  I'm on Windows 10 X64, I have tried launching qemu (commit d0cc248164961a=
7ba9d43806feffd76f9f6d7f41 but also way older) with:
  ./qemu-system-i386 -serial msmouse -fda mousetest.img
  ./qemu-system-i386 -chardev msmouse,id=3Dmsmouse -device isa-serial,chard=
ev=3Dmsmouse -fda mousetest.img
  ./qemu-system-i386 -chardev msmouse,id=3Dmsmouse -device pci-serial,chard=
ev=3Dmsmouse -chardev msmouse,id=3Dmsmouse -fda mousetest.img

  Then I boot FreeDOS (but regular DOS shows same behavior), start the Cute=
Mouse driver and force the scan of a serial mouse with CTM /S.
  The mouse is never found. With other drivers (in the attachment), the mou=
se is probably not found but the driver is installed anyway, but it does no=
t work (there's a MOUSETST in the same floppy; it works iwth CTM and PS/2 m=
ouse emulation).

  Using a serial port sniffer inside the guest, it would seem that data
  is indeed transmitted. Setting a few printf in msmouse.c also confirms
  that the mouse gets initilized and starts transmitting data. However,
  it does not work...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888663/+subscriptions

