Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B4C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 03:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6705521928
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 03:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6705521928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7A0V-0003HD-J0
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 23:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i79zj-0002qH-Mg
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 23:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i79zi-0007ux-Eg
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 23:05:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:56144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i79zi-0007uc-2r
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 23:05:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i79zg-00050J-Ea
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 03:05:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 619462E8033
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 03:05:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2019 02:57:57 -0000
From: Alexander Huszagh <ahuszagh@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: float libm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahuszagh
X-Launchpad-Bug-Reporter: Alexander Huszagh (ahuszagh)
X-Launchpad-Bug-Modifier: Alexander Huszagh (ahuszagh)
References: <156799031829.6257.13539682604144427187.malonedeb@soybean.canonical.com>
Message-Id: <156799787797.977.18369831675907435218.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1826639cc6777f7a832c1e6aa1e1edb28904d7b7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843205] Re: Inaccurate Fmod on i386
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
Reply-To: Bug 1843205 <1843205@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags removed: fmod
** Tags added: float libm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843205

Title:
  Inaccurate Fmod on i386

Status in QEMU:
  New

Bug description:
  # Qemu Version

  ```bash
  $ qemu-i386 --version
  qemu-i386 version 3.0.1 (qemu-3.0.1-4.fc29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  ```

  # Failing Source Code (C)

  ```c
  #include <math.h>
  #include <stdio.h>

  int main()
  {
      double x =3D 29860476080414620.0;
      double y =3D 17.0;
      double z =3D fmod(x, y);
      printf("%f\n", z);
      return 0;
  }
  ```

  The code was compiled with GCC (8.3.1) on x86-64 with the flags `-O3
  -m32 -lm -static`.

  # Emitted (Annotated) Assembly

  In order to facilitate debugging the issue, the following assembly was
  generated to show nothing unusual occurred during compilation. The
  assembly was generated with flags `-S -O3 -m32 -lm`, and then
  annotated to show the operands to fmod.

  ```asm
  	.file	"a.c"
  	.text
  	.section	.rodata.str1.1,"aMS",@progbits,1
  .LC2:
  	.string	"%f\n"
  	.section	.text.startup,"ax",@progbits
  	.p2align 4,,15
  	.globl	main
  	.type	main, @function
  main:
  .LFB16:
  	.cfi_startproc
  	leal	4(%esp), %ecx
  	.cfi_def_cfa 1, 0
  	andl	$-16, %esp
  	pushl	-4(%ecx)
  	pushl	%ebp
  	.cfi_escape 0x10,0x5,0x2,0x75,0
  	movl	%esp, %ebp
  	pushl	%ecx
  	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
  	subl	$4, %esp
  	pushl	$1076953088				; high 32-bits of double for y
  	pushl	$0 						; low 32-bits of double for y
  	pushl	$1130005884				; high 32-bits of double for x
  	pushl	$2003187687				; low 32-bits of double for x
  	call	fmod
  	movl	$.LC2, (%esp)
  	fstpl	4(%esp)
  	call	printf
  	movl	-4(%ebp), %ecx
  	.cfi_def_cfa 1, 0
  	addl	$16, %esp
  	xorl	%eax, %eax
  	leave
  	.cfi_restore 5
  	leal	-4(%ecx), %esp
  	.cfi_def_cfa 4, 4
  	ret
  	.cfi_endproc
  .LFE16:
  	.size	main, .-main
  	.ident	"GCC: (GNU) 8.3.1 20190223 (Red Hat 8.3.1-2)"
  	.section	.note.GNU-stack,"",@progbits
  ```

  # Result

  Running the compiled binary on x86_64 produces the expected value of
  `15.000000`, while using `qemu-i386 <binary>` produces the unexpected
  result of `-4.000000`.

  This was tested against:

  1. Qemu 3.0.1 for Fedora 29.
  2. Qemu 4.1.0 built from source, downloaded from https://download.qemu.or=
g/qemu-4.1.0.tar.xz
  3. Qemu built-from-source against commit 90b1e3afd33226b6078fec6d77a18373=
712a975c.

  # Building Qemu

  Qemu built-from-source was compiled as follows:

  ```bash
  mkdir build && cd build
  ../configure --disable-kvm --target-list=3D"i386-linux-user"
  make -j 5
  ```

  # Results

  All built versions of Qemu running the 32-bit failed to produce the
  accurate result. Using qemu-x86_64 against an x86_64 binary built from
  the same C source code produces correct results. Running the 32-bit
  binary natively produces the correct result.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843205/+subscriptions

