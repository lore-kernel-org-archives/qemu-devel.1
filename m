Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B077207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B077207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoLg-0006f3-I3
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCnK6-0008Sr-2B
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCnK3-0007Fk-Hz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:54214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCnK3-0007FL-Ck
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:05:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCnK1-0006Do-R8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 16:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C81442E8019
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 16:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2019 15:54:58 -0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc64 testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc mark-cave-ayland philmd
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: Mark Cave-Ayland (mark-cave-ayland)
References: <156711057074.6835.13599471410604217618.malonedeb@soybean.canonical.com>
Message-Id: <156934049814.14091.15173209336921636139.malone@gac.canonical.com>
Subject: [Bug 1841990] Re: instruction 'denbcdq' misbehaving
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1a93da4f79a65dc4f83e20e2e540111ed72c0d67
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1841990 <1841990@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry I didn't get a chance to look at this before I went away on
holiday, however I've just posted a patchset at
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg05577.html
which should resolve the issue for you.

With the above patchset applied I now see the following results with
your test program:

LE host:
$ ../qemu-ppc64le -L /usr/powerpc64le-linux-gnu -cpu power9 test-denbcdqle
0x00000000000000000000000000000000
0x0000000000000000000000000000000c
0x22080000000000000000000000000000
$ ../qemu-ppc64le -L /usr/powerpc64le-linux-gnu -cpu power9 test-denbcdqle 1
0x00000000000000000000000000000001
0x0000000000000000000000000000001c
0x22080000000000000000000000000001
$ ../qemu-ppc64le -L /usr/powerpc64le-linux-gnu -cpu power9 test-denbcdqle =
$(seq 0 99)
0x00000000000000000000000000000064
0x0000000000000000000000000000100c
0x22080000000000000000000000000080

BE host:
$ ../qemu-ppc64 -L /usr/powerpc64-linux-gnu -cpu power9 test-denbcdq
0x00000000000000000000000000000000
0x000000000000000c0000000000000000
0x00000000000000002208000000000000
$ ../qemu-ppc64 -L /usr/powerpc64-linux-gnu -cpu power9 test-denbcdq 1
0x00000000000000010000000000000000
0x000000000000001c0000000000000000
0x00000000000000012208000000000000
$ ../qemu-ppc64 -L /usr/powerpc64-linux-gnu -cpu power9 test-denbcdq $(seq =
0 99)
0x00000000000000640000000000000000
0x000000000000100c0000000000000000
0x00000000000000802208000000000000

If you could confirm that the BE host results above match those on real
hardware then that would be great as I've switched over to use macros
that should do the right thing regardless of host endian.

Finally if you have access to a more comprehensive test suite then that
would be helpful to test more of the 64-bit DFP number paths and some of
more esoteric DFP instructions.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841990

Title:
  instruction 'denbcdq' misbehaving

Status in QEMU:
  New

Bug description:
  Instruction 'denbcdq' appears to have no effect.  Test case attached.

  On ppc64le native:
  --
  gcc -g -O -mcpu=3Dpower9 bcdcfsq.c test-denbcdq.c -o test-denbcdq
  $ ./test-denbcdq
  0x00000000000000000000000000000000
  0x0000000000000000000000000000000c
  0x22080000000000000000000000000000
  $ ./test-denbcdq 1
  0x00000000000000000000000000000001
  0x0000000000000000000000000000001c
  0x22080000000000000000000000000001
  $ ./test-denbcdq $(seq 0 99)
  0x00000000000000000000000000000064
  0x0000000000000000000000000000100c
  0x22080000000000000000000000000080
  --

  With "qemu-ppc64le -cpu power9"
  --
  $ qemu-ppc64le -cpu power9 -L [...] ./test-denbcdq
  0x00000000000000000000000000000000
  0x0000000000000000000000000000000c
  0x0000000000000000000000000000000c
  $ qemu-ppc64le -cpu power9 -L [...] ./test-denbcdq 1
  0x00000000000000000000000000000001
  0x0000000000000000000000000000001c
  0x0000000000000000000000000000001c
  $ qemu-ppc64le -cpu power9 -L [...] ./test-denbcdq $(seq 100)
  0x00000000000000000000000000000064
  0x0000000000000000000000000000100c
  0x0000000000000000000000000000100c
  --

  I started looking at the code, but I got confused rather quickly.
  Could be related to endianness? I think denbcdq arrived on the scene
  before little-endian was a big deal.  Maybe something to do with
  utilizing implicit floating-point register pairs...  I don't think the
  right data is getting to helper_denbcdq, which would point back to the
  gen_fprp_ptr uses in dfp-impl.inc.c (GEN_DFP_T_FPR_I32_Rc).  (Maybe?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1841990/+subscriptions

