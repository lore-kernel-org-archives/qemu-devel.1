Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68BC433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A212073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A212073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYs6-0000LZ-Ke
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jxYrH-0007y4-9r
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:41:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:37482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jxYrF-00078Z-5i
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:41:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jxYrD-0000Ts-1r
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 16:41:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 06C202E80F0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 16:41:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2020 16:27:58 -0000
From: Peter Maydell <1873898@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell
X-Launchpad-Bug-Reporter: Peter Maydell (pmaydell)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158739845498.17284.14931679531130317910.malonedeb@wampee.canonical.com>
Message-Id: <159526247869.12226.8101638472885836978.malone@soybean.canonical.com>
Subject: [Bug 1873898] Re: arm linux-user: bkpt insn doesn't cause SIGTRAP
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: cd8468b42ba4803c14034d77b63848641f9bdabd
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 11:25:44
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

Should be fixed in current git, will be in 5.2.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873898

Title:
  arm linux-user: bkpt insn doesn't cause SIGTRAP

Status in QEMU:
  Fix Committed

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

