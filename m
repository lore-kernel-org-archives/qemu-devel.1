Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eazag-0002sL-RY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eazad-00006r-NH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:53:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:20445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eazad-0008Uy-D2
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:53:55 -0500
Message-ID: <5A5C5EA2.7060605@intel.com>
Date: Mon, 15 Jan 2018 15:56:18 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
In-Reply-To: <20180112101807.GE7356@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/12/2018 06:18 PM, Stefan Hajnoczi wrote:
> On Fri, Jan 12, 2018 at 11:32:56AM +0800, Jason Wang wrote:
>>
>> On 2018年01月11日 23:23, Stefan Hajnoczi wrote:
>>> On Thu, Jan 11, 2018 at 06:57:03PM +0800, Jason Wang wrote:
>>>> On 2018年01月11日 00:14, Stefan Hajnoczi wrote:
>>>
>> Looks not, if I read the code correctly, vhost-pci has a device
>> implementation in qemu, and in slave VM it only have a vhost-pci-net driver.
> You are right that the current "[PATCH v3 0/7] Vhost-pci for inter-VM
> communication" does not reach this goal yet.  The patch series focusses
> on a subset of vhost-user-net for poll mode drivers.
>
> But the goal is to eventually let VMs implement any vhost device type.
> Even if Wei, you, or I don't implement scsi, for example, someone else
> should be able to do it based on vhost-pci or virtio-vhost-user.
>
> Wei: Do you agree?

Yes. I agree it would be good to have only one device, which performs 
the fundamental emulation (e.g. expose master VM memory via a bar) that 
is common to all the types (net, scsi..). The device should be able to 
tell the driver which type the master side is. So, at the QEMU device 
layer, we don't need to distinguish between device types, while 
regarding the driver, each device type has its own specific driver 
implementation, which is based on a common vhost-pci driver layer.


Best,
Wei
