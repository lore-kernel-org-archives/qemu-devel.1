Received: from eggs.gnu.org ([2001:4830:134:3::10]:52297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95zI-0002Eh-06
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95zA-0006wx-D8
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:04:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59516
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e95zA-0006wd-7x
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:03:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9U93otR088152
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:03:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dwxcufuvf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:03:27 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 09:03:25 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 10:03:16 +0100
Message-Id: <20171030090320.93625-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/4] s390: fixups for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter,

The following changes since commit a93ece47fd9edbd4558db24300056c9a57d3bcd4:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20171026-tag' into staging (2017-10-27 14:43:02 +0100)

are available in the git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20171030

for you to fetch changes up to 7a4ec18d117d74eedccdadca882331b928135465:

  s390-*.img: update s390 bios with latest fixes (2017-10-30 09:04:25 +0100)

----------------------------------------------------------------
s390x: fixups for 2.11

- missing \r in the BIOS console output
- CPU type name is now "s390x-cpu"
- fixup for the host-model on z14 and older machine versions

----------------------------------------------------------------
Christian Borntraeger (2):
      s390x/kvm: use cpu model for gscb on compat machines
      s390-*.img: update s390 bios with latest fixes

Collin L. Walling (1):
      s390-ccw: print carriage return with new lines

David Hildenbrand (1):
      target/s390x: change CPU type name to "s390x-cpu"

 hw/s390x/s390-virtio-ccw.c         |   8 --------
 include/hw/s390x/s390-virtio-ccw.h |   3 ---
 pc-bios/s390-ccw.img               | Bin 26416 -> 30520 bytes
 pc-bios/s390-ccw/sclp.c            |  24 +++++++++++++++++++++---
 pc-bios/s390-netboot.img           | Bin 83864 -> 83864 bytes
 qapi-schema.json                   |   4 ++--
 target/s390x/cpu-qom.h             |   2 +-
 target/s390x/cpu_models.c          |   4 ++--
 target/s390x/kvm.c                 |   2 +-
 target/s390x/machine.c             |   2 +-
 10 files changed, 28 insertions(+), 21 deletions(-)
