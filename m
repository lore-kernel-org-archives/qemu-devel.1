Received: from eggs.gnu.org ([2001:4830:134:3::10]:45643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb7ls-0002x8-MA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb7lo-00076n-Lr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:10:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fb7lo-00076T-GT
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:10:16 -0400
Date: Thu, 5 Jul 2018 20:10:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180705200659-mutt-send-email-mst@kernel.org>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
	<20180705164343.GE16293@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705164343.GE16293@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, jferlan@redhat.com, ben@skyportsystems.com

On Thu, Jul 05, 2018 at 05:43:43PM +0100, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 04:20:33PM +0200, Laszlo Ersek wrote:
> > QEMU does the right thing. If other hypervisors don't do this -- while
> > still taking and displaying the value in UUID / GUID textual format --,
> > they are wrong. The VMGENID spec from Microsoft
> > <http://go.microsoft.com/fwlink/?LinkId=260709> specifically mentions
> > "GUID".
> 
> The MSFT spec does mention GUID, but it seems to me that it's only
> using GUID as an incidental example -- ie. that you might use the VM
> Generation ID to generate a GUID.  Outside that example it
> consistently refers to the VM Gen ID as a 128-bit integer.  It also
> says that it could be used as a "high entropy random data source",
> which is not in fact true if it's a UUID.
> 
> It has to be said that after reading the spec again [the MSFT spec,
> not qemu's spec] and what other hypervisors are doing, I'm not sure
> qemu is doing the right thing here.
> 
> Rich.

So right now we have a "GUID" property.
We could always add an alternative property for people who want
to treat the ID as an integer. Would that address the issue?

> -- 
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> libguestfs lets you edit virtual machines.  Supports shell scripting,
> bindings from many languages.  http://libguestfs.org
