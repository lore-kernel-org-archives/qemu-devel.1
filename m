Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB59C2D0E3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9421B20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9421B20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIN9z-0005D2-Kb
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 22:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIN93-0004NS-Kr
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 22:26:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:54070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIN91-0005ep-7F
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 22:26:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kIN8z-0007g4-Gy
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 02:26:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 66F2B2E8084
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 02:26:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2020 02:18:43 -0000
From: Launchpad Bug Tracker <1883984@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu; 
 component=main; status=Fix Released; importance=Medium;
 assignee=None; 
X-Launchpad-Bug-Tags: verification-done verification-done-focal
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bruno-clisp janitor nhfbeebe paelzer raof rth
 tjaalton ubuntu-sru-bot
X-Launchpad-Bug-Reporter: Nelson H F Beebe (nhfbeebe)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <159243063748.16697.11009205973276249282.malonedeb@chaenomeles.canonical.com>
Message-Id: <160022272617.24055.3016817148738602034.malone@ackee.canonical.com>
Subject: [Bug 1883984] Re: QEMU S/390x sqxbr (128-bit IEEE 754 square root)
 crashes qemu-system-s390x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: c1f9a71b545fd65c6b840c6240061449e3cc7005
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 22:25:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1883984 <1883984@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bug was fixed in the package qemu - 1:4.2-3ubuntu6.5

---------------
qemu (1:4.2-3ubuntu6.5) focal; urgency=3Dmedium

  * further stabilize qemu by importing patches of qemu v4.2.1
    Fixes (LP: #1891203) and (LP: #1891877)
    - d/p/stable/lp-1891877-*
    - as part of the stabilization this also fixes an
      riscv emulation issue due to the CVE-2020-13754 fixes via
      d/p/ubuntu/hw-riscv-Allow-64-bit-access-to-SiFive-CLINT.patch
  * fix s390x SQXBR emulation (LP: #1883984)
    - d/p/ubuntu/lp-1883984-target-s390x-Fix-SQXBR.patch
  * fix -no-reboot for s390x protvirt guests (LP: #1890154)
    - d/p/ubuntu/lp-1890154-s390x-protvirt-allow-to-IPL-secure-guests-with-*

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Wed, 19 Aug
2020 13:40:49 +0200

** Changed in: qemu (Ubuntu Focal)
       Status: Fix Committed =3D> Fix Released

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13754

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883984

Title:
  QEMU S/390x sqxbr (128-bit IEEE 754 square root) crashes qemu-system-
  s390x

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Focal:
  Fix Released

Bug description:
  [Impact]

   * An instruction was described wrong so that on usage the program would =

     crash.

  [Test Case]

   * Run s390x in emulation and there use this program:
     For simplicity and speed you can use KVM guest as usual on s390x, that =

     after prep&install&compile of the test you run in qemu-tcg like:

     $ sudo qemu-system-s390x -machine s390-ccw-virtio,accel=3Dtcg -cpu max=
,zpci=3Don -serial mon:stdio -display none -m 4096 -nic user,model=3Dvirtio=
,hostfwd=3Dtcp::2222-:22 -drive file=3D/var/lib/uvtool/libvirt/images/focal=
-sqxbr.qcow,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone -=
device virtio-blk-ccw,devno=3Dfe.0.0001,drive=3Ddrive-virtio-disk0,id=3Dvir=
tio-disk0,bootindex=3D1,scsi=3Doff
     Obviously is you have no s390x access you need to use emulation right =

     away.

   * Build and run failing program
     $ sudo apt install clang
     $ cat > bug-sqrtl-one-line.c << EOF
  int main(void) { volatile long double x, r; x =3D 4.0L; __asm__ =

  __volatile__("sqxbr %0, %1" : "=3Df" (r) : "f" (x)); return (0);}
  EOF
     $ cc bug-sqrtl-one-line.c
     $ ./a.out
     Segmentation fault (core dumped)

     qemu is dead by now as long as the bug is present

  [Regression Potential]

   * The change only modifies 128 bit square root on s390x so regressions
     should be limited to exactly that - which formerly before this fix was =

     a broken instruction.

  [Other Info]
   =

   * n/a

  ---

  In porting software to guest Ubuntu 18.04 and 20.04 VMs for S/390x, I dis=
covered
  that some of my own numerical programs, and also a GNU configure script f=
or at
  least one package with CC=3Dclang, would cause an instant crash of the VM=
, sometimes
  also destroying recently opened files, and producing long strings of NUL =
characters
  in /var/log/syslog in the S/390 guest O/S.

  Further detective work narrowed the cause of the crash down to a single I=
BM S/390
  instruction: sqxbr (128-bit IEEE 754 square root).  Here is a one-line pr=
ogram
  that when compiled and run on a VM hosted on QEMUcc emulator version 4.2.0
  (Debian 1:4.2-3ubuntu6.1) [hosted on Ubuntu 20.04 on a Dell Precision 7920
  workstation with an Intel Xeon Platinum 8253 CPU],  and also on QEMU emul=
ator
  version 5.0.0, reproducibly produces a VM crash under qemu-system-s390x.

  % cat bug-sqrtl-one-line.c
  int main(void) { volatile long double x, r; x =3D 4.0L; __asm__ __volatil=
e__("sqxbr %0, %1" : "=3Df" (r) : "f" (x)); return (0);}

  % cc bug-sqrtl-one-line.c && ./a.out
  Segmentation fault (core dumped)

  The problem code may be the function float128_sqrt() defined in qemu-5.0.=
0/fpu/softfloat.c
  starting at line 7619.  I have NOT attempted to run the qemu-system-s390x=
 executable
  under a debugger.  However, I observe that S/390 is the only CPU family t=
hat I know of,
  except possibly for a Fujitsu SPARC-64, that has a 128-bit square root in=
 hardware.
  Thus, this instruction bug may not have been seen before.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883984/+subscriptions

