Received: from eggs.gnu.org ([209.51.188.92]:34834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1Dj9-0000Ul-RB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1Dj9-0005LY-30
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:19:39 -0500
References: <20190304194857.9780-1-philmd@redhat.com>
	<20190304194857.9780-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9fef26c9-d43e-0ee3-3251-162ef6f0feb6@redhat.com>
Date: Tue, 5 Mar 2019 18:19:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190304194857.9780-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/i386/pc_sysfw: Remove obsolete
 PcSysFwDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 03/04/19 20:48, Philippe Mathieu-Daud=C3=A9 wrote:
> This structure is not used since 6dd2a5c98a.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 34727c5b1f..46b87afe23 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -40,11 +40,6 @@
> =20
>  #define BIOS_FILENAME "bios.bin"
> =20
> -typedef struct PcSysFwDevice {
> -    SysBusDevice busdev;
> -    uint8_t isapc_ram_fw;
> -} PcSysFwDevice;
> -
>  static void pc_isa_bios_init(MemoryRegion *rom_memory,
>                               MemoryRegion *flash_mem,
>                               int ram_size)
>=20

Looks sane, and the commit reference is precise.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
