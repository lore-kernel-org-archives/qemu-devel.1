Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB07C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F70B205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F70B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56196 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkdK-0000gm-9m
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:06:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOkc9-0007nI-JK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOkc8-0006jL-FD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:49162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOkc8-0006iX-9x
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:05:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOkc7-0005hx-79
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:05:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2D1B52E80C9
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 15:05:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2019 14:59:24 -0000
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
References: <155741248596.25660.12793938251081176084.malonedeb@chaenomeles.canonical.com>
Message-Id: <155741396464.16507.4964839745502258537.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18961";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: c0a694d1103a7cb4d2cb19012f1528dd8b244254
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

I'm on it. Will follow up when I have a result.

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

