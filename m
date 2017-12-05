Received: from eggs.gnu.org ([2001:4830:134:3::10]:54271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMHGB-0007DA-Ug
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMHG8-0004oF-R8
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:44:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMHG8-0004mc-Hb
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:43:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5HhUSq007281
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 12:43:53 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enya2tgw4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 12:43:53 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 10:43:52 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 05 Dec 2017 11:43:38 -0600
Message-Id: <151249581846.21308.741155875987398872@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc4 is now available
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
fifth release candidate for the QEMU 2.11 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.11.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-2.11.0-rc4.tar.xz.sig

A note from the maintainer:

  Unfortunately we had to have another release candidate to fix
  some final bugs. These fix crashes and other issues for
  virtio, vhost, and PPC guests. We now expect to be able to
  make the final release of 2.11.0 in a week, on the 12th December.

You can help improve the quality of the QEMU 2.11 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.11

Please add entries to the ChangeLog for the 2.11 release below:

  http://wiki.qemu.org/ChangeLog/2.11

Changes since rc3:

2babfe0c92: Update version for v2.11.0-rc4 release (Peter Maydell)
2994cb2ee2: vhost-scsi: add missing virtqueue_size parameter (Eric Farman)
044897ef4a: target/ppc: Fix system lockups caused by interrupt_request stat=
e corruption (Richard Purdie)
3d5d319e12: blockjob: Make block_job_pause_all() keep a reference to the jo=
bs (Alberto Garcia)
768a20f3a4: spapr: Include "pre-plugged" DIMMS in ram size calculation at r=
eset (David Gibson)
75ba2ddb18: pc: fix crash on attempted cpu unplug (Igor Mammedov)
758ead31c7: virtio: check VirtQueue Vring object is set (Prasad J Pandit)
2fe45ec3bf: vhost: fix error check in vhost_verify_ring_mappings() (Greg Ku=
rz)
d36d0a9d15: dump-guest-memory.py: fix No symbol "vmcoreinfo_find" (Marc-And=
r=C3=A9 Lureau)
2ae39a113a: vhost: restore avail index from vring used index on disconnecti=
on (Maxime Coquelin)
2d4ba6cc74: virtio: Add queue interface to restore avail index from vring u=
sed index (Maxime Coquelin)
861fec459b: i386/msi: Correct mask of destination ID in MSI address (Chao G=
ao)
be1b21e885: target-ppc: Don't invalidate non-supported msr bits (Kurban Mal=
lachiev)
0c86b2df78: pseries: fix TCG migration (Laurent Vivier)
