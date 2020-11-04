Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE66C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9660A20739
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaP3C-0001Ub-Bj
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 15:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaP24-0000LI-Ga
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:05:24 -0500
Received: from indium.canonical.com ([91.189.90.7]:49384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaP20-00049Q-7E
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:05:24 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaP1x-0007r3-CU
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 20:05:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 505202E812F
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 20:05:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 19:51:49 -0000
From: John Snow <1569491@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: intermediadc jnsnow
X-Launchpad-Bug-Reporter: luigiburdo (intermediadc)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <20160412175749.2128.24352.malonedeb@wampee.canonical.com>
Message-Id: <160451950953.18523.3463818616775270667.malone@soybean.canonical.com>
Subject: [Bug 1569491] Re: qemu system i386 poor performance on e5500 core
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: da53e13abfea5b18e6d8a4b4526f117378cbe4eb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 14:49:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1569491 <1569491@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm triaging old bugs: Can you provide command lines, versions, and
steps to test and measure the relative performance?

At the very least, please try to confirm on the latest version of QEMU
(5.2.0-rc0, if possible) to update this report.

** Changed in: qemu
       Status: Opinion =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1569491

Title:
  qemu system i386 poor performance on e5500 core

Status in QEMU:
  Incomplete

Bug description:
  I had been tested with generic core net building or with mtune e5500 but =
i have the same result: performances =

  are extremly low compared with other classes of powerpc cpu.
  The strange is the 5020 2ghz in all emulators been tested by me is compar=
able with a 970MP 2.7 ghz in speed and benchmarks but im facing the half of=
 performance in i386-soft-mmu compared with a 2.5 ghz 970MP.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1569491/+subscriptions

