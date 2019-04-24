Received: from eggs.gnu.org ([209.51.188.92]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH2-0008IJ-CC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH1-00017C-3R
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:44292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBH0-00016e-Tt
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBH0-0007fL-3K
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 160222E80CB
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:06:50 -0000
From: Thomas Huth <1801073@bugs.launchpad.net>
Reply-To: Bug 1801073 <1801073@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154107832062.28716.3850477436321808708.malonedeb@soybean.canonical.com>
Message-Id: <155608601152.13953.30287693307562144.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1801073] Re: util/zbin.c:390:37: error: absolute
 value function 'abs' given an argument of type 'long int' but has parameter
 of type 'int' which may cause truncation of value [-Werror=absolute-value]
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
https://bugs.launchpad.net/bugs/1801073

Title:
  util/zbin.c:390:37: error: absolute value function 'abs' given an
  argument of type 'long int' but has parameter of type 'int' which may
  cause truncation of value [-Werror=3Dabsolute-value]

Status in QEMU:
  Fix Released

Bug description:
  For qemu-3.0.0 I see with GCC 9 compiler a new warning:

  $ make -j1 -C roms pxerom VERBOSE=3D1 V=3D1
  make: Entering directory '/home/abuild/rpmbuild/BUILD/qemu-3.0.0/roms'
  make -C ipxe/src CONFIG=3Dqemu \
  	PACKAGING_TIMESTAMP=3D1534273834 \
  	CROSS_COMPILE=3D \
  	bin/8086100e.rom bin/808610d3.rom bin/80861209.rom bin/10500940.rom bin/=
10222000.rom bin/10ec8139.rom bin/1af41000.rom bin/15ad07b0.rom
  make[1]: Entering directory '/home/abuild/rpmbuild/BUILD/qemu-3.0.0/roms/=
ipxe/src'
  gcc  -Wall -W -Wformat-nonliteral -O2 -g -Werror util/zbin.c -llzma -o ut=
il/zbin
  util/zbin.c: In function 'process_zinfo_add':
  util/zbin.c:390:37: error: absolute value function 'abs' given an argumen=
t of type 'long int' but has parameter of type 'int' which may cause trunca=
tion of value [-Werror=3Dabsolute-value]
    390 |      ( ( addend < 0 ) ? "-" : "" ), abs ( addend ), size,
        |                                     ^~~
  util/zbin.c:398:37: error: absolute value function 'abs' given an argumen=
t of type 'long int' but has parameter of type 'int' which may cause trunca=
tion of value [-Werror=3Dabsolute-value]
    398 |      ( ( addend < 0 ) ? "-" : "" ), abs ( addend ), size,
        |                                     ^~~
  util/zbin.c:419:37: error: absolute value function 'abs' given an argumen=
t of type 'long int' but has parameter of type 'int' which may cause trunca=
tion of value [-Werror=3Dabsolute-value]
    419 |      ( ( addend < 0 ) ? "-" : "" ), abs ( addend ),
        |                                     ^~~
  cc1: all warnings being treated as errors
  make[1]: *** [Makefile.housekeeping:1368: util/zbin] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1801073/+subscriptions
