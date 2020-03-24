Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C5C54FCF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BAB20724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BAB20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGb9l-00078D-9n
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 00:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jGb8a-0005KK-EG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jGb8Z-0005mE-4O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:26:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:37044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jGb8Y-0005lj-V9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:25:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jGb8W-0001Oe-8T
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 18C2F2E80E5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2020 04:17:21 -0000
From: Launchpad Bug Tracker <1659901@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: edward-vielmetti janitor pgnd pmaydell rdicroce
X-Launchpad-Bug-Reporter: Rich DiCroce (rdicroce)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170127171804.11595.14600.malonedeb@soybean.canonical.com>
Message-Id: <158502344189.22792.16802592816969830963.malone@loganberry.canonical.com>
Subject: [Bug 1659901] Re: Regression: SIGSEGV running Java
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 27e52094af0adb390d8dc1b368f8cadb9750fb77
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
Reply-To: Bug 1659901 <1659901@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1659901

Title:
  Regression: SIGSEGV running Java

Status in QEMU:
  Expired

Bug description:
  I have a build script that bootstraps a Debian armhf image. Part of
  the process involves running a Java program while inside a chroot. I
  am using Debian's qemu-user-static package to run the armhf Java
  binary on an amd64 system.

  qemu-user-static version 1:2.7+dfsg-3~bpo8+2 works fine. Version
  1:2.8+dfsg-1~bpo8+1 always causes Java to crash with a SIGSEGV. The
  location of the crash appears to be random and hasn't been the same
  twice.

  I am using the Azul Systems Zulu Embedded Java runtime, rather than
  the regular OpenJDK runtime, because the Zulu runtime has an arm32 JIT
  whereas OpenJDK is interpreter-only on arm32.

  I can reproduce the problem easily by mounting the image created by my
  build script and executing "java -XshowSettings -version" in a chroot.
  I can give you the image if that would help debug the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1659901/+subscriptions

