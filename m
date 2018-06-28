Received: from eggs.gnu.org ([2001:4830:134:3::10]:57938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYcWV-0001Lm-CX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYcWS-0001KT-3E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYcWR-0001Im-SP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB986C004EB8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 19:24:02 +0000 (UTC)
Date: Thu, 28 Jun 2018 16:23:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180628192353.GG7451@localhost.localdomain>
References: <20180628154502.GO3513@redhat.com> <20180628185938.GC2538@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628185938.GC2538@work-vm>
Subject: Re: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Thu, Jun 28, 2018 at 07:59:38PM +0100, Dr. David Alan Gilbert wrote:
[...]
> > An application like virt-manager which wants a simple UI can forever be
> > happy simply giving users a list of bare CPU model names, and allowing
> > libvirt / QEMU to automatically expand to the best versioned model for
> > their host.
> > 
> > An application like oVirt/OpenStack which wants direct control can allow
> > the admin to choice if a bare name, or explicitly picking a versioned name
> > if they need to cope with possibility of outdated hosts.
> 
> I fear people are going to find this out the hard way, when they add
> a new system into their cluster, a little bit later it gets a VM started
> on it, and then they try and migrate it to one of the older machines.
> 
> Now if there was something that could take the CPU defintions from all
> the machines in the cluster and tell it which to use/which problems
> they had then that might make sense.  It would be best for each
> higher level not to reinvent that.

I think QEMU already provides enough info to allow that to be
implemented.  I'm not sure sure if the libvirt API already
provides all the info needed for this (I think it does).


> 
> Would you restrict the combinations to cut down the test matrix - e.g.
> not allow Haswell-3.0.0 on anything prior to a 2.12 machine type?

Not sure if it would be worth the extra complexity: we would need
an interface to tell libvirt which CPU models are usable on which
machine-types.

But a generic mechanism to tell libvirt which devices are allowed
on each machine-type would very interesting to have, anyway.

-- 
Eduardo
