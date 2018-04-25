Received: from eggs.gnu.org ([2001:4830:134:3::10]:33456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLXj-0000lb-PP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLXe-0008Ar-29
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLXd-0008Af-TD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:05 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-4-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5432636d-b371-9fb8-1377-5ea158bd4070@redhat.com>
Date: Wed, 25 Apr 2018 16:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/13] hw/mips/boston.c: Don't create
 "null" chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Following commit 12051d82f004024, UART devices should handle
> being passed a NULL pointer chardev, so we don't need to
> create "null" backends in board code. Remove the code that
>  does this and updates serial_hds[].
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/mips/boston.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index fb23161b33..14f0f6673b 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -505,10 +505,6 @@ static void boston_mach_init(MachineState *machine)
>                            "boston-platregs", 0x1000);
>      memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0);
>  
> -    if (!serial_hds[0]) {
> -        serial_hds[0] = qemu_chr_new("serial0", "null");
> -    }
> -
>      s->uart = serial_mm_init(sys_mem, 0x17ffe000, 2,
>                               get_cps_irq(s->cps, 3), 10000000,
>                               serial_hds[0], DEVICE_NATIVE_ENDIAN);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
