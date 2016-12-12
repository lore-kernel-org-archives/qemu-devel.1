Received: from eggs.gnu.org ([2001:4830:134:3::10]:50972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1cGOFu-000139-Jb
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1cGOFr-0004xl-Ha
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:54:50 -0500
Received: from helcar.hengli.com.au ([209.40.204.226]:37395
	helo=helcar.apana.org.au)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <herbert@gondor.apana.org.au>)
	id 1cGOFr-0004wP-3Z
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:54:47 -0500
Date: Mon, 12 Dec 2016 18:54:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20161212105407.GA3033@gondor.apana.org.au>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-3-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

On Mon, Dec 12, 2016 at 06:25:12AM +0000, Gonglei (Arei) wrote:
> Hi, Michael & Herbert
> 
> Because the virtio-crypto device emulation had been in QEMU 2.8,
> would you please merge the virtio-crypto driver for 4.10 if no other
> comments? If so, Miachel pls ack and/or review the patch, then
> Herbert will take it (I asked him last week). Thank you!
> 
> Ps: Note on 4.10 merge window timing from Linus
>  https://lkml.org/lkml/2016/12/7/506
> 
> Dec 23rd is the deadline for 4.10 merge window.

Sorry but it's too late for 4.10.  It needed to have been in my
tree before the merge window opened to make it for this cycle.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
