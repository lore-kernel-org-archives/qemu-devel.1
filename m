Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66189C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 21:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2592072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 21:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2592072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLZCD-0007eP-Dm
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 17:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jLZBS-0007EK-VH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jLZBR-0003WW-Lr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:21:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:57174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jLZBR-0003US-Gc
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:21:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jLZBP-0004xC-RQ
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 21:21:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CE1512E8107
 for <qemu-devel@nongnu.org>; Mon,  6 Apr 2020 21:21:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Apr 2020 21:07:15 -0000
From: martin short <1663287@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mips
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bacam martin-sk th-huth yongbok-kim
X-Launchpad-Bug-Reporter: Brian Campbell (bacam)
X-Launchpad-Bug-Modifier: martin short (martin-sk)
References: <20170209154937.3933.99004.malonedeb@chaenomeles.canonical.com>
Message-Id: <158620723534.21403.16504598011986972232.malone@gac.canonical.com>
Subject: [Bug 1663287] Re: Illegal delay slot code causes abort on mips64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 05b62a19ed5dff3438010f77cc2a3f1e4b77638d
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
Reply-To: Bug 1663287 <1663287@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found the exact same bug. Tested on several hosts and qemu releases.
The newest one I tested was on FreeBSD 12.1 host and qemu-4.1.1_1 built
from ports.

Instructions:
  4000d0:	0320f809 	jalr	t9
  4000d4:	45454545 	0x45454545         # bc1any4t $fcc1,0x800101f8

I was running qemu-mips as:

qemu-system-mipsel -s -m 1024 -M malta \
        -kernel vmlinux-3.16.0-6-4kc-malta -initrd initrd.img-3.16.0-6-4kc-=
malta \
	-device virtio-blk-pci,drive=3Dhd0 -drive if=3Dnone,id=3Dhd0,format=3Dqcow=
2,file=3Ddebian_wheezy_mipsel_standard.qcow2    \
	-append "root=3D/dev/vda1" \
	-device virtio-net-pci,netdev=3Dnet0 \
	-netdev user,id=3Dnet0,hostfwd=3Dtcp::1666-:22,ipv6=3Doff  \
	-curses =


abort() was in target/mips/translate.c:12945, in gen_branch().

Doesn't really matter if the instruction is supported on given CPU, user
can crash the qemu within guest.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1663287

Title:
  Illegal delay slot code causes abort on mips64

Status in QEMU:
  New

Bug description:
  During some randomised testing of an experimental MIPS implementation
  I found an instruction sequence that also causes aborts on mainline
  qemu's MIPS support.  The problem is triggered by an MSA branch
  instruction appearing in a delay slot when emulating a processor
  without MSA support.

  For example, with the current repository HEAD
  (f073cd3a2bf1054135271b837c58a7da650dd84b) configured for
  mips64-softmmu, if I run the attached binary using

      mips64-softmmu/qemu-system-mips64 -bios ../abort2.bin -machine
  mipssim -nographic

  it will report

      unknown branch 0x13000
      Aborted (core dumped)

  The binary contains the following two instructions:

      00200008 jr at
      47081e61 bz.b       w8,0xffffffffbfc0798c

  The jr sets up a jump, and hflags is set accordingly in
  gen_compute_branch (in target/mips/translate.c).  When processing the
  bz.b, check_insn generates an exception because the instruction isn't
  support, but gen_msa_branch skips the usual delay slot check for the
  same reason, and sets more bits in hflags, leading to an abort in
  gen_branch because the hflags are now invalid.

  I suspect the best fix is to remove the instruction set condition from
  the delay slot check in gen_msa_branch.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1663287/+subscriptions

