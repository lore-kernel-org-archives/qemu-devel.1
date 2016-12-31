Received: from eggs.gnu.org ([2001:4830:134:3::10]:44957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNBIs-0002Wc-EM
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNBIp-0006IM-0i
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:29:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:41536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cNBIo-0006I1-NW
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:29:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cNBIm-0008OO-7U
	for <qemu-devel@nongnu.org>; Sat, 31 Dec 2016 04:29:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 808312E80CD
	for <qemu-devel@nongnu.org>; Sat, 31 Dec 2016 04:29:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Dec 2016 04:17:26 -0000
From: Launchpad Bug Tracker <1077514@bugs.launchpad.net>
Reply-To: Bug 1077514 <1077514@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121110232423.30270.24933.malonedeb@wampee.canonical.com>
Message-Id: <20161231041726.5270.87778.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1077514] Re: *** buffer overflow detected ***:
 qemu-system-x86_64 terminated with nowait enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1077514

Title:
  *** buffer overflow detected ***: qemu-system-x86_64 terminated  with
  nowait enabled

Status in QEMU:
  Expired

Bug description:
  qemu-system-x86_64 -m 1024 -nographic -cpu coreduo -icount auto -hdachs 9=
80,16,32 -kernel asa842-vmlinuz -initrd asa842-initrd.gz -append "ide_gener=
ic.probe_mask=3D0x01 ide_core.chs=3D0.0:980,16,32 auto nousb console=3DttyS=
0,9600 bigphysarea=3D65536 no-hlt" -net nic -serial telnet::3020,server,now=
ait
  failed to initialize KVM: Device or resource busy
  Back to tcg accelerator.
  QEMU 1.2.0 monitor - type 'help' for more information
  (qemu) Warning: vlan 0 is not connected to host network
  *** buffer overflow detected ***: qemu-system-x86_64 terminated
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/x86_64-linux-gnu/libc.so.6(__fortify_fail+0x5c)[0x7fd9f04b882c]
  /lib/x86_64-linux-gnu/libc.so.6(+0x109700)[0x7fd9f04b7700]
  /lib/x86_64-linux-gnu/libc.so.6(+0x10a7be)[0x7fd9f04b87be]
  qemu-system-x86_64(+0xf1b5d)[0x7fd9f4bb1b5d]
  qemu-system-x86_64(+0x18f148)[0x7fd9f4c4f148]
  qemu-system-x86_64(main+0xfe3)[0x7fd9f4b35353]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7fd9f03cf76d]
  qemu-system-x86_64(+0x796e9)[0x7fd9f4b396e9]
  =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
  40f54000-50f54000 rwxp 00000000 00:00 0 =

  7fd990000000-7fd990029000 rw-p 00000000 00:00 0 =

  7fd990029000-7fd994000000 ---p 00000000 00:00 0 =

  7fd995907000-7fd995a34000 rw-p 00000000 00:00 0 =

  7fd995a34000-7fd995a76000 rw-p 00000000 00:00 0 =

  7fd995a76000-7fd995c00000 rw-p 00000000 00:00 0 =

  7fd995c00000-7fd996c00000 rw-p 00000000 00:00 0 =

  7fd996c00000-7fd99842c000 rw-p 00000000 00:00 0 =

  7fd99842d000-7fd99842e000 rw-p 00000000 00:00 0 =

  7fd99842e000-7fd99844e000 rw-p 00000000 00:00 0 =

  7fd99844e000-7fd998450000 rw-p 00000000 00:00 0 =

  7fd998450000-7fd998470000 rw-p 00000000 00:00 0 =

  7fd998470000-7fd998472000 rw-p 00000000 00:00 0 =

  7fd998472000-7fd998492000 rw-p 00000000 00:00 0 =

  7fd998492000-7fd998493000 rw-p 00000000 00:00 0 =

  7fd998493000-7fd998494000 ---p 00000000 00:00 0 =

  7fd998494000-7fd998d95000 rw-p 00000000 00:00 0                          =
[stack:4808]
  7fd998dd6000-7fd998e00000 rw-p 00000000 00:00 0 =

  7fd998e00000-7fd9d8e00000 rw-p 00000000 00:00 0 =

  7fd9d8e00000-7fd9d8fd7000 rw-p 00000000 00:00 0 =

  7fd9d8fd7000-7fd9d8fd8000 ---p 00000000 00:00 0 =

  7fd9d8fd8000-7fd9e87d9000 rw-p 00000000 00:00 0                          =
[stack:4807]
  7fd9e87d9000-7fd9e87e2000 r-xp 00000000 08:05 1577354                    =
/lib/x86_64-linux-gnu/libcrypt-2.15.so
  7fd9e87e2000-7fd9e89e2000 ---p 00009000 08:05 1577354                    =
/lib/x86_64-linux-gnu/libcrypt-2.15.so
  7fd9e89e2000-7fd9e89e3000 r--p 00009000 08:05 1577354                    =
/lib/x86_64-linux-gnu/libcrypt-2.15.so
  7fd9e89e3000-7fd9e89e4000 rw-p 0000a000 08:05 1577354                    =
/lib/x86_64-linux-gnu/libcrypt-2.15.so
  7fd9e89e4000-7fd9e8a12000 rw-p 00000000 00:00 0 =

  7fd9e8a12000-7fd9e8ab7000 r-xp 00000000 08:05 4341908                    =
/usr/lib/x86_64-linux-gnu/libsqlite3.so.0.8.6
  7fd9e8ab7000-7fd9e8cb7000 ---p 000a5000 08:05 4341908                    =
