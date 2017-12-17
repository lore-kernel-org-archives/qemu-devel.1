Received: from eggs.gnu.org ([2001:4830:134:3::10]:58687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQNWx-0003Fs-NO
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 20:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQNWu-0006JH-IJ
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 20:14:15 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQNWu-0006J8-DY
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 20:14:12 -0500
Received: by mail-qk0-x244.google.com with SMTP id u184so14609532qkd.6
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 17:14:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171216213004.30393-1-hpoussin@reactos.org>
	<20171216213004.30393-15-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f16b03f3-16a8-81aa-ee8c-5ced825ca7a6@amsat.org>
Date: Sat, 16 Dec 2017 22:14:07 -0300
MIME-Version: 1.0
In-Reply-To: <20171216213004.30393-15-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/15] piix4: rename PIIX4 object to
 piix4-isa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Hervé,

On 12/16/2017 06:30 PM, Hervé Poussineau wrote:
> Other piix4 parts are already named piix4-ide and piix4-usb-uhci.
> 
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/isa/piix4.c       | 2 +-
>  hw/mips/mips_malta.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index dc7146ee14..8bf260594f 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -52,7 +52,7 @@ typedef struct PIIX4State {
>      uint8_t rcr;
>  } PIIX4State;
>  
> -#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
> +#define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
>  #define PIIX4_PCI_DEVICE(obj) \
>      OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
>  
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 3d304a6e0a..28d91c9668 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1178,7 +1178,7 @@ void mips_malta_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>  
>      pci = pci_create_multifunction(pci_bus, PCI_DEVFN(10, 0),
> -                                   true, "PIIX4");
> +                                   true, "piix4-isa");

Can you use TYPE_PIIX4_PCI_DEVICE instead?

Then:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      dev = DEVICE(pci);
>  
>      /* Floppy */
> 
