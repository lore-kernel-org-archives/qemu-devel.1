Received: from eggs.gnu.org ([2001:4830:134:3::10]:54252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPQJ6-0000kH-6o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPQJ4-0000Y8-Uo
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:27:44 -0400
Date: Mon, 26 Jun 2017 10:27:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170626092735.GA2136@work-vm>
References: <20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
	<CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
	<20170622172555.GE2100@work-vm>
	<20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
	<20170622175012.GF2100@work-vm>
	<fb2c7124-2d3f-6684-e2f2-265bfb3eb6da@redhat.com>
	<CAFEAcA-A=UrkKjLmVOcFA_d4rMW1AJwGffE4r2Uy6fw++XFF6w@mail.gmail.com>
	<20170622183457.GG2100@work-vm>
	<20170622212332.38f4b434@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622212332.38f4b434@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Separate function types from opaque types
 in include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

* Greg Kurz (groug@kaod.org) wrote:
> On Thu, 22 Jun 2017 19:34:58 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > On 22 June 2017 at 19:08, Thomas Huth <thuth@redhat.com> wrote:  
> > > > On 22.06.2017 19:50, Dr. David Alan Gilbert wrote:  
> > > >> Could do; I'm just not finding tiny header files with one or
> > > >> two entries each that useful.  
> > > 
> > > Well, it means that the bulk of code that doesn't care about the
> > > types doesn't get its compilation fractionally slowed by having
> > > to parse the typedef anyway. In general I think we're drifting
> > > towards "have each .c file get fewer things automatically" rather
> > > than otherwise (eg more finely focused files rather than stuffing
> > > everything into qemu-common.h).  
> > 
> > At the cost of things getting fractionally slower by including lots
> > more tiny headers.
> > 
> > I generally agree in the case where there's a useful chunk,
> > but when it's down to one or two definitions I don't see the point.
> > 
> > > > Do we really need these function typedefs at all? IMHO it's quite ugly
> > > > to hide such things in a typedef unless it is really necessary (and in
> > > > this case, it does not seem to be really necessary since it is only used
> > > > in a few places). So what about simply removing the typedefs in this case?  
> > > 
> > > I find function typedefs much more readable than having the
> > > function-types inline in function arguments and the like.
> > > 
> > > This is all fairly rapidly heading into bikeshed territory
> > > though -- in the final analysis I don't think it matters
> > > much what we do.  
> > 
> > Agreed.
> > 
> 
> Last question for my own comprehension.
> 
> I can't think of a case where we would do something like:
> 
>    some_vmsd->load_state_old = some_se->ops->load_state;
> 
> Does it make sense for VMStateDescription::load_state_old and SaveVMHandlers::load_state
> to be of the same type ?

(I think this is what we discussed on irc)
There's only a few _old's and they're the same interface as the
non-_old's,   the only difference is the range of version_id's they're
prepared to take.

Dave

> > Dave
> > 
> > > thanks
> > > -- PMM  
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
