Received: from eggs.gnu.org ([2001:4830:134:3::10]:32871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYS3i-0006WB-Iv
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYS3h-0003It-QR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:13:42 -0400
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-7-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86ce6b9d-3476-5050-f23b-f16209ff63dc@redhat.com>
Date: Thu, 28 Jun 2018 10:13:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180627232951.14725-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 06/10] ESP: add pseudo-DMA as used by
 Macintosh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 28/06/2018 01:29, Laurent Vivier wrote:
>      int32_t ti_size;
> @@ -46,6 +47,11 @@ struct ESPState {
>      ESPDMAMemoryReadWriteFunc dma_memory_write;
>      void *dma_opaque;
>      void (*dma_cb)(ESPState *s);
> +    uint8_t pdma_buf[32];
> +    uint32_t pdma_len;
> +    uint8_t *pdma_start;
> +    uint8_t *pdma_cur;
> +    void (*pdma_cb)(ESPState *s);
>  };

I suppose migration of ESP is completely busted, since we're not
migrating dma_cb?  This patch is not making it any better, but perhaps
at least pdma_start and pdma_cur could be indices instead of pointers.

Thanks,

Paolo
