Received: from eggs.gnu.org ([2001:4830:134:3::10]:36570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPRLq-0006ra-7a
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPRBJ-0004ah-TV
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:00:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPRBJ-0004ab-Nd
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:00:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so1927475wrw.5
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 04:00:33 -0800 (PST)
References: <20181120203811.18406-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3526a4e0-2b26-dfc5-4b81-9fdf94734398@redhat.com>
Date: Wed, 21 Nov 2018 13:00:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181120203811.18406-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: xtfpga: provide default
 memory sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

Hi Max,

On 20/11/18 21:38, Max Filippov wrote:
> Provide default RAM sizes for all XTFPGA boards, so that when started
> without -m option they do the right thing.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   hw/xtensa/xtfpga.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index b3161de32093..7c1421d5beb4 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -568,6 +568,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx60_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 64 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx60_type = {
> @@ -584,6 +585,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx60_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 64 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx60_nommu_type = {
> @@ -600,6 +602,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx200_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 96 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx200_type = {
> @@ -616,6 +619,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_lx200_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 96 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_lx200_nommu_type = {
> @@ -632,6 +636,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_ml605_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 256 * MiB;

Isn't it 512 MB for the ML605?

>   }
>   
>   static const TypeInfo xtfpga_ml605_type = {
> @@ -648,6 +653,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_ml605_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 256 * MiB;

Ditto.

>   }
>   
>   static const TypeInfo xtfpga_ml605_nommu_type = {
> @@ -664,6 +670,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_kc705_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_ram_size = 1 * GiB;
>   }
>   
>   static const TypeInfo xtfpga_kc705_type = {
> @@ -680,6 +687,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
>       mc->init = xtfpga_kc705_nommu_init;
>       mc->max_cpus = 4;
>       mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
> +    mc->default_ram_size = 256 * MiB;
>   }
>   
>   static const TypeInfo xtfpga_kc705_nommu_type = {
> 

Others looks OK.

Regards,

Phil.
