Received: from eggs.gnu.org ([2001:4830:134:3::10]:35082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fLujU-0005UK-MG
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fLujT-0003WM-Ov
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:13:00 -0400
References: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <7cd201d8-bc92-02f5-df4d-626b57131ecf@reactos.org>
Date: Thu, 24 May 2018 20:12:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] prep: fix keyboard for the 40p machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, f4bug@amsat.org, david@gibson.dropbear.id.au

Le 24/05/2018 à 07:39, Mark Cave-Ayland a écrit :
> Commit 72d3d8f052 "hw/isa/superio: Add a keyboard/mouse controller (8042)"
> added an 8042 keyboard device to the PC87312 superio device to replace that
> being used by the prep machine.
> 
> Unfortunately this commit didn't do the same for the 40p machine which broke
> the keyboard by registering two 8042 keyboard devices at the same address.
> 
> Resolve this by similarly removing the 8042 keyboard from the 40p machine as
> done for the prep machine in commit 72d3d8f052.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> ---
>   hw/ppc/prep.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index a1e7219db6..be4db6a687 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -770,7 +770,6 @@ static void ibm_40p_init(MachineState *machine)
>   
>       /* add some more devices */
>       if (defaults_enabled()) {
> -        isa_create_simple(isa_bus, TYPE_I8042);
>           m48t59 = NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
>   
>           dev = DEVICE(isa_create(isa_bus, "cs4231a"));
> 
