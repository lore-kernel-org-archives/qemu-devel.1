Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38162C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6332064B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6332064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwY1o-0000Vr-0Y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 17:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwY14-0008Vg-B4
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 17:35:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:36894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwY12-0003V5-D6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 17:35:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jwY0z-0004E1-IV
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 21:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 89EE32E80F0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 21:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2020 21:26:50 -0000
From: Helge Deller <1880287@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 8-deller
X-Launchpad-Bug-Reporter: Helge Deller (8-deller)
X-Launchpad-Bug-Modifier: Helge Deller (8-deller)
References: <159022297856.20775.958724179871171148.malonedeb@soybean.canonical.com>
Message-Id: <159502121068.13621.18184835876951101397.malone@gac.canonical.com>
Subject: [Bug 1880287] Re: gcc crashes in hppa emulation
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e5cf6fd6820b497e67789e7b5a80457ef1c62925
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 11:25:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1880287 <1880287@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test still crashes the VM and chroot with up-to-date debian chroot,
including updated gcc-9.3.0-14.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880287

Title:
  gcc crashes in hppa emulation

Status in QEMU:
  New

Bug description:
  There seems to be a translation bug in the qemu-hppa (qemu v5.0.0) emulat=
ion:
  A stripped down testcase (taken from Linux kernel build) is attached.

  In there is "a.sh", a shell script which calls gcc-9 (fails with both
  debian gcc-9.3.0-11 or gcc-9.3.0-12). and "a.iii", the preprocessed
  source.

  When starting a.sh, in the emulation gcc crashes with segfault.
  On real hardware gcc succeeds to compile the source.

  In a hppa-user chroot running "apt update && apt install gcc-9" should
  be sufficient to get the needed reproducer environment.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880287/+subscriptions

