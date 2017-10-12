Received: from eggs.gnu.org ([2001:4830:134:3::10]:43518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2fva-0001qt-L8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2fvU-0003jQ-Mo
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:01:42 -0400
Date: Thu, 12 Oct 2017 18:01:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171012180131.6871342d@nial.brq.redhat.com>
In-Reply-To: <20171012172051.0c90ce58@bahia.lab.toulouse-stg.fr.ibm.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-14-git-send-email-imammedo@redhat.com>
	<20171010092946.02beddd2@bahia.lan> <20171012143400.555ba3c0@bahia>
	<20171012165839.6af44578@nial.brq.redhat.com>
	<20171012172051.0c90ce58@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 13/24] ppc: spapr: define
 core types statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 12 Oct 2017 17:20:51 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu, 12 Oct 2017 16:58:39 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 12 Oct 2017 15:10:30 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >   
> > > On Tue, 10 Oct 2017 09:29:46 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >     
> > > > On Mon,  9 Oct 2017 21:51:00 +0200
> > > > Igor Mammedov <imammedo@redhat.com> wrote:
> > > >       
> > > > > spapr core type definition doesn't have any fields that
> > > > > require it to be defined at runtime. So replace code
> > > > > that fills in TypeInfo at runtime with static TypeInfo
> > > > > array that does the same at complie time.
> > > > > 
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > > v2:
> > > > >   - fix rebase conflict: add newly added power9_v2 core
> > > > > ---        
> > > > 
> > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > >       
> > > 
> > > Oops, this patch causes a regression when you try to pass a sPAPR core to
> > > a non-pseries machine.
> > > 
> > > Without this patch:
> > > 
> > > $ ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core 
> > > qemu-system-ppc64: -device host-spapr-cpu-core:
> > >  'host-spapr-cpu-core' is not a valid device model name
> > > 
> > > With this patch:
> > > 
> > > $ ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core 
> > > **
> > > ERROR:qom/object.c:217:object_type_get_instance_size:
> > >  assertion failed: (type != NULL)
> > > Aborted    
> > there shouldn't be type host-spapr-cpu-core with this patch since you don't have -enable-kvm on CLI
> > maybe you are talking about
> >     [PATCH v2 15/24] ppc: spapr: register 'host' core type  along with the rest of core types
> >   
> 
> Oops you're right, I replied to the wrong mail... of course, I meant the
> following commit in David's staging tree:
> 
> https://github.com/dgibson/qemu/commit/c18165144076cef0c17206f5231cf9787c944037

fixed by:
  [PATCH v2 14/24] fixup! ppc: spapr: use cpu type name  directly

also I've stumbled upon another issue, fixup also posted:

  [PATCH v2 18/24] fixup! ppc: spapr: use generic  cpu_model parsing

fixup well localized and didn't cause conflicts so there is no need to respin series
