Received: from eggs.gnu.org ([2001:4830:134:3::10]:46841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVBCL-0001Il-Gi
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVBCI-0007n1-C3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:37:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVBCI-0007md-7Z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:37:02 -0400
Date: Tue, 19 Jun 2018 15:36:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180619073650.GB14814@xz-mi>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-8-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-8-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 07/12] migration: hold the lock only if it
 is really needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jun 04, 2018 at 05:55:15PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Try to hold src_page_req_mutex only if the queue is not
> empty

Pure question: how much this patch would help?  Basically if you are
running compression tests then I think it means you are with precopy
(since postcopy cannot work with compression yet), then here the lock
has no contention at all.

Regards,

-- 
Peter Xu
