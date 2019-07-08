Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F97CC606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AC320861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AC320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkSrE-00034j-Th
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkREP-0005Cr-4S
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkREN-0008Nn-5g
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:50:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:48666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkREG-00087H-99
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:50:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkRED-0005Ns-4q
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 10:50:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 205ED2E802D
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 10:50:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 10:36:02 -0000
From: Tristan Van Berkom <tristan.vanberkom@codethink.co.uk>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: tristan-vanberkom
X-Launchpad-Bug-Reporter: Tristan Van Berkom (tristan-vanberkom)
X-Launchpad-Bug-Modifier: Tristan Van Berkom (tristan-vanberkom)
Message-Id: <156258216266.21278.12556510470216212187.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 3e2d57d78e59198b5a2f9082c31f2ec82fd18f49
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 08 Jul 2019 08:32:36 -0400
Subject: [Qemu-devel] [Bug 1835729] [NEW] GTK display does not support host
 scale factor
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
Reply-To: Bug 1835729 <1835729@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

In the GNOME desktop environment, for HiDPI displays there is support to
upscale everything.

This can be set in "System Settings -> Displays -> Scale".

I believe this affects GDK in the same way as setting the "GDK_SCALE"
environment variable does.

When launching `qemu-system-x86_64 ... -display gtk`, this scale factor
seems to get lost; the result is that the host window is upscaled and
doubled in size, while the guest appears only in the bottom left corner
of the UI.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Screenshot displaying the problem"
   https://bugs.launchpad.net/bugs/1835729/+attachment/5275625/+files/qemu-=
gtk-display.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835729

Title:
  GTK display does not support host scale factor

Status in QEMU:
  New

Bug description:
  In the GNOME desktop environment, for HiDPI displays there is support
  to upscale everything.

  This can be set in "System Settings -> Displays -> Scale".

  I believe this affects GDK in the same way as setting the "GDK_SCALE"
  environment variable does.

  When launching `qemu-system-x86_64 ... -display gtk`, this scale
  factor seems to get lost; the result is that the host window is
  upscaled and doubled in size, while the guest appears only in the
  bottom left corner of the UI.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835729/+subscriptions

