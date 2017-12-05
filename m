Received: from eggs.gnu.org ([2001:4830:134:3::10]:42203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMA5T-00039Z-Pd
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMA5P-0003gO-RZ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:04:27 -0500
Date: Tue, 5 Dec 2017 11:04:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205110415.64d7e074.cohuck@redhat.com>
In-Reply-To: <e33bd227-4cb2-2e9b-9ebd-e498ec4aafe7@redhat.com>
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-6-david@redhat.com>
	<20171204182244.2b789717.cohuck@redhat.com>
	<8904d9e3-990f-46e1-49d1-9d37533d025e@redhat.com>
	<20171204185352.39f2b131.cohuck@redhat.com>
	<51a752c1-994e-e57a-8fce-1e2afcc2092c@redhat.com>
	<20171204185833.64a68453.cohuck@redhat.com>
	<e33bd227-4cb2-2e9b-9ebd-e498ec4aafe7@redhat.com>
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

On Mon, 4 Dec 2017 19:37:26 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.12.2017 18:58, Cornelia Huck wrote:
> > On Mon, 4 Dec 2017 18:56:00 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 04.12.2017 18:53, Cornelia Huck wrote:  
> >>> On Mon, 4 Dec 2017 18:34:36 +0100
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> On 04.12.2017 18:22, Cornelia Huck wrote:    
> >>>>> On Mon,  4 Dec 2017 13:55:05 +0100
> >>>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>>       
> >>>>>> We somehow missed that, new kernels require it.      
> >>>>>
> >>>>> Why _new_ kernels? I think we have unconditionally issued stcrw since
> >>>>> back in 2.2?      
> >>>>
> >>>> Okay, the problem is then rather related to my setup. No ccw devices ->
> >>>> no stcrw.
> >>>>
> >>>> How could we ever add ccw devices to a TCG guest then?    
> >>>
> >>> Hotplug never worked before your patches. Coldplug does not create
> >>> machine checks and thus does not trigger the guest to do STCRW. (Only
> >>> STSCH, in keeping with "all channel I/O acronyms look the same".)
> >>>     
> >>
> >> But booting Fedora 26/27 without any involved hotplugs (therefore
> >> machine checks) triggers a STCRW.
> >>
> >> That's how I originally found it. (I started playing with machine checks
> >> after I had fedora 26/27 running)
> >>  
> > 
> > Confused. Do you have a backtrace? (Guest/host)
> >   
> 
> Unfortunately not. Strange, I just tried to reproduce but can't trigger
> it. Maybe aside effect from the other BUGs I have been fixing :)
> 
> So I'll just rephrase this to "CRW machine check handling requires STCRW."
> 

Yeah, let's do that.
