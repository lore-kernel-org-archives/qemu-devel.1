Received: from eggs.gnu.org ([2001:4830:134:3::10]:54455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9BrV-0001yH-9S
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9BrQ-0002Vf-Bh
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:52:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9BrQ-0002Uq-21
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:52:36 -0400
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-7-tiwei.bie@intel.com>
	<20180418192154-mutt-send-email-mst@kernel.org>
	<20180419111439.i6gfhnept6wy7uzp@debian>
	<D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
	<20180419182035-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
Date: Thu, 19 Apr 2018 17:52:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180419182035-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/6] vhost-user: support registering
 external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>
Cc: "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly, Dan" <dan.daly@intel.com>, "Tan,
	Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>

On 19/04/2018 17:42, Michael S. Tsirkin wrote:
>> A compiler barrier is enough on strongly-ordered memory platform.
>> As it doesn't re-order store, PCI device won't see a stale index
>> value. But a weakly-ordered memory needs sfence.
> 
> Oh you are right.
> 
> So it's only needed for non-intel platforms or when packets are in
> WC memory then. And I don't know whether dpdk ever puts packets in WC
> memory.
> 
> I guess we'll cross this bridge when we get to it.

Non-TSO architectures seem important...

Paolo
