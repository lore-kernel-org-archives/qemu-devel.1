Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2449C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B202175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B202175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37505 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOykt-0005q6-Pb
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:11:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOyk5-0004zo-Tt
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOyk4-0007m1-Ll
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:10:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:49720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOyk4-0007hW-G5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:10:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOyk2-00053h-L3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 06:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 98C7C2E80C7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 06:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 May 2019 06:02:46 -0000
From: Amol Surati <1828507@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: asurati
X-Launchpad-Bug-Reporter: Amol Surati (asurati)
X-Launchpad-Bug-Modifier: Amol Surati (asurati)
Message-Id: <155746816636.22030.3977137421670178751.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 5b2e968ee02091a1e8bac5b8a104a22c7ca13e05
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1828507] [NEW] qemu-system-ppc64 smp crash on
 manual reset
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
Reply-To: Bug 1828507 <1828507@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Host Environment:
   x86_64 Linux v5.0.2
   QEMU emulator version 4.0.50 (v4.0.0-354-g812b835fb4)
   SLOF:
       Build Date =3D Jan 14 2019 18:00:39
       FW Version =3D git-a5b428e1c1eae703

Problem: Qemu crash immediately after a manual reset
         (this is not the initial reset which launches the guest).

Steps:

1. Download Debian ppc64el mini.iso:
   http://ftp.debian.org/debian/dists/sid/main/installer-ppc64el/current/im=
ages/netboot/mini.iso
2. Run qemu on the host. Ensure that it runs with more than one CPUs. With =
a single CPU, I was unable
   to reproduce the crash.
   qemu-system-ppc64 -M pseries -cpu power9 -smp 2 -m 512 -cdrom mini.iso
3. SLOF prints the version info on the serial device, and proceeds to boot.
4. After a few seconds, the GRUB menu appears on the VGA screen.
5. Select one of the install options (I have tested with Default and Expert=
), and wait
   for the Debian's text-mode installer (blue-gray-red) screen to appear.
6. Click Machine->Reset (or enter system_reset on the qemu monitor).
7. Notice that, on the serial device, SLOF has printed the version info. Th=
at is, the system
   has reset and is attempting to boot again.
8. On the host cmd prompt, qemu dies after printing this fatal error and sp=
ewing the
   contents of the CPU registers:

   qemu: fatal: Trying to deliver HV exception (MSR) 70 with no HV support
   <CPU contents> (See attached out.txt for details)
   Aborted (core dumped)


The HV exception is either
   (a) 70 =3D HISI, which occurs when NIP contains an outright bogus or ina=
ccessible value, or
   (b) 69 =3D HDSI, which occurs when NIP happens to contain a somewhat san=
er value, and
       the cpu attempts to run the instruction at that address.

The exception can occur on either of the CPUs. It occurs when qemu is runni=
ng the SLOF
code.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "a few instances of the crash"
   https://bugs.launchpad.net/bugs/1828507/+attachment/5262806/+files/out.t=
xt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828507

Title:
  qemu-system-ppc64 smp crash on manual reset

Status in QEMU:
  New

Bug description:
  Host Environment:
     x86_64 Linux v5.0.2
     QEMU emulator version 4.0.50 (v4.0.0-354-g812b835fb4)
     SLOF:
         Build Date =3D Jan 14 2019 18:00:39
         FW Version =3D git-a5b428e1c1eae703

  Problem: Qemu crash immediately after a manual reset
           (this is not the initial reset which launches the guest).

  Steps:

  1. Download Debian ppc64el mini.iso:
     http://ftp.debian.org/debian/dists/sid/main/installer-ppc64el/current/=
images/netboot/mini.iso
  2. Run qemu on the host. Ensure that it runs with more than one CPUs. Wit=
h a single CPU, I was unable
     to reproduce the crash.
     qemu-system-ppc64 -M pseries -cpu power9 -smp 2 -m 512 -cdrom mini.iso
  3. SLOF prints the version info on the serial device, and proceeds to boo=
t.
  4. After a few seconds, the GRUB menu appears on the VGA screen.
  5. Select one of the install options (I have tested with Default and Expe=
rt), and wait
     for the Debian's text-mode installer (blue-gray-red) screen to appear.
  6. Click Machine->Reset (or enter system_reset on the qemu monitor).
  7. Notice that, on the serial device, SLOF has printed the version info. =
That is, the system
     has reset and is attempting to boot again.
  8. On the host cmd prompt, qemu dies after printing this fatal error and =
spewing the
     contents of the CPU registers:

     qemu: fatal: Trying to deliver HV exception (MSR) 70 with no HV support
     <CPU contents> (See attached out.txt for details)
     Aborted (core dumped)

  =

  The HV exception is either
     (a) 70 =3D HISI, which occurs when NIP contains an outright bogus or i=
naccessible value, or
     (b) 69 =3D HDSI, which occurs when NIP happens to contain a somewhat s=
aner value, and
         the cpu attempts to run the instruction at that address.

  The exception can occur on either of the CPUs. It occurs when qemu is run=
ning the SLOF
  code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828507/+subscriptions

