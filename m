Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVIlM-0004H6-Mb
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVIlJ-0005A5-Jv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fVIlJ-000596-Bo
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5JFd9r1053020
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 11:41:40 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jq4fagrky-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 11:41:39 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 19 Jun 2018 11:41:38 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 19 Jun 2018 11:41:32 -0400
Message-Id: <cover.1529422492.git.alifm@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Detect & register virtio-crypto algos
 only if it can be supported by backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, herbert@gondor.apana.org.au, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, mst@redhat.com

Hi,

Currently the Linux virtio-crypto driver registers the crypto
algorithm without verifying if the backend actually supports the
algorithm.

This kernel patch series adds support for registering algorithm
with Linux crypto layer, only if the algorithm is supported by
the backend device. This also makes the driver more compliant with
the virtio-crypto spec [1].

I would appreciate any feedback or comments on this.

Thank you
Farhan

Reference
---------
[1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html

ChangeLog
---------
v2 -> v3
    - Add Christian Borntrager's acks for the patches.

v1 -> v2
   - Modify comment as suggested by Arei (patch 1)
   - Modify error message as suggested by Arei (patch 2)

Farhan Ali (2):
  crypto/virtio-crypto: Read crypto services and algorithm masks
  crypto/virtio-crypto: Register an algo only if it's supported

 drivers/crypto/virtio/virtio_crypto_algs.c   | 112 ++++++++++++++++++---------
 drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
 drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
 drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 +++++++++++++++++--
 4 files changed, 202 insertions(+), 45 deletions(-)

-- 
2.7.4
