Received: from eggs.gnu.org ([2001:4830:134:3::10]:37827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euFLt-0006CH-83
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euFLs-0003ov-7O
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:34:17 -0500
References: <20180308223946.26784-1-f4bug@amsat.org>
	<20180308223946.26784-6-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3bd5ba56-dede-f66b-d6e0-114dd580a78c@ilande.co.uk>
Date: Fri, 9 Mar 2018 10:33:57 +0000
MIME-Version: 1.0
In-Reply-To: <20180308223946.26784-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/25] hw/isa/pc87312: Rename the device
 type as TYPE_PC87312_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "open list:PReP" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 08/03/18 22:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> (hw/ppc)
> ---
>   include/hw/isa/pc87312.h | 4 ++--
>   hw/isa/pc87312.c         | 2 +-
>   hw/ppc/prep.c            | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
> index bf74470d40..710eb1c807 100644
> --- a/include/hw/isa/pc87312.h
> +++ b/include/hw/isa/pc87312.h
> @@ -28,8 +28,8 @@
>   #include "hw/isa/isa.h"
>   
>   
> -#define TYPE_PC87312 "pc87312"
> -#define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312)
> +#define TYPE_PC87312_SUPERIO "pc87312"
> +#define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312_SUPERIO)
>   
>   typedef struct PC87312State {
>       ISADevice dev;
> diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
> index 48b29e3c3c..e9edbc6c50 100644
> --- a/hw/isa/pc87312.c
> +++ b/hw/isa/pc87312.c
> @@ -391,7 +391,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo pc87312_type_info = {
> -    .name          = TYPE_PC87312,
> +    .name          = TYPE_PC87312_SUPERIO,
>       .parent        = TYPE_ISA_DEVICE,
>       .instance_size = sizeof(PC87312State),
>       .instance_init = pc87312_initfn,
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index ae724b0613..610ec7ec32 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -613,7 +613,7 @@ static void ppc_prep_init(MachineState *machine)
>       isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci), "isa.0"));
>   
>       /* Super I/O (parallel + serial ports) */
> -    isa = isa_create(isa_bus, TYPE_PC87312);
> +    isa = isa_create(isa_bus, TYPE_PC87312_SUPERIO);
>       dev = DEVICE(isa);
>       qdev_prop_set_uint8(dev, "config", 13); /* fdc, ser0, ser1, par0 */
>       qdev_init_nofail(dev);
> 

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
