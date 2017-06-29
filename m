Received: from eggs.gnu.org ([2001:4830:134:3::10]:39887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQiqf-0002KB-G8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQiqe-0007NC-P5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQiqe-0007Mb-IC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:27:44 -0400
Date: Fri, 30 Jun 2017 02:27:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630022719-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<1498773362-18675-2-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498773362-18675-2-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] hw/acpi: remove dead acpi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, Jun 30, 2017 at 12:55:57AM +0300, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>


I agree it seems unused. I'm not sure why do we have this
code. Igor?

> ---
>  hw/i386/acpi-build.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index afcadac..6fce967 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1912,16 +1912,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_piix4_pci0_int(dsdt);
>      } else {
>          sb_scope = aml_scope("_SB");
> -        aml_append(sb_scope,
> -            aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x0c));
> -        aml_append(sb_scope,
> -            aml_operation_region("PCSB", AML_SYSTEM_IO, aml_int(0xae0c), 0x01));
> -        field = aml_field("PCSB", AML_ANY_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -        aml_append(field, aml_named_field("PCIB", 8));
> -        aml_append(sb_scope, field);
> -        aml_append(dsdt, sb_scope);
> -
> -        sb_scope = aml_scope("_SB");
>          dev = aml_device("PCI0");
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> -- 
> 2.7.4
