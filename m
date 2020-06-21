Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F1C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 01:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E2522A85
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 01:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E2522A85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmp8k-000754-Q7
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 21:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jmp88-0006Zs-Qp
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 21:50:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:34354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jmp86-0008Hp-EC
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 21:50:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jmp83-0006wN-BG
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 01:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4F54A2E8023
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 01:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2020 01:43:29 -0000
From: Rin Okuyama <1668041@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nyh rokuyama
X-Launchpad-Bug-Reporter: Nadav Har'El (nyh)
X-Launchpad-Bug-Modifier: Rin Okuyama (rokuyama)
References: <20170226112349.20229.38263.malonedeb@gac.canonical.com>
Message-Id: <159270380962.25756.17467835093283243595.malone@gac.canonical.com>
Subject: [Bug 1668041] Re: x86 Floating point exceptions - incorrect support?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6a6c52fdba890b35f5db95ed6da5c948383a7843
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 21:50:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1668041 <1668041@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This problem still exists on QEMU 5.0.0 both for i386 and x86_64;
floating-point zero division is not trapped at all, while integer
one is trapped correctly.

This seriously affects NetBSD project, which carries out periodic
regression tests on QEMU:

https://releng.netbsd.org/test-results.html

Tests including floating-point zero division are falling on QEMU,
while they are successfully passing on real hardwares.

HOW TO REPEAT:

Compile and run this program on Unix like operating systems:

---
#include <fenv.h>
#include <stdlib.h>
#include <unistd.h>

int
main(void)
{
        volatile double a =3D getpid();
        volatile double b =3D atoi("0");

        feenableexcept(FE_ALL_EXCEPT);

        usleep((int)(a / b));

        return 0;
}
---

It crashes by SIGFPE on real hardware, but normally exits on QEMU.

I ran this program on NetBSD 9.0 for x86_64 and i386 on QEMU 5.0.0:

(1) Obtain NetBSD 9.0 release from here:

For x86_64:
http://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-amd64.iso

For i386:
http://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-i386.iso

(2) Install it for disk image.

(3) qemu-system-x86_64 NetBSD.qcow2 or qemu-system-i386 NetBSD.qcow2

(4) Compile and run the test program above:

# cc fpe.c -lm -o fpe
# ./fpe

(5) Then, it exits normally, while it should abort due to SIGFPE.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1668041

Title:
  x86 Floating point exceptions - incorrect support?

Status in QEMU:
  New

Bug description:
  It seems that qemu does not correctly emulate the x86 support for
  optionally causing a floating-point exception (#FP) when, for example,
  dividing by zero. Reports such as:

  https://github.com/cloudius-systems/osv/issues/855
  http://stackoverflow.com/questions/15134189/qemu-div-by-zero-mxcsr-regist=
er

  suggest that setting the exception mask in the fpu cw or mxcsr (e.g.,
  using a function like feenableexcept() in the guest OS) does not
  generate floating point exceptions on divide by zero. The problem only
  happens on pure QEMU - when a QEMU/KVM combination is used, the actual
  hardware does the floating point work, and does throw the exception on
  divide by zero if so requested.

  Looking at the qemu (2.8.0) source code, it seems to me it really
  lacks support for generating fpu exceptions: For example,
  helper_fdiv() in target-i386/fpu_helper.c, when it notices the divisor
  is zero, seems to set the divide-by-zero exception bit, but doesn't
  seem to check whether it needs to trigger an exception (when the right
  bits on the x87 or SSE control words are enabled).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1668041/+subscriptions

