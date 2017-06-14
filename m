Received: from eggs.gnu.org ([2001:4830:134:3::10]:54748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dLGc1-00006O-O0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 18:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dLGbw-0004BM-Mm
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 18:18:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:57477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dLGbw-00049s-HH
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 18:18:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dLFb0-0007gK-OX
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 21:12:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3AAC82E85A2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 21:11:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2017 20:41:43 -0000
From: Thomas Huth <1093691@bugs.launchpad.net>
Reply-To: Bug 1093691 <1093691@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121225211212.2307.81304.malonedeb@chaenomeles.canonical.com>
Message-Id: <149747290376.320.7967831849566239906.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1093691] Re: QEMU build fails on OpenBSD/mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... does this problem still persist with the
latest version of QEMU (currently version 2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1093691

Title:
  QEMU build fails on OpenBSD/mips64

Status in QEMU:
  Incomplete

Bug description:
  Building QEMU 1.2.1 on OpenBSD/mips64 fails as follows although I
  believe QEMU was also broken with 1.1.x as well..

  cc -I/usr/obj/ports/qemu-1.2.1/qemu-1.2.1/slirp -I. -I/usr/obj/ports/qemu=
-1.2.1/qemu-1.2.1 -I/usr/obj/ports/qemu-1.2.1/qemu-1.2.1/fpu -I/usr/obj/por=
ts/qemu-1.2.1/qemu-1.2.1/tcg -
  I/usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/mips  -D_GNU_SOURCE -D_FILE_OFF=
SET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wa=
ll -Wundef -Wwrite-strings -Wmis
  sing-prototypes -fno-strict-aliasing -I/usr/local/include -I/usr/X11R6/in=
clude -Wno-redundant-decls -DTIME_MAX=3DINT_MAX  -Wendif-labels -Wmissing-i=
nclude-dirs -Wnested-externs -Wf
  ormat-security -Wformat-y2k -Winit-self -Wold-style-definition -I/usr/loc=
al/include/libpng -DHAS_AUDIO -DHAS_AUDIO_CHOICE  -DTARGET_PHYS_ADDR_BITS=
=3D64 -I.. -I/usr/obj/ports/qemu-1
  .2.1/qemu-1.2.1/target-i386 -DNEED_CPU_H -I/usr/obj/ports/qemu-1.2.1/qemu=
-1.2.1/include    -I/usr/local/include/libpng -pthread -I/usr/local/include=
/glib-2.0 -I/usr/local/lib/gli
  b-2.0/include -I/usr/local/include -MMD -MP -MT tcg/tcg.o -MF tcg/tcg.d -=
O2 -pipe -c -o tcg/tcg.o /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg.c
  In file included from /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg.c:50:
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h: In function 'tcg_gen_d=
iv_i64':
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1229: error: 'TCG_TARGE=
T_HAS_div_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1229: error: (Each unde=
clared identifier is reported only once
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1229: error: for each f=
unction it appears in.)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1231: error: 'TCG_TARGE=
T_HAS_div2_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h: In function 'tcg_gen_r=
em_i64':
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1248: error: 'TCG_TARGE=
T_HAS_div_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1250: error: 'TCG_TARGE=
T_HAS_div2_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h: In function 'tcg_gen_d=
ivu_i64':
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1267: error: 'TCG_TARGE=
T_HAS_div_i64' undeclared (first use in this function)                     =
                              =

  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1269: error: 'TCG_TARGE=
T_HAS_div2_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h: In function 'tcg_gen_r=
emu_i64':
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1286: error: 'TCG_TARGE=
T_HAS_div_i64' undeclared (first use in this function)                     =
                              =

  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1288: error: 'TCG_TARGE=
T_HAS_div2_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h: In function 'tcg_gen_e=
xt8s_i64':
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1526: error: 'TCG_TARGE=
T_HAS_ext8s_i64' undeclared (first use in this function)
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h: In function 'tcg_gen_e=
xt16s_i64':
  /usr/obj/ports/qemu-1.2.1/qemu-1.2.1/tcg/tcg-op.h:1536: error: 'TCG_TARGE=
T_HAS_ext16s_i64' undeclared (first use in this function)
  ...

  Attached is the full build log.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1093691/+subscriptions
