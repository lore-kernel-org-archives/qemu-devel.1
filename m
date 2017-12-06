Received: from eggs.gnu.org ([2001:4830:134:3::10]:34182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMWjo-0007mk-Us
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMWjk-0006a8-Ct
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:15:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:41564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eMWjk-0006WS-4O
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:15:32 -0500
Message-ID: <5A27C3B7.7010109@intel.com>
Date: Wed, 06 Dec 2017 18:17:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
	<20171205145950.GF31150@stefanha-x1.localdomain>
In-Reply-To: <20171205145950.GF31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add
 vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com

On 12/05/2017 10:59 PM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
>> Add the vhost-pci-net device emulation. The device uses bar 2 to expose
>> the remote VM's memory to the guest. The first 4KB of the the bar area
>> stores the metadata which describes the remote memory and vring info.
> This device looks like the beginning of a new "vhost-pci" virtio device
> type.  There are layering violations:
>
> 1. This has nothing to do with virtio-net or networking, it's purely
>     vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?

Here are a few things that are specific to vhost-pci-net here:

1) The device category here is set to NETWORK.
2) vhost-pci-net related features (e.g. future MQ feature) will be added 
to the property here.

Right now, we only have vhost-pci-net. How about all focusing on the 
vhost-pci-net, and ignore vhost-pci for now? When future other types of 
devices are addded, we can abstract out a common vhost-pci layer?

Best,
Wei
