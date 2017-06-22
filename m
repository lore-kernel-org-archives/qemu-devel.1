Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO6FL-0004jE-0O
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO6FG-0002Nd-U8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:50:22 -0400
Date: Thu, 22 Jun 2017 18:50:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170622175012.GF2100@work-vm>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
	<CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
	<20170622172555.GE2100@work-vm>
	<20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Juan Quintela <quintela@redhat.com>

* Greg Kurz (groug@kaod.org) wrote:
> On Thu, 22 Jun 2017 18:25:55 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > On 22 June 2017 at 18:03, Juan Quintela <quintela@redhat.com> wrote:  
> > > > Greg Kurz <groug@kaod.org> wrote:  
> > > >> On Thu, 22 Jun 2017 17:14:08 +0100
> > > >> Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >>  
> > > >>> On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote:  
> > > >>> > Function types cannot reside in the same sorted list as opaque types since
> > > >>> > they may depend on a type which would be defined later.
> > > >>> >
> > > >>> > Of course, the same problem could arise if a function type depends on
> > > >>> > another function type with greater alphabetical order. Hopefully we
> > > >>> > don't have that at this time.  
> > > >>>
> > > >>> The other approach would be to put function types somewhere
> > > >>> else and leave typedefs.h for the simple 'opaque types
> > > >>> for structures' that it was started as.
> > > >>>
> > > >>> For instance we have include/qemu/fprintf-fn.h as a precedent.
> > > >>>  
> > > >>
> > > >> Indeed, and I'm not quite sure why Juan decided to put these types into
> > > >> typedefs.h instead of a dedicated header file in include/migration... is
> > > >> it only because it was the quickest fix ?  
> > > >
> > > > All other typedefs were defined there.  I can create a different include
> > > > file, but I think that is "overengineering", no?  They are typedefs,
> > > > just not of structs.  But I agree that they are the only ones.  
> > > 
> > > Well, the comment in the file says "opaque types so that device init
> > > declarations don't have to pull in all the real definitions", whereas
> > > the ones you've added aren't opaque types, they are the real
> > > definitions. They're also only used by a very small subset of .c
> > > files, whereas typedefs.h goes everywhere.  
> > 
> > mv fprintf-fn.f   fn-typedefs.h
> > 
> > move those two defs into that?
> > 
> 
> Wouldn't it be more appropriate to put them in a dedicated
> include/migration/handler-fn.h header included by both
> vmstate.h and register.h ?

Could do; I'm just not finding tiny header files with one or
two entries each that useful.

Dave

> > Dave
> > 
> > > thanks
> > > -- PMM  
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
