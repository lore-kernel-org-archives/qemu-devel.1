Received: from eggs.gnu.org ([2001:4830:134:3::10]:49017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhTWD-00056T-4N
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhTW9-0008CB-H6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:36:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhTW9-0008C1-0S
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:36:21 -0400
Date: Mon, 23 Jul 2018 13:36:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723053602.GG2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-8-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719121520.30026-8-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/8] migration: hold the lock only if it
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
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Jul 19, 2018 at 08:15:19PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Try to hold src_page_req_mutex only if the queue is not
> empty
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
