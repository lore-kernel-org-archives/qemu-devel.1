Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A889CC3A5A4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 01:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81789217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 01:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81789217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4bQf-0002cf-SA
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 21:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i4bPa-0002B5-Fb
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 21:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i4bPZ-0006fu-Cr
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 21:45:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:47244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i4bPZ-0006fh-82
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 21:45:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i4bPW-0004yP-U0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 01:45:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C5AAA2E80C9
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 01:45:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Sep 2019 01:36:07 -0000
From: Geoffrey McRae <1839060@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gnif idarlund spheenik
X-Launchpad-Bug-Reporter: Martin Schrodt (spheenik)
X-Launchpad-Bug-Modifier: Geoffrey McRae (gnif)
References: <156507518934.25260.15982229597694445610.malonedeb@soybean.canonical.com>
Message-Id: <156738816745.6300.11491240971474223228.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0111253024cca66cc46dd4ba13d5a2a95148e439
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839060] Re: HDA device non functional in Windows
 10 1903
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
Reply-To: Bug 1839060 <1839060@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am trying to dig into this issue, can you please provide the verb
debug trace from the working version of windows.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839060

Title:
  HDA device non functional in Windows 10 1903

Status in QEMU:
  New

Bug description:
  I made the update to 1903, and the HDA device stopped working.

  The driver says the device is working correctly, but it does not.
  When I try to open the Windows sound configuration, the dialog hangs and =
never shows it's content.

  Several people reported this back in May:

  https://windowsreport.com/windows-10-v1903-ich6-ich9-virtio/

  I can confirm I have exactly the same problem.

  Host is Arch Linux, current (5.2.5) kernel, QEMU 4.0.

  I enabled HDA debug output and compared an older, working Windows
  version to 1903, but could not see the difference. The driver seems to
  issue the same verbs.

  I am happy to provide additional information if needed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839060/+subscriptions

