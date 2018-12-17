Received: from eggs.gnu.org ([2001:4830:134:3::10]:58969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxgP-0000Gl-QQ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxgL-00051A-HM
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:32:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxgJ-0004t8-M7
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:31:56 -0500
Date: Mon, 17 Dec 2018 20:31:42 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181217183142.GA18512@lap1>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
	<20181217081047.2039-12-yuval.shaia@oracle.com>
	<0443a8ef-f94a-0d1c-56ff-9c134ba6d7ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0443a8ef-f94a-0d1c-56ff-9c134ba6d7ff@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

On Mon, Dec 17, 2018 at 10:02:19AM -0600, Eric Blake wrote:
> On 12/17/18 2:10 AM, Yuval Shaia wrote:
> > The control over the RDMA device's GID table is done by updating the
> > device's Ethernet function addresses.
> > Usually the first GID entry is determined by the MAC address, the second
> > by the first IPv6 address and the third by the IPv4 address. Other
> > entries can be added by adding more IP addresses. The opposite is the
> > same, i.e. whenever an address is removed, the corresponding GID entry
> > is removed.
> > 
> > The process is done by the network and RDMA stacks. Whenever an address
> > is added the ib_core driver is notified and calls the device driver
> > add_gid function which in turn update the device.
> > 
> > To support this in pvrdma device we need to hook into the create_bind
> > and destroy_bind HW commands triggered by pvrdma driver in guest.
> > Whenever changed is made to the pvrdma port's GID table a special QMP
> 
> s/changed/a change/
> 
> > messages is sent to be processed by libvirt to update the address of the
> 
> s/messages/message/

Thanks!
Will fix and send v8

> 
> > backend Ethernet device.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> > ---
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
