Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF72C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D482206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D482206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mKV-0006kr-P6
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mHp-0004O8-Js
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:15:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:51266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mHn-0007Z2-EF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:15:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mHl-0000p6-Sc
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:15:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D002A2E80D2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:15:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 14:59:27 -0000
From: Thomas Huth <757702@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anuppatelinvincible janitor pmaydell th-huth
X-Launchpad-Bug-Reporter: Anup Patel (anuppatelinvincible)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20110411161233.16764.21820.malonedeb@soybean.canonical.com>
Message-Id: <159793556795.15369.6845875057853844998.malone@soybean.canonical.com>
Subject: [Bug 757702] Re: ARM: singlestepping insn which UNDEFs should stop at
 UNDEF vector insn, not after it
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 021bfce8f1ce769f6f8e891b08407aa68b52a030
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
Reply-To: Bug 757702 <757702@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix has been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dba3c35d9c4026361fd3

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/757702

Title:
  ARM: singlestepping insn which UNDEFs should stop at UNDEF vector
  insn, not after it

Status in QEMU:
  Fix Released

Bug description:
  ARMv7a has lot of undefined instruction from its instruction opcode
  space. This undefined instructions are very useful for replacing
  sensitive non-priviledged instructions of guest operating systems
  (virtualization). The undefined instruction exception executes at
  <exception_base> + 0x4, where <exception_base> can be 0x0 or
  0xfff00000. Currently, in qemu 0.14.0 undefined instruction fault at
  0x8 offset instead of 0x4. This was not a problem with qemu 0.13.0,
  seems like this is a new bug. As as example, if we try to execute
  value "0xec019800" in qemu 0.14.0 then it should cause undefined
  exception at <exception_base>+0x4 since "0xec019800" is an undefined
  instruction.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/757702/+subscriptions

