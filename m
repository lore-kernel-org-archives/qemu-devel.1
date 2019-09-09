Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3131C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C617218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C617218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7I3S-0004W8-II
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 07:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7I2P-00044u-3s
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7I2O-0000Ge-1W
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:35296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7I2N-0000G9-S2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:40:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7I2M-00032Z-4l
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 11:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2182D2E80C3
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 11:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2019 11:27:51 -0000
From: Udo Steinberg <1843254@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm virtualization
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: udo-hypervisor
X-Launchpad-Bug-Reporter: Udo Steinberg (udo-hypervisor)
X-Launchpad-Bug-Modifier: Udo Steinberg (udo-hypervisor)
Message-Id: <156802847195.6589.6854466446567964580.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3203f435da87e5bece308d343c9c8f20456c134e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843254] [NEW] HCR.TID3 traps are not implemented
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
Reply-To: Bug 1843254 <1843254@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

On ARM (aarch64), HCR_EL2.TID3 [bit18] is supposed to trap ID group 3,
which includes the ID_AA64{PFR,DFR,ISAR,MMFR,AFR}*_EL1 registers.
However, setting that HCR bit has no effect and accesses to those ID
registers are not trapped to EL2 with an EC syndrome value of 0x18.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm virtualization

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843254

Title:
  HCR.TID3 traps are not implemented

Status in QEMU:
  New

Bug description:
  On ARM (aarch64), HCR_EL2.TID3 [bit18] is supposed to trap ID group 3,
  which includes the ID_AA64{PFR,DFR,ISAR,MMFR,AFR}*_EL1 registers.
  However, setting that HCR bit has no effect and accesses to those ID
  registers are not trapped to EL2 with an EC syndrome value of 0x18.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843254/+subscriptions

