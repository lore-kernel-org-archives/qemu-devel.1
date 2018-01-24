Received: from eggs.gnu.org ([2001:4830:134:3::10]:48276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeKdI-0000mv-1l
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeKdH-0002eH-Bd
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:58:28 -0500
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-9-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e8f6a860-6c20-bfbe-e8c6-c65763a72102@vivier.eu>
Date: Wed, 24 Jan 2018 13:58:14 +0100
MIME-Version: 1.0
In-Reply-To: <1516694904-64879-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/25] m68k: cpu: add CPU_RESOLVING_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Le 23/01/2018 à 09:08, Igor Mammedov a écrit :
> it will be used for providing to cpu name resolving class for
> parsing cpu model for system and user emulation code.
> 
> Along with change add target to null-machine test, so
> that when switch to CPU_RESOLVING_TYPE happens,
> test would ensure that null-mchine usecase still works.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h         | 1 +
>  tests/machine-none-test.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 2985b03..8a4299a 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -405,6 +405,7 @@ void register_m68k_insns (CPUM68KState *env);
>  
>  #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
>  #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
> +#define CPU_RESOLVING_TYPE TYPE_M68K_CPU
>  
>  #define cpu_signal_handler cpu_m68k_signal_handler
>  #define cpu_list m68k_cpu_list
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 1159290..c9445b6 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -31,6 +31,7 @@ static struct arch2cpu cpus_map[] = {
>      { "alpha", "ev67" },
>      { "cris", "crisv32" },
>      { "lm32", "lm32-full" },
> +    { "m68k", "m5206" },
>  };
>  
>  static const char *get_cpu_model_by_arch(const char *arch)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
