Received: from eggs.gnu.org ([2001:4830:134:3::10]:60438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz2Dm-0000TH-Op
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz2Dg-0000SU-50
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:01:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz2Dg-0000SA-0Z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:01:20 -0400
Received: by mail-qk0-x243.google.com with SMTP id q8so4032693qkl.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 08:01:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-30-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b305a9d4-3692-314c-7571-22473259fe61@amsat.org>
Date: Mon, 2 Oct 2017 12:01:11 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-30-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 29/38] sparc: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> introduce SPARC_CPU_TYPE_NAME macro and use it to
> construct cpu type names.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> macro will also be used in follow up patches to define
> default cpu types per board
> 
> CC: mark.cave-ayland@ilande.co.uk
> CC: atar4qemu@gmail.com
> ---
>   target/sparc/cpu.h | 3 +++
>   target/sparc/cpu.c | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 1598f65..7aa45c9 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -658,6 +658,9 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
>   #endif
>   
> +#define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
> +#define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
> +
>   #define cpu_signal_handler cpu_sparc_signal_handler
>   #define cpu_list sparc_cpu_list
>   
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index beab90f..f09ba50 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -712,7 +712,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
>   
>   static char *sparc_cpu_type_name(const char *cpu_model)
>   {
> -    char *name = g_strdup_printf("%s-" TYPE_SPARC_CPU, cpu_model);
> +    char *name = g_strdup_printf(SPARC_CPU_TYPE_NAME("%s"), cpu_model);
>       char *s = name;
>   
>       /* SPARC cpu model names happen to have whitespaces,
> 
