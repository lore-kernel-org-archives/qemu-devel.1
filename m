Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dosvU-0005JQ-Av
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dosuA-0003lK-Cl
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:04:36 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dosuA-0003kR-7o
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:03:14 -0400
Received: by mail-qt0-x244.google.com with SMTP id v20so428420qtg.1
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 08:03:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee6dfcaa-c2fd-a3f3-a2ea-8fe9cce69099@amsat.org>
Date: Mon, 4 Sep 2017 12:03:09 -0300
MIME-Version: 1.0
In-Reply-To: <1504533662-198084-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] cpu: rename cpu_parse_features() to
 cpu_parse_cpu_model()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Igor,

On 09/04/2017 11:00 AM, Igor Mammedov wrote:
> function not just parses features but also converts CPU model
> name to CPU type, rename it to reflect what it actualy does.

Why not squash this with your 1st patch "split cpu_generic_init()"?

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   include/qom/cpu.h | 4 ++--
>   qom/cpu.c         | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 392ae75..a718daf 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -643,7 +643,7 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
>   CPUState *cpu_create(const char *typename);
>   
>   /**
> - * cpu_parse_features:
> + * cpu_parse_cpu_model:
>    * @typename: The CPU base type or CPU type.
>    * @cpu_model: The model string including optional parameters.
>    *
> @@ -652,7 +652,7 @@ CPUState *cpu_create(const char *typename);
>    * Returns: type of CPU to create or prints error and terminates process
>    *          if an error occurred.
>    */
> -const char *cpu_parse_features(const char *typename, const char *cpu_model);
> +const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model);
>   
>   /**
>    * cpu_generic_init:
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 307d638..199ad57 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -66,7 +66,7 @@ CPUState *cpu_create(const char *typename)
>       return cpu;
>   }
>   
> -const char *cpu_parse_features(const char *typename, const char *cpu_model)
> +const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model)
>   {
>       ObjectClass *oc;
>       CPUClass *cc;
> @@ -99,7 +99,7 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
>       /* TODO: all callers of cpu_generic_init() need to be converted to
>        * call cpu_parse_features() only once, before calling cpu_generic_init().
>        */
> -    const char *cpu_type = cpu_parse_features(typename, cpu_model);
> +    const char *cpu_type = cpu_parse_cpu_model(typename, cpu_model);
>   
>       assert(cpu_type);
>       return cpu_create(cpu_type);
> 
