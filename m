Received: from eggs.gnu.org ([209.51.188.92]:54838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqoP-00028u-O2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqoJ-0000UN-9a
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:50:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqoD-0000QZ-ER
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:50:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so541252wml.2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:50:37 -0800 (PST)
References: <20190218121322.DAB0474569F@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52a4d378-c03e-f8cf-af69-37ab7abbc30d@redhat.com>
Date: Mon, 18 Feb 2019 22:50:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190218121322.DAB0474569F@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] mips_fulong2e: Add on-board graphics
 chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>

On 2/18/19 1:09 PM, BALATON Zoltan wrote:
> Add (partial) emulation of the on-board GPU of the machine. This
> allows the PMON2000 firmware to run and should also work with Linux
> console but probably not with X yet.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> Tested-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>

Mojibake :S

---

> Based-on: 20190218030257.624A7745694@zero.eik.bme.hu

The 'based-on' tag goes below the '---' separator to avoid to keep it
indefinitely in the git history.

> ---
>  hw/mips/mips_fulong2e.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index eec6fd02c8..68bd030fc1 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -287,6 +287,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      I2CBus *smbus;
>      MIPSCPU *cpu;
>      CPUMIPSState *env;
> +    DeviceState *dev;
>  
>      /* init CPUs */
>      cpu = MIPS_CPU(cpu_create(machine->cpu_type));
> @@ -347,6 +348,11 @@ static void mips_fulong2e_init(MachineState *machine)
>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>                                 &smbus, &isa_bus);
>  
> +    /* GPU */
> +    dev = DEVICE(pci_create(pci_bus, -1, "ati-vga"));
> +    qdev_prop_set_uint16(dev, "device_id", 0x5159);
> +    qdev_init_nofail(dev);
> +
>      /* Populate SPD eeprom data */
>      spd_data = spd_data_generate(DDR, ram_size, &err);
>      if (err) {
> 
