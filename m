Received: from eggs.gnu.org ([2001:4830:134:3::10]:45997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVB6G-0000Ag-Lo
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVB6D-0005VX-Hq
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:30:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVB6D-0005VI-CJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:30:45 -0400
Date: Tue, 19 Jun 2018 15:30:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180619073034.GA14814@xz-mi>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-7-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-7-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 06/12] migration: do not detect zero page
 for compression
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

On Mon, Jun 04, 2018 at 05:55:14PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Detecting zero page is not a light work, we can disable it
> for compression that can handle all zero data very well

Is there any number shows how the compression algo performs better
than the zero-detect algo?  Asked since AFAIU buffer_is_zero() might
be fast, depending on how init_accel() is done in util/bufferiszero.c.

>From compression rate POV of course zero page algo wins since it
contains no data (but only a flag).

Regards,

-- 
Peter Xu
