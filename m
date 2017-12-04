Received: from eggs.gnu.org ([2001:4830:134:3::10]:35540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLmxN-0005lO-Vv
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLmxL-0006D7-C3
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:22:33 -0500
Date: Mon, 4 Dec 2017 10:22:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204102220.31fce015.cohuck@redhat.com>
In-Reply-To: <389e2efe-cbc5-8a78-e009-cd330d4ede6a@linux.vnet.ibm.com>
References: <20171128134648.21530-1-cohuck@redhat.com>
	<6513d1c5-032e-b9d0-3dab-f2d0bd337ae2@linux.vnet.ibm.com>
	<20171128152718.229a20fe.cohuck@redhat.com>
	<bf78fad3-b6b2-bf82-2625-477233adb6cf@linux.vnet.ibm.com>
	<389e2efe-cbc5-8a78-e009-cd330d4ede6a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] s390x: cut down on unattached
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com

On Fri, 1 Dec 2017 15:41:21 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 11/28/2017 04:21 PM, Halil Pasic wrote:
> [..]
> >>> Otherwise at first glance both patches seem sane.  
> >>
> >> Can I count this as an ack, or do you plan to do more review?
> >>  
> > 
> > Yes I was planning to give it another look. And I do already
> > have questions. Isn't the QOM composition tree API? I mean
> > let's assume the QMP commands working on this tree are not completely
> > useless. How is client code (management software) supposed to work,
> > assumed it can rely on paths of e.g. properties being stable. Just
> > imagine we had this default-cssid property (for the sake of the
> > argument, not like we want it) on the css bridge.  
> 
> Ping! I would like to get this clarified before proceeding with reviewing
> this series.

[It might be helpful to not drop cc:s.]

I don't think we really want a static tree. As long as the devices are
locateable, it should be fine.

> 
> > 
> > Now if the composition tree is API then these can only be bug fixes
> > (IMHO).
> > 
> > There are also other oddities I've spotted. My idea was to put
> > this composition tree discussion on hold until the vfio-ccw stuff
> > is sorted out. I would certainly like to build a better understanding.
> > 
> > Halil
> >   
> 
> [..]
> 
> 
