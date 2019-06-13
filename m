Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C312C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145BD2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145BD2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSZj-0001HQ-80
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52753)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hbRNa-0004Lv-RN
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hbRNZ-0005KT-DU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:11:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:45020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hbRNY-0005HF-0t
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:11:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hbRNV-000277-BE
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 15:11:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3FF4D2E80C8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 15:11:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jun 2019 14:57:50 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee christophe-lyon
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Christophe Lyon (christophe-lyon)
References: <156025884763.18155.9614824235777300144.malonedeb@wampee.canonical.com>
Message-Id: <156043787007.24644.10211587159854825990.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 16f5283b7de3b474967c907925eb5cd0d7ec68ab
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

It's fairly recent:
qemu-arm version 4.0.50 (v4.0.0-1215-ga578cdf-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

commit a578cdfbdd8f9beff5ced52b7826ddb1669abbbf
Merge: 19735c8 43b3952
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Jun 10 16:09:19 2019 +0100

     Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190610'
into staging

     Move softmmu tlb into CPUNegativeOffsetState

configured with:
--target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-us=
er --enable-debug

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832353

Title:
  cpu_exec: Assertion !have_mmap_lock() failed

Status in QEMU:
  New

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

