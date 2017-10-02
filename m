Received: from eggs.gnu.org ([2001:4830:134:3::10]:56304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz4In-0004DZ-2K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz4Ij-0003bR-TH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:14:45 -0400
References: <1506790175-581-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: John Snow <jsnow@redhat.com>
Message-ID: <adcb36e5-70bc-1ef8-651d-c4c5871c4f33@redhat.com>
Date: Mon, 2 Oct 2017 13:14:37 -0400
MIME-Version: 1.0
In-Reply-To: <1506790175-581-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] macio: add missing registers to
 VMStateDescription
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
List-ID: <qemu-devel.nongnu.org>



On 09/30/2017 12:49 PM, Mark Cave-Ayland wrote:
> Commit 4f7265f "ppc/ide/macio: Add missing registers" added two extra macio
> registers but forgot to add them to the corresponding VMStateDescription.
> 
> The version number is bumped accordingly, although this will have little
> effect given that the Mac machines are practically unmigratable.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/ide/macio.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index ce194c6..2e043ef 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -353,12 +353,14 @@ static const MemoryRegionOps pmac_ide_ops = {
>  
>  static const VMStateDescription vmstate_pmac = {
>      .name = "ide",
> -    .version_id = 4,
> +    .version_id = 5,
>      .minimum_version_id = 0,
>      .fields = (VMStateField[]) {
>          VMSTATE_IDE_BUS(bus, MACIOIDEState),
>          VMSTATE_IDE_DRIVES(bus.ifs, MACIOIDEState),
>          VMSTATE_BOOL(dma_active, MACIOIDEState),
> +        VMSTATE_UINT32(timing_reg, MACIOIDEState),
> +        VMSTATE_UINT32(irq_reg, MACIOIDEState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> 
Acked-by: John Snow <jsnow@redhat.com>
