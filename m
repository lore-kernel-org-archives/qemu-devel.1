Received: from eggs.gnu.org ([2001:4830:134:3::10]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT192-0003Jw-SG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18y-0005Qb-TI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41370
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dT18y-0005QN-N1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v667O6Jv117522
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 03:24:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvqkr3fg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:24:07 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jul 2017 08:23:42 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  6 Jul 2017 09:23:29 +0200
Message-Id: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/8] s390x/kvm/migration: fixes,
 enhancements and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter,

the following changes since commit 2185c93ba80f81bfa27ce6f259c7f2ef4f08b668:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next.for-upstream' into staging (2017-07-04 13:05:30 +0100)

are available in the git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20170706

for you to fetch changes up to 1045e3cdafaf1218d9f771080ba5c9d4f64346e4:

  hw/s390x/ipl: Fix endianness problem with netboot_start_addr (2017-07-05 19:46:30 +0200)

----------------------------------------------------------------
s390x/kvm/migration: fixes, enhancements and cleanups

- new email address for Cornelia
- Fixes: 3270, flic, virtio-scsi-ccw, ipl
- Enhancements, cpumodel, migration

----------------------------------------------------------------
Cornelia Huck (1):
      s390x/MAINTAINERS: Update my email address

Dong Jia Shi (1):
      s390x/3270: fix instruction interception handler

Halil Pasic (3):
      s390x: vmstatify config migration for virtio-ccw
      s390x: fix error propagation in kvm-flic's realize
      s390x: fix realize inheritance for kvm-flic

QingFeng Hao (1):
      virtio-scsi-ccw: use ioeventfd even when KVM is disabled

Thomas Huth (1):
      hw/s390x/ipl: Fix endianness problem with netboot_start_addr

Viktor Mihajlovski (1):
      s390x: return unavailable features via query-cpu-definitions

 MAINTAINERS                  |   8 +-
 hw/intc/s390_flic.c          |  32 +++-
 hw/intc/s390_flic_kvm.c      |  29 +++-
 hw/s390x/3270-ccw.c          |   1 +
 hw/s390x/ccw-device.c        |  10 ++
 hw/s390x/ccw-device.h        |   4 +
 hw/s390x/css.c               | 378 +++++++++++++++++++++++++------------------
 hw/s390x/ipl.c               |   2 +-
 hw/s390x/virtio-ccw.c        | 160 +++++++++---------
 include/hw/s390x/css.h       |  12 +-
 include/hw/s390x/s390_flic.h |   5 +
 target/s390x/cpu.h           |   6 +-
 target/s390x/cpu_models.c    |  62 ++++++-
 13 files changed, 456 insertions(+), 253 deletions(-)
