Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F514C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433D020692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433D020692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9EmG-0001AY-Gj
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 16:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i9Elb-0000j4-AH
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i9Ela-0001UN-2w
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:35:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:53950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i9ElZ-0001UB-TZ
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i9ElZ-0007NX-3o
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 20:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1AE092E80CB
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 20:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Sep 2019 20:29:18 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paulo-cesar-pereira-de-andrade rth
X-Launchpad-Bug-Reporter: =?utf-8?q?Paulo_C=C3=A9sar_Pereira_de_Andrade_=28?=
 =?utf-8?q?paulo-cesar-pereira-de-andrade=29?=
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <156787148109.29148.9145557698070556446.malonedeb@chaenomeles.canonical.com>
Message-Id: <156849295899.660.7788290394933110670.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 799cc4c2c4adebda62385435138fee488a50d9fb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843133] Re: Possibly incorrect branch in
 qemu-system-hppa
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
Reply-To: Bug 1843133 <1843133@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test case works for me.

$ ./hppa-linux-user/qemu-hppa ~/a.out
$ echo $?
0

>From -d in_asm,cpu logs:

IN: main
0x000112d0:  addb,*<,n r24,r23,0x112e4

IA_F 000112d3 IA_B 000112d7
PSW  0000bf00 CB   11111111 ------------------
GR00 00000000 GR01 00000000 GR02 0001162b GR03 ff7fe9c0
GR04 00011b94 GR05 00011c6c GR06 00000000 GR07 00000000
GR08 00000000 GR09 00000000 GR10 00000000 GR11 00000000
GR12 00000000 GR13 00000000 GR14 00000000 GR15 00000000
GR16 00000000 GR17 00000000 GR18 00000000 GR19 ff7fe888
GR20 00000000 GR21 00000000 GR22 000112bc GR23 7fffffff
GR24 00000001 GR25 ff7fe674 GR26 00000001 GR27 0009a0e0
GR28 0009f080 GR29 00000001 GR30 ff7fea00 GR31 0001162b

About to execute the addb; r23 and r24 as expected.

----------------
IN: main
0x000112e4:  ldi 0,ret0

IA_F 000112e7 IA_B 000112eb
PSW  0000bf00 CB   11111111 ------------------
GR00 00000000 GR01 00000000 GR02 0001162b GR03 ff7fe9c0
GR04 00011b94 GR05 00011c6c GR06 00000000 GR07 00000000
GR08 00000000 GR09 00000000 GR10 00000000 GR11 00000000
GR12 00000000 GR13 00000000 GR14 00000000 GR15 00000000
GR16 00000000 GR17 00000000 GR18 00000000 GR19 ff7fe888
GR20 00000000 GR21 00000000 GR22 000112bc GR23 80000000
GR24 00000001 GR25 ff7fe674 GR26 00000001 GR27 0009a0e0
GR28 0009f080 GR29 00000001 GR30 ff7fea00 GR31 0001162b

The branch has been taken, correctly.
We can see the expected result in r23.

I've also tested this in system mode, though getting logs
from that is significantly more difficult.

I am testing git master, not v3.1.1.  Can you please try
the development version?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843133

Title:
  Possibly incorrect branch in qemu-system-hppa

Status in QEMU:
  Incomplete

Bug description:
  I plan to release a new GNU Lightning soon.
  I no longer have access to any physical HPPA, but code that
  was tested some years ago did work on HPPA/HP-UX, and now it
  appears qemu-system-hppa incorrectly branches in code generated
  by GNU Lightning. Currently only 32 bit hppa jit generation
  supported.

  In the lightning check/test tool, the code would be:

  .code
      prolog
      movi %r0 0x7fffffff
      movi %r1 1
      boaddr L0 %r0 %r1
      calli @abort
  L0:
      ret
      epilog

  The code/debug information looks like this:
              movi r4 0x7fffffff
              0xf8ef5018      ldil L%7ffff800,r4
              0xf8ef501c      ldo 7ff(r4),r4
              movi r5 0x1
              0xf8ef5020      ldi 1,r5
          boaddr L1 r4 r5
              0xf8ef5024      addb,sv,n r5,r4,0xf8ef5044 :a.tst:291
              0xf8ef5028      nop
          calli 0xf8eeb68a
              [...]
      L1:

  Apparently it is not understanding 0x7fffffff + 1 is a signed
  overflow.

  Tested in Fedora with qemu-system-hppa-3.1.1-2.fc30.x86_64 and using
  the debian-10 image.

  To make it a bit easier to test (partially transformed the
  not so optimized code generated by lightning to gcc -S output):
  # cat a.s
  	.LEVEL 1.1
  	.text
  	.align 4
  .globl main
  	.type	main, @function
  main:
  	.PROC
  	.CALLINFO FRAME=3D64,NO_CALLS,SAVE_SP,ENTRY_GR=3D3
  	.ENTRY
  	copy %r3,%r1
  	copy %r30,%r3
  	stwm %r1,64(%r30)
  	zdepi -1,31,31,%r23
  	ldi 1,%r24
  	addb,sv,n %r24,%r23,.L0
  	nop
  	ldi 1,%r28
  	b,n .L1
  	nop
  .L0:
  	ldi 0,%r28
  .L1:
  	ldo 64(%r3),%r30
  	ldwm -64(%r30),%r3
  	bv,n %r0(%r2)
  	.EXIT
  	.PROCEND
  	.size	main, .-main

  # gcc a.s
  # ./a.out; echo $?
  1

  It should have returned 0.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843133/+subscriptions

