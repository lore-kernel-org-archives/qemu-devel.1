Received: from eggs.gnu.org ([2001:4830:134:3::10]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dosCL-0004dc-6C
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dosCG-00068g-25
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dosCF-00068G-S5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:17:51 -0400
Date: Mon, 4 Sep 2017 11:17:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170904141748.GU7570@localhost.localdomain>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
	<5bf40ca8376c537ac05dd848a84e072a88a1d939.1504228916.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf40ca8376c537ac05dd848a84e072a88a1d939.1504228916.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/7] hw/i386: Improve some of the
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
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com, Don Slutz <dslutz@verizon.com>

On Fri, Sep 01, 2017 at 09:51:05AM -0700, Alistair Francis wrote:
[...]
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 169a214d50..435eb2c458 100644
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
> +                        " (0x%" PRIx64 ") and max-ram-below-4g (%"PRIu64")"
> +                        " note a multiple of 1G; possible bad performance.",
> +                        machine->ram_size, lowmem, pcms->max_ram_below_4g);

Here lowmem and max_ram_below_4g have exactly the same value,
don't they?  There's no internal limit involved in this logic,
only max_ram_below_4g and ram_size.

-- 
Eduardo
