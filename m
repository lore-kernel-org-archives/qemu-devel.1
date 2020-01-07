Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D96C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA736207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA736207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomoO-0001k2-MB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iomgO-0003uR-MS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iomgN-0004Ss-DY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:05:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:38664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iomgN-0004SW-88
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:05:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iomgM-0005JO-8z
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 11:05:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 295BD2E80CC
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:05:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2020 10:55:48 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1856549@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: i2c m68k rtc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dcb314 laurent-vivier philmd
X-Launchpad-Bug-Reporter: dcb (dcb314)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <157649490094.7480.17075229014510714852.malonedeb@soybean.canonical.com>
Message-Id: <157839454891.2574.3115010173944275179.malone@soybean.canonical.com>
Subject: [Bug 1856549] Re: qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1a8e18483fed610ce312f5ad3e28036f17a8bbe2
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
Reply-To: Bug 1856549 <1856549@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch posted: https://www.mail-archive.com/qemu-
devel@nongnu.org/msg666836.html

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856549

Title:
  qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?

Status in QEMU:
  In Progress

Bug description:
  1.

  qemu-4.2.0/hw/misc/mac_via.c:417:27: style: Expression is always false
  because 'else if' condition matches previous condition at line 412.
  [multiCondition]

                  } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {
  ...
                  } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {

  2.

  qemu-4.2.0/hw/misc/mac_via.c:467:27: style: Expression is always false
  because 'else if' condition matches previous condition at line 463.
  [multiCondition]

  Duplicate.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856549/+subscriptions

