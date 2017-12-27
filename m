Received: from eggs.gnu.org ([2001:4830:134:3::10]:36617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eU9ku-0004RE-SM
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 06:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eU9kr-0002cC-KN
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 06:20:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eU9kr-0002aQ-E4
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 06:20:13 -0500
Date: Wed, 27 Dec 2017 12:20:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171227122002.071588cf@igors-macbook-pro.local>
In-Reply-To: <20171214040855.22231-3-douly.fnst@cn.fujitsu.com>
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
	<20171214040855.22231-3-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com

On Thu, 14 Dec 2017 12:08:55 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
