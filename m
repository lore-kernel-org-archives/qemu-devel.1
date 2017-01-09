Received: from eggs.gnu.org ([2001:4830:134:3::10]:33435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRb0-0004pn-7f
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRav-0001kY-Bf
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:10 -0500
Received: from indium.canonical.com ([91.189.90.7]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQRav-0001kO-5i
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQRat-0007lF-2r
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 04:30:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE0692E80CD
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 04:30:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 04:17:32 -0000
From: Launchpad Bug Tracker <881637@bugs.launchpad.net>
Reply-To: Bug 881637 <881637@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111025194609.17756.53947.malonedeb@gac.canonical.com>
Message-Id: <20170109041732.18789.22660.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 881637] Re: QEMU fails to build on OpenBSD/hppa
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
https://bugs.launchpad.net/bugs/881637

Title:
  QEMU fails to build on OpenBSD/hppa

Status in QEMU:
  Expired

Bug description:
  Trying to build previous QEMU releases as well as git code fails on
  OpenBSD/hppa...

  cc -I/home/hack/jasper/qemu/slirp -I. -I/home/hack/jasper/qemu -I/home/ha=
ck/jasper/qemu/fpu -I/home/hack/jasper/qemu/tcg -I/home/hack/jasper/qemu/tc=
g/hppa  -D_FORTIFY_SOURCE=3D2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LAR=
GEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-s=
trings -Wmissing-prototypes -fno-strict-aliasing -Wno-redundant-decls -I/us=
r/local/include -I/usr/X11R6/include -Wendif-labels -Wmissing-include-dirs =
-Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wold-style-def=
inition -I/usr/local/include/libpng -DHAS_AUDIO -DHAS_AUDIO_CHOICE  -DTARGE=
T_PHYS_ADDR_BITS=3D64 -I.. -I/home/hack/jasper/qemu/target-i386 -DNEED_CPU_=
H -pthread -I/usr/local/include/glib-2.0 -I/usr/local/lib/glib-2.0/include =
   -I/usr/local/include/libpng -pthread -I/usr/local/include/glib-2.0 -I/us=
r/local/lib/glib-2.0/include -MMD -MP -MT translate.o -MF ./translate.d -O2=
 -g  -c -o translate.o /home/hack/jasper/qemu/target-i386/translate.c
  /tmp//ccvNbj1U.s: Assembler messages:
  /tmp//ccvNbj1U.s:258792: Error: Field out of range [-262144..262143] (-26=
2776).
  /tmp//ccvNbj1U.s:261989: Error: Field out of range [-262144..262143] (-26=
7096).
  /tmp//ccvNbj1U.s:262006: Error: Field out of range [-262144..262143] (-26=
7136).
  /tmp//ccvNbj1U.s:264184: Error: Field out of range [-262144..262143] (-27=
0612).
  /tmp//ccvNbj1U.s:271893: Error: Field out of range [-262144..262143] (-28=
1260).
  /tmp//ccvNbj1U.s:276623: Error: Field out of range [-262144..262143] (-28=
8784).
  /tmp//ccvNbj1U.s:276906: Error: Field out of range [-262144..262143] (-28=
9636).
  /tmp//ccvNbj1U.s:277122: Error: Field out of range [-262144..262143] (-29=
0280).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/881637/+subscriptions
