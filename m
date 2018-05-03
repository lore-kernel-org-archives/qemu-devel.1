Received: from eggs.gnu.org ([2001:4830:134:3::10]:41963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE9PL-00080K-QF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE9PH-0002qc-4w
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:16:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fE9PH-0002ps-0U
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:16:03 -0400
Date: Thu, 3 May 2018 16:15:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503081545.GD29580@xz-mi>
References: <20180503080611.23834-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503080611.23834-1-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: introduce
 decompress-error-check
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

On Thu, May 03, 2018 at 04:06:11PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> QEMU 2.13 enables strict check for compression & decompression to
> make the migration more robust, that depends on the source to fix
> the internal design which triggers the unexpected error conditions
> 
> To make it work for migrating old version QEMU to 2.13 QEMU, we
> introduce this parameter to disable the error check on the
> destination which is the default behavior of the machine type
> which is older than 2.13, alternately, the strict check can be
> enabled explicitly as followings:
>       -M pc-q35-2.11 -global migration.decompress-error-check=true
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
