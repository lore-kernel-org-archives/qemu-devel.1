Received: from eggs.gnu.org ([2001:4830:134:3::10]:41464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxMO-0007Mp-PV
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxMK-00043H-RK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:20:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48165
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIxMK-000437-LC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:20:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58DJQkA101410
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 09:20:20 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axxkm87xd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:20:18 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Jun 2017 14:20:10 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  8 Jun 2017 15:18:55 +0200
Message-Id: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/5] s390x/kvm: various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter,

The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)

are available in the git repository at:

  ssh://git@github.com/borntraeger/qemu.git tags/s390x-20170608

for you to fetch changes up to fbe8202ea81519a42855830059ccc8e10b58dfa5:

  s390x/cpumodel: improve defintion search without an IBC (2017-06-06 10:50:40 +0200)

----------------------------------------------------------------
s390x: misc fixes

bunch of fixes
- reject MIDA accesses for CCWs
- cpumodel fixes
- cross-build fix for bios
- migration improvements

----------------------------------------------------------------
Cornelia Huck (1):
      s390x/css: fence off MIDA

David Hildenbrand (2):
      s390x/cpumodel: take care of the cpuid format bit for KVM
      s390x/cpumodel: improve defintion search without an IBC

Greg Kurz (1):
      pc-bios/s390-ccw: use STRIP variable in Makefile

Halil Pasic (1):
      s390x/css: catch section mismatch on load

 hw/s390x/css.c            | 19 +++++++++++++++++++
 hw/s390x/virtio-ccw.c     |  6 +++++-
 include/hw/s390x/ioinst.h |  1 +
 pc-bios/s390-ccw/Makefile |  4 +++-
 target/s390x/cpu_models.c | 10 ++++++++++
 target/s390x/cpu_models.h | 10 +++++++---
 target/s390x/ioinst.c     |  4 ++++
 target/s390x/kvm.c        |  1 +
 8 files changed, 50 insertions(+), 5 deletions(-)
