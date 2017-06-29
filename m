Received: from eggs.gnu.org ([2001:4830:134:3::10]:53608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dQS9I-00053T-1L
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 01:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dQS9E-0004E0-2Z
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 01:37:52 -0400
Message-ID: <1498714660.30519.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 29 Jun 2017 15:37:40 +1000
In-Reply-To: <20170628184137.699a4f9f@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
	<a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
	<20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
	<78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
	<20170628184137.699a4f9f@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, sbobroff@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On Wed, 2017-06-28 at 18:41 +0200, Greg Kurz wrote:
> On Wed, 28 Jun 2017 18:18:06 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
> > On 28/06/2017 13:59, Greg Kurz wrote:
> > > On Wed, 28 Jun 2017 12:23:06 +0200
> > > Cédric Le Goater <clg@kaod.org> wrote:
> > >   
> > > > On 06/28/2017 11:18 AM, Laurent Vivier wrote:  
> > > > > On 28/06/2017 11:11, Cédric Le Goater wrote:    
> > > > > > On 06/28/2017 10:18 AM, David Gibson wrote:    
> > > > > > > On Wed, Jun 28, 2017 at 09:09:24AM +0200, Thomas Huth
> > > > > > > wrote:    
> > > > > > > > On 28.06.2017 03:42, joserz@linux.vnet.ibm.com
> > > > > > > > wrote:    
> > > > > > > > > On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent
> > > > > > > > > Vivier wrote:    
> > > > > > > > > > On 23/06/2017 11:21, David Gibson wrote:    
> > > > > > > > > > > On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas
> > > > > > > > > > > Huth wrote:    
> > > > > > > > > > > > On 22.06.2017 13:26, Laurent Vivier wrote:    
> > > > > > > > > > > > > CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this
> > > > > > > > > > > > > is the POWER9 v1.0.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > When we run qemu on a POWER9 DD1 host, we
> > > > > > > > > > > > > must use either
> > > > > > > > > > > > > "-cpu host" or "-cpu POWER9", but in the
> > > > > > > > > > > > > latter case it fails with
> > > > > > > > > > > > > 
> > > > > > > > > > > > >     Unable to find sPAPR CPU Core definition
> > > > > > > > > > > > > 
> > > > > > > > > > > > > because POWER9 DD1 doesn't appear in the list
> > > > > > > > > > > > > of known CPUs.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > This patch fixes this by defining POWER9_v1.0
> > > > > > > > > > > > > with POWER9 DD1
> > > > > > > > > > > > > PVR instead of CPU_POWERPC_POWER9_BASE.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Signed-off-by: Laurent Vivier <lvivier@redhat
> > > > > > > > > > > > > .com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  target/ppc/cpu-models.c | 2 +-
> > > > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-
> > > > > > > > > > > > > )
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/target/ppc/cpu-models.c
> > > > > > > > > > > > > b/target/ppc/cpu-models.c
> > > > > > > > > > > > > index 4d3e635..a22363c 100644
> > > > > > > > > > > > > --- a/target/ppc/cpu-models.c
> > > > > > > > > > > > > +++ b/target/ppc/cpu-models.c
> > > > > > > > > > > > > @@ -1144,7 +1144,7 @@
> > > > > > > > > > > > >      POWERPC_DEF("970_v2.2",      CPU_POWERPC
> > > > > > > > > > > > > _970_v22,                970,
> > > > > > > > > > > > >                  "PowerPC 970 v2.2")
> > > > > > > > > > > > >  
> > > > > > > > > > > > > -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC
> > > > > > > > > > > > > _POWER9_BASE,            POWER9,
> > > > > > > > > > > > > +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC
> > > > > > > > > > > > > _POWER9_DD1,             POWER9,
> > > > > > > > > > > > >                  "POWER9 v1.0")
> > > > > > > > > > > > >  
> > > > > > > > > > > > >      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC
> > > > > > > > > > > > > _970FX_v10,              970,
> > > > > > > > > > > > >    
> > > > > > > > > > > > 
> > > > > > > > > > > > I think this also makes sense for running in
> > > > > > > > > > > > TCG mode to get a valid
> > > > > > > > > > > > real PVR there.    
> > > > > > > > > > > 
> > > > > > > > > > > I'm not so convinced.
> > > > > > > > > > > 
> > > > > > > > > > > IIUC, this will make TCG default (for now) to a
> > > > > > > > > > > DD1 POWER9.  That's a)
> > > > > > > > > > > probably not what anyone wants - who'd select a
> > > > > > > > > > > buggy prototype and b)
> > > > > > > > > > > not accurate - TCG does not implement DD1's
> > > > > > > > > > > bugs.    
> > > > > > > > > > 
> > > > > > > > > > According to the POWER8 user manual (I didn't fine
> > > > > > > > > > the POWER9 one):
> > > > > > > > > > 
> > > > > > > > > > "3.6.3.1 Processor Version Register (PVR)
> > > > > > > > > > 
> > > > > > > > > > The processor revision level (PVR[16:31]) starts at
> > > > > > > > > > x‘0100’, indicating
> > > > > > > > > > revision ‘1.0’. As revisions are made, bits [29:31]
> > > > > > > > > > will indicate minor
> > > > > > > > > > revisions. Similarly, bits [20:23] indicate major
> > > > > > > > > > changes."
> > > > > > > > > > 
> > > > > > > > > > POWER9 DD1 PVR is 0x004E0100, so this is really
> > > > > > > > > > version 1.0 of the POWER9.
> > > > > > > > > > 
> > > > > > > > > > Perhaps we can define POWER9_v1.0 as
> > > > > > > > > > CPU_POWERPC_POWER9_DD1, and
> > > > > > > > > > introduce a POWER9_v0.0 set to
> > > > > > > > > > CPU_POWERPC_POWER9_BASE and define it as
> > > > > > > > > > the default one?    
> > > > > > > > > 
> > > > > > > > > I like the suggestion to set a v0.0 to
> > > > > > > > > CPU_POWERPC_POWER9_BASE. But, I
> > > > > > > > > think we could have only that option, removing the
> > > > > > > > > CPU_POWERPC_POWER9_DD1 entry.    
> > > > > > > > 
> > > > > > > > I really dislike the idea of having a CPU called "v0.0"
> > > > > > > > ... we do not
> > > > > > > > have this for any other CPU generation, and it sounds
> > > > > > > > like it could be
> > > > > > > > very confusing for the users (you'd need to document
> > > > > > > > somewhere what the
> > > > > > > > v0.0 exactly means). If we really want to go this way,
> > > > > > > > I think we should
> > > > > > > > name it "POWER9-generic" or "PowerISA-3.0" or something
> > > > > > > > similar instead.
> > > > > > > > 
> > > > > > > > Or does somebody already know the exact PVR for DD2? If
> > > > > > > > so, we could
> > > > > > > > simply add a POWER9_v2.0 CPU already and let the POWER9
> > > > > > > > alias point to
> > > > > > > > that version instead.    
> > > > > > > 
> > > > > > > Yes, I think that's a better idea.  I don't know the DD2
> > > > > > > PVR, but I'm
> > > > > > > pretty sure we should be able to find out from someone at
> > > > > > > IBM.
> > > > > > > 
> > > > > > > I've CCed Sam & Suraj - can you ask Mikey or someone what
> > > > > > > the PVR
> > > > > > > value for DD2.0 will be?    
> > > > > > 
> > > > > > I would expect something like :
> > > > > > 
> > > > > >  0x200D104980000000UL; /* P9 Nimbus DD2.0 */    
> > > > > 
> > > > > 
> > > > > I would expect something like 0x004Exxxx.    
> > > > 
> > > > ah yes, I am mistaking the PVR and the CFAM ID. 
> > > > 
> > > > C. 
> > > >    
> > > 
> > > According to https://patchwork.ozlabs.org/patch/776052/
> > > 
> > > POWER9 DD2's PVR is expected to be 0x004e1200
> > >  
> > 
> > So, perhaps I can send a v2 of the patch with POWER9_v1.0 set to
> > DD1
> > PVR, and POWER9_v2.0 set to DD2 PVR?
> > 
> 
> FWIW Thomas suggested to do just that and David agreed it was "a
> better idea".

I assume we would have just -cpu POWER9 alias to DD2?

We probably need to have a nice abort if someone tries to run TCG with
DD1, I'm not sure where it will break but I'm fairly sure it won't
boot.

That makes the assumption that DD2 doesn't require any work arounds
which TCG can't handle.

I think the absence of -cpu on the CLI should give -cpu host for KVM-
HV. FWIW currently TCG defaults to POWER8, so I guess we have to decide
if/when we want to bump that to POWER9.

> 
> > Thanks,
> > Laurent
> > 
> > 
> 
> 
