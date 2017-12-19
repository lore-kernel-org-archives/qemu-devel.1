Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRCmy-0006HD-1X
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRCmt-0007nX-Ko
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:58:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:57833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eRCmt-0007lL-9Q
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:58:07 -0500
Message-ID: <5A38C70D.30207@intel.com>
Date: Tue, 19 Dec 2017 16:00:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171215170519.31392-1-stefanha@redhat.com>
In-Reply-To: <20171215170519.31392-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC virtio-dev] vhost-user-slave: add vhost-user
 slave device type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 12/16/2017 01:05 AM, Stefan Hajnoczi wrote:
> The vhost-user slave device facilitates vhost-user device emulation
> through vhost-user protocol exchanges and access to shared memory.
> Software-defined networking, storage, and other I/O appliances can
> provide services through this device.
>
> This device is based on Wei Wang's vhost-pci work.  The vhost-user slave
> device differs from vhost-pci because it is a single virtio device type
> that exposes the vhost-user protocol instead of a family of new virtio
> device types, one for each vhost-user device type.
>
> This device supports vhost-user slave and vhost-user master
> reconnection.  It also contains a UUID so that vhost-user slave programs
> can identify a specific device among many without using bus addresses.
>
> It is somewhat unconventional for a virtio device because it makes use
> of additional resources called doorbells, notifications, and shared
> memory.  A mapping of these resources to the virtio PCI transport is
> provided.  Other transports, such as CCW may not be able to support
> this device.

Hi Stefan,

Sorry for being late. I need to shift my focus to some other things for 
a week or two.

I still couldn't see how those problems can be solved with this slave 
device proposal (which vhost-pci doesn't have):

- The complexity of the "relaying" mechanism for two directions 
(GuestSlave<->QemuSlave<->Master). I couldn't think of a simple way to 
do this. If you know a *simple* way, could you please describe the 
detailed steps or show a picture of the details? (I think most of us 
couldn't see the true advantage over the vhost-pci's method)

- Reusability. We seem to have no chance to reuse one slave 
implementation for GuestSlave and QemuSlave, which also wasn't your 
intention as you mentioned. If this couldn't be solved, shall we give up 
this option?

Best,
Wei
