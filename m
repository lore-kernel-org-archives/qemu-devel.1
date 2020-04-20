Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B05C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9826E20782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9826E20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZiW-0001IX-Oz
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54734 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQZht-0000sm-62
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:55:41 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQZhs-0006cN-DU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:55:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:49798)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jQZhr-0006bQ-VC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:55:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jQZhq-0004Lv-1q
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 16:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CEB122E8029
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 16:55:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2020 16:45:52 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell
X-Launchpad-Bug-Reporter: Peter Maydell (pmaydell)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158739845498.17284.14931679531130317910.malonedeb@wampee.canonical.com>
Message-Id: <158740115339.5694.15005890604371194746.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1873898] Re: arm linux-user: bkpt insn doesn't cause SIGTRAP
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 72b429eb0d4ea3db43c115b4157a75649af8042c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 12:15:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1873898 <1873898@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873898

Title:
  arm linux-user: bkpt insn doesn't cause SIGTRAP

Status in QEMU:
  In Progress

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

