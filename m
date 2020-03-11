Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85EAC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECDD208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECDD208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBsxT-0007dR-LT
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 00:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBswe-0006rd-T0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBswd-0007Rr-SZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:26:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:41866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBswd-0007QM-NA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:26:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBswa-0008OB-MB
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 04:26:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 09E252E80DB
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 04:26:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2020 04:17:24 -0000
From: Launchpad Bug Tracker <1657841@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor th-huth therock247uk
X-Launchpad-Bug-Reporter: therock247uk (therock247uk)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170119170931.14633.66977.malonedeb@soybean.canonical.com>
Message-Id: <158390024490.22252.170737467750018783.malone@loganberry.canonical.com>
Subject: [Bug 1657841] Re: QEMU Intel HAX Windows
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1ea0a1174d646ad7babdd83c712d02a0f8da7b63
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
Reply-To: Bug 1657841 <1657841@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657841

Title:
  QEMU Intel HAX Windows

Status in QEMU:
  Expired

Bug description:
  Hi,

  Using the latest exe's from http://qemu.weilnetz.de/w32/

  C:\Users\therock247uk\Desktop\jan\qemu-w64-setup-20170113>qemu-system-i38=
6 --enable-hax -m 512 -cdrom C:\Users\therock247uk\Desktop\jan\en_windows_x=
p_professional_with_service_pack_3_x86_cd_x14-80428.iso
  HAX is working and emulator runs in fast virt mode.
  Failed to allocate 20000000 memory

  The emulator seems to hang/get stuck during booting from the CD taking
  out --enable-hax allows it to boot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657841/+subscriptions

