Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9bBr-0005ct-Sk
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9bBo-0001ym-Bz
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420155547.9497-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e972d5b4-4740-228e-014e-15686d0b1dc1@amsat.org>
Date: Fri, 20 Apr 2018 15:55:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180420155547.9497-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/raspi: Don't bother setting
 default_cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, patches@linaro.org

On 04/20/2018 12:55 PM, Peter Maydell wrote:
> In commit 210f47840dd62, we changed the bcm2836 SoC object to
> always create a CPU of the correct type for that SoC model. This
> makes the default_cpu_type settings in the MachineClass structs
> for the raspi2 and raspi3 boards redundant. We didn't change
> those at the time because it would have meant a temporary
> regression in a corner case of error handling if the user
> requested a non-existing CPU type. The -cpu parse handling
> changes in 2278b93941d42c3 mean that it no longer implicitly
> depends on default_cpu_type for this to work, so we can now
> delete the redundant default_cpu_type fields.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Tidying up a loose end from the raspi changes I did last month...
> 
>  hw/arm/raspi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 955a7c4e80..66899c28dc 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -226,7 +226,6 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->no_parallel = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
>      mc->max_cpus = BCM283X_NCPUS;
>      mc->min_cpus = BCM283X_NCPUS;
>      mc->default_cpus = BCM283X_NCPUS;
> @@ -249,7 +248,6 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->no_parallel = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
>      mc->max_cpus = BCM283X_NCPUS;
>      mc->min_cpus = BCM283X_NCPUS;
>      mc->default_cpus = BCM283X_NCPUS;
> 
