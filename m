Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9280DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669F5207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669F5207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioouV-0002f7-4g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ioork-00055p-M3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ioorj-0002a2-EM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:53962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ioorj-0002Z1-8J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ioord-0004nD-B9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 13:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 18E6E2E80D0
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2020 13:17:55 -0000
From: puchuu <1858461@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aladjev-andrew
X-Launchpad-Bug-Reporter: puchuu (aladjev-andrew)
X-Launchpad-Bug-Modifier: puchuu (aladjev-andrew)
References: <157833123209.15024.12557979334447840996.malonedeb@wampee.canonical.com>
Message-Id: <157840307561.2880.15699191944143021403.malone@soybean.canonical.com>
Subject: [Bug 1858461] Re: Please refactor linux-user/mips/cpu_loop.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 94f0ba47bf89a9ff5e6abb272cb2f3ac72eca701
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
Reply-To: Bug 1858461 <1858461@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've found a reliable way to generate syscall arguments count table.

cd /usr/src/linux
make clean
make CONFIG_DEBUG_INFO=3Dy CONFIG_DEBUG_INFO_SPLIT=3Dy CONFIG_DEBUG_INFO_DW=
ARF4=3Dy
llvm-dwarfdump -debug-info --name ksys_getdents64 --show-children --recurse=
-depth=3D1 fs/readdir.dwo

0x00013738: DW_TAG_subprogram
              DW_AT_name        ("ksys_getdents64")
              ...

0x00013752:   DW_TAG_formal_parameter
              ...

0x00013766:   DW_TAG_formal_parameter
              ...

0x00013779:   DW_TAG_formal_parameter
              ...

We can count "DW_TAG_formal_parameter" for syscall and it that's it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1858461

Title:
  Please refactor linux-user/mips/cpu_loop.c

Status in QEMU:
  New

Bug description:
  Hello. I am working with qemu on test images. I've added a new syscall
  (436) to qemu but received ENOSYS from mips application.

  Please open "linux-user/mips/cpu_loop.c". I've added at the end of
  "mips_syscall_args" the following:

  ```
  MIPS_SYS(sys_getdents64_x32, 3)
  ```

  But

  ```
  syscall_num =3D env->active_tc.gpr[2] - 4000;
  if (syscall_num >=3D sizeof(mips_syscall_args)) {
    ret =3D -TARGET_ENOSYS;
  ```

  returns -TARGET_ENOSYS

  We can see that "linux-user/mips/cpu_loop.c" differs a lot from
  "linux-user/arm/cpu_loop.c". Arm has it's own "ARM_NR_BASE" and etc.

  Can you please refactor mips cpu loop in the same way as arm? Thank
  you.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1858461/+subscriptions

