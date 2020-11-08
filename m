Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24EC388F7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A5D20885
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A5D20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbZOg-00030K-55
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 20:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbZO1-0002XE-0m
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 20:20:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:52868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbZNy-0003JW-7Y
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 20:20:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbZNt-0005RC-8U
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 01:20:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3EF2F2E802E
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 01:20:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 01:08:34 -0000
From: Russell Morris <1694808@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu-kvm; component=main; 
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 6-u3untu-h colinfinck paelzer th-huth
X-Launchpad-Bug-Reporter: Colin Finck (colinfinck)
X-Launchpad-Bug-Modifier: Russell Morris (6-u3untu-h)
References: <149625981140.25356.9191241290348673100.malonedeb@soybean.canonical.com>
Message-Id: <160479771420.28892.7211849012285283573.malone@chaenomeles.canonical.com>
Subject: [Bug 1694808] Re: Passthrough USB Host Keyboard doesn't work on Q35
 platform on boot-up
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 5ba972fc59d28dd1fcd2d0fb1390235e164dc31d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 20:20:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1694808 <1694808@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Seeing this same thing! And I'm on Ubuntu 20.10, so pretty current :-).
vt82c686b-usb-uhci doesn't seem to be accessible any more, but trying
qemu-xhci =3D> no joy, still have to reset the VM after each startup, to
get the keyboard and mouse working.

Is this expected?

Thanks!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1694808

Title:
  Passthrough USB Host Keyboard doesn't work on Q35 platform on boot-up

Status in QEMU:
  New
Status in qemu-kvm package in Ubuntu:
  New

Bug description:
  Using qemu-kvm as shipped with Ubuntu 16.04, I cannot get a passed-
  through USB Host Keyboard to work at boot-up using the Q35 platform.

  My minimal example to verify this bug is the following:

    qemu-system-x86_64 -M q35 -m 128 -cdrom mini.iso -usb -usbdevice
  host:04ca:005a -vnc :1 -display none

  Using a noname USB Keyboard with ID 04ca:005a and the Ubuntu 16.04
  NetBoot mini.iso, I can see the boot screen of the Ubuntu ISO through
  VNC, but pressing the arrow keys doesn't do anything.

  By taking out the "-M q35" parameter, QEMU switches to the traditional
  i440FX system. The passed-through USB Host Keyboard works there, but
  the old platform is no option for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1694808/+subscriptions

