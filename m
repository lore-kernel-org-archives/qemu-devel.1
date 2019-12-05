Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C33C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7417B22525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7417B22525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrk9-0006M0-3z
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1icrhK-0004cA-7z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1icrhE-0006pw-HP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:01:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:39162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1icrhC-0006oH-Op
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:01:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1icrhA-0003oJ-BO
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 14:01:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 238C12E80CC
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 14:01:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Dec 2019 13:54:39 -0000
From: "Misa.Z" <1809291@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kcwang misaz philmd pmaydell
X-Launchpad-Bug-Reporter: k.c. Wang (kcwang)
X-Launchpad-Bug-Modifier: Misa.Z (misaz)
References: <154532874183.18487.10011391612831676105.malonedeb@gac.canonical.com>
Message-Id: <157555407960.6406.1338258523296144389.malone@gac.canonical.com>
Subject: [Bug 1809291] Re: SD Card not working in Ubuntu 18.10 (CMD 2,
 3 timeout). The device worked fine in Ubuntu 18.04 and earlier
 versions but not in Ubuntu 18.10
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 765b0d1c7239898f7ae0a4f13ba946ac26a77cd1
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
Reply-To: Bug 1809291 <1809291@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear Dr. KC.Wang,

Download qemu-4.2.0-rc4 source code, change hw/sd/sd.c at line 1560 like
follows and remake

(line: 1560)

if (req.arg & ACMD41_ENQUIRY_MASK) {
/*if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {*/

BTW,  here is my micro-kernel-os for arm platform based the contents
from your books, thanks !

https://github.com/MisaZhu/micro_kernel_os

Misa.Z

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809291

Title:
  SD Card not working in Ubuntu 18.10 (CMD 2,3 timeout).  The device
  worked fine in Ubuntu 18.04 and earlier versions but not in Ubuntu
  18.10

Status in QEMU:
  Confirmed

Bug description:
  ARM PL181 MMC card no longer working in qemu-system-arm in Ubuntu 18.10
  The MMC driver code worked fine in Ubuntu 15.10 to 18.04.
  The command to run qemu-system-arm is

      qemu-system-arm -M versatilepb -m 256M -sd sdimage -kernel t.bin
  -serial mon:stdio

  During SDC initialization, SDC commands 2, 3, 9, 13, 7, 16 all timeout, =

  which cause subsequent read/write commands 17/24 to fail also.

  Tried both ARM versatilepb and realview-pb-a8, realview-pbx-a9 boards:
  all the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809291/+subscriptions

