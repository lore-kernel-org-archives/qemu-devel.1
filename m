Received: from eggs.gnu.org ([2001:4830:134:3::10]:48089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDKs7-0007Bq-9H
	for qemu-devel@nongnu.org; Tue, 23 May 2017 21:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDKs4-0000uI-31
	for qemu-devel@nongnu.org; Tue, 23 May 2017 21:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dDKs3-0000u0-Sf
	for qemu-devel@nongnu.org; Tue, 23 May 2017 21:13:52 -0400
Date: Wed, 24 May 2017 04:13:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170524001758-mutt-send-email-mst@kernel.org>
References: <82063967A54EF84C8AFCD6BD7F6AD93310D199A2@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82063967A54EF84C8AFCD6BD7F6AD93310D199A2@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] virtio crypto device implemenation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zeng, Xin" <xin.zeng@intel.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, May 23, 2017 at 04:08:25PM +0000, Zeng, Xin wrote:
> Hi, Michael, 
>    As you know, Lei Gong from Huawei and I are co-working  on virtio crypto device spec, he is focusing on symmetric algorithm part, I am focusing on asymmetric part.  Now I am planning the implementation for asymmetric part, would you please give me your point regarding the questions below?
>    Current virtio crypto device implementation from Lei Gong:
>    The virtio crypto device implementation has been upstreamed to QEMU and it has a qemu backend implementation for symmetric algorithm part, the front end Linux device driver for symmetric part has been upstreamed to Linux kernel as well.
>    My questions:
>    From my side, I planned to add the asymmetric part support in upstreamed front end device driver, and I don't want to add the asymmetric algorithm support to current virtio crypto device's qemu backend, instead, I would like to implement and upstream a DPDK vhost-user based backend for asymmetric algorithm, and accordingly Lei Gong will help to upstream a vhost user agent for virtio crypto device in QEMU,  is this approach acceptable? Is a qemu backend a mandatory requirement for the virtio crypto device?  Is there a general policy for this?
> 
> Thanks

Parity on QEMU side is naturally preferable.  I don't think we should require it
at all times, but if there's no implementation outside vhost-user,
and if the feature includes a non-trivial amount of code, how
will it be tested? I don't think we want to require all testers to use
dpdk. An implementation under tests using libvhost-user might
be a solution.

-- 
MST
