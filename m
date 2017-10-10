Received: from eggs.gnu.org ([2001:4830:134:3::10]:60374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1yj4-0007tN-JL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1yj1-0001RA-Ez
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1yj1-0001Qv-8Q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BFFCC04AC6E
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:53:50 +0000 (UTC)
Date: Tue, 10 Oct 2017 14:53:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010175344.GH3246@localhost.localdomain>
References: <20171006132502.9191-1-ehabkost@redhat.com>
	<20171010134204.135a9425@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010134204.135a9425@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] isapc: Remove unnecessary migration
 compatibility code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Oct 10, 2017 at 01:42:04PM +0200, Igor Mammedov wrote:
> On Fri,  6 Oct 2017 10:25:02 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > We don't touch isapc when we change guest ABI and add new entries
> > to PC_COMPAT_* or new PCMachineClass compat flags.  This means
> > isapc never guaranteed guest ABI and cross-QEMU-version live
> > migration compatibility.  There's no point in keeping code for
> > kvm-pv-eoi and APIC ID compatibility in pc_init_isa().
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks!

Michael, do you prefer those pc*.c patches that touch only
CPU-related code to go always through your tree, or can I merge
them through x86-next without your Acked-by if it's appropriate?

> 
> > ---
> >  hw/i386/pc_piix.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 9ff79b1fd9..31646e63c4 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -378,8 +378,6 @@ static void pc_compat_0_13(MachineState *machine)
> >  
> >  static void pc_init_isa(MachineState *machine)
> >  {
> > -    x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
> > -    enable_compat_apic_id_mode();
> >      pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
> >  }
> >  
> 

-- 
Eduardo
