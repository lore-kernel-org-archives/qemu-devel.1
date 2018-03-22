Received: from eggs.gnu.org ([2001:4830:134:3::10]:40091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eywtj-0003Pg-9C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eywti-0000Ha-D2
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:52:39 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 22 Mar 2018 11:52:17 +0200
Message-Id: <20180322095220.9976-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.12 0/3] hw/rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, eblake@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi all,
Following are three patches which fixes various compilation warnings and
errors detected when compiling rdma device in 32bit host.

All three patches are based on Eric Blake patch for rdma device.
Thanks!

Patch #1: Change host_virt to void *
Low level IB verbs library accept void * argument so let's make sure this
is what we supply. This issue reported by Eric Blake.

Patch #2: Use correct print format in CHK_ATTR macro
This macro can utilize the given 'format' argument and not need to cast a=
ll
members to u64. This patch is an alternative to suggested patch by Eric
Blake.

Patch #3: Fix 32-bit compilation
Based on Eric Blake patch this patch replaces all %ld/%lx with the platfo=
rm
independent PRIx64/PRId64 format.

Again, thanks Eric Blake for the report.

v1 -> v2:
	* Address comments from Philippe Mathieu-Daud=C3=A9
	* Fix checkpatch warnings (trim some strings)
	* Add reviewers signatures

Yuval Shaia (3):
  hw/rdma: Change host_virt to void *
  hw/rdma: Use correct print format in CHK_ATTR macro
  hw/rdma: Fix 32-bit compilation

 hw/rdma/rdma_backend.c        | 33 +++++++++++++++++----------------
 hw/rdma/rdma_backend.h        |  2 +-
 hw/rdma/rdma_rm.c             | 14 +++++++-------
 hw/rdma/rdma_rm_defs.h        |  2 +-
 hw/rdma/rdma_utils.c          |  6 +++---
 hw/rdma/vmw/pvrdma_cmd.c      |  8 ++++----
 hw/rdma/vmw/pvrdma_dev_ring.c |  6 +++---
 hw/rdma/vmw/pvrdma_dev_ring.h |  2 +-
 hw/rdma/vmw/pvrdma_main.c     | 25 +++++++++++++------------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  6 +++---
 10 files changed, 53 insertions(+), 51 deletions(-)

--=20
2.13.6
