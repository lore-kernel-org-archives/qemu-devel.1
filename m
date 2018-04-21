Received: from eggs.gnu.org ([2001:4830:134:3::10]:50295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fA0xV-0008Nx-PB
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 18:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fA0xS-0002sR-ME
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 18:26:17 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fA0xS-0002rx-GY
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 18:26:14 -0400
Received: by mail-qt0-x242.google.com with SMTP id h2-v6so1539456qtp.7
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 15:26:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <54740d83-d866-80cb-80eb-7521a5b1b697@amsat.org>
Date: Sat, 21 Apr 2018 19:26:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/13] hw/xtensa/xtfpga.c: Don't create
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
> does this and updates serial_hds[].
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/xtensa/xtfpga.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 70686a2eb1..9db99e1f7e 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -278,10 +278,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>                  xtensa_get_extint(env, 1), nd_table);
>      }
>  
> -    if (!serial_hds[0]) {
> -        serial_hds[0] = qemu_chr_new("serial0", "null");
> -    }
> -
>      serial_mm_init(system_io, 0x0d050020, 2, xtensa_get_extint(env, 0),
>              115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
>  
> 
