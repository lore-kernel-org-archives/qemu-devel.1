Received: from eggs.gnu.org ([209.51.188.92]:37000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h2Bf6-0005pq-4p
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h2Bf5-0000Oj-H0
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:28 -0500
Date: Fri, 8 Mar 2019 10:19:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190308101923.0082ca46.cohuck@redhat.com>
In-Reply-To: <4410deed-a325-cbe2-382a-bb08ab6490d5@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-11-git-send-email-jjherne@linux.ibm.com>
	<20190304192522.138639d3.cohuck@redhat.com>
	<4410deed-a325-cbe2-382a-bb08ab6490d5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/16] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Thu, 7 Mar 2019 14:25:00 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 3/4/19 1:25 PM, Cornelia Huck wrote:
> > On Fri,  1 Mar 2019 13:59:30 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> >> +    consume_io_int();
> >> +
> >> +    /* collect status */
> >> +    rc = tsch(schid, irb);
> >> +    if (rc) {
> >> +        print_int("tsch failed with rc=", rc);
> >> +    }  
> > 
> > Hm. The whole code flow relies on the fact that not only no more than
> > one cpu is enabled for I/O interrupts, but also only one subchannel.
> > Otherwise, you could get an interrupt for another subchannel, which
> > would be the only way you'd get cc 1 on the tsch for this subchannel
> > here (no status pending). Maybe peek at the interruption information
> > stored into the lowcore first?
> > 
> > Won't be a problem with the code as it is now, though, AFAICS.
> >   
> Agreed, voting to leave as is. Perhaps a comment to explain that we rely on only one 
> "Active" i/o device?

Yes, sounds good.
