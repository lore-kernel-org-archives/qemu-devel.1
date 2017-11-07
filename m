Received: from eggs.gnu.org ([2001:4830:134:3::10]:60057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCAhL-0004wq-HA
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCAhH-0008Hr-J6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:42:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:45114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCAhH-0008Hf-CM
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:42:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCAhD-0003BL-Nf
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 20:42:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2451A2E80D5
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 20:41:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 20:35:35 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1713434 <1713434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150391152035.18876.7874968547091336063.malonedeb@chaenomeles.canonical.com>
Message-Id: <151008693516.4605.18382184335014818814.malone@gac.canonical.com>
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

Some times it's still puzzling, when I got the clean git tree still
seeing crash with correct OpenBIOS file.

[root@zzfp365-lp1 test]# git clone git://git.qemu.org/qemu.git
Cloning into 'qemu'...
remote: Counting objects: 349636, done.
remote: Compressing objects: 100% (66763/66763), done.
remote: Total 349636 (delta 284434), reused 346628 (delta 282016)
Receiving objects: 100% (349636/349636), 112.12 MiB | 1.28 MiB/s, done.
Resolving deltas: 100% (284434/284434), done.

[root@zzfp365-lp1 qemu]# md5sum ./pc-bios/openbios-sparc64
15418a4c9429d9ee9c637701b94c7ffb  ./pc-bios/openbios-sparc64

[root@zzfp365-lp1 qemu]# git pull
Already up-to-date.

did configure:
./configure --enable-attr --enable-bsd-user --enable-cap-ng --enable-corout=
ine-pool --enable-crypto-afalg --enable-curl --enable-curses --enable-debug=
 --enable-debug-info --enable-debug-tcg --enable-fdt --enable-gcrypt  --ena=
ble-gnutls --enable-gprof --enable-gtk  --enable-guest-agent --enable-kvm -=
-enable-libiscsi  --enable-libssh2 --enable-linux-aio --enable-linux-user  =
--enable-live-block-migration --enable-modules  --enable-numa --enable-pie =
--enable-profiler  --enable-qom-cast-debug --enable-rbd --enable-replicatio=
n  --enable-seccomp --enable-smartcard --enable-stack-protector  --enable-s=
ystem --enable-tcg --enable-tcg-interpreter  --enable-tools --enable-tpm --=
enable-trace-backend=3Dftrace  --enable-user --enable-vhost-net --enable-vh=
ost-scsi  --enable-vhost-user --enable-vhost-vsock --enable-virtfs  --enabl=
e-vnc --enable-tpm --enable-vnc-png  --enable-vnc-sasl --enable-werror --en=
able-xfsctl  --enable-gcov --enable-debug-stack-usage

make -j 32

# ./sparc64-softmmu/qemu-system-sparc64 -nographic -M sun4u -prom-env 'use-=
nvramrc?=3Dtrue' -prom-env 'nvramrc=3D." Hello World!" cr'
OpenBIOS for Sparc64
Unhandled Exception 0x0000000000000034
PC =3D 0x00000000ffd0f704 NPC =3D 0x00000000ffd0f708
Stopping execution
QEMU 2.10.90 monitor - type 'help' for more information
(qemu) quit

# md5sum ./pc-bios/openbios-sparc64
15418a4c9429d9ee9c637701b94c7ffb  ./pc-bios/openbios-sparc64

git head is at b0fbe46ad82982b289a44ee2495b59b0bad8a842

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
