Received: from eggs.gnu.org ([209.51.188.92]:35723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEqoR-0003GK-1m
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEqoQ-0002uO-1m
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:41:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEqoP-0002te-MY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:41:25 -0400
References: <20190411182240.5957-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef726224-d07e-1e4a-2a63-222b68af560a@redhat.com>
Date: Fri, 12 Apr 2019 09:41:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190411182240.5957-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/04/19 20:22, Thomas Huth wrote:
> ps2.c only needs to be compiled if we are building pckbd.c or pl050.c.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
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

Queued, thanks.  (Also, nice find :)).

Paolo
