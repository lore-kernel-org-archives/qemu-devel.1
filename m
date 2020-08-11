Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93746C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4482076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4482076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5cnz-00083k-M4
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 18:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5cn8-0007c3-SG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 18:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:49308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5cn6-0002Ml-Bw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 18:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5cn4-0003le-8n
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 22:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 27E742E8082
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 22:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2020 22:23:57 -0000
From: TheCatFelix <1884684@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: thecatfelix
X-Launchpad-Bug-Reporter: TheCatFelix (thecatfelix)
X-Launchpad-Bug-Modifier: TheCatFelix (thecatfelix)
References: <159287262873.13509.14889128175029136647.malonedeb@wampee.canonical.com>
Message-Id: <159718463763.26262.10272195649266297628.malone@gac.canonical.com>
Subject: [Bug 1884684] Re: QEMU 5.0: Guest VM hangs/freeze when unplugging USB
 device
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: caf5e71135a0bfb56e895ae2b81dee61daa5b6df
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 17:11:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1884684 <1884684@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Link to bug on the proxmox side:

https://bugzilla.proxmox.com/show_bug.cgi?id=3D2781

** Bug watch added: bugzilla.proxmox.com/ #2781
   https://bugzilla.proxmox.com/show_bug.cgi?id=3D2781

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884684

Title:
  QEMU 5.0: Guest VM hangs/freeze when unplugging USB device

Status in QEMU:
  New

Bug description:
  Setup:

  Host: Debian/SID, Kernel 5.6, QEMU 5.0
  Guest: Windows 10 VM with PCI and USB device passthrough.

  Problem: Guest VM suddenly hangs when pulling USB device out from the
  Host.

  Observations:
   - Issue appears to be related to QEMU 5.0
     - It started after an upgrade to QEMU 5.0.
     - Downgrading only QEMU on multiple systems fixes the issue.

   - Issue is very reproducible.
     - Most of the time within a few attempts of pulling/reconnecting the d=
evice.
     - Issue happens with multiple devices (I did try standard HID devices,=
 a webcam and an x-ray sensor).

   - Guest just hangs.
     - Display output remains on last frame shown.
     - Ping to Guest immediately stops working.
     - Logs in the Guest stop logging immediately.

   - Host is fine and thinks the Guest is fine. =

     - Guest continues to show as running in "virsh list".
     - No suspicious entries in the QEMU logs.
     - No suspicious entries in Host syslogs/messages.
     - Host can can kill guest "virsh destroy" and respawn fine.

   - Issue seems widespread.
     - Multiple similar reports from ProxMox users after upgrade to ProxMox=
 6.2 for both Windows and Linux guests (First version that uses QEMU 5.0)

  https://forum.proxmox.com/threads/vm-freezes-when-disconnecting-usb-keybo=
ard-and-mouse.70287/
  https://forum.proxmox.com/threads/usb-drive-crashes-vm.70214/
  https://forum.proxmox.com/threads/latest-proxmox-usb-disconnects-freeze-k=
vm.70398/
  https://forum.proxmox.com/threads/vm-with-gpu-passthrough-freezes-when-tu=
rning-off-monitor-after-proxmox-6-2-upgrade.69821/
  https://forum.proxmox.com/threads/vm-with-gpu-passthrough-freezes-when-tu=
rning-off-monitor-after-proxmox-6-2-upgrade.69824/

  I'd be more than happy any debugs that might be helpful.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884684/+subscriptions

