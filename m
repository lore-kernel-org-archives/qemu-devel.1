Received: from eggs.gnu.org ([2001:4830:134:3::10]:48640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8ppH-00025D-AN
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8ppG-0000l0-Go
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:20:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <60e0cbee-0c0c-7e58-a0ab-e015196359f9@amsat.org>
Date: Wed, 18 Apr 2018 13:20:45 -0300
MIME-Version: 1.0
In-Reply-To: <1524061685-83305-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.13 v2 1/5] arm: always
 start from first_cpu when registering loader cpu reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, eric.auger@redhat.com

On 04/18/2018 11:28 AM, Igor Mammedov wrote:
> if arm_load_kernel() were passed non first_cpu, QEMU would end up
> with partially set do_cpu_reset() callback leaving some CPUs without it.
> 
> Make sure that do_cpu_reset() is registered for all CPUs by enumerating
> CPUs from first_cpu.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 26184bc..9ae6ab2 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1188,7 +1188,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>       * actually loading a kernel, the handler is also responsible for
>       * arranging that we start it correctly.
>       */
> -    for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
> +    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
>          qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
>      }
>  }
> 
