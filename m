Received: from eggs.gnu.org ([2001:4830:134:3::10]:44523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctXNt-0004Fv-JB
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctXNp-00087J-LT
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctXNp-00086n-EL
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:32:49 -0400
References: <20170330050924.22134-1-iwona260909@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e0025b06-b26d-d168-8894-0f246e1c37f0@redhat.com>
Date: Thu, 30 Mar 2017 13:32:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170330050924.22134-1-iwona260909@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 03/30/2017 08:09 AM, Iwona Kotlarska wrote:
> Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
> "dump-guest-memory /dev/null 0 8192" results in segfault.
> Fix by checking if we have CPU.
>
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
> ---

Hi Iwona,

Next time (this patch is OK) please add here,
after the "---" line a quick info on the version changes, e.g. :

v2 -> v3:
   - Addressed Eduardo's comment and didn't split the assignment.
   - ...

v1-> v2:


   - ....

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
>

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
