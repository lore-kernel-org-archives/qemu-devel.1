Received: from eggs.gnu.org ([2001:4830:134:3::10]:39674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fwl8M-00075T-FX
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fwl8H-00041Q-KS
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:26:58 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:38660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fwl8H-00041H-Dp
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:26:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id f4-v6so3064983pgq.5
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 02:26:53 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  3 Sep 2018 17:26:40 +0800
Message-Id: <20180903092644.25812-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v5 0/4] migration: compression optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Changelog in v5:
   use the way in the older version to handle flush_compressed_data in the
   iteration, i.e, introduce dirty_sync_count and flush compressed data if
   the count is changed. That's because we should post the data after
   QEMU_VM_SECTION_PART has been posted out. Peter, I have dropped your
   Reviewed-by on this patch, please review. :)


Xiao Guangrong (4):
  migration: do not flush_compressed_data at the end of each iteration
  migration: fix calculating xbzrle_counters.cache_miss_rate
  migration: show the statistics of compression
  migration: handle the error condition properly

 hmp.c                 | 13 ++++++++
 migration/migration.c | 12 +++++++
 migration/ram.c       | 91 +++++++++++++++++++++++++++++++++++++++++++--------
 migration/ram.h       |  1 +
 qapi/migration.json   | 26 ++++++++++++++-
 5 files changed, 128 insertions(+), 15 deletions(-)

-- 
2.14.4
