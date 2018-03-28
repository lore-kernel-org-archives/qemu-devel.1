Received: from eggs.gnu.org ([2001:4830:134:3::10]:38130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17xX-00004u-H4
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17xW-0003Pw-Ph
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:05:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f17xW-0003PY-LE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:05:34 -0400
Date: Wed, 28 Mar 2018 18:05:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180328100520.GH29554@xz-mi>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-7-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327091043.30220-7-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/10] migration: move some code
 ram_save_host_page
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

On Tue, Mar 27, 2018 at 05:10:39PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Move some code from ram_save_target_page() to ram_save_host_page()
> to make it be more readable for latter patches that dramatically
> clean ram_save_target_page() up
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
