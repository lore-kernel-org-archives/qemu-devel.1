Received: from eggs.gnu.org ([2001:4830:134:3::10]:35263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9DTg-0001bA-US
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9DTc-0002Xg-UB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:36:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9DTc-0002WP-Op
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:36:08 -0400
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-7-tiwei.bie@intel.com>
	<20180418192154-mutt-send-email-mst@kernel.org>
	<20180419111439.i6gfhnept6wy7uzp@debian>
	<D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
	<20180419182035-mutt-send-email-mst@kernel.org>
	<f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E950C67@SHSMSX104.ccr.corp.intel.com>
	<28ab1675-15ae-dab4-fd71-7632666f57fc@redhat.com>
	<20180419200049-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce75f966-4170-e263-9e34-a0401bacc9e2@redhat.com>
Date: Thu, 19 Apr 2018 19:35:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180419200049-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] RE: [PATCH v3 6/6] vhost-user:
 support registering external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly, Dan" <dan.daly@intel.com>, "Tan,
	Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>

On 19/04/2018 19:27, Michael S. Tsirkin wrote:
> 
> That CONFIG_SMP here is clearly wrong but I don't really know what
> to set it to. Also, we probably should switch virtio_wmb to dma_XX
> barriers.
> 
> That's actually easy. Will try to do.

Should it be dma_wmb() before updating the indices, and wmb() before
writing the "kick virtqueue" register?

Paolo
