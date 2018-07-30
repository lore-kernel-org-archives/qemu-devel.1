Received: from eggs.gnu.org ([2001:4830:134:3::10]:56567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fk2oS-0005Ss-1H
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fk2oO-0001KN-Vl
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:40266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fk2oO-0001Jy-MT
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:48 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 30 Jul 2018 15:13:55 +0800
Message-Id: <1532934837-5966-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] bitmap: some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, quintela@redhat.com
Cc: mst@redhat.com

"nbits = 0" is not applicable to BITMAP_LAST_WORD_MASK, callers should
avoid that. Fix bitmap_count_one to avoid passing 0 to the macro.

Wei Wang (2):
  bitmap.h: add comments to BITMAP_LAST_WORD_MASK
  bitmap: fix bitmap_count_one

 include/qemu/bitmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
