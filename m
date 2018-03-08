Received: from eggs.gnu.org ([2001:4830:134:3::10]:40289)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ettZJ-0004Wo-Ka
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ettZG-0001za-Eg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:41 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:56238 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ettZG-0001yX-5B
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:38 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 8 Mar 2018 12:18:28 +0100
From: Peter Lieven <pl@kamp.de>
Date: Thu,  8 Mar 2018 12:18:23 +0100
Message-Id: <1520507908-16743-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 0/5] block migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com, Peter Lieven <pl@kamp.de>

Peter Lieven (5):
  migration: do not transfer ram during bulk storage migration
  migration/block: reset dirty bitmap before read in bulk phase
  migration/block: rename MAX_INFLIGHT_IO to MAX_IO_BUFFERS
  migration/block: limit the number of parallel I/O requests
  migration/block: compare only read blocks against the rate limiter

 migration/block.c | 17 ++++++++---------
 migration/ram.c   |  8 ++++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.7.4
