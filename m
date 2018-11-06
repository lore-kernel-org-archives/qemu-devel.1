Received: from eggs.gnu.org ([2001:4830:134:3::10]:41908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJypx-0006On-DO
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJypw-0006at-RH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:43:57 -0500
Date: Tue, 6 Nov 2018 11:43:06 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181106104306.GB27585@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-4-sameo@linux.intel.com>
	<591c453a-977c-98a5-a23e-bd04b6dc9533@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591c453a-977c-98a5-a23e-bd04b6dc9533@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/24] hw: acpi: The RSDP build API can
 return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Nov 06, 2018 at 11:23:39AM +0100, Paolo Bonzini wrote:
> On 05/11/2018 02:40, Samuel Ortiz wrote:
> >  /* RSDP */
> > -static GArray *
> > +static void
> >  build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> >  {
> >      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> > @@ -392,8 +392,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> >      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> >          (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> >          (char *)&rsdp->checksum - rsdp_table->data);
> > -
> > -    return rsdp_table;
> >  }
> >  
> 
> Better than v4. :)
Right, I followed Philippe's advice and it does make things clearer :)

Cheers,
Samuel.
