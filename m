Received: from eggs.gnu.org ([2001:4830:134:3::10]:47921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5p-0002FE-1k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5k-0000X9-2s
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gWi5j-0000Vi-Sx
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:52 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 11 Dec 2018 18:56:37 +0530
Message-Id: <20181211132642.3027-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] rdma: various issues in rdma/pvrdma backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

Various issues OOB access, null dereference and possible infinite loop we=
re
reported in the rdma/pvrdma backends. This patch set attempts to fix thes=
e.

Thank you.
---
Prasad J Pandit (5):
  rdma: check that num_sge does not exceed MAX_SGE
  pvrdma: add uar_read routine
  pvrdma: check number of pages when creating rings
  pvrdma: release ring object in case of an error
  pvrdma: check return value from pvrdma_idx_ring_has_ routines

 hw/rdma/rdma_backend.c        |  8 ++++----
 hw/rdma/vmw/pvrdma_cmd.c      | 17 ++++++++++++++++-
 hw/rdma/vmw/pvrdma_dev_ring.c | 16 +++++++++++-----
 hw/rdma/vmw/pvrdma_main.c     |  6 ++++++
 4 files changed, 37 insertions(+), 10 deletions(-)

--=20
2.19.2
