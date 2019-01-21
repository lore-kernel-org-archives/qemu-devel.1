Received: from eggs.gnu.org ([209.51.188.92]:59852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1glWE9-0005nt-6D
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1glWE8-0004P7-CW
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:50:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:52858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1glWE8-0004Mq-6G
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:50:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1glWE4-0002Tb-84
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5CC102E80D7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jan 2019 09:41:24 -0000
From: Martin Liska <mliska@suse.cz>
Reply-To: Bug 1801073 <1801073@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154107832062.28716.3850477436321808708.malonedeb@soybean.canonical.com>
Message-Id: <154806368418.1312.9404758182083241030.malone@gac.canonical.com>
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

Thank you, I contacted IPXE folks.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1801073

Title:
  util/zbin.c:390:37: error: absolute value function 'abs' given an
  argument of type 'long int' but has parameter of type 'int' which may
  cause truncation of value [-Werror=3Dabsolute-value]

Status in QEMU:
  New

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
