Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJykD-0005qX-LS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyWT-0005Nf-GT
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:51 -0500
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-4-sameo@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <591c453a-977c-98a5-a23e-bd04b6dc9533@redhat.com>
Date: Tue, 6 Nov 2018 11:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181105014047.26447-4-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On 05/11/2018 02:40, Samuel Ortiz wrote:
>  /* RSDP */
> -static GArray *
> +static void
>  build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  {
>      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> @@ -392,8 +392,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>          (char *)rsdp - rsdp_table->data, sizeof *rsdp,
>          (char *)&rsdp->checksum - rsdp_table->data);
> -
> -    return rsdp_table;
>  }
>  

Better than v4. :)

Paolo
