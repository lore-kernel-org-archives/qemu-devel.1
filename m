Received: from eggs.gnu.org ([2001:4830:134:3::10]:47548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKZQ-0004FM-Ha
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKZN-0001yl-EV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKZN-0001xo-7r
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:32:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499866456.git.alistair.francis@xilinx.com>
	<e81d6354fe83b9c870097428214f400f020f24ea.1499866456.git.alistair.francis@xilinx.com>
Date: Wed, 12 Jul 2017 18:32:53 +0200
In-Reply-To: <e81d6354fe83b9c870097428214f400f020f24ea.1499866456.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Wed, 12 Jul 2017 06:57:44 -0700")
Message-ID: <87o9sp39ai.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/7] hw/i386: Improve some of the
 warning messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net

Alistair Francis <alistair.francis@xilinx.com> writes:

> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 1653a47f0a..c915719b0c 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -101,9 +101,11 @@ static void pc_q35_init(MachineState *machine)
>          lowmem = pcms->max_ram_below_4g;
>          if (machine->ram_size - lowmem > lowmem &&
>              lowmem & ((1ULL << 30) - 1)) {
> -            warn_report("Large machine and max_ram_below_4g(%"PRIu64
> -                        ") not a multiple of 1G; possible bad performance.",
> -                        pcms->max_ram_below_4g);
> +            warn_report("Large machine as the ram size (0x%" PRIx64 ") is more"
> +                        " then twice the size of the internal limit"

than

> +                        " (0x%" PRIx64 ") and max_ram_below_4g (%"PRIu64")"

Space between string literal and PRIu64, please.

> +                        " note a multiple of 1G; possible bad performance.",
> +                        machine->ram_size, lowmem, pcms->max_ram_below_4g);
>          }
>      }
