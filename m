Received: from eggs.gnu.org ([2001:4830:134:3::10]:47452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVwPm-00047i-MJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVwPg-0008Nz-RX
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:02:06 -0400
References: <20180611195607.3015-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5abab447-b25b-0431-5fc9-7b6cda73e7a5@redhat.com>
Date: Thu, 21 Jun 2018 12:01:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180611195607.3015-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Add missing newline to
 -accel help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

On 11/06/2018 21:56, Eduardo Habkost wrote:
> The newline was removed by commit c97d6d2c, and broke -help output:
> 
> Before this patch:
> 
>   $ qemu-system-x86_64 -help | grep smp
>                   thread=single|multi (enable multi-threaded TCG)-smp [...]
> 
> After this patch:
> 
>   $ qemu-system-x86_64 -help  | grep smp
>   -smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]
> 
> Fixes: c97d6d2cdf97edb4aebe832fdba65d701ad7bcb6
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c0d3951e9f..6364cf3f94 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -130,7 +130,7 @@ ETEXI
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "-accel [accel=]accelerator[,thread=single|multi]\n"
>      "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
> -    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
> +    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
>  STEXI
>  @item -accel @var{name}[,prop=@var{value}[,...]]
>  @findex -accel
> 

Queued, thanks.

Paolo
