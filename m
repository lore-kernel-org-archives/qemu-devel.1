Received: from eggs.gnu.org ([2001:4830:134:3::10]:38666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNoB-0004Fe-1h
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNo9-0003fk-Im
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:47:22 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <d86f51e6-0f5d-e78a-3aba-cad233e83efa@reactos.org>
Date: Tue, 30 Oct 2018 07:47:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 06/11] esp: add pseudo-DMA as used by
 Macintosh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

Le 29/10/2018 à 14:39, Mark Cave-Ayland a écrit :
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/scsi/esp.c         | 292 +++++++++++++++++++++++++++++++++++++++++++++-----
>   include/hw/scsi/esp.h |   7 ++
>   2 files changed, 270 insertions(+), 29 deletions(-)
> 

[...]

>   
> @@ -409,6 +564,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
>               s->ti_size--;
>               s->rregs[ESP_FIFO] = s->ti_buf[s->ti_rptr++];
>           }
> +        esp_raise_irq(s);
>           if (s->ti_rptr == s->ti_wptr) {
>               s->ti_rptr = 0;
>               s->ti_wptr = 0;

You're now raising irq (not drq) when reading registers. In my opinion, this deserves its own patch with an explanation.

Hervé
