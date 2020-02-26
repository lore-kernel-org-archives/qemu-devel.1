Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7049C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 06:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCC121556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 06:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCC121556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6qEk-0001hA-M7
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 01:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j6qDb-0001GU-Ll
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 01:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j6qDa-0001DC-F3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 01:30:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:32868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j6qDa-0001Bi-9M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 01:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j6qDY-0000b6-9j
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 06:30:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2730B2E80C8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 06:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2020 06:21:24 -0000
From: "Chris S." <1863710@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chriscjsus
X-Launchpad-Bug-Reporter: Chris S. (chriscjsus)
X-Launchpad-Bug-Modifier: Chris S. (chriscjsus)
References: <158200914380.31311.6636278385327327157.malonedeb@wampee.canonical.com>
Message-Id: <158269808498.13945.18235705315363753963.malone@wampee.canonical.com>
Subject: [Bug 1863710] Re: qemu 4.2 does not process discard(trim) commands 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9eff1c37c1740693bdcba94d8f8c608164af5689";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 32a765026abfbf080c66465290473d767fd2c073
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
Reply-To: Bug 1863710 <1863710@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Attachment removed: "win10-real.xml"
   https://bugs.launchpad.net/qemu/+bug/1863710/+attachment/5329158/+files/=
win10-real.xml

** Attachment added: "win10.xml"
   https://bugs.launchpad.net/qemu/+bug/1863710/+attachment/5331124/+files/=
win10.xml

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863710

Title:
  qemu 4.2 does not process discard(trim) commands

Status in QEMU:
  New

Bug description:
  I'm using Arch Linux with qemu 4.2 and blktrace to monitor discard
  commands as they are sent to the hardware.  Blktrace shows nothing as
  the VM is trimming the SSDs.

  I downgraded to qemu 4.1.1 and blktrace shows lots of discard commands
  as the VM is trimming.

  Kernel version is 5.5.4.

  Attached is the libvirt xml.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863710/+subscriptions

