Received: from eggs.gnu.org ([2001:4830:134:3::10]:43134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC4M9-00071P-9M
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC4M4-0001FY-CX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:55:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC4M4-0001D9-7A
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:55:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC4M1-000864-3V
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 13:55:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EB4AF2E80D0
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 13:55:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 13:48:19 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1713434 <1713434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150391152035.18876.7874968547091336063.malonedeb@chaenomeles.canonical.com>
Message-Id: <151006249978.4525.1695685972433619614.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1713434] Re: prom-env-test test aborted and core
 dumped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This test case was working till 2.10.0 and got broken in 2.10.1

I checked with 2.9.1, 2.10.0-rc2, 2.10.0-rc3, 2.10.0-rc4, 2.10.0

Working scenario:
# ./sparc64-softmmu/qemu-system-sparc64 -nographic -M sun4u -prom-env 'use-=
nvramrc?=3Dtrue' -prom-env 'nvramrc=3D." Hello World!" cr'
OpenBIOS for Sparc64
Configuration device id QEMU version 1 machine id 0
kernel cmdline
CPUs: 1 x SUNW,UltraSPARC-IIi
UUID: 00000000-0000-0000-0000-000000000000
Hello World!
Welcome to OpenBIOS v1.1 built on Jul 13 2017 18:27
  Type 'help' for detailed information
Trying disk:a...
No valid state has been set by load or init-program

0 > QEMU 2.10.0 monitor - type 'help' for more information
(qemu) quit

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1713434

Title:
  prom-env-test test aborted and core dumped

Status in QEMU:
  In Progress

Bug description:
  On ppc64le architecture machine the following test case Aborted and
  Core dumped.

  # tests/prom-env-test --quiet --keep-going -m=3Dquick --GTestLogFD=3D6
  **
  ERROR:tests/libqtest.c:628:qtest_get_arch: assertion failed: (qemu !=3D N=
ULL)
  Aborted (core dumped)

  Steps to re-produce:
  clone from the git
  configure & compile =

  run the unit tests by 'make check'

  (gdb) bt
  #0  0x00003fff9d60eff0 in raise () from /lib64/libc.so.6
  #1  0x00003fff9d61136c in abort () from /lib64/libc.so.6
  #2  0x00003fff9de1aa04 in g_assertion_message () from /lib64/libglib-2.0.=
so.0
  #3  0x00003fff9de1ab0c in g_assertion_message_expr () from /lib64/libglib=
-2.0.so.0
  #4  0x000000001000cc30 in qtest_get_arch () at tests/libqtest.c:628
  #5  0x00000000100048f0 in main (argc=3D5, argv=3D0x3ffff2145538) at tests=
/prom-env-test.c:82
  (gdb) i r
  r0             0xfa	250
  r1             0x3ffff2144d30	70368510627120
  r2             0x3fff9d7b9900	70367091333376
  r3             0x0	0
  r4             0x12a7	4775
  r5             0x6	6
  r6             0x8	8
  r7             0x1	1
  r8             0x0	0
  r9             0x0	0
  r10            0x0	0
  r11            0x0	0
  r12            0x0	0
  r13            0x3fff9dfa1950	70367099623760
  r14            0x0	0
  r15            0x0	0
  r16            0x0	0
  r17            0x0	0
  r18            0x0	0
  r19            0x0	0
  r20            0x0	0
  r21            0x0	0
  r22            0x0	0
  r23            0x0	0
  r24            0x0	0
  r25            0x0	0
  r26            0x0	0
  r27            0x100287f8	268601336
  r28            0x16841b40	377756480
  r29            0x4c	76
  r30            0x3ffff2144de8	70368510627304
  r31            0x6	6
  pc             0x3fff9d60eff0	0x3fff9d60eff0 <raise+96>
  msr            0x900000000280f033	10376293541503627315
  cr             0x42000842	1107298370
  lr             0x3fff9d61136c	0x3fff9d61136c <abort+396>
  ctr            0x0	0
  xer            0x0	0
  orig_r3        0x12a7	4775
  trap           0xc00	3072

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1713434/+subscriptions
