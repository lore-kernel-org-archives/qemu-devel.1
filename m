Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C516C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB652073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB652073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0HS-0007QD-5o
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jJyDR-0007jQ-Gv
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jJyDP-0007rP-OI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:40:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:44560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jJyDP-0007q6-I4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 07:40:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jJyDN-00085C-LJ
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 11:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7AFBC2E810F
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 11:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Apr 2020 11:35:01 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: r-volkmer
X-Launchpad-Bug-Reporter: Ruben (r-volkmer)
X-Launchpad-Bug-Modifier: Ruben (r-volkmer)
Message-Id: <158582730148.12209.12098183760358013098.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1870331] [NEW] default nic device created even though supplied
 by configfile
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7e05b36bb5618e4b5691041324133b735dc43817
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Thu, 02 Apr 2020 09:52:34 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Bug 1870331 <1870331@bugs.launchpad.net>, Ruben <R.Volkmer@ITB-Solutions.de>
From: Ruben via <qemu-devel@nongnu.org>

Public bug reported:

QEMU emulator version 4.1.94

Documentation states that qemu will create a default nic as long as not
explicitly forbidden (-nic none) or defined ( e.g. -nic <options>).

Observation:
Even though qemu-system-ppc is started with "-readconfig" (which defines a =
nic), another nic gets created. When additionally suppling "-nic none", onl=
y the nic of the config file is created.
As matter of fact, if all items that are defined in config file are supplie=
d as command line arguments, no further nic is created. =


Expectation:
When a nic is defined in config file, the default guest-nic should not get =
created.
That would match behavior when all items, defined in config file are suppli=
ed as command line arguments.


Attached config file.

(qemu) info pci
 Bus 0, device 0, function 0:
 Host bridge: PCI device 1057:0002
 PCI subsystem 1af4:1100
 id ""
 Bus 0, device 1, function 0:
 VGA controller: PCI device 1234:1111
 PCI subsystem 1af4:1100
 BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
 BAR2: 32 bit memory at 0x81000000 [0x81000fff].
 BAR6: 32 bit memory at 0xffffffffffffffff [0x0000fffe].
 id ""
 Bus 0, device 2, function 0:
 Ethernet controller: PCI device 10ec:8029
 PCI subsystem 1af4:1100
 IRQ 23.
 BAR0: I/O at 0x1000 [0x10ff].
 BAR6: 32 bit memory at 0xffffffffffffffff [0x0007fffe].
 id ""
 Bus 0, device 3, function 0:
 Ethernet controller: PCI device 10ec:8029
 PCI subsystem 1af4:1100
 IRQ 24.
 BAR0: I/O at 0x1100 [0x11ff].
 BAR6: 32 bit memory at 0xffffffffffffffff [0x0007fffe].
 id ""

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "readconfig file"
   https://bugs.launchpad.net/bugs/1870331/+attachment/5344765/+files/qemu.=
config

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1870331

Title:
  default nic device created even though supplied by configfile

Status in QEMU:
  New

Bug description:
  QEMU emulator version 4.1.94

  Documentation states that qemu will create a default nic as long as
  not explicitly forbidden (-nic none) or defined ( e.g. -nic
  <options>).

  Observation:
  Even though qemu-system-ppc is started with "-readconfig" (which defines =
a nic), another nic gets created. When additionally suppling "-nic none", o=
nly the nic of the config file is created.
  As matter of fact, if all items that are defined in config file are suppl=
ied as command line arguments, no further nic is created. =


  Expectation:
  When a nic is defined in config file, the default guest-nic should not ge=
t created.
  That would match behavior when all items, defined in config file are supp=
lied as command line arguments.

  =

  Attached config file.

  (qemu) info pci
   Bus 0, device 0, function 0:
   Host bridge: PCI device 1057:0002
   PCI subsystem 1af4:1100
   id ""
   Bus 0, device 1, function 0:
   VGA controller: PCI device 1234:1111
   PCI subsystem 1af4:1100
   BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
   BAR2: 32 bit memory at 0x81000000 [0x81000fff].
   BAR6: 32 bit memory at 0xffffffffffffffff [0x0000fffe].
   id ""
   Bus 0, device 2, function 0:
   Ethernet controller: PCI device 10ec:8029
   PCI subsystem 1af4:1100
   IRQ 23.
   BAR0: I/O at 0x1000 [0x10ff].
   BAR6: 32 bit memory at 0xffffffffffffffff [0x0007fffe].
   id ""
   Bus 0, device 3, function 0:
   Ethernet controller: PCI device 10ec:8029
   PCI subsystem 1af4:1100
   IRQ 24.
   BAR0: I/O at 0x1100 [0x11ff].
   BAR6: 32 bit memory at 0xffffffffffffffff [0x0007fffe].
   id ""

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1870331/+subscriptions

