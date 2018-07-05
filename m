Received: from eggs.gnu.org ([2001:4830:134:3::10]:58174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fbBLh-0000as-DC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fbBLd-0001Mm-FD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fbBLd-0001MO-AH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:59:29 -0400
Date: Thu, 5 Jul 2018 21:59:24 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180705205924.GQ1455@redhat.com>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
	<20180705164343.GE16293@redhat.com>
	<20180705200659-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705200659-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, jferlan@redhat.com, ben@skyportsystems.com

On Thu, Jul 05, 2018 at 08:10:15PM +0300, Michael S. Tsirkin wrote:
> On Thu, Jul 05, 2018 at 05:43:43PM +0100, Richard W.M. Jones wrote:
> > On Thu, Jul 05, 2018 at 04:20:33PM +0200, Laszlo Ersek wrote:
> > > QEMU does the right thing. If other hypervisors don't do this -- while
> > > still taking and displaying the value in UUID / GUID textual format --,
> > > they are wrong. The VMGENID spec from Microsoft
> > > <http://go.microsoft.com/fwlink/?LinkId=260709> specifically mentions
> > > "GUID".
> > 
> > The MSFT spec does mention GUID, but it seems to me that it's only
> > using GUID as an incidental example -- ie. that you might use the VM
> > Generation ID to generate a GUID.  Outside that example it
> > consistently refers to the VM Gen ID as a 128-bit integer.  It also
> > says that it could be used as a "high entropy random data source",
> > which is not in fact true if it's a UUID.
> > 
> > It has to be said that after reading the spec again [the MSFT spec,
> > not qemu's spec] and what other hypervisors are doing, I'm not sure
> > qemu is doing the right thing here.
> > 
> > Rich.
> 
> So right now we have a "GUID" property.
> We could always add an alternative property for people who want
> to treat the ID as an integer. Would that address the issue?

TBH I'm fairly relaxed about this and I don't want to put in any
effort to change anything.  As Dan says later in the thread, no data
is ever lost in the transformation.

I have now written a "128 bit int" -> "GUID" mangler for virt-v2v's
VM Generation ID handling code, so I'm happy enough.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
