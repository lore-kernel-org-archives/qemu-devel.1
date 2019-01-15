Received: from eggs.gnu.org ([209.51.188.92]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjTu9-00064u-7k
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjTu8-0006wu-39
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:57:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjTu7-0006tm-Ih
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:57:39 -0500
Date: Tue, 15 Jan 2019 13:57:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115135548-mutt-send-email-mst@kernel.org>
References: <20190115100058.44712-1-sgarzare@redhat.com>
	<20190115100058.44712-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115100058.44712-5-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Maran Wilson <maran.wilson@oracle.com>

On Tue, Jan 15, 2019 at 11:00:58AM +0100, Stefano Garzarella wrote:
> Use pvh.bin option rom when we are booting an uncompressed
> kernel using the x86/HVM direct boot ABI.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>

I don't think this is a great way to give attribution.
Can you pls include the author name and the S.O.B from there as well?


> ---
>  hw/i386/pc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 06bce6a101..7564ba51d2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1005,6 +1005,10 @@ static void load_linux(PCMachineState *pcms,
>              fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
>                               header, sizeof(header));
>  
> +            option_rom[nb_option_roms].bootindex = 0;
> +            option_rom[nb_option_roms].name = "pvh.bin";
> +            nb_option_roms++;
> +
>              return;
>          }
>          /* This looks like a multiboot kernel. If it is, let's stop
> @@ -1456,6 +1460,7 @@ void xen_load_linux(PCMachineState *pcms)
>      for (i = 0; i < nb_option_roms; i++) {
>          assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                 !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> +               !strcmp(option_rom[i].name, "pvh.bin") ||
>                 !strcmp(option_rom[i].name, "multiboot.bin"));
>          rom_add_option(option_rom[i].name, option_rom[i].bootindex);
>      }

OK but this is guest visible so needs to be guarded by the
new machine type.


> -- 
> 2.20.1
