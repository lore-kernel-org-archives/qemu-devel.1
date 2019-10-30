Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7ACA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D40B21734
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D40B21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPkgJ-00051U-Bh
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iPket-0003tS-Qn
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iPkeq-0005g1-9x
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:52:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:52974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iPkcx-0005TS-Ja
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:52:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iPkcu-0004MZ-LQ
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 09:50:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 821B22E80D0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 09:50:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2019 09:44:14 -0000
From: tm <1850378@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: riscv
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: palmerdabbelt tm42
X-Launchpad-Bug-Reporter: tm (tm42)
X-Launchpad-Bug-Modifier: tm (tm42)
References: <157235518365.28116.9958641157871998206.malonedeb@chaenomeles.canonical.com>
Message-Id: <157242865526.28116.241229341660228915.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1850378] Re: RISC-V unreliable IPIs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b9be65af5d5cb36d385f0e05d3078c86e017fd23
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
Reply-To: Bug 1850378 <1850378@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  I am working on a project with custom inter processor interrupts (IPIs) o=
n the RISC-V virt machine.
  After upgrading from version 3.1.0 to 4.1.0 which fixes a related issue (=
https://github.com/riscv/riscv-qemu/issues/132) I am able to use the CPU ho=
tplug feature.
  =

  However, if I try to use IPIs for communication between two cores, the
  wfi instruction behaves strangely. Either it does not return, or it
  returns on timer interrupts, even though they are disabled. The code, I
  use on one core to wait for an interrupt is the following.
  =

- 	csr_clear(sie, SIE_SEIE | SIE_STIE);
- 	do {
- 		wait_for_interrupt();
- 		sipval =3D csr_read(sip);
- 		sieval =3D csr_read(sie);
- 		scauseval =3D csr_read(scause) & 0xFF;
- 	/* only break if wfi returns for an software interrupt */
- 	} while ((sipval & sieval) =3D=3D 0 && scauseval !=3D 1);
- 	csr_set(sie, SIE_SEIE | SIE_STIE);
+ =C2=A0csr_clear(sie, SIE_SEIE | SIE_STIE);
+ =C2=A0do {
+ =C2=A0=C2=A0wait_for_interrupt();
+ =C2=A0=C2=A0sipval =3D csr_read(sip);
+ =C2=A0=C2=A0sieval =3D csr_read(sie);
+ =C2=A0=C2=A0scauseval =3D csr_read(scause) & 0xFF;
+ =C2=A0/* only break if wfi returns for an software interrupt */
+ =C2=A0} while ((sipval & sieval) =3D=3D 0 && scauseval !=3D 1);
+ =C2=A0csr_set(sie, SIE_SEIE | SIE_STIE);
  =

  Since the resulting sequence does not seem to be deterministic, my guess
  is, that it has something to do with the communication of qemu's threads
  for the different cores.
+ =

+ Update:
+ The exact same setup works fine in spike (the actual sim, not the qemu bo=
ard), which might give a hint, that it is related to the interrupt controll=
er implementation.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1850378

Title:
  RISC-V unreliable IPIs

Status in QEMU:
  New

Bug description:
  I am working on a project with custom inter processor interrupts (IPIs) o=
n the RISC-V virt machine.
  After upgrading from version 3.1.0 to 4.1.0 which fixes a related issue (=
https://github.com/riscv/riscv-qemu/issues/132) I am able to use the CPU ho=
tplug feature.

  However, if I try to use IPIs for communication between two cores, the
  wfi instruction behaves strangely. Either it does not return, or it
  returns on timer interrupts, even though they are disabled. The code,
  I use on one core to wait for an interrupt is the following.

  =C2=A0csr_clear(sie, SIE_SEIE | SIE_STIE);
  =C2=A0do {
  =C2=A0=C2=A0wait_for_interrupt();
  =C2=A0=C2=A0sipval =3D csr_read(sip);
  =C2=A0=C2=A0sieval =3D csr_read(sie);
  =C2=A0=C2=A0scauseval =3D csr_read(scause) & 0xFF;
  =C2=A0/* only break if wfi returns for an software interrupt */
  =C2=A0} while ((sipval & sieval) =3D=3D 0 && scauseval !=3D 1);
  =C2=A0csr_set(sie, SIE_SEIE | SIE_STIE);

  Since the resulting sequence does not seem to be deterministic, my
  guess is, that it has something to do with the communication of qemu's
  threads for the different cores.

  Update:
  The exact same setup works fine in spike (the actual sim, not the qemu bo=
ard), which might give a hint, that it is related to the interrupt controll=
er implementation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1850378/+subscriptions

