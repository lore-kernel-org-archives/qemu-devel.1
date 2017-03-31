Received: from eggs.gnu.org ([2001:4830:134:3::10]:46381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cttNY-0001Yn-KP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cttNV-00089S-Iz
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cttNV-00089E-CM
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:01:57 -0400
Date: Fri, 31 Mar 2017 11:01:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331100149.GA4514@work-vm>
References: <20170330050924.22134-1-iwona260909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330050924.22134-1-iwona260909@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Iwona Kotlarska <iwona260909@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

* Iwona Kotlarska (iwona260909@gmail.com) wrote:
> Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
> "dump-guest-memory /dev/null 0 8192" results in segfault.
> Fix by checking if we have CPU.
> 
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>

Queued.

I've fixed up the title to
  hmp: fix "dump-quest-memory" segfault

since that's the actual command it fixes.

Dave

> ---
>  target/i386/arch_dump.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 5a2e4be5d0..fe0aa36932 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -391,8 +391,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>  
>  #ifdef TARGET_X86_64
>      X86CPU *first_x86_cpu = X86_CPU(first_cpu);
> -
> -    lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
> +    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
>  #endif
>  
>      if (lma) {
> -- 
> 2.12.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
