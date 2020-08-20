Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB61C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72402075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72402075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mXr-0003oR-Tb
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mNH-000122-Qt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:21:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:53678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mNF-0008Bl-3H
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:21:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mNB-0001mo-SX
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:21:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BD89D2E8137
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:21:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:14:16 -0000
From: Thomas Huth <1873898@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell th-huth
X-Launchpad-Bug-Reporter: Peter Maydell (pmaydell)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158739845498.17284.14931679531130317910.malonedeb@wampee.canonical.com>
Message-Id: <159793645614.2169.15170843426032030532.malone@chaenomeles.canonical.com>
Subject: [Bug 1873898] Re: arm linux-user: bkpt insn doesn't cause SIGTRAP
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 97c6bbd32418bab8aa0bd07272c96f640048a2a8
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
Reply-To: Bug 1873898 <1873898@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D13a0c21e64bddf1a36

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873898

Title:
  arm linux-user: bkpt insn doesn't cause SIGTRAP

Status in QEMU:
  Fix Released

Bug description:
  QEMU's 32-bit arm linux-user mode doesn't correctly turn guest BKPT
  insns into SIGTRAP signals. Test case:

  =3D=3D=3Dbegin bkpt.c=3D=3D=3D
  /* test bkpt insn */

  #include <stdlib.h>
  #include <stdio.h>

  int main(void)
  {
      printf("breakpoint\n");
  #ifdef __aarch64__
      __asm__ volatile("brk 0x42\n");
  #else
      __asm__ volatile("bkpt 0x42\n");
  #endif
      printf("done\n");
      return 0;
  }
  =3D=3D=3Dendit=3D=3D=3D

  Compile with
  $ arm-linux-gnueabihf-gcc -g -Wall -o bkpt-aa32 bkpt.c
  $ aarch64-linux-gnu-gcc -g -Wall -o bkpt-aa64 bkpt.c

  Contrast aarch64 which delivers the SIGTRAP and arm which doesn't:

  $ qemu-aarch64 bkpt-aa64
  breakpoint
  qemu: uncaught target signal 5 (Trace/breakpoint trap) - core dumped
  Trace/breakpoint trap (core dumped)
  $ qemu-arm bkpt-aa32
  breakpoint
  done

  This is because in linux-user/arm/cpu-loop.c we incorrectly treat
  EXCP_BKPT similarly to EXCP_SWI, which means that we actually perform
  a syscall (which one depends on what happens to be in r7...). This
  code has been like this (more or less) since commit 06c949e62a098f in
  2006 which added BKPT in the first place. This is probably because at
  the time the same code path was used to handle both Linux syscalls and
  semihosting calls, and (on M profile) BKPT does imply a semihosting
  call. But these days we've moved handling of semihosting out to an
  entirely different codepath, so we can fix this bug by simply removing
  this handling of EXCP_BKPT and instead making it deliver a SIGTRAP
  like EXCP_DEBUG (as we do already on aarch64).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1873898/+subscriptions

