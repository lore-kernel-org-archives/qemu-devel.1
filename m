Received: from eggs.gnu.org ([2001:4830:134:3::10]:44776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dkxGL-0007a5-Pr
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dkxGI-0006q5-ND
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:53:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dkxGI-0006oj-Dy
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:53:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OIorCA035550
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 14:53:47 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cj15svcxf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 14:53:47 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 14:53:46 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 13:53:37 -0500
Message-Id: <150360081780.16351.6836234147404830593@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc4 is now available
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
fifth release candidate for the QEMU 2.10 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.10.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-2.10.0-rc4.tar.xz.sig

A note from the maintainer:

  This release contains last minute fixes for some bugs affecting
  PowerPC hosts and also for bugs in the QEMU network block device code.
  Any final testing should therefore be concentrated on these areas.
  We plan to make the final release of QEMU 2.10 on Wednesday 30th
  August.
  =

  (30th August happens to be my birthday, but this is purely
  coincidental :-))

You can help improve the quality of the QEMU 2.10 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.10

Please add entries to the ChangeLog for the 2.10 release below:

  http://wiki.qemu.org/ChangeLog/2.10

Changes since rc3:

248b237: Update version for v2.10.0-rc4 release (Peter Maydell)
40f4a21: nbd-client: avoid spurious qio_channel_yield() re-entry (Stefan Ha=
jnoczi)
12314f2: qemu-iotests: add 194 non-shared storage migration test (Stefan Ha=
jnoczi)
7d5b526: block: Update open_flags after ->inactivate() callback (Stefan Haj=
noczi)
045a2f8: mirror: Mark target BB as "force allow inactivate" (Fam Zheng)
ca2e214: block-backend: Allow more "can inactivate" cases (Fam Zheng)
c16de8f: block-backend: Refactor inactivate check (Fam Zheng)
3da2bd8: numa: Move numa_legacy_auto_assign_ram to pc-i440fx-2.9 (Eduardo H=
abkost)
d0a1801: fix build failure in nbd_read_reply_entry() (Igor Mammedov)
1f98e55: hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" =
device (Thomas Huth)
8ccccff: hw/ppc/spapr_rtc: Mark the RTC device with user_creatable =3D fals=
e (Thomas Huth)
0479097: hw/ppc/spapr: Fix segfault when instantiating a 'pc-dimm' without =
'memdev' (Thomas Huth)
188bfe1: spapr: Allow configure-connector to be called multiple times (Bhar=
ata B Rao)
5dfaa53: ppc: fix ppc_set_compat() with KVM PR (Greg Kurz)
c363a37: target/ppc: 'PVR !=3D host PVR' in KVM_SET_SREGS workaround (Danie=
l Henrique Barboza)
b96919d: boot-serial-test: prefer tcg accelerator (Cornelia Huck)
