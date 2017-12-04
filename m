Received: from eggs.gnu.org ([2001:4830:134:3::10]:52912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuwO-0006uD-I8
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuwK-0004bV-JG
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:54:04 -0500
Date: Mon, 4 Dec 2017 18:53:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204185352.39f2b131.cohuck@redhat.com>
In-Reply-To: <8904d9e3-990f-46e1-49d1-9d37533d025e@redhat.com>
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-6-david@redhat.com>
	<20171204182244.2b789717.cohuck@redhat.com>
	<8904d9e3-990f-46e1-49d1-9d37533d025e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 5/5] s390x/tcg: wire up STORE
 CHANNEL REPORT WORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon, 4 Dec 2017 18:34:36 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.12.2017 18:22, Cornelia Huck wrote:
> > On Mon,  4 Dec 2017 13:55:05 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> We somehow missed that, new kernels require it.  
> > 
> > Why _new_ kernels? I think we have unconditionally issued stcrw since
> > back in 2.2?  
> 
> Okay, the problem is then rather related to my setup. No ccw devices ->
> no stcrw.
> 
> How could we ever add ccw devices to a TCG guest then?

Hotplug never worked before your patches. Coldplug does not create
machine checks and thus does not trigger the guest to do STCRW. (Only
STSCH, in keeping with "all channel I/O acronyms look the same".)
