Received: from eggs.gnu.org ([2001:4830:134:3::10]:35063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJIxe-0000cb-J7
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJIxa-0004w9-M3
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:56:34 -0500
Date: Mon, 27 Nov 2017 13:56:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171127135624.28052dc5.cohuck@redhat.com>
In-Reply-To: <8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
	<76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
	<20171124134650.46665791.cohuck@redhat.com>
	<7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
	<20171124142758.39d7726f.cohuck@redhat.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On Fri, 24 Nov 2017 17:39:04 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 11/24/2017 05:15 PM, Cornelia Huck wrote:
> >>> In theory this should work. 
> >>>
> >>> In reality it seems more complicated. A per-device property is easy and can be
> >>> inspected on the command line (e.g. -device virtio-blk-ccw,help), while a new 
> >>> machine property would require to change the qemu help output and qemu-options 
> >>> file (which makes it visible for all architectures).    
> >> And then we have the fun of describing, that this property is weird, and can
> >> not be set, and it's value does not matter.  
> > Well, that's the case for both, no?  
> 
> 
> I don't think we have to document _device_ properites in qemu-options.hx
> I don't see any documented neither for virtio-ccw nor for vfio-ccw. The
> machine properties, on the contrary, are documented in this file.

But not having to describe it does not make it any less weird.

> > 
> > (Unless we simply make this a "default cssid" prop after all - then it
> > would be more than just a simple indication for libvirt...)
> >   
> 
> We are now talking about the "cssid-unrestricted" property. The default
> cssid is not something I would like to do any time soon.

What's so bad about this? As said above, I think it would be much more
useful. If libvirt can detect r/o vs. r/w for properties, we can simply
start out with a r/o variant now...
