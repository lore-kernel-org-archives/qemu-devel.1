Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C624C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA3B2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA3B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmJx-0007QM-Lx
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkmIv-0006bF-NX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkmIu-0001af-Mp
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:57260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkmIu-0001Zr-HD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkmIt-0008Co-4O
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:20:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 16E662E80CC
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 09:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jul 2019 09:11:07 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Tags: arm tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee christophe-lyon pmaydell rth
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156025884763.18155.9614824235777300144.malonedeb@wampee.canonical.com>
Message-Id: <156266346841.23706.4826780197693140024.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 087ec7f40abba719f4ba92b5eecd9fd3737de7e7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832353] Re: cpu_exec: Assertion
 !have_mmap_lock() failed
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
Reply-To: Bug 1832353 <1832353@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832353

Title:
  cpu_exec: Assertion !have_mmap_lock() failed

Status in QEMU:
  In Progress

Bug description:
  Hi,

  I have isolated a testcase from the GCC testsuite (actually gfortran,
  test proc_ptr_51.f90) which produces tons of:

  qemu-arm: /home/christophe.lyon/src/qemu/accel/tcg/cpu-exec.c:701:
  cpu_exec: Assertion `!have_mmap_lock()' failed.

  including with master qemu as of today.

  I'm attaching a tarball containing:
  qemu-assert:
  cmd  lib  proc_ptr_51.exe

  qemu-assert/lib:
  ld-linux-armhf.so.3  libc.so.6  libgcc_s.so.1  libgfortran.so.5  libm.so.6

  where cmd is the basic command used to launch the test & reproduce the
  failure.

  Note that the test or the generated may actually be buggy: I have
  reported failures on native aarch64 and arm machines. Yet, qemu should
  not fail with a loop of asserts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832353/+subscriptions

