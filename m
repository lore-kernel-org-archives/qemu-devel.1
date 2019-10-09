Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1099DECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D760B206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D760B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFax-0005we-0D
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iI9QL-0003bN-FQ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iI9QK-0005dC-A2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:42:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:59110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iI9QK-0005bg-46
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:42:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iI9QI-0008WV-QM
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 10:42:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BE66D2E80C7
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 10:42:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2019 10:28:24 -0000
From: Yves Lhuillier <1847467@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: amd64
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ylhuillier
X-Launchpad-Bug-Reporter: Yves Lhuillier (ylhuillier)
X-Launchpad-Bug-Modifier: Yves Lhuillier (ylhuillier)
Message-Id: <157061690442.756.9495451631448947331.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1847467] [NEW] qemu-x86_64 segment prefixes error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 22029a976ea2d3b1c7c5b351613fd06b890758f8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1847467 <1847467@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu-x86_64 version 4.1.0 (qemu-x86_64 version 4.0.0 also have the
issue)

In 64-bit mode (x86_64) the DS, ES, SS or CS segment prefixes should be
ignored; qemu-x86_64 does not ignore them.

example: an x86_64 instructions preceded by FS DS (0x64 0x26) segment
prefixes have the linear address of its memory reference flat-mapped (as
if DS was in action) whereas it should be FS-mapped (offset by FS_base,
because the DS, ES, SS or CS are just ignored).


I attach a small C++ program that shows this discrepancy.

$ ./sample
I'm not in QEMU

$ qemu-x86_64 ./sample
I'm in QEMU

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: amd64

** Attachment added: "small C++ program to reproduce the bug"
   https://bugs.launchpad.net/bugs/1847467/+attachment/5295831/+files/sampl=
e.cc

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847467

Title:
  qemu-x86_64 segment prefixes error

Status in QEMU:
  New

Bug description:
  qemu-x86_64 version 4.1.0 (qemu-x86_64 version 4.0.0 also have the
  issue)

  In 64-bit mode (x86_64) the DS, ES, SS or CS segment prefixes should
  be ignored; qemu-x86_64 does not ignore them.

  example: an x86_64 instructions preceded by FS DS (0x64 0x26) segment
  prefixes have the linear address of its memory reference flat-mapped
  (as if DS was in action) whereas it should be FS-mapped (offset by
  FS_base, because the DS, ES, SS or CS are just ignored).

  =

  I attach a small C++ program that shows this discrepancy.

  $ ./sample
  I'm not in QEMU

  $ qemu-x86_64 ./sample
  I'm in QEMU

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847467/+subscriptions

