Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E0B206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E0B206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbzjP-0000sp-UR
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 00:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbziq-00008m-Au
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:55:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:55184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbzip-0006gj-1W
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:55:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbzim-0002SU-EL
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 04:55:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2E0F72E8081
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 04:55:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2020 04:48:54 -0000
From: Thomas Huth <1877716@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anatol busimus post-factum stefanha zkrx
X-Launchpad-Bug-Reporter: zkrx (zkrx)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158901182209.5021.12832610872088111923.malonedeb@soybean.canonical.com>
Message-Id: <159012293504.30845.3836592342378726563.launchpad@wampee.canonical.com>
Subject: [Bug 1877716] Re: Win10 guest unusable after a few minutes
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8d18ba233b01c557464a320f1c429f2790cd6188
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 21:50:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1877716 <1877716@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877716

Title:
  Win10 guest unusable after a few minutes

Status in QEMU:
  Fix Committed

Bug description:
  On Arch Linux, the recent qemu package update seems to misbehave on
  some systems. In my case, my Windows 10 guest runs fine for around 5
  minutes and then start to get really sluggish, even unresponsive. It
  needs to be forced off. I could reproduce this on a minimal VM with no
  passthrough, although my current testing setup involves an nvme pcie
  passthrough.

  I bisected it to the following commit which rapidly starts to run sluggis=
hly on my setup:
  https://github.com/qemu/qemu/commit/73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4=
ccf

  I've ran the previous commit (
  https://github.com/qemu/qemu/commit/b321051cf48ccc2d3d832af111d688f2282f0=
89b
  ) for the entire night without an issue so far.

  I believe this might be a duplicate of
  https://bugs.launchpad.net/qemu/+bug/1873032 , although I'm not sure.

  Linux cc 5.6.10-arch1-1 #1 SMP PREEMPT Sat, 02 May 2020 19:11:54 +0000 x8=
6_64 GNU/Linux
  AMD Ryzen 7 2700X Eight-Core Processor

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877716/+subscriptions

