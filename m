Received: from eggs.gnu.org ([2001:4830:134:3::10]:43681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYvLh-0006cU-2C
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYvLb-0002HN-JB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gYvLb-0002Gn-D1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:02:23 -0500
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
	<20181217081047.2039-12-yuval.shaia@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0443a8ef-f94a-0d1c-56ff-9c134ba6d7ff@redhat.com>
Date: Mon, 17 Dec 2018 10:02:19 -0600
MIME-Version: 1.0
In-Reply-To: <20181217081047.2039-12-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 11/23] hw/pvrdma: Add support to allow
 guest to configure GID table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

On 12/17/18 2:10 AM, Yuval Shaia wrote:
> The control over the RDMA device's GID table is done by updating the
> device's Ethernet function addresses.
> Usually the first GID entry is determined by the MAC address, the second
> by the first IPv6 address and the third by the IPv4 address. Other
> entries can be added by adding more IP addresses. The opposite is the
> same, i.e. whenever an address is removed, the corresponding GID entry
> is removed.
> 
> The process is done by the network and RDMA stacks. Whenever an address
> is added the ib_core driver is notified and calls the device driver
> add_gid function which in turn update the device.
> 
> To support this in pvrdma device we need to hook into the create_bind
> and destroy_bind HW commands triggered by pvrdma driver in guest.
> Whenever changed is made to the pvrdma port's GID table a special QMP

s/changed/a change/

> messages is sent to be processed by libvirt to update the address of the

s/messages/message/

> backend Ethernet device.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> ---


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
