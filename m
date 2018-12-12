Received: from eggs.gnu.org ([2001:4830:134:3::10]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFW-00087k-33
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFR-0001OM-JY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gXAFR-0001Ns-Da
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:45 -0500
From: P J P <ppandit@redhat.com>
Date: Thu, 13 Dec 2018 01:00:33 +0530
Message-Id: <20181212193039.11445-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] rdma: various issues in rdma/pvrdma
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

This is a revised version v2 of the earlier patch set to fix issues
in the rdma/pvrdma backend.

Update to include review comments from
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02616.html

Thank you.
---
Prasad J Pandit (6):
  rdma: check num_sge does not exceed MAX_SGE
  pvrdma: add uar_read routine
  pvrdma: check number of pages when creating rings
  pvrdma: release ring object in case of an error
  rdma: remove unused VENDOR_ERR_NO_SGE macro
  pvrdma: check return value from pvrdma_idx_ring_has_ routines

 hw/rdma/rdma_backend.c        | 15 ++++++-----
 hw/rdma/vmw/pvrdma_cmd.c      | 47 +++++++++++++++++++++++++++--------
 hw/rdma/vmw/pvrdma_dev_ring.c | 29 ++++++++-------------
 hw/rdma/vmw/pvrdma_main.c     |  6 +++++
 4 files changed, 60 insertions(+), 37 deletions(-)

--=20
2.19.2
