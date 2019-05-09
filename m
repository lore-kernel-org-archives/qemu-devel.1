Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E684EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748532177E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748532177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlj8-0002UD-Do
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:16:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOli9-0001ss-7z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOli4-0005tZ-Qh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:15:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:46828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOli4-0005sI-GP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:15:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOli1-00028u-0n
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 16:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 18D312E80DB
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 16:15:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2019 16:00:55 -0000
From: Brett Neumeier <1828429@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bneumeier pmaydell
X-Launchpad-Bug-Reporter: Brett Neumeier (bneumeier)
X-Launchpad-Bug-Modifier: Brett Neumeier (bneumeier)
X-Launchpad-Bug-Duplicate: 1824853
References: <155741248596.25660.12793938251081176084.malonedeb@chaenomeles.canonical.com>
Message-Id: <155741765530.32394.4452121474160881397.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18961";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 724640a79a36c4cd5e7e12da0b4fe231ccc90370
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1828429] Re: qemu-system-aarch64 crashes with
 assertion failed while running GCC 9 test suite
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1828429 <1828429@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1824853 ***
    https://bugs.launchpad.net/bugs/1824853

Confirmed, this is a duplicate of 1824853 and is resolved in
68a7b9724fe80bedb85060bde605213ce3f9baec.

** This bug has been marked a duplicate of bug 1824853
   4.0.0-rc3 crashes with tcg/tcg.c:3952: tcg_gen_code: Assertion `s->gen_i=
nsn_end_off[num_insns] =3D=3D off' failed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828429

Title:
  qemu-system-aarch64 crashes with assertion failed while running GCC 9
  test suite

Status in QEMU:
  New

Bug description:
  I am using QEMU 4.0.0 on an x86_64 Linux 4.19.0 host, the guest is an
  Aarch64 linux 5.0.0 system. The same issue occurred on QEMU 3.1.0.

  While running the GCC 9.1 test suite on the guest system, QEMU crashes
  with:

  qemu-system-aarch64: [...]/qemu-4.0.0/tcg/tcg.c:3952: tcg_gen_code:
  Assertion `s->gen_insn_end_off[num_insns] =3D=3D off' failed.

  I am able to reproduce the issue reliably, which is encouraging. The
  full QEMU command line is:

  qemu-system-aarch64 -kernel kernel-5.0.0cbl1 -append "root=3D/dev/vda1
  ro init=3D/sbin/init console=3DttyAMA0" -name guest=3Dcbl -drive
  file=3Dcbl.qcow2,index=3D0,media=3Ddisk,format=3Dqcow2 -drive
  file=3Dswap.qcow2,index=3D1,media=3Ddisk,format=3Dqcow2 -machine virt -cpu
  cortex-a57 -smp 4,sockets=3D1,cores=3D2,threads=3D2 -m size=3D8192 -netdev
  tap,id=3Dnetwork0,ifname=3Dtapcbl2,script=3Dno,downscript=3Dno -device vi=
rtio-
  net-device,netdev=3Dnetwork0,mac=3Daa:bb:cc:dd:ee:02 -nographic

  The specific GCC test that causes QEMU to crash is vldX.c run from
  advsimd-intrinsics.exp; I can reproduce via "make check-gcc
  RUNTESTFLAGS=3Dadvsimd-intrinsics.exp=3DvldX.c"

  If there is anything I can do to further triage the issue, or gain
  more insight into what is going on, please let me know! I am eager to
  help however I can.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828429/+subscriptions

