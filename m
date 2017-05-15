Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAEvQ-00066V-Il
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAEvN-0001f8-BG
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:16:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dAEvN-0001eL-5z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:16:29 -0400
Date: Mon, 15 May 2017 20:16:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170515121620.GD31572@pxdev.xzpeter.org>
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<1494838260-30439-3-git-send-email-peterx@redhat.com>
	<6c4a5786-0ac0-4e25-9398-cd233dce7c17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c4a5786-0ac0-4e25-9398-cd233dce7c17@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] exec: rename resolve_subpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Mon, May 15, 2017 at 11:03:49AM +0200, Paolo Bonzini wrote:
> 
> 
> On 15/05/2017 10:50, Peter Xu wrote:
> > It is not easy for people to know "what this parameter does" before
> > knowing "what is subpage". Let's use "is_mmio" to make it easier to
> > understand.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Maybe invert the direction and call it for_iotlb?

I wasn't aware that tcg is using resolve_subpage==false always. Then
at least is_mmio does not suite here. I am not sure whether for-iotlb
suites here either... So maybe I will just drop this patch as well,
just like patch 3.

Thanks for reviewing it!

-- 
Peter Xu
