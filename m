Received: from eggs.gnu.org ([2001:4830:134:3::10]:42364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQL3-00086t-5y
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQL2-0000Rp-Gr
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:26:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQKy-0000MC-Bz
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:26:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180821081029.26121-2-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Tue, 21 Aug 2018 16:10:20 +0800")
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
	<20180821081029.26121-2-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:25:53 +0200
Message-ID: <871saq4s0e.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 01/10] migration: do not wait for free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Instead of putting the main thread to sleep state to wait for
> free compression thread, we can directly post it out as normal
> page that reduces the latency and uses CPUs more efficiently
>
> A parameter, compress-wait-thread, is introduced, it can be
> enabled if the user really wants the old behavior
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
