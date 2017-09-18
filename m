Received: from eggs.gnu.org ([2001:4830:134:3::10]:49125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtmxe-0007sj-Ka
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtmxd-0001Ye-TB
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:43:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88f86547-b2f6-8214-d457-ec8237d4fb5e@amsat.org>
Date: Mon, 18 Sep 2017 00:42:56 -0300
MIME-Version: 1.0
In-Reply-To: <1505668548-16616-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] ppc: QOMify g3beige machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

On 09/17/2017 02:15 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ppc/mac_oldworld.c |   17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index fcac399..5d1171d 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -380,8 +380,10 @@ static int heathrow_kvm_type(const char *arg)
>       return 2;
>   }
>   
> -static void heathrow_machine_init(MachineClass *mc)
> +static void heathrow_class_init(ObjectClass *oc, void *data)
>   {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
>       mc->desc = "Heathrow based PowerMAC";
>       mc->init = ppc_heathrow_init;
>       mc->block_default_type = IF_IDE;
> @@ -394,4 +396,15 @@ static void heathrow_machine_init(MachineClass *mc)
>       mc->kvm_type = heathrow_kvm_type;
>   }
>   
> -DEFINE_MACHINE("g3beige", heathrow_machine_init)
> +static const TypeInfo ppc_heathrow_machine_info = {
> +    .name          = MACHINE_TYPE_NAME("g3beige"),
> +    .parent        = TYPE_MACHINE,
> +    .class_init    = heathrow_class_init
> +};
> +
> +static void ppc_heathrow_register_types(void)
> +{
> +    type_register_static(&ppc_heathrow_machine_info);
> +}
> +
> +type_init(ppc_heathrow_register_types);
> 