/usr/lib/x86_64-linux-gnu/libsqlite3.so.0.8.6
  7fd9e8cb7000-7fd9e8cb9000 r--p 000a5000 08:05 4341908                    =
/usr/lib/x86_64-linux-gnu/libsqlite3.so.0.8.6
  7fd9e8cb9000-7fd9e8cbb000 rw-p 000a7000 08:05 4341908                    =
/usr/lib/x86_64-linux-gnu/libsqlite3.so.0.8.6
  7fd9e8cbb000-7fd9e8cbc000 rw-p 00000000 00:00 0 =

  7fd9e8cbc000-7fd9e8d00000 r-xp 00000000 08:05 4341652                    =
/usr/lib/x86_64-linux-gnu/libhx509.so.5.0.0
  7fd9e8d00000-7fd9e8f00000 ---p 00044000 08:05 4341652                    =
/usr/lib/x86_64-linux-gnu/libhx509.so.5.0.0
  7fd9e8f00000-7fd9e8f02000 r--p 00044000 08:05 4341652                    =
/usr/lib/x86_64-linux-gnu/libhx509.so.5.0.0
  7fd9e8f02000-7fd9e8f04000 rw-p 00046000 08:05 4341652                    =
/usr/lib/x86_64-linux-gnu/libhx509.so.5.0.0
  7fd9e8f04000-7fd9e8f11000 r-xp 00000000 08:05 4341646                    =
/usr/lib/x86_64-linux-gnu/libheimbase.so.1.0.0
  7fd9e8f11000-7fd9e9110000 ---p 0000d000 08:05 4341646                    =
/usr/lib/x86_64-linux-gnu/libheimbase.so.1.0.0
  7fd9e9110000-7fd9e9111000 r--p 0000c000 08:05 4341646                    =
/usr/lib/x86_64-linux-gnu/libheimbase.so.1.0.0
  7fd9e9111000-7fd9e9112000 rw-p 0000d000 08:05 4341646                    =
/usr/lib/x86_64-linux-gnu/libheimbase.so.1.0.0
  7fd9e9112000-7fd9e913a000 r-xp 00000000 08:05 4341985                    =
/usr/lib/x86_64-linux-gnu/libwind.so.0.0.0
  7fd9e913a000-7fd9e9339000 ---p 00028000 08:05 4341985                    =
/usr/lib/x86_64-linux-gnu/libwind.so.0.0.0
  7fd9e9339000-7fd9e933a000 r--p 00027000 08:05 4341985                    =
/usr/lib/x86_64-linux-gnu/libwind.so.0.0.0
  7fd9e933a000-7fd9e933b000 rw-p 00028000 08:05 4341985                    =
/usr/lib/x86_64-linux-gnu/libwind.so.0.0.0
  7fd9e933b000-7fd9e933c000 rw-p 00000000 00:00 0 =

  7fd9e933c000-7fd9e9342000 r-xp 00000000 08:05 4341777                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.0
  7fd9e9342000-7fd9e9541000 ---p 00006000 08:05 4341777                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.0
  7fd9e9541000-7fd9e9542000 r--p 00005000 08:05 4341777                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.0
  7fd9e9542000-7fd9e9543000 rw-p 00006000 08:05 4341777                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.0
  7fd9e9543000-7fd9e956e000 r-xp 00000000 08:05 4341974                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7fd9e956e000-7fd9e976e000 ---p 0002b000 08:05 4341974                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7fd9e976e000-7fd9e976f000 r--p 0002b000 08:05 4341974                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7fd9e976f000-7fd9e9770000 rw-p 0002c000 08:05 4341974                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7fd9e9770000-7fd9e9a23000 r-xp 00000000 08:05 4341976                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7fd9e9a23000-7fd9e9c22000 ---p 002b3000 08:05 4341976                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7fd9e9c22000-7fd9e9c3e000 r--p 002b2000 08:05 4341976                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7fd9e9c3e000-7fd9e9c3f000 rw-p 002ce000 08:05 4341976                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7fd9e9c3f000-7fd9e9c89000 r-xp 00000000 08:05 4336879                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7fd9e9c89000-7fd9e9e89000 ---p 0004a000 08:05 4336879                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7fd9e9e89000-7fd9e9e8a000 r--p 0004a000 08:05 4336879                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7fd9e9e8a000-7fd9e9e8b000 rw-p 0004b000 08:05 4336879                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7fd9e9e8b000-7fd9e9ea2000 r-xp 00000000 08:05 1577610                    =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7fd9e9ea2000-7fd9ea0a1000 ---p 00017000 08:05 1577610                    =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7fd9ea0a1000-7fd9ea0a2000 r--p 00016000 08:05 1577610                    =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7fd9ea0a2000-7fd9ea0a3000 rw-p 00017000 08:05 1577610                    =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7fd9ea0a3000-7fd9ea0a6000 rw-p 00000000 00:00 0 =

  7fd9ea0a6000-7fd9ea0a8000 r-xp 00000000 08:05 1579638                    =
/lib/x86_64-linux-gnu/libkeyutils.so.1.4
  7fd9ea0a8000-7fd9ea2a8000 ---p 00002000 08:05 1579638                    =
/lib/x86_64-linux-gnu/libkeyutils.so.1.4
  7fd9ea2a8000-7fd9ea2a9000 r--p 00002000 08:05 1579638                    =
/lib/x86_64-linux-gnu/libkeyutils.so.1.4
  7fd9ea2a9000-7fd9ea2aa000 rw-p 00003000 08:05 1579638                    =
/lib/x86_64-linux-gnu/libkeyutils.so.1.4Afbrudt (SIGABRT) (core dumped)

  this only happens with "nowait" enabled.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1077514/+subscriptions
