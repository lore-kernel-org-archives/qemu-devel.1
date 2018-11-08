Received: from eggs.gnu.org ([2001:4830:134:3::10]:55667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKiH6-0004ET-Jy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKiH2-0000sR-Kj
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:15:00 -0500
Date: Thu, 8 Nov 2018 12:14:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108121446.4f1d09dc.cohuck@redhat.com>
In-Reply-To: <b38c2f96-46ed-db0f-86b7-dc458ac80ee8@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-5-david@redhat.com>
	<b114a7d0-1e56-2294-484c-f4143cfd989e@redhat.com>
	<20181105134118.01fef179.cohuck@redhat.com>
	<b38c2f96-46ed-db0f-86b7-dc458ac80ee8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/4] s390x/zpci: properly fail if the
 zPCI device cannot be created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S .
	Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>

On Mon, 5 Nov 2018 13:46:10 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 05.11.18 13:41, Cornelia Huck wrote:
> > On Mon, 5 Nov 2018 13:04:04 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 2018-11-05 12:03, David Hildenbrand wrote:  
> >>> Right now, errors during realize()/pre_plug/plug of the zPCI device
> >>> would result in QEMU crashing instead of failing nicely when creating
> >>> a zPCI device for a PCI device.  
> > 
> > Yeah, failing instead of crashing is better :)
> > 
> > Is there any way we can trigger this problem for testing?  
> 
> I guess trying to add more PCI devices (with implicit zPCI devices
> getting created) than we have zPCI slots should be enough. So making
> e.g. s390_pci_alloc_idx() fail.
> 
> (FH_MASK_INDEX = 0x0000ffff implies 65536 devices, which is not really
> easy to test ;) )
> 

I was hoping for an easy test. Oh well :)
