Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04889C32754
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10CD21880
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10CD21880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvdkL-0006dF-5u
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hvdjx-0006D6-Vl
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hvdjw-00008Q-Sd
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:25:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:35852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hvdjw-00007m-Mi
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:25:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hvdjv-0002YM-FZ
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 08:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3D2F02E80CC
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 08:25:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Aug 2019 08:11:05 -0000
From: Philipp Oppermann <1839294@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: baw-mls phil-opp
X-Launchpad-Bug-Reporter: Koganinja89 (baw-mls)
X-Launchpad-Bug-Modifier: Philipp Oppermann (phil-opp)
References: <156516896995.16228.929773034443965895.malonedeb@soybean.canonical.com>
Message-Id: <156525186580.14072.13193868788541043705.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19015";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1c87dfb1fb81e9daa6d71e512a0f7d2d1a466d31
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839294] Re: Latest Installer
 (qemu-w64-setup-20190807.exe) for windows immediately deletes installed
 files at the very end of the installation
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
Reply-To: Bug 1839294 <1839294@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I hit the same error in my azure pipelines script that uses `choco
install qemu`. While it worked with qemu-w64-setup-20190731.exe, the
`C:\Program Files\qemu` directory is empty with
qemu-w64-setup-20190807.exe.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839294

Title:
  Latest Installer (qemu-w64-setup-20190807.exe) for windows immediately
  deletes installed files at the very end of the installation

Status in QEMU:
  New

Bug description:
  This happens on Windows 10 with the latest installer for 64 bit
  Windows: qemu-w64-setup-20190807.exe

  On install it will create the files and go through all the typical
  functions of installing the software, at the very end step it will
  then delete all files the installer created.

  I looked for logs to see when was going on so I ran the installation
  in Sandboxie and was able to retain all the installed files but I
  couldn't find a log for the installer.

  Here is a screenshot of it deleting all the files at the end of the
  process.

  https://imgur.com/BWiTA38

  If goes too fast for me to see what is written in the text console
  otherwise I would post more information but this is all I have. It
  does not give any error or any other information at completion.

  This error does not occur in the earlier release:
  qemu-w64-setup-20190731.exe

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839294/+subscriptions

