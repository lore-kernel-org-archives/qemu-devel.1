Received: from eggs.gnu.org ([2001:4830:134:3::10]:52127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHwWL-0004dD-Ln
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 13:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHwWK-0007GX-HN
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 13:46:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:59486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eHwWK-0007Eq-Ar
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 13:46:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eHwWI-00011N-Dg
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 18:46:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B74232E80D2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 18:46:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2017 18:34:54 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1172613 <1172613@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130425082449.5153.30611.malonedeb@wampee.canonical.com>
Message-Id: <151146209421.14642.6256239011450248036.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1172613] Re: [qemu 1.4.1] inconsistent behavior
 on different architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In particular, the only crashes here are the ones where --library-path
isn't specified, so it isn't even a case of "QEMU should somehow support
whiteouts in --library-path so you can tell it to ignore the host
ld.so.cache". So I'm going to close this bug report (with 'invalid' as
the closest sensible resolution).


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1172613

Title:
  [qemu 1.4.1] inconsistent behavior on different architecture

Status in QEMU:
  Invalid

Bug description:
  Running with qemu 1.4.1 and eglibc 2.17 on Debian Linux 7.0 for amd64

  ---------------- armhf ----------------
  $ arm-linux-gnueabihf-gcc hello.c
  $ qemu-arm ./a.out
  /lib/ld-linux-armhf.so.3: No such file or directory

  $ qemu-arm arm-linux-gnueabihf/lib/ld-2.17.so ./a.out
  ./a.out: error while loading shared libraries: libc.so.6: cannot open sha=
red object file: No such file or directory

  $ qemu-arm arm-linux-gnueabihf/lib/ld-2.17.so --library-path  arm-linux-g=
nueabihf/lib ./a.out
  Hello, world !

  ---------------- powerpc64 ----------------
  $ powerpc64-linux-gcc hello.c

  $ qemu-ppc64 ./a.out
  /lib64/ld64.so.1: No such file or directory

  [BAD BEHAVIOR !!!]
  $ qemu-ppc64 powerpc64-linux/lib64/ld-2.17.so ./a.out
  Invalid data memory access: 0x00000041988fd008
  NIP 000000400001cb2c   LR 000000400001cc30 CTR 0000000000000000 XER 00000=
00000000000
  MSR 8000000002006000 HID0 0000000060000000  HF 8000000002006000 idx 0
  TB 00000000 00000000
  GPR00 0000000000000000 000000400083a220 0000004000041230 00000043309bd010
  GPR04 0000004000026f12 000000000000000b 000000000000002e 000000000000002e
  GPR08 0000000000000030 000000008803fffc 00000041988fcff4 0000000000000037
  GPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR16 0000000000000000 000000400003a4d8 000000400083a6d0 000000400083a6d8
  GPR20 000000400003a898 000000000000000a 0000000000000000 00000043309bd010
  GPR24 0000004000037b60 00000000cfe8ced7 000000400003a430 0000000010000261
  GPR28 00000001980bfff4 0000000000000000 000000004401ffff 000000002200ffff
  CR 22242224  [ E  E  E  G  E  E  E  G  ]             RES ffffffffffffffff
  FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR08 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  FPSCR 0000000000000000
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault

  $ qemu-ppc64 powerpc64-linux/lib64/ld-2.17.so --library-path powerpc64-li=
nux/lib64 ./a.out
  Hello, world !

  ---------------- sparc64 ----------------
  $ sparc64-linux-gcc hello.c

  $ qemu-sparc64 ./a.out
  /lib64/ld-linux.so.2: No such file or directory

  [BAD BEHAVIOR !!!]
  $ qemu-sparc64 sparc64-linux/lib64/ld-2.17.so ./a.out
  Segmentation fault

  $ qemu-sparc64 sparc64-linux/lib64/ld-2.17.so --library-path sparc64-linu=
x/lib64 ./a.out
  Hello, world !

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1172613/+subscriptions
