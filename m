Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3B2C4BA04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 23:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145D021927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 23:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145D021927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6jys-0004iD-5J
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 18:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j6jyK-0004JH-2w
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 18:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j6jyI-0005r0-Kf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 18:50:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:36998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j6jyI-0005n2-Dm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 18:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j6jyH-0003Ns-2u
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:50:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1356E2E80C7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:50:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Feb 2020 23:40:46 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier xiaoxing-fang
X-Launchpad-Bug-Reporter: Xiaoxing Fang (xiaoxing-fang)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158266147970.14929.12590183127375701795.malonedeb@wampee.canonical.com>
Message-Id: <158267404692.18796.11868805424384979986.malone@chaenomeles.canonical.com>
Subject: [Bug 1864704] Re: No compatible -machine option in qemu-system-ppc64
 for e6500 core
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9eff1c37c1740693bdcba94d8f8c608164af5689";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c2b261d4ab7c44c989814f0a1db19a535116af5b
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
Reply-To: Bug 1864704 <1864704@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Try "-M ppce500 -cpu e6500"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1864704

Title:
  No compatible -machine option in qemu-system-ppc64 for e6500 core

Status in QEMU:
  New

Bug description:
  Hi,

  I'm trying to use qemu-system-ppc64 for emulating a QorIQ T2080 (with e65=
00 cores). =

  However, I couldn't find any -machine option that matches -cpu e6500 opti=
on, which are listed below:

  C:\Program Files\qemu>qemu-system-ppc64 -machine help
  Supported machines are:
  40p                  IBM RS/6000 7020 (40p)
  bamboo               bamboo
  g3beige              Heathrow based PowerMAC
  mac99                Mac99 based PowerMAC
  mpc8544ds            mpc8544ds
  none                 empty machine
  powernv8             IBM PowerNV (Non-Virtualized) POWER8
  powernv              IBM PowerNV (Non-Virtualized) POWER9 (alias of power=
nv9)
  powernv9             IBM PowerNV (Non-Virtualized) POWER9
  ppce500              generic paravirt e500 platform
  prep                 PowerPC PREP platform (deprecated)
  pseries-2.1          pSeries Logical Partition (PAPR compliant)
  pseries-2.10         pSeries Logical Partition (PAPR compliant)
  pseries-2.11         pSeries Logical Partition (PAPR compliant)
  pseries-2.12         pSeries Logical Partition (PAPR compliant)
  pseries-2.12-sxxm    pSeries Logical Partition (PAPR compliant)
  pseries-2.2          pSeries Logical Partition (PAPR compliant)
  pseries-2.3          pSeries Logical Partition (PAPR compliant)
  pseries-2.4          pSeries Logical Partition (PAPR compliant)
  pseries-2.5          pSeries Logical Partition (PAPR compliant)
  pseries-2.6          pSeries Logical Partition (PAPR compliant)
  pseries-2.7          pSeries Logical Partition (PAPR compliant)
  pseries-2.8          pSeries Logical Partition (PAPR compliant)
  pseries-2.9          pSeries Logical Partition (PAPR compliant)
  pseries-3.0          pSeries Logical Partition (PAPR compliant)
  pseries-3.1          pSeries Logical Partition (PAPR compliant)
  pseries-4.0          pSeries Logical Partition (PAPR compliant)
  pseries-4.1          pSeries Logical Partition (PAPR compliant)
  pseries              pSeries Logical Partition (PAPR compliant) (alias of=
 pseries-4.2)
  pseries-4.2          pSeries Logical Partition (PAPR compliant) (default)
  ref405ep             ref405ep
  sam460ex             aCube Sam460ex
  taihu                taihu
  virtex-ml507         Xilinx Virtex ML507 reference design

  I am wondering if anyone knows that is if any of them can be selected
  for such emulation? Thank you!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1864704/+subscriptions

