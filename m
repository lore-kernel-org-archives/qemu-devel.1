Received: from eggs.gnu.org ([209.51.188.92]:38693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gonqa-0002hk-M4
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gonqa-0004t1-1e
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:16:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gonqZ-0004sU-Q1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:15:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so21206906wmb.3
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 03:15:59 -0800 (PST)
References: <20190130030207.6770-1-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e847da2-8ced-fefd-b566-30093d9fe331@redhat.com>
Date: Wed, 30 Jan 2019 12:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190130030207.6770-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i386,
 acpi: cleanup build_facs by removing second unused argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 1/30/19 4:02 AM, Wei Yang wrote:
> The second argument of build_facs() is not used, just remove it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 236a20eaa8..023729c1f2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -292,7 +292,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
>  
>  /* FACS */
>  static void
> -build_facs(GArray *table_data, BIOSLinker *linker)
> +build_facs(GArray *table_data)
>  {
>      AcpiFacsDescriptorRev1 *facs = acpi_data_push(table_data, sizeof *facs);
>      memcpy(&facs->signature, "FACS", 4);
> @@ -2643,7 +2643,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       * requirements.
>       */
>      facs = tables_blob->len;
> -    build_facs(tables_blob, tables->linker);
> +    build_facs(tables_blob);
>  
>      /* DSDT is pointed to by FADT */
>      dsdt = tables_blob->len;
> 
