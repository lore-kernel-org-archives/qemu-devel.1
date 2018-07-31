Received: from eggs.gnu.org ([2001:4830:134:3::10]:43606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fkadg-0001U8-ER
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fkadd-00073d-CP
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:49:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fkadd-00072T-2R
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:48:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VJiOep034647
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:48:54 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjw69jmga-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:48:54 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 31 Jul 2018 15:48:53 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2018 14:48:46 -0500
Message-Id: <153306652609.4449.8295999692943472926@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.0-rc3 is now available
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
fourth release candidate for the QEMU 3.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.0.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-3.0.0-rc3.tar.xz.sig

A note from the maintainer:

  In an ideal world, rc3 will be our final release candidate before
  final release. If we find no further showstopper regression bugs
  that would require a new release candidate, we'll do the final
  release on the 7th. If we do need to roll an rc4, final release
  will likely be on the 14th.

You can help improve the quality of the QEMU 3.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.0

Please add entries to the ChangeLog for the 3.0 release below:

  http://wiki.qemu.org/ChangeLog/3.0

Thank you to everyone involved!

Changes since rc2:

f750236039: Update version for v3.0.0-rc3 release (Peter Maydell)
9a1054061c: monitor: temporary fix for dead-lock on event recursion (Marc-A=
ndr=C3=A9 Lureau)
5d9f3ea081: linux-user: ppc64: don't use volatile register during safe_sysc=
all (Shivaprasad G Bhat)
28cbb997d6: tests: add check_invalid_maps to test-mmap (Alex Benn=C3=A9e)
38138fab93: linux-user/mmap.c: handle invalid len maps correctly (Alex Benn=
=C3=A9e)
408e5ace51: s390x/sclp: fix maxram calculation (Christian Borntraeger)
0261fb805c: target/arm: Remove duplicate 'host' entry in '-cpu ?' output (P=
hilippe Mathieu-Daud=C3=A9)
218fe5ce40: hw/misc/tz-mpc: Zero the LUT on initialization, not just reset =
(Peter Maydell)
984b0c100f: hw/arm/iotkit: Fix IRQ number for timer1 (Peter Maydell)
942566ffc1: armv7m_nvic: Fix m-security subsection name (Peter Maydell)
d1fb710a9b: hw/arm/sysbus-fdt: Fix assertion in copy_properties_from_host()=
 (Geert Uytterhoeven)
758b71f7a3: arm/smmuv3: Fix missing VMSD terminator (Dr. David Alan Gilbert)
1239ac241f: qemu-iotests: Test query-blockstats with -drive and -blockdev (=
Kevin Wolf)
567dcb31f2: block/qapi: Include anonymous BBs in query-blockstats (Kevin Wo=
lf)
5a9cb5a97f: block/qapi: Add 'qdev' field to query-blockstats result (Kevin =
Wolf)
34fa110e42: file-posix: Fix write_zeroes with unmap on block devices (Kevin=
 Wolf)
52ebcb2682: block: Fix documentation for BDRV_REQ_MAY_UNMAP (Kevin Wolf)
8ba4f10fa6: iotests: Add test for 'qemu-img convert -C' compatibility (Fam =
Zheng)
e11ce12f5e: qemu-img: Add -C option for convert with copy offloading (Fam Z=
heng)
b85504314f: Revert "qemu-img: Document copy offloading implications with -S=
 and -c" (Fam Zheng)
ac49c189b4: iotests: Don't lock /dev/null in 226 (Fam Zheng)
f4a1b6536f: docs: Describe using images in writing iotests (Fam Zheng)
a1c81f4f16: file-posix: Handle EINTR in preallocation=3Dfull write (Fam Zhe=
ng)
308999e9d4: qcow2: A grammar fix in conflicting cache sizing error message =
(Leonid Bloch)
41b6513436: qcow: fix a reference leak (KONRAD Frederic)
cc4c77e12b: backends/cryptodev: remove dead code (Jay Zhou)
e4dab9449a: timer: remove replay clock probe in deadline calculation (Pavel=
 Dovgalyuk)
1d3db6bdbb: i386: implement MSR_SMI_COUNT for TCG (Paolo Bonzini)
990e0be260: i386: do not migrate MSR_SMI_COUNT on machine types <2.12 (Paol=
o Bonzini)
ba891d68b4: qstring: Move qstring_from_substr()'s @end one to the right (Ma=
rkus Armbruster)
b65ab77b3a: qstring: Assert size calculations don't overflow (Markus Armbru=
ster)
ad63c549ec: qstring: Fix qstring_from_substr() not to provoke int overflow =
(liujunjie)
