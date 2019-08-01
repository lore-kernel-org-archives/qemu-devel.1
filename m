Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC512C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 21:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8852080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 21:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8852080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htJ3x-000692-OQ
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htJ2u-0005iS-6M
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 17:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htJ2s-0008BH-Rc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 17:55:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:51722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htJ2s-00086t-L2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 17:55:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htJ2r-0000Sf-F5
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 21:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6CF242E8053
 for <qemu-devel@nongnu.org>; Thu,  1 Aug 2019 21:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Aug 2019 21:48:41 -0000
From: Toolybird <1838703@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gschafer
X-Launchpad-Bug-Reporter: Toolybird (gschafer)
X-Launchpad-Bug-Modifier: Toolybird (gschafer)
Message-Id: <156469612119.27436.5161465617131751094.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ca67bbe2e59a1583149af5684c81bd541d4ef39a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838703] [NEW] Makefile BUG in edk2 firmware
 install 4.1.0-rc3
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
Reply-To: Bug 1838703 <1838703@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

DESTDIR installs end up with wrong paths in JSON files installed to
$prefix/share/qemu/firmware. For example, the file:

  50-edk2-x86_64-secure.json

ends up incorrectly with:

  "filename": "/build/qemu/pkg/qemu/usr/share/qemu/edk2-x86_64-secure-
code.fd",

instead of the correct:

  "filename": "/usr/share/qemu/edk2-x86_64-secure-code.fd",

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838703

Title:
  Makefile BUG in edk2 firmware install 4.1.0-rc3

Status in QEMU:
  New

Bug description:
  DESTDIR installs end up with wrong paths in JSON files installed to
  $prefix/share/qemu/firmware. For example, the file:

    50-edk2-x86_64-secure.json

  ends up incorrectly with:

    "filename": "/build/qemu/pkg/qemu/usr/share/qemu/edk2-x86_64-secure-
  code.fd",

  instead of the correct:

    "filename": "/usr/share/qemu/edk2-x86_64-secure-code.fd",

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838703/+subscriptions

