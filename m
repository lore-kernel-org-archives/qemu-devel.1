Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX5f-0004BP-Uz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX5c-0005gl-RP
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1etX5c-0005gW-Mb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Mar 2018 12:18:18 +0100
Message-Id: <20180307111822.29403-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Multiboot patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jack.schwartz@oracle.com

The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:

  misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4b9006a41ea8818f2385ae5228e07f211bb4a33d:

  multiboot: fprintf(stderr...) -> error_report() (2018-03-07 11:53:37 +0100)

----------------------------------------------------------------
Multiboot patches

----------------------------------------------------------------
Jack Schwartz (4):
      multiboot: bss_end_addr can be zero
      multiboot: Remove unused variables from multiboot.c
      multiboot: Use header names when displaying fields
      multiboot: fprintf(stderr...) -> error_report()

 hw/i386/multiboot.c | 77 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)
