Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D8C742D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 00:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807CD20896
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 00:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807CD20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm6EG-0005yg-T6
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 20:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hm5hR-0000au-BA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 20:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hm5hQ-0003rF-7e
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 20:15:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:47052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hm5hQ-0003qt-2A
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 20:15:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hm5hO-0007qj-Lk
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 00:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 94E892E804C
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 00:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jul 2019 00:09:34 -0000
From: Francesco Dainese <franci.dainese@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: karrq
X-Launchpad-Bug-Reporter: Francesco Dainese (karrq)
X-Launchpad-Bug-Modifier: Francesco Dainese (karrq)
Message-Id: <156297657458.27697.12325008509748748159.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 06d0b159471fffaf97528f07f08d30b821e51c57
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Fri, 12 Jul 2019 20:49:24 -0400
Subject: [Qemu-devel] [Bug 1836430] [NEW] Can't install on Windows 10
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
Reply-To: Bug 1836430 <1836430@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Latest release (20190712) 64-bit doesn't install:

The setup seems to work fine at first and actually extract all the files ne=
eded for qemu in the correct location, but after it has done that, it proce=
eds to delete every file and leaves no trace of qemu except the installatio=
n folder.
The setup then finishes and notifies the user that it has been installed su=
ccesfully.

I downloaded the previous release and it installs correctly.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836430

Title:
  Can't install on Windows 10

Status in QEMU:
  New

Bug description:
  Latest release (20190712) 64-bit doesn't install:

  The setup seems to work fine at first and actually extract all the files =
needed for qemu in the correct location, but after it has done that, it pro=
ceeds to delete every file and leaves no trace of qemu except the installat=
ion folder.
  The setup then finishes and notifies the user that it has been installed =
succesfully.

  I downloaded the previous release and it installs correctly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836430/+subscriptions

