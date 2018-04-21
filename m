Received: from eggs.gnu.org ([2001:4830:134:3::10]:49279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9ibN-0006Pb-Je
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 22:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9ibK-00059t-BG
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 22:50:13 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9ibK-00059Q-5d
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 22:50:10 -0400
Received: by mail-qt0-x242.google.com with SMTP id l8-v6so11926289qtp.6
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 19:50:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f3f0ccf9-40ba-864a-35f3-5be8554918b3@amsat.org>
Date: Fri, 20 Apr 2018 23:50:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> Following commit 12051d82f004024, UART devices should handle
> being passed a NULL pointer chardev, so we don't need to
> create "null" backends in board code. Remove the code that
>  does this and updates serial_hds[].
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
