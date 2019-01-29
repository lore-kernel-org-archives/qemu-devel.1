Received: from eggs.gnu.org ([209.51.188.92]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goOiY-0005f1-Iv
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goOiX-0004Pg-O4
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:26:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goOiX-0004P8-Hr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:26:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so16788400wmd.0
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 00:26:00 -0800 (PST)
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f61313f-8a66-587e-b3b0-dc485923bf8d@redhat.com>
Date: Tue, 29 Jan 2019 09:25:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190129000820.31190-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/i386/pc.c: remove unused
 function pc_acpi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, laurent@vivier.eu, mst@redhat.com

On 1/29/19 1:08 AM, Wei Yang wrote:
> Function pc_acpi_init() is not used anymore.
> 
> Remove the definition and declaration.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i386/pc.c         | 27 ---------------------------
>  include/hw/i386/pc.h |  1 -
>  2 files changed, 28 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5317e08f60..734d3268fa 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1280,33 +1280,6 @@ void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
>                                          pci_address_space, -1);
>  }
>  
> -void pc_acpi_init(const char *default_dsdt)
> -{
> -    char *filename;
> -
> -    if (acpi_tables != NULL) {
> -        /* manually set via -acpitable, leave it alone */
> -        return;
> -    }
> -
> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, default_dsdt);
> -    if (filename == NULL) {
> -        warn_report("failed to find %s", default_dsdt);
> -    } else {
> -        QemuOpts *opts = qemu_opts_create(qemu_find_opts("acpi"), NULL, 0,
> -                                          &error_abort);
> -        Error *err = NULL;
> -
> -        qemu_opt_set(opts, "file", filename, &error_abort);
> -
> -        acpi_table_add_builtin(opts, &err);
> -        if (err) {
> -            warn_reportf_err(err, "failed to load %s: ", filename);
> -        }
> -        g_free(filename);
> -    }
> -}
> -
>  void xen_load_linux(PCMachineState *pcms)
>  {
>      int i;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9d29c4b1df..541124ba6d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -187,7 +187,6 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>  
>  void pc_cpus_init(PCMachineState *pcms);
>  void pc_hot_add_cpu(const int64_t id, Error **errp);
> -void pc_acpi_init(const char *default_dsdt);
>  
>  void pc_guest_info_init(PCMachineState *pcms);
>  
> 
