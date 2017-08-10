Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfjma-0000H9-9r
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfjmU-0008ND-9G
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:29:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfjmU-0008Mq-37
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:29:30 -0400
References: <1502359951-29160-1-git-send-email-changpeng.liu@intel.com>
	<1502359951-29160-3-git-send-email-changpeng.liu@intel.com>
	<20170809194506-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3de58a9-a701-958d-b3c1-a7bec93e8c5e@redhat.com>
Date: Thu, 10 Aug 2017 11:29:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170809194506-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On 09/08/2017 19:10, Michael S. Tsirkin wrote:
> So user specifies properties and
> they get sent to backend at init time. Only handle geometry changes
> specially.

So QEMU would get the configuration, set these properties, and send the
result to the backend via SET_CONFIG?

vhost-user-blk-pci.cyls=uint32
vhost-user-blk-pci.secs=uint32
vhost-user-blk-pci.heads=uint32
vhost-user-blk-pci.serial=str
vhost-user-blk-pci.min_io_size=uint16
vhost-user-blk-pci.opt_io_size=uint32
vhost-user-blk-pci.logical_block_size=uint16
vhost-user-blk-pci.physical_block_size=uint16

If the properties are incompatible (e.g. too small logical block size)
SET_CONFIG fails and QEMU would fail to realize the device.  This makes
sense, I think.

Thanks,

Paolo
