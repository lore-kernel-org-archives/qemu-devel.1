Received: from eggs.gnu.org ([2001:4830:134:3::10]:38571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHUmo-0005qw-Is
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHUmj-00073l-3Z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:14:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:30794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHUmi-000735-Q2
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:14:21 -0400
Date: Tue, 30 Oct 2018 15:13:35 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181030141335.GB5291@caravaggio.home>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-20-sameo@linux.intel.com>
	<7023e8f9-a7e3-ae11-e1d7-429434e895d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7023e8f9-a7e3-ae11-e1d7-429434e895d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 19/19] hw: i386: Implement the ACPI
 builder interface for PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Paolo,

On Mon, Oct 29, 2018 at 06:28:39PM +0100, Paolo Bonzini wrote:
> On 29/10/2018 18:01, Samuel Ortiz wrote:
> > @@ -1556,6 +1557,7 @@ void acpi_build(AcpiBuildTables *tables,
> >      GArray *tables_blob = tables->table_data;
> >      AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
> >      Object *vmgenid_dev;
> > +    AcpiBuilder *ab = ACPI_BUILDER(machine);
> >  
> >      acpi_get_pm_info(&pm);
> >      acpi_get_misc_info(&misc);
> > @@ -1605,7 +1607,8 @@ void acpi_build(AcpiBuildTables *tables,
> >      aml_len += tables_blob->len - fadt;
> >  
> >      acpi_add_table(table_offsets, tables_blob);
> > -    build_madt(tables_blob, tables->linker, machine, conf);
> > +    acpi_builder_madt(ab, tables_blob, tables->linker,
> > +                      machine, conf);
> >  
> >      vmgenid_dev = find_vmgenid_dev();
> >      if (vmgenid_dev) {
> 
> Just a quick question before I go and actually apply the patches to look
> at the resulting code: is there any reason why you didn't add the
> MachineState and/or AcpiBuilder to AcpiBuildState, similar to how it was
> in v1?
With v1 I was not adding MachineState to AcpiBuildState, I may be
missing your point.
Do you mean adding an AcpiBuilder pointer to AcpiConfiguration?

Cheers,
Samuel.
