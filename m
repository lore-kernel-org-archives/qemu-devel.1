Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eYvC6-0004tf-30
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eYvC2-0007iB-TV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:48:02 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:42191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eYvC2-0007eG-Ep
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:47:58 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1515501687-7874-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1515501687-7874-1-git-send-email-wei.w.wang@intel.com>
Message-Id: <201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
Date: Tue, 9 Jan 2018 23:42:16 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v21 2/5 RESEND] virtio-balloon:
 VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> - enable OOM to free inflated pages maintained in the local temporary
>   list.

I do want to see it before applying this patch.

Please carefully check how the xbitmap implementation works, and you will
find that you are adding a lot of redundant operations with a bug.
