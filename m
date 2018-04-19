Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Bqx-0001U7-5K
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Bqt-00022S-Gx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:52:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9Bqt-00022D-Al
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:52:03 -0400
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-7-tiwei.bie@intel.com>
	<20180418192154-mutt-send-email-mst@kernel.org>
	<20180419111439.i6gfhnept6wy7uzp@debian>
	<D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
	<c41439d6-69b7-474a-530f-07ffb5f1b9e6@redhat.com>
	<20180419180912-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <174b5e48-dfde-cb5f-e664-39d43a20a629@redhat.com>
Date: Thu, 19 Apr 2018 17:51:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180419180912-mutt-send-email-mst@kernel.org>
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

On 19/04/2018 17:19, Michael S. Tsirkin wrote:
>> - if we make it 1 when weak barriers are needed, the device also needs
>> to nack feature negotiation (not allow setting the FEATURES_OK) if the
>> bit is not set by the driver.
>>  However, that is not enough.  Live
>> migration assumes that it is okay to migrate a virtual machine from a
>> source that doesn't support a feature to a destination that supports it.
>>  In this case, it would assume that it is okay to migrate from software
>> virtio to hardware virtio.  This is wrong because the destination would
>> use weak barriers
> 
> You can't migrate between systems with different sets of device features
> right now.

Yes, you can, exactly because some features are defined not by the
machine type but rather by the host kernel.  See virtio_net_get_features
in QEMU's hw/virtio/virtio-net.c, and virtio_set_features_nocheck in
QEMU's hw/virtio/virtio.c.

Thanks,

Paolo
