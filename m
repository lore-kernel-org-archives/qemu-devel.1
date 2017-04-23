Received: from eggs.gnu.org ([2001:4830:134:3::10]:36127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LL6-0003sv-2r
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LL5-00079V-BT
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:30:24 -0400
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-2-famz@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <a573309c-24a9-072d-4c0a-b55f66d77222@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 20:30:17 +0300
MIME-Version: 1.0
In-Reply-To: <20170207132723.13934-2-famz@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-blk: Remove useless condition
 around g_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

07.02.2017 16:27, Fam Zheng wrote:
> Laszlo spotted and studied this wasteful "if". He pointed out:
> 
> The original virtio_blk_free_request needed an "if" as it accesses one
> field, since 671ec3f05655 ("virtio-blk: Convert VirtIOBlockReq.elem to
> pointer", 2014-06-11); later on in f897bf751fbd ("virtio-blk: embed
> VirtQueueElement in VirtIOBlockReq", 2014-07-09) the field became
> embedded, so the "if" became unnecessary (at which point we were using
> g_slice_free(), but it is the same.
> 
> Now drop it.

Applied to -trivial, thanks!

/mjt
