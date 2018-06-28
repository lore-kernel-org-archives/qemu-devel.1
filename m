Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYSHr-0001ik-GK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYSHq-0007Gz-LX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:28:19 -0400
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-7-laurent@vivier.eu>
	<86ce6b9d-3476-5050-f23b-f16209ff63dc@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <514b2988-89b8-3726-2ed9-80e4d044f84a@vivier.eu>
Date: Thu, 28 Jun 2018 10:27:50 +0200
MIME-Version: 1.0
In-Reply-To: <86ce6b9d-3476-5050-f23b-f16209ff63dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Le 28/06/2018 à 10:13, Paolo Bonzini a écrit :
> On 28/06/2018 01:29, Laurent Vivier wrote:
>>      int32_t ti_size;
>> @@ -46,6 +47,11 @@ struct ESPState {
>>      ESPDMAMemoryReadWriteFunc dma_memory_write;
>>      void *dma_opaque;
>>      void (*dma_cb)(ESPState *s);
>> +    uint8_t pdma_buf[32];
>> +    uint32_t pdma_len;
>> +    uint8_t *pdma_start;
>> +    uint8_t *pdma_cur;
>> +    void (*pdma_cb)(ESPState *s);
>>  };
> 
> I suppose migration of ESP is completely busted, since we're not
> migrating dma_cb?  This patch is not making it any better, but perhaps
> at least pdma_start and pdma_cur could be indices instead of pointers.

Thank you, I will try that.

Laurent
