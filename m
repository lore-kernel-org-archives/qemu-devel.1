Received: from eggs.gnu.org ([2001:4830:134:3::10]:51317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxs4F-00052l-8X
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxs4B-0006bU-Eg
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:03:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fxs49-0006SV-Nw
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:03:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180906070101.27280-1-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Thu, 6 Sep 2018 15:00:58 +0800")
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Thu, 06 Sep 2018 13:03:00 +0200
Message-ID: <87k1ny51nf.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 0/3] migration: compression optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Changelog in v6:
>
> Thanks to Juan's review, in this version we
> 1) move flush compressed data to find_dirty_block() where it hits the end
>    of memblock
> 2) use save_page_use_compression instead of migrate_use_compression in
>    flush_compressed_data
>
> Xiao Guangrong (3):
>   migration: do not flush_compressed_data at the end of iteration
>   migration: show the statistics of compression
>   migration: use save_page_use_compression in flush_compressed_data
>
>  hmp.c                 | 13 +++++++++++
>  migration/migration.c | 12 ++++++++++
>  migration/ram.c       | 63 +++++++++++++++++++++++++++++++++++++++++++--------
>  migration/ram.h       |  1 +
>  qapi/migration.json   | 26 ++++++++++++++++++++-
>  5 files changed, 105 insertions(+), 10 deletions(-)

queued
