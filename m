Received: from eggs.gnu.org ([2001:4830:134:3::10]:54275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dRzud-00033F-HE
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dRzuZ-0003zL-KD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dRzuZ-0003yY-Df
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:53:03 -0400
Date: Mon, 3 Jul 2017 13:52:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170703135255.658173a4@nial.brq.redhat.com>
In-Reply-To: <20170630022719-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<1498773362-18675-2-git-send-email-zuban32s@gmail.com>
	<20170630022719-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] hw/acpi: remove dead acpi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, 30 Jun 2017 02:27:40 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jun 30, 2017 at 12:55:57AM +0300, Aleksandr Bezzubikov wrote:
> > Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>  
> 
> 
> I agree it seems unused. I'm not sure why do we have this
> code. Igor?
it's leftovers of original ASL code from SeaBIOS,
my conversion only was 1:1 from ASL to AML to avoid regressions
and almost no cleanups has been done on result.

It should be safe to remove these objects as they are not used by
Q35 (no AML or hw users for these ports)

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > ---
> >  hw/i386/acpi-build.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index afcadac..6fce967 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1912,16 +1912,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          build_piix4_pci0_int(dsdt);
> >      } else {
> >          sb_scope = aml_scope("_SB");
> > -        aml_append(sb_scope,
> > -            aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x0c));
> > -        aml_append(sb_scope,
> > -            aml_operation_region("PCSB", AML_SYSTEM_IO, aml_int(0xae0c), 0x01));
> > -        field = aml_field("PCSB", AML_ANY_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> > -        aml_append(field, aml_named_field("PCIB", 8));
> > -        aml_append(sb_scope, field);
> > -        aml_append(dsdt, sb_scope);
> > -
> > -        sb_scope = aml_scope("_SB");
> >          dev = aml_device("PCI0");
> >          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> >          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> > -- 
> > 2.7.4  
