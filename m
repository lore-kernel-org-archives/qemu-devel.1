Received: from eggs.gnu.org ([2001:4830:134:3::10]:41058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsjJ-0004a4-Dp
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsjE-00025W-MC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:20:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsjE-00022j-Fg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:20:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsjB-0004xD-0A
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:20:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 62F692E8193
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:14:04 -0000
From: Thomas Huth <1713408@bugs.launchpad.net>
Reply-To: Bug 1713408 <1713408@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150390171227.19506.41697463404689071.malonedeb@chaenomeles.canonical.com>
Message-Id: <151335444496.9940.15599568625092747286.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1713408] Re: qemu crashes with "GLib-ERROR **:
 gmem.c" error when a negative value passed to "maxcpus"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1713408

Title:
  qemu crashes with "GLib-ERROR **: gmem.c" error when a negative value
  passed to "maxcpus"

Status in QEMU:
  Fix Released

Bug description:
  # ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
  pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D20g -device virtio-blk-
  pci,drive=3Drootdisk -drive file=3D/home/nasastry/avocado-fvt-wrapper/data
  /avocado-
  vt/images/pegas-1.0-ppc64le.qcow2,if=3Dnone,cache=3Dnone,id=3Drootdisk,fo=
rmat=3Dqcow2
  -monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio
  -net user -device nec-usb-xhci -smp 8,cores=3D1,threads=3D1,maxcpus=3D-12

  (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
  18446744073709550568 bytes

  From GDB:
  [New Thread 0x3fffb5aceb60 (LWP 12190)]

  (process:12184): GLib-ERROR **: gmem.c:130: failed to allocate
  18446744073709550568 bytes

  Program received signal SIGTRAP, Trace/breakpoint trap.
  0x00003fffb75e5408 in raise () from /lib64/libpthread.so.0
  Missing separate debuginfos, use: debuginfo-install glib2-2.50.3-3.el7.pp=
c64le glibc-2.17-196.el7.ppc64le gnutls-3.3.26-9.el7.ppc64le krb5-libs-1.15=
.1-8.el7.ppc64le libgcc-4.8.5-16.el7.ppc64le libstdc++-4.8.5-16.el7.ppc64le=
 ncurses-libs-5.9-13.20130511.el7.ppc64le nss-3.28.4-8.el7.ppc64le nss-soft=
okn-freebl-3.28.3-6.el7.ppc64le nss-util-3.28.4-3.el7.ppc64le openldap-2.4.=
44-5.el7.ppc64le openssl-libs-1.0.2k-8.el7.ppc64le p11-kit-0.23.5-3.el7.ppc=
64le
  (gdb) bt
  #0  0x00003fffb75e5408 in raise () from /lib64/libpthread.so.0
  #1  0x00003fffb796be9c in _g_log_abort () from /lib64/libglib-2.0.so.0
  #2  0x00003fffb796d4c4 in g_log_default_handler () from /lib64/libglib-2.=
0.so.0
  #3  0x00003fffb796d86c in g_logv () from /lib64/libglib-2.0.so.0
  #4  0x00003fffb796db00 in g_log () from /lib64/libglib-2.0.so.0
  #5  0x00003fffb796b694 in g_malloc0 () from /lib64/libglib-2.0.so.0
  #6  0x000000001018fa84 in spapr_possible_cpu_arch_ids (machine=3D0x111656=
60) at /home/nasastry/upstream/qemu/hw/ppc/spapr.c:3322
  #7  0x000000001018b444 in spapr_init_cpus (spapr=3D0x11165660) at /home/n=
asastry/upstream/qemu/hw/ppc/spapr.c:2096
  #8  0x000000001018bc6c in ppc_spapr_init (machine=3D0x11165660) at /home/=
nasastry/upstream/qemu/hw/ppc/spapr.c:2275
  #9  0x000000001041ca38 in machine_run_board_init (machine=3D0x11165660) a=
t hw/core/machine.c:760
  #10 0x000000001037723c in main (argc=3D24, argv=3D0x3ffffffff108, envp=3D=
0x3ffffffff1d0) at vl.c:4633
  (gdb) i r
  r0             0xfa	250
  r1             0x3fffffffe450	70368744170576
  r2             0x3fffb7608100	70367525765376
  r3             0x0	0
  r4             0x2f98	12184
  r5             0x5	5
  r6             0x0	0
  r7             0x3fffa8000020	70367267782688
  r8             0x2f98	12184
  r9             0x0	0
  r10            0x0	0
  r11            0x0	0
  r12            0x0	0
  r13            0x3fffb64fccb0	70367507893424
  r14            0x0	0
  r15            0x0	0
  r16            0x0	0
  r17            0x0	0
  r18            0x1	1
  r19            0x0	0
  r20            0x3fffb796d3f0	70367529325552
  r21            0x0	0
  r22            0x20000000	536870912
  r23            0x1	1
  r24            0x3fffb7a61498	70367530325144
  r25            0x3fffb7a614e8	70367530325224
  r26            0x3fffb7a61488	70367530325128
  r27            0x3fffa80008c0	70367267784896
  r28            0x3fffb79cd2a8	70367529718440
  r29            0x3fffb79cd2a8	70367529718440
  r30            0xffffffffffffffff	18446744073709551615
  r31            0x1	1
  pc             0x3fffb75e5408	0x3fffb75e5408 <raise+56>
  msr            0x900000000000d033	10376293541461676083
  cr             0x42244842	1109674050
  lr             0x3fffb796be9c	0x3fffb796be9c <_g_log_abort+60>
  ctr            0x0	0
  xer            0x0	0
  orig_r3        0x2f98	12184
  trap           0xc00	3072

  Similar error observed on x86_64 and PPC64LE architectures.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1713408/+subscriptions
