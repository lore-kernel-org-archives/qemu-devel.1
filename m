Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B652FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EF4208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EF4208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mFZ-0008RQ-MX
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mDq-0006Kr-5L
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:11:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:50618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mDh-0006ul-3L
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:11:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mDe-0000Df-So
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:11:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D8DEE2E80D2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:11:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:03:02 -0000
From: Thomas Huth <1888165@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jmmorlan th-huth
X-Launchpad-Bug-Reporter: Jeffrey (jmmorlan)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159520414927.8137.962061150870003047.malonedeb@wampee.canonical.com>
Message-Id: <159793578281.2425.2325689653543746987.malone@chaenomeles.canonical.com>
Subject: [Bug 1888165] Re: loopz/loopnz clearing previous instruction's
 modified flags on cx -> 0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: af875e176d9cb7190f221e5ddd67033761b1042d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:50:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1888165 <1888165@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D3cb3a7720b01830abd5

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888165

Title:
  loopz/loopnz clearing previous instruction's modified flags on cx -> 0

Status in QEMU:
  Fix Released

Bug description:
  If you run QBasic in qemu, printing a double-type single-digit number
  will print an extra decimal point (e.g. PRINT CDBL(3) prints "3.")
  that does not appear when running on a real CPU (or on qemu with
  -enable-kvm). I tracked this down to the state of the status flags
  after a loopnz instruction.

  After executing a sequence like this in qemu:

  	mov bx,1
  	mov cx,1
  	dec bx    ; sets Z bit in flags
  A:	loopnz A  ; should not modify flags

  Z is incorrectly clear afterwards. loopz does the same thing (but not
  plain loop). Interestingly, inserting pushf+popf after dec results in
  Z set, so loopnz/loopz does not always clear Z itself but is rather
  interfering with the previous instruction's flag setting.

  Version 5.1.0-rc0, x86-64 host.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888165/+subscriptions

