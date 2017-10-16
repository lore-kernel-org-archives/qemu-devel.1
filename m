Received: from eggs.gnu.org ([2001:4830:134:3::10]:56534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43xc-0001oR-Up
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43xZ-0005jr-0E
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:53:33 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<c3849730c544362ab5e7965f1c5c85ed987b57a7.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d3dd8e1-f93a-ca58-bc69-fce690284034@redhat.com>
Date: Mon, 16 Oct 2017 13:53:24 +0200
MIME-Version: 1.0
In-Reply-To: <c3849730c544362ab5e7965f1c5c85ed987b57a7.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 32/47] hw/ppc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, qemu-ppc@nongnu.org, armbru@redhat.com

On 30.09.2017 02:16, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index db0e49ab8f..8a5350161f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
[...]
> @@ -967,7 +967,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>                                            cur_base,
>                                            ram_size - cur_base);
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      machine->kernel_filename);
>              exit(1);
>          }
> @@ -982,8 +982,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>                                            ram_size - initrd_base);
>  
>          if (initrd_size < 0) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> -                    machine->initrd_filename);
> +            error_report("qemu: could not load initial ram disk '%s'",
> +                         machine->initrd_filename);
>              exit(1);
>          }
>  
> @@ -1024,7 +1024,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>          kernel_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
>                                    NULL, NULL);
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load firmware '%s'\n", filename);
> +            error_report("qemu: could not load firmware '%s'", filename);
>              exit(1);
>          }
>      }

Please remove the "qemu:" prefix from the strings here, too.

 Thomas
