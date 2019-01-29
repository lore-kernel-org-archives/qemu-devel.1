Received: from eggs.gnu.org ([209.51.188.92]:55766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goOjX-0006Br-9R
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goOjW-0004li-K1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:27:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goOjW-0004lK-EV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:27:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so20955245wrx.9
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 00:27:02 -0800 (PST)
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-3-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c83e805-a049-3401-1d1f-4fe4749e78b2@redhat.com>
Date: Tue, 29 Jan 2019 09:27:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190129000820.31190-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] hw/acpi: remove unused function
 acpi_table_add_builtin()
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
> Function acpi_table_add_builtin() is not used anymore.
> 
> Remove the definition and declaration.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/acpi/core.c         | 6 ------
>  include/hw/acpi/acpi.h | 1 -
>  2 files changed, 7 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index d6f0709691..e9b1a85e54 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -305,12 +305,6 @@ out:
>  
>  static bool acpi_table_builtin = false;
>  
> -void acpi_table_add_builtin(const QemuOpts *opts, Error **errp)
> -{
> -    acpi_table_builtin = true;
> -    acpi_table_add(opts, errp);
> -}
> -
>  unsigned acpi_table_len(void *current)
>  {
>      struct acpi_table_header *hdr = current - sizeof(hdr->_length);
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index c20ace0d0b..4a8bbaf1b5 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -190,7 +190,6 @@ uint8_t *acpi_table_first(void);
>  uint8_t *acpi_table_next(uint8_t *current);
>  unsigned acpi_table_len(void *current);
>  void acpi_table_add(const QemuOpts *opts, Error **errp);
> -void acpi_table_add_builtin(const QemuOpts *opts, Error **errp);
>  
>  typedef struct AcpiSlicOem AcpiSlicOem;
>  struct AcpiSlicOem {
> 
