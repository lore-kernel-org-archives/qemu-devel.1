Received: from eggs.gnu.org ([2001:4830:134:3::10]:52703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJhTk-00083b-Tm
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJhTg-0007x8-W4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:07:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eJhTg-0007wp-P5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:07:16 -0500
Date: Tue, 28 Nov 2017 16:07:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171128160713.0b0ea2fe@redhat.com>
In-Reply-To: <20171005203638.19255-2-ehabkost@redhat.com>
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<20171005203638.19255-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/9] hw/acpi-build: Make assignment
 statement of next_base easy to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org

On Thu,  5 Oct 2017 17:36:30 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
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
> Message-Id: <1504231805-30957-3-git-send-email-douly.fnst@cn.fujitsu.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Pls, retest/respin once 2.12 dev window is open

> ---
>  hw/i386/acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2af37a9129..73e3443bce 100644
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
