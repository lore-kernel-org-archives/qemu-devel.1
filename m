Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B07C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA64206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA64206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWo8-0005xe-MX
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYWmz-00056L-0R
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:25:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:49646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYWmx-0000dX-LV
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYWms-0008Vg-AL
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 15:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4D6932E810D
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 15:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2020 15:19:38 -0000
From: zkrx <1877716@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anatol busimus post-factum stefanha zkrx
X-Launchpad-Bug-Reporter: zkrx (zkrx)
X-Launchpad-Bug-Modifier: zkrx (zkrx)
References: <158901182209.5021.12832610872088111923.malonedeb@soybean.canonical.com>
Message-Id: <158929677818.12255.12177151132371166667.malone@wampee.canonical.com>
Subject: [Bug 1877716] Re: Win10 guest unusable after a few minutes
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b87186053ebd208b7374d63e973af40d5ca878f7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:25:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

Hi Stefan,

I applied your series on top of master with io_uring enabled and I no
longer experience the issue. Let me know if you need additional testing.

Thank you for fixing this so promptly.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877716

Title:
  Win10 guest unusable after a few minutes

Status in QEMU:
  New

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

