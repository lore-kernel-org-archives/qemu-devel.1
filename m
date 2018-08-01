Received: from eggs.gnu.org ([2001:4830:134:3::10]:39563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkr1K-00038H-4l
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkr1H-0001B8-03
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:18:30 -0400
Date: Wed, 1 Aug 2018 15:18:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180801151821.324f06d0.cohuck@redhat.com>
In-Reply-To: <20180801151123.5a52e0e6.cohuck@redhat.com>
References: <20180724092413.5770-1-cohuck@redhat.com>
	<20180801102127.GF14577@lemon.usersys.redhat.com>
	<20180801145451.2e640621.cohuck@redhat.com>
	<20180801151123.5a52e0e6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] s390x: remove 's390-squash-mcss'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-s390x@nongnu.org, Xiao Feng Ren <renxiaof@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Wed, 1 Aug 2018 15:11:23 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 1 Aug 2018 14:54:51 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 1 Aug 2018 18:21:27 +0800
> > Fam Zheng <famz@redhat.com> wrote:
> >   
> > > On Tue, 07/24 11:24, Cornelia Huck wrote:    
> > > > diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> > > > index a02d708239..1bd6c8b458 100644
> > > > --- a/hw/s390x/css-bridge.c
> > > > +++ b/hw/s390x/css-bridge.c
> > > > @@ -106,7 +106,6 @@ VirtualCssBus *virtual_css_bus_init(void)
> > > >      /* Create bus on bridge device */
> > > >      bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
> > > >      cbus = VIRTUAL_CSS_BUS(bus);      
> > > 
> > > Not used now?
> > > 
> > > Fam    
> > 
> > Indeed, we can ditch the cbus variable.  
> 
> ...or not :) We still need it for the return value, which is processed
> in ccw_init(). We could change the return code of the function to
> BusState, but I'm not sure it is worth the hassle.

...but we can indeed get rid of the cbus and qbus variables in
s390_ccw_realize().
