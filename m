Received: from eggs.gnu.org ([209.51.188.92]:47708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyw1-0003JY-Jv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyvz-0002Au-Le
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:21:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEyvw-00028t-5s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:21:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so12670263wra.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:21:44 -0700 (PDT)
References: <20190412152619.23542-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c7385cf-78ba-3331-53f0-1973408f0e4d@redhat.com>
Date: Fri, 12 Apr 2019 18:21:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190412152619.23542-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 4/12/19 5:26 PM, Thomas Huth wrote:
> These machines depend on the deprecated bluetooth subsystem. In case we
> finally decide to remove the bluetooth subsystem, we likely need to
> remove the n800 and n810 machines, too, so mark them now as deprecated.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/nseries.c     | 3 +++
>  qemu-deprecated.texi | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 906b7ca22d..66e50b850c 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -1309,6 +1309,9 @@ static void n8x0_init(MachineState *machine,
>      struct n800_s *s = (struct n800_s *) g_malloc0(sizeof(*s));
>      int sdram_size = binfo->ram_size;
>  
> +    warn_report("The n800 and n810 machines are deprecated. Please use a "
> +                "different Arm machine instead.");
> +

Unrelated to this patch, but can you add a similar warning in
uart_hci_init() to make obvious that the bluetooth subsystem is now
deprecated?

>      s->mpu = omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
>  
>      /* Setup peripherals
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2219386769..4de7452fac 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -145,6 +145,12 @@ This machine type uses an unmaintained firmware, broken in lots of ways,
>  and unable to start post-2004 operating systems. 40p machine type should be
>  used instead.
>  
> +@subsection n800 and n810 (Arm) (since 4.1)
> +
> +These machines depend on the deprecated bluetooth subsystem. When the
> +bluetooth subsystem will be removed, the n800 and n810 machines will be
> +deleted, too. If possible, use a different Arm board instead.
> +
>  @section Device options
>  
>  @subsection Block device options
> 
