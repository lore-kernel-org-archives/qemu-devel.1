Received: from eggs.gnu.org ([2001:4830:134:3::10]:48217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dClqn-000095-Tv
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dClqk-000700-TB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:50:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:32819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dClqk-0006zM-Jt
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:50:10 -0400
Message-ID: <5922D0EC.6060405@intel.com>
Date: Mon, 22 May 2017 19:52:12 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1495161139-28757-1-git-send-email-wei.w.wang@intel.com>
	<20170519233750-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170519233750-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH RFC] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, "pbonzini"@redhat.com, jan.scheurich@ericsson.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 05/20/2017 04:42 AM, Michael S. Tsirkin wrote:
> On Fri, May 19, 2017 at 10:32:19AM +0800, Wei Wang wrote:
>> This patch enables the virtio-net tx queue size to be configurable
>> between 256 (the default queue size) and 1024 by the user. The queue
>> size specified by the user should be power of 2.
>>
>> Setting the tx queue size to be 1024 requires the guest driver to
>> support the VIRTIO_NET_F_MAX_CHAIN_SIZE feature.
> This should be a generic ring feature, not one specific to virtio net.
OK. How about making two more changes below:

1) make the default tx queue size = 1024 (instead of 256).
We can reduce the size (to 256) if the MAX_CHAIN_SIZE feature
is not supported by the guest.
In this way, people who apply the QEMU patch can directly use the
largest queue size(1024) without adding the booting command line.

2) The vhost backend does not use writev, so I think when the vhost
backed is used, using 1024 queue size should not depend on the
MAX_CHAIN_SIZE feature.


Best,
Wei
