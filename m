Received: from eggs.gnu.org ([2001:4830:134:3::10]:49210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fATZB-0007cv-66
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fATZ6-00053o-CB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:59:05 -0400
Date: Mon, 23 Apr 2018 00:58:56 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <585131164.21709010.1524459536821.JavaMail.zimbra@redhat.com>
In-Reply-To: <e3b1e7df-55ae-520f-bd52-0fc94f6b8ed3@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<693523847.21650747.1524373124143.JavaMail.zimbra@redhat.com>
	<e3b1e7df-55ae-520f-bd52-0fc94f6b8ed3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


> > 
> > Hello,
> > 
> > This is good re-factoring and needed for 'virtio-pmem' as well to
> > reserve memory region in system address space.
> > 
> > I have tested this code with virtio-pmem and its working fine. Thank you
> > for the work.
> > 
> > I just have a small suggestion : when functions like(get_addr(),
> > get_plugged_size etc)
> > in the interface are not provided by derived class, Qemu crashes.
> > 
> > I think having a contract for must override functions with NULL check and
> > error
> > at the calling sites would be better?
> 
> I expect that all of these functions are implemented. It's a contract
> for devices that are mapped into address space. We might later have
> additional functions that might not be required to be provided and will
> be checked for NULL.
> 
> So for the current set of functions, I don't think it makes sense to
> make them optional.

o.k. that's reasonable.

Thanks,
Pankaj
> 
> Thanks!
> 
> > 
> > Thanks,
> > Pankaj
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
