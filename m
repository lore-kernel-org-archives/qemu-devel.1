Received: from eggs.gnu.org ([2001:4830:134:3::10]:49850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQsoH-0006DN-Bz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQsoD-0008Qi-8r
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:10:29 -0400
Date: Thu, 7 Jun 2018 13:10:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180607131018.577a2219.cohuck@redhat.com>
In-Reply-To: <3f81742d-4ce8-4c3f-643d-44745ed88374@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-2-david@redhat.com>
	<20180604133853.7c0f7933.cohuck@redhat.com>
	<a26f4c5e-59b2-078d-19a3-e73dbece67c1@redhat.com>
	<20180604141434.508e2f55.cohuck@redhat.com>
	<3f81742d-4ce8-4c3f-643d-44745ed88374@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/7] s390x/tod: factor out
 TOD into separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Collin L . Walling" <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Thu, 7 Jun 2018 12:49:23 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 04.06.2018 14:14, Cornelia Huck wrote:
> > On Mon, 4 Jun 2018 14:00:43 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 04.06.2018 13:38, Cornelia Huck wrote:  
> >>> On Fri, 25 May 2018 13:37:02 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> Let's treat this like a separate device. TCG will have to store the
> >>>> actual state/time later on.
> >>>>
> >>>> Include cpu-qom.h in kvm_s390x.h (due to S390CPU) to compile tod-kvm.c.    
> >>>
> >>> Can't you include it in tod-kvm.c instead? Why was it not needed before?    
> >>
> >> Guess I can, kvm_s390x.h looks to me like the right place, as S390CPU is
> >> used in there.
> >>
> >> All other users include "cpu.h" already, so it isn't needed.  
> > 
> > Hm, and for kvm_s390_irq, this file is using a forward declaration,
> > which would likely be more awkward for this structure.  
> 
> I remember that we wanted to use cpu-qom.h for this typedef fun, that's
> why I decided to do it this way.
> 
> > 
> > Header dependencies are always fun :)
> >   
> 
> So what do you suggest? Thanks!
> 

Let's go with cpu-qom.h for this, then.
