Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3B2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52932053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52932053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYp3-00083M-W0
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iMYjL-0002fY-UF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iMYjK-00030j-IH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:32:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:33966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iMYjK-00030a-Cf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:32:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iMYjJ-0000wS-LB
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:32:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9D0C42E802B
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:32:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2019 14:20:57 -0000
From: Jose Santiago <1829576@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: ppc64
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee ivmn jlsantiago0 mark-cave-ayland
X-Launchpad-Bug-Reporter: Jose Santiago (jlsantiago0)
X-Launchpad-Bug-Modifier: Jose Santiago (jlsantiago0)
References: <155812687142.26079.4364411221525864419.malonedeb@soybean.canonical.com>
Message-Id: <157166765822.9091.15761422455400336726.malone@soybean.canonical.com>
Subject: [Bug 1829576] Re: QEMU-SYSTEM-PPC64 Regression QEMU-4.0.0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1199e3a3825c9c3609a3cad662f7cf6ec0d67bca
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
Reply-To: Bug 1829576 <1829576@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is fixed with the 4.1.0 release. Thank you.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829576

Title:
  QEMU-SYSTEM-PPC64 Regression QEMU-4.0.0

Status in QEMU:
  Fix Released

Bug description:
  I have been using QEMU-SYSTEM-PPC64 v3.1.0 to run CentOS7 PPC emulated
  system. It stopped working when I upgraded to QEMU-4.0.0 . I
  downgraded back to QEMU-3.1.0 and it started working again. The
  problem is that my CentOS7 image will not boot up udner QEMU-4.0.0,
  but works fine under QEMU-3.1.0.

  I have an QCOW2 image available at
  https://www.mediafire.com/file/d8dda05ro85whn1/linux-
  centos7-ppc64.qcow2/file . NOTE: It is 15GB. Kind of large.

  I run it as follows:

     qemu-system-ppc64 \
        -name "CENTOS7-PPC64" \
        -cpu POWER7 -machine pseries \
        -m 4096 \
        -netdev bridge,id=3Dnetbr0,br=3Dbr0 \
        -device e1000,netdev=3Dnetbr0,mac=3D52:54:3c:13:21:33 \
        -hda "./linux-centos7-ppc64.qcow2" \
        -monitor stdio

  HOST: I am using Manjaro Linux on an Intel i7 machine with the QEMU
  packages installed via the package manager of the distribution.

  [jsantiago@jlsws0 ~]$ uname -a
  Linux jlsws0.haivision.com 4.19.42-1-MANJARO #1 SMP PREEMPT Fri May 10 20=
:52:43 UTC 2019 x86_64 GNU/Linux

  jsantiago@jlsws0 ~]$ cpuinfo =

  Intel(R) processor family information utility, Version 2019 Update 3 Buil=
d 20190214 (id: b645a4a54)
  Copyright (C) 2005-2019 Intel Corporation.  All rights reserved.

  =3D=3D=3D=3D=3D  Processor composition  =3D=3D=3D=3D=3D
  Processor name    : Intel(R) Core(TM) i7-6700K  =

  Packages(sockets) : 1
  Cores             : 4
  Processors(CPUs)  : 8
  Cores per package : 4
  Threads per core  : 2

  =3D=3D=3D=3D=3D  Processor identification  =3D=3D=3D=3D=3D
  Processor	Thread Id.	Core Id.	Package Id.
  0       	0   		0   		0   =

  1       	0   		1   		0   =

  2       	0   		2   		0   =

  3       	0   		3   		0   =

  4       	1   		0   		0   =

  5       	1   		1   		0   =

  6       	1   		2   		0   =

  7       	1   		3   		0   =

  =3D=3D=3D=3D=3D  Placement on packages  =3D=3D=3D=3D=3D
  Package Id.	Core Id.	Processors
  0   		0,1,2,3		(0,4)(1,5)(2,6)(3,7)

  =3D=3D=3D=3D=3D  Cache sharing  =3D=3D=3D=3D=3D
  Cache	Size		Processors
  L1	32  KB		(0,4)(1,5)(2,6)(3,7)
  L2	256 KB		(0,4)(1,5)(2,6)(3,7)
  L3	8   MB		(0,1,2,3,4,5,6,7)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829576/+subscriptions

