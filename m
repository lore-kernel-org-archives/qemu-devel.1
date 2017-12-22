Received: from eggs.gnu.org ([2001:4830:134:3::10]:38718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eST2U-00034s-2u
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eST2Q-0004pr-Ui
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:31:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eST2Q-0004pP-Ou
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:31:22 -0500
Date: Fri, 22 Dec 2017 21:31:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171222213109-mutt-send-email-mst@kernel.org>
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
	<20171214040855.22231-3-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214040855.22231-3-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [RESEND PATCH for-2.12 2/2] hw/acpi-build: Make
 next_base easy to follow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: ehabkost@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com

On Thu, Dec 14, 2017 at 12:08:55PM +0800, Dou Liyang wrote:
> It may be hard to read the assignment statement of "next_base", so
> 
> S/next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>  /next_base = mem_base + mem_len;
> 
> ... for readability.
> 
> No functionality change.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 73519ab3ac..2010108ae0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2381,7 +2381,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>              }
>              mem_base = 1ULL << 32;
>              mem_len = next_base - pcms->below_4g_mem_size;
> -            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
> +            next_base = mem_base + mem_len;
>          }
>          numamem = acpi_data_push(table_data, sizeof *numamem);
>          build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -- 
> 2.14.3
> 
> 
