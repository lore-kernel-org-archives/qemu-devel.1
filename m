Received: from eggs.gnu.org ([2001:4830:134:3::10]:40626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBS-0000yi-Vw
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBP-0000cs-QS
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBP-0000cX-Ko
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7eUCk012670
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:46 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29xucaxkeb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:45 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:44 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 00/11] s390x patches for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f3586:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170420' into staging (2017-04-20 17:41:34 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170421

for you to fetch changes up to cb55c19a26d6928b445f1bd9394843c9eb60f8ab:

  s390x: Drop useless casts (2017-04-21 09:32:09 +0200)

----------------------------------------------------------------
The first batch of s390x changes for 2.10:
- the new compat machine
- several cleanups and optimizations
- introspection for css ids

----------------------------------------------------------------

Cornelia Huck (1):
  s390x: introduce 2.10 compat machine

Danil Antonov (2):
  s390x/kvm: make printf always compile in debug output
  s390x/pci: make printf always compile in debug output

Dong Jia Shi (3):
  s390x/css: introduce read-only property type for device ids
  s390x/css: provide introspection for virtual subchannel and device
    busid
  s390x/css: consolidate the devno property for ccw devices

Eric Blake (1):
  s390x: Drop useless casts

Fei Li (4):
  s390x: use enum for adapter type and standardize its naming
  s390x: initialize flic before I/O subsystems
  s390x/flic: cache flic in s390_get_flic
  s390x: register I/O adapters per ISC during init

 hw/intc/s390_flic.c        |  9 +++--
 hw/s390x/ccw-device.c      | 40 ++++++++++++++++++++
 hw/s390x/ccw-device.h      |  9 ++++-
 hw/s390x/css-bridge.c      |  3 ++
 hw/s390x/css.c             | 92 ++++++++++++++++++++++++++++++----------------
 hw/s390x/s390-pci-bus.c    | 19 ++++++----
 hw/s390x/s390-pci-bus.h    |  1 -
 hw/s390x/s390-pci-inst.c   | 26 ++++++-------
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++-
 hw/s390x/virtio-ccw.c      | 54 ++++++++++++++-------------
 include/hw/compat.h        |  3 ++
 include/hw/s390x/css.h     | 19 ++++++++--
 target/s390x/cpu_models.c  |  4 +-
 target/s390x/kvm.c         | 16 ++++----
 14 files changed, 218 insertions(+), 97 deletions(-)

-- 
2.11.0
