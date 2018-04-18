Received: from eggs.gnu.org ([2001:4830:134:3::10]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f8oVj-0008Uo-Oh
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f8oVf-0004ar-MJ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:56:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f8oVf-0004ZW-DA
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:56:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3IEuLaB129739
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 10:56:32 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2he6m1wgv1-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 10:56:31 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 18 Apr 2018 10:56:29 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 18 Apr 2018 09:56:20 -0500
Message-Id: <152406338081.5947.5696498314762417499@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 2.12 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.12.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-2.12.0-rc4.tar.xz.sig

A note from the maintainer:

  Barring any reports of showstopper bugs, the plan is to release
  2.12.0 with no further changes on Tuesday 24th April.

You can help improve the quality of the QEMU 2.12 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.12

Please add entries to the ChangeLog for the 2.12 release below:

  http://wiki.qemu.org/ChangeLog/2.12

Changes since rc3:

27e757e29c: Update version for v2.12.0-rc4 release (Peter Maydell)
6f660996f1: Revert "mux: fix ctrl-a b again" (Peter Maydell)
ce8d408205: fpu: Bound increment for scalbn (Richard Henderson)
1b2503fcf7: mux: fix ctrl-a b again (Marc-Andr=C3=A9 Lureau)
bb3ba35f20: linux-user: check that all of AArch64 SVE extended sigframe is =
writable (Peter Maydell)
9cb4e398c2: fpu/softfloat: check for Inf / x or 0 / x before /0 (Alex Benn=
=C3=A9e)
0d914f39a7: i386: Don't automatically enable FEAT_KVM_HINTS bits (Eduardo H=
abkost)
aebbdbee55: vhost: do not verify ring mappings when IOMMU is enabled (Jason=
 Wang)
2a6b5372d7: Makefile: install gtk message catalogs if CONFIG_GTK=3Dy too, n=
ot only =3Dm (Michael Tokarev)
25bf2426f3: iotests: fix 169 (Vladimir Sementsov-Ogievskiy)
605bc8be42: qcow2: try load bitmaps only once (Vladimir Sementsov-Ogievskiy)
aac8f55633: linux-user/signal.c: Put AArch64 frame record in the right plac=
e (Peter Maydell)
161dfd1e7f: tcg/mips: Handle large offsets from target env to tlb_table (Pe=
ter Maydell)
801bc56336: fpu/softfloat: raise float_invalid for NaN/Inf in round_to_int_=
and_pack (Alex Benn=C3=A9e)
000761dc0c: m68k: fix exception stack frame for 68000 (Pavel Dovgalyuk)
6245327a36: softfloat: fix {min, max}nummag for same-abs-value inputs (Emil=
io G. Cota)
