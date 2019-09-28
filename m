Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977DCC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 04:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1112075D
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 04:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1112075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iE4Q9-0004mr-Bo
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 00:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iE4Op-0004Kj-Ls
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iE4Oo-0003TB-LO
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:32:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:58052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iE4Oo-0003Go-Fc
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 00:32:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iE4Ok-0003qV-UL
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 04:31:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1C8742E81C1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 04:31:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Sep 2019 04:17:20 -0000
From: Launchpad Bug Tracker <1809453@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor marcandre-lureau zhaoby
X-Launchpad-Bug-Reporter: zhaoby (zhaoby)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <154539736525.20217.16347056739487632712.malonedeb@soybean.canonical.com>
Message-Id: <156964424025.19189.15393430506446114466.malone@loganberry.canonical.com>
Subject: [Bug 1809453] Re: Windows qemu download Big file bug in net user mode
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19064";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 53772c85f9670a86a3003c2c7567cebc8c15d0f5
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
Reply-To: Bug 1809453 <1809453@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809453

Title:
  Windows  qemu download Big file bug in net user mode

Status in QEMU:
  Expired

Bug description:
  hi

  Windows qemu with -net user downloading big files has a bug, -net tap
  is good!

  I suspect that the Slirp protocol has a bug on the Windows pc, which
  is normal on ubuntu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809453/+subscriptions

