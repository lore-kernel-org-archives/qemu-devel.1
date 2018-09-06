Received: from eggs.gnu.org ([2001:4830:134:3::10]:52477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxqk0-0006MF-VU
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxqjw-0006qy-UR
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:38:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fxqjw-0006oX-Nm
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:38:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180906070101.27280-2-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Thu, 6 Sep 2018 15:00:59 +0800")
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
	<20180906070101.27280-2-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Thu, 06 Sep 2018 11:38:03 +0200
Message-ID: <87sh2n3r0k.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 1/3] migration: do not
 flush_compressed_data at the end of iteration
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
> flush_compressed_data() needs to wait all compression threads to
> finish their work, after that all threads are free until the
> migration feeds new request to them, reducing its call can improve
> the throughput and use CPU resource more effectively
>
> We do not need to flush all threads at the end of iteration, the
> data can be kept locally until the memory block is changed or
> memory migration starts over in that case we will meet a dirtied
> page which may still exists in compression threads's ring
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>
