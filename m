Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e47tp-0008AT-DW
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e47tj-0003Ro-JB
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:05:53 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:60026)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e47tj-0003QM-71
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:05:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2017 03:05:43 +1100
From: geoff@hostfission.com
In-Reply-To: <4d957ed9-0430-927c-ec78-672c39f11682@redhat.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<4d957ed9-0430-927c-ec78-672c39f11682@redhat.com>
Message-ID: <f943ff3537236d38b711a907cdb6aed4@hostfission.com>
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 2017-10-17 02:20, Eric Blake wrote:
> On 10/15/2017 04:32 AM, geoff--- via Qemu-devel wrote:
>> Hi All,
>> 
>> I am writing some code that needs to share a block of ram between a
>> Windows guest and Linux host. For this I am using the ivshmem device 
>> and
>> I have written a very primitive driver for windows that allows a 
>> single
>> application to request to memory map the pci bar (shared memory) into
>> the program's context using DeviceIoControl.
> 
> Note that upstream support of ivshmem is rather lackluster.  Very 
> often,
> the first question in response to someone saying "I need ivshmem", is
> "Why? and can we accomplish the same task using a better device
> instead?"  Without knowing the full use case, it's hard to argue that
> ivshmem is the right device to fit the use case.

Noted, but I believe that this is a very useful feature for even hacking
about with VMs before going as far as to write an entire driver for some
simple once use code.

There are some future personal projects I can see this being very handy
for into the future.

> 
> There have been efforts to propose a better specified and better
> structured replacement for ivshmem, such as vhost-pci, but I'm not sure
> what status those patches are in, or if it would be a better fit for
> your needs.

My needs are rather specific, I am capturing the desktop on a VM with
passthrough VGA using nVidia NvFBC and mapping it to the host for
extremely low latency high quality display. Unfortunately the use of
NvFBC is limited to high end professional cards such as the GRID. As 
such
I don't see it warranting a specific driver for my niche use.

I also lack the time to learn how to write a virtual PCI device for QEMU
that would be able to accommodate this exact feature. I would also need
to acquire a signing certificate to sign the driver which is a cost I 
can
not justify.

In comparison writing a windows interface to the existing IVSHMEM device
is not such a huge feat. In fact, I have already got a prototype driver
as part of my local virtio-win fork.

-Geoff
