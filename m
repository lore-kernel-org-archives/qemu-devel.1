Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E251C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E9321537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E9321537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkVBF-0004kI-5r
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkV8a-00039q-8m
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkV8V-0006iH-0Z
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:01:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:34288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkV8L-0006Ep-NC
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkV8I-0000Be-5n
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 15:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 27E472E80BA
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 15:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 14:54:46 -0000
From: Matthew Intriago <1835793@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mintriago
X-Launchpad-Bug-Reporter: Matthew Intriago (mintriago)
X-Launchpad-Bug-Modifier: Matthew Intriago (mintriago)
Message-Id: <156259768655.23216.11898576300198780398.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 33d2cf596d17e8e3db58ebd9823ab21052831082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1835793] [NEW] Running an edk2 based bios
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
Reply-To: Bug 1835793 <1835793@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

This is not necessarily a bug, however I wasn't sure were to get help.

I am currently working on using QEMU  to run a BIOS my company has
developed. In order to see if the software was working correctly, I was
able to successfully run the edk2 bios using the following command:

qemu-system-x86_64.exe -bios "C:\Users\matthew.intriago\Desktop\ovmf.fd"
-net none

However, when running the same command using  our personalized bios,
QEMU launches stating that =E2=80=9Cguest has not initialized display=E2=80=
=9D.
Theoretically, QEMU should be able to run the bios since it is edk2
based, the only difference between the two is that our bios has more
features.

If anyone has any insight on what the issue might be I would greatly
appreciate any help.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835793

Title:
  Running an edk2 based bios

Status in QEMU:
  New

Bug description:
  This is not necessarily a bug, however I wasn't sure were to get help.

  I am currently working on using QEMU  to run a BIOS my company has
  developed. In order to see if the software was working correctly, I
  was able to successfully run the edk2 bios using the following
  command:

  qemu-system-x86_64.exe -bios
  "C:\Users\matthew.intriago\Desktop\ovmf.fd" -net none

  However, when running the same command using  our personalized bios,
  QEMU launches stating that =E2=80=9Cguest has not initialized display=E2=
=80=9D.
  Theoretically, QEMU should be able to run the bios since it is edk2
  based, the only difference between the two is that our bios has more
  features.

  If anyone has any insight on what the issue might be I would greatly
  appreciate any help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835793/+subscriptions

