Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdst-0008E1-JQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFddv-0004CT-7M
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:17:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFdds-0004Ai-Cx
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:17:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so1100832wmc.2
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 04:17:29 -0700 (PDT)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b31347c5-51e9-5830-dda8-ee57373aeeaf@redhat.com>
Date: Thu, 25 Oct 2018 13:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181025085256.20522-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On 25/10/18 10:52, Gerd Hoffmann wrote:
> While being at it deprecate cirrus too.
> 
> Reason (short version): use stdvga instead.
> Verbose version:
>      https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/display/cirrus_vga.c     | 2 ++
>   hw/display/cirrus_vga_isa.c | 2 ++
>   qemu-deprecated.texi        | 4 ++++
>   3 files changed, 8 insertions(+)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index d9b854d..2f16ba9 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3024,6 +3024,8 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_pci_cirrus_vga;
>       dc->props = pci_vga_cirrus_properties;
>       dc->hotpluggable = false;
> +    dc->deprecation_reason =
> +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful";

We should propably add an archived copy of this post to www.qemu.org.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   }
>   
>   static const TypeInfo cirrus_vga_info = {
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index fa10b74..c2d853c 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -81,6 +81,8 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
>       dc->realize = isa_cirrus_vga_realizefn;
>       dc->props = isa_cirrus_vga_properties;
>       set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->deprecation_reason =
> +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful";
>   }
>   
>   static const TypeInfo isa_cirrus_vga_info = {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 7951a4f..1b1d434 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -120,6 +120,10 @@ or ``ivshmem-doorbell`` device types.
>   
>   Has known buffer overflow.
>   
> +@subsection cirrus (since 3.1)
> +
> +Use stdvga instead (-vga std or -device VGA).
> +
>   @section System emulator machines
>   
>   @subsection pc-0.10 and pc-0.11 (since 3.0)
> 
