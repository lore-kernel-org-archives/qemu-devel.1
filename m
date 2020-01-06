Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB7C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3972220731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3972220731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWEw-00061q-2k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ioWD9-0004XE-ME
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ioWD8-0001RJ-BM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:30:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:49826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ioWD8-0001Oy-3q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:30:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ioWD6-0006X5-1G
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 17:30:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 06CEE2E8054
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 17:30:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jan 2020 17:20:31 -0000
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
Message-Id: <157833123209.15024.12557979334447840996.malonedeb@wampee.canonical.com>
Subject: [Bug 1858461] [NEW] Please refactor linux-user/mips/cpu_loop.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ee94af4fe38081b75be4ec1dc39fd81cd3c222bd
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

Public bug reported:

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

We can see that "linux-user/mips/cpu_loop.c" differs a lot from "linux-
user/arm/cpu_loop.c". Arm has it's own "ARM_NR_BASE" and etc.

Can you please refactor mips cpu loop in the same way as arm? Thank you.

** Affects: qemu
     Importance: Undecided
         Status: New

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

