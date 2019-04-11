Received: from eggs.gnu.org ([209.51.188.92]:59146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEfdB-000625-2U
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEfd9-0000cH-5s
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:45:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEfd5-0000ak-IN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:45:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so8116261wmd.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:44:58 -0700 (PDT)
References: <20190411182240.5957-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e869e7fd-26f1-6bac-9a48-f302e4095a5c@redhat.com>
Date: Thu, 11 Apr 2019 21:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190411182240.5957-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/input: Add a CONFIG_PS2 switch
 for the ps2.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 4/11/19 8:22 PM, Thomas Huth wrote:
> ps2.c only needs to be compiled if we are building pckbd.c or pl050.c.

Hehe I have the same patch staged locally =)

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/input/Kconfig       | 5 +++++
>  hw/input/Makefile.objs | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index e2e66f0858..316573f782 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -8,10 +8,15 @@ config LM832X
>  config PCKBD
>      bool
>      default y
> +    select PS2
>      depends on ISA_BUS
>  
>  config PL050
>      bool
> +    select PS2
> +
> +config PS2
> +    bool
>  
>  config STELLARIS_INPUT
>      bool
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index c8b00f71ec..6db5ee0e71 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -3,7 +3,7 @@ common-obj-y += hid.o
>  common-obj-$(CONFIG_LM832X) += lm832x.o
>  common-obj-$(CONFIG_PCKBD) += pckbd.o
>  common-obj-$(CONFIG_PL050) += pl050.o
> -common-obj-y += ps2.o
> +common-obj-$(CONFIG_PS2) += ps2.o
>  common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
>  common-obj-$(CONFIG_TSC2005) += tsc2005.o
>  
> 
