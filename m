Received: from eggs.gnu.org ([209.51.188.92]:51638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNEep-00029Y-Hr
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNEeo-0003QV-Lw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:46:11 -0400
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
	<1557003754-26473-4-git-send-email-atar4qemu@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7e282cd4-f402-c807-b9aa-7034d04031b6@ilande.co.uk>
Date: Sun, 5 May 2019 11:46:03 +0100
MIME-Version: 1.0
In-Reply-To: <1557003754-26473-4-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] hw/isa/i82378.c: use 1900 as a base
 year
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 04/05/2019 22:02, Artyom Tarasenko wrote:

> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/isa/i82378.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index a5d67bc..546c928 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>      isa = isa_create_simple(isabus, "i82374");
>  
>      /* timer */
> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> +    qdev_init_nofail(DEVICE(isa));
>  }
>  
>  static void i82378_init(Object *obj)

Is this true for the 82378 in general, or is it a particular quirk of the 40p
machine/PReP specification?


ATB,

Mark.
