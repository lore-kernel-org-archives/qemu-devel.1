Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25FDC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7426321D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7426321D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yIR-0008OY-HM
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j3yHZ-0007jB-Ag
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j3yHX-0006Qu-Rw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:31:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:38180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j3yHX-0006QS-Lr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:31:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j3yHV-0003uD-Ir
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:31:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7C4302E80C9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:31:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Feb 2020 08:21:21 -0000
From: Rokas Kupstys <1846451@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kraxel-redhat rokups th-huth
X-Launchpad-Bug-Reporter: Rokas Kupstys (rokups)
X-Launchpad-Bug-Modifier: Rokas Kupstys (rokups)
References: <157008676845.21009.5220720197845563324.malonedeb@chaenomeles.canonical.com>
Message-Id: <158201408171.14879.11526645754031512393.malone@soybean.canonical.com>
Subject: [Bug 1846451] Re: K800 keyboard no longer works when attached to a VM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 09543ec9d1ee2b1d35febc61ab8214271cf871b9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Any way to get old behavior back when using `virsh attach` command?
Devices are not attached on boot. I am stuck with qemu 4.0 because of
this.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1846451

Title:
  K800 keyboard no longer works when attached to a VM

Status in QEMU:
  Fix Released

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

