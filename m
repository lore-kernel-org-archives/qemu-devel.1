Received: from eggs.gnu.org ([2001:4830:134:3::10]:33533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fxoI4-0001P9-DA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fxoHz-000893-Tc
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:20 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fxoHw-00085d-1a
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:13 -0400
Received: by mail-pl1-x644.google.com with SMTP id h3-v6so1159295plh.10
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 00:01:11 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  6 Sep 2018 15:00:58 +0800
Message-Id: <20180906070101.27280-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v6 0/3] migration: compression optimization
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

Changelog in v6:

Thanks to Juan's review, in this version we
1) move flush compressed data to find_dirty_block() where it hits the end
   of memblock
2) use save_page_use_compression instead of migrate_use_compression in
   flush_compressed_data

Xiao Guangrong (3):
  migration: do not flush_compressed_data at the end of iteration
  migration: show the statistics of compression
  migration: use save_page_use_compression in flush_compressed_data

 hmp.c                 | 13 +++++++++++
 migration/migration.c | 12 ++++++++++
 migration/ram.c       | 63 +++++++++++++++++++++++++++++++++++++++++++--------
 migration/ram.h       |  1 +
 qapi/migration.json   | 26 ++++++++++++++++++++-
 5 files changed, 105 insertions(+), 10 deletions(-)

-- 
2.14.4
