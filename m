Received: from eggs.gnu.org ([209.51.188.92]:42395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.com>) id 1hC3PQ-00051K-7U
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.com>) id 1hC3Ho-0004m3-PB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:24:14 -0400
References: <20190404121015.28634-1-pl@kamp.de>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <9397a338-529c-6834-a61a-2bc26cf84503@suse.com>
Date: Thu, 4 Apr 2019 16:24:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190404121015.28634-1-pl@kamp.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] megasas: fix mapped frame size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, pbonzini@redhat.com, fam@euphon.net

On 4/4/19 2:10 PM, Peter Lieven wrote:
> the current value of 1024 bytes (16 * MFI_FRAME_SIZE) we map is not enough to hold
> the maximum number of scatter gather elements we advertise. We actually need a
> maximum of 2048 bytes. This is 128 max sg elements * 16 bytes (sizeof (union mfi_sgl)).
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>   hw/scsi/megasas.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index a56317e026..5ad762de23 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -477,7 +477,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
>   {
>       PCIDevice *pcid = PCI_DEVICE(s);
>       MegasasCmd *cmd = NULL;
> -    int frame_size = MFI_FRAME_SIZE * 16;
> +    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
>       hwaddr frame_size_p = frame_size;
>       unsigned long index;
>   
> 
Indeed.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
