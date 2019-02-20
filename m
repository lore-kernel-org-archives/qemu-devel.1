Received: from eggs.gnu.org ([209.51.188.92]:60376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwQ5j-0005ih-4M
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwQ5i-0003np-9f
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwQ5h-0003gM-V5
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:06 -0500
References: <20190219211936.6466-1-viktor.prutyanov@phystech.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0855c42-bd84-4f90-9af3-0080e0de1740@redhat.com>
Date: Wed, 20 Feb 2019 12:30:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190219211936.6466-1-viktor.prutyanov@phystech.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] contrib/elf2dmp: add kernel start address
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, peter.maydell@linaro.org
Cc: rkagan@virtuozzo.com, qemu-devel@nongnu.org

On 19/02/19 22:19, Viktor Prutyanov wrote:
> Before this patch, if elf2dmp failed to find NT kernel PE magic in
> allowed virtual address range, then it assumes NULL as NT kernel
> address and cause segfault.
> 
> This patch fix the problem described above by checking NT kernel address
> before futher processing.
> 
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> ---
>  contrib/elf2dmp/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index 1a45eaf565..1bfeb89ba7 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -524,6 +524,12 @@ int main(int argc, char *argv[])
>          }
>      }
>  
> +    if (!nt_start_addr) {
> +        eprintf("Failed to find NT kernel image\n");
> +        err = 1;
> +        goto out_ps;
> +    }
> +
>      printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
>              (char *)nt_start_addr);
>  
> 

Queued, thanks.

Paolo
