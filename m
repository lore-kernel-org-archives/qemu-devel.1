Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E8CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5290D20830
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5290D20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMRBC-0003kg-EK
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 02:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iMRA4-00033I-CA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iMRA3-0004cQ-4Q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:27:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:41844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iMRA2-0004cA-VL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:27:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iMRA1-0001zc-DD
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:27:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 613412E80C9
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:27:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2019 06:15:15 -0000
From: Rokas Kupstys <1846451@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kraxel-redhat rokups
X-Launchpad-Bug-Reporter: Rokas Kupstys (rokups)
X-Launchpad-Bug-Modifier: Rokas Kupstys (rokups)
References: <157008676845.21009.5220720197845563324.malonedeb@chaenomeles.canonical.com>
Message-Id: <157163851591.9806.17054988358067922883.malone@soybean.canonical.com>
Subject: [Bug 1846451] Re: K800 keyboard no longer works when attached to a VM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 74ea8b0b30936ea0e97af67c87387c04e9fe7027
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
Reply-To: Bug 1846451 <1846451@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am bit slow to test, but i just realized that i am still not sure how
to test this. My devices are attached using "virsh attach" after system
has started. So it seems to me there is no way to test it with libvirt.
A global option to restore old behavior would be useful until libvirt
starts supporting this option.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1846451

Title:
  K800 keyboard no longer works when attached to a VM

Status in QEMU:
  New

Bug description:
  I use Logitech K800 keyboard which is connected to a PC through
  Logitech unifying receiver. In order to control my windows VM i attach
  unifying receiver USB device to a VM using "virsh attach-device VM-
  Name ./device.xml". Device ID as seen in lsusb is 046d:c52b.

  As of v4.1.0 keyboard no longer works when attached to a windows VM.
  When attached receiver is still at least partially functional.
  Logitech pairing utility properly displays paired keyboard, pressing
  buttons on the keyboard shows changing indicator icon in pairing
  utility. Pairing and unpairing works. Pressing keys however fails to
  register any key presses.

  Downgrading to v4.0.0 fixes the issue.

  device.xml used to attach USB device:
  ```
  <hostdev mode=3D'subsystem' type=3D'usb'>
          <source>
                  <vendor id=3D'0x046d'/>
                  <product id=3D'0xc52b'/>
          </source>
  </hostdev>

  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1846451/+subscriptions

