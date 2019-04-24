Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92D9C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A25D218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A25D218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAft-0006nM-QC
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:42:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeN-0005sQ-0x
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeL-00080r-EB
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAeL-00080J-7S
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAeK-0003uy-EE
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 69DCB2E80C7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:33:00 -0000
From: Thomas Huth <1807675@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aortega pmaydell
X-Launchpad-Bug-Reporter: Alberto Ortega (aortega)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154443228387.16328.809879618975540748.malonedeb@soybean.canonical.com>
Message-Id:
 <155608398182.16809.12875759120526725702.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ca761bf4f96f614679c5315011b856ea4d5e0597
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1807675] Re: qemu commit 80422b0: tcg.c crash in
 temp_load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1807675 <1807675@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424053300.jYgEiwq1IA7E80LAb2QpR606y1DTXTDM4ckmepIsPcg@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1807675

Title:
  qemu commit 80422b0: tcg.c crash in temp_load

Status in QEMU:
  Fix Released

Bug description:
  As discussed in #1803160 I'm opening a new ticket for the new bug.

  QEMU version:
  -------------

  qemu from git, master branch commit
  80422b00196a7af4c6efb628fae0ad8b644e98af

  Summary:
  --------

  TCG crashes in i386 and x86_64 when it tries to execute some specific
  illegal instructions. When running full OS emulation, both the guest
  system and QEMU crash.

  $ qemu-i386 tcg_crash1.elf
  /home/alberto/Documents/qemu/tcg/tcg.c:2863: tcg fatal error
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  zsh: segmentation fault (core dumped) ./qemu/build/i386-linux-user/qemu-i=
386 tcg_crash1.elf

  Invalid instructions:

  f0 invalid
  40 inc eax
  a7 cmpsd dword [esi], dword ptr es:[edi]
  48 dec eax

  Testcase:
  ---------

  Find ELF file attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1807675/+subscriptions

