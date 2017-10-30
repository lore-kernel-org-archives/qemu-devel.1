Received: from eggs.gnu.org ([2001:4830:134:3::10]:52093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9FII-0007Tu-OF
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9FID-00047D-Le
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:00:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45836
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e9FID-000460-6V
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:00:13 -0400
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<de8125f4-fb99-1f9e-f7a8-7f1f9c4f0b5a@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <836e7a63-c841-a866-c82c-04bf785420ca@ilande.co.uk>
Date: Mon, 30 Oct 2017 19:00:01 +0000
MIME-Version: 1.0
In-Reply-To: <de8125f4-fb99-1f9e-f7a8-7f1f9c4f0b5a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 00/13] sun4m: sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 27/10/17 17:42, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
>> This patchset aims to tidy-up the sparc32_dma code by improving the
>> modelling of the espdma/ledma devices using both QOM and the memory
>> API which didn't exist when the code was first written.
>>
>> The result is that it is now possible to remove both the iommu_opaque
>> and is_ledma workarounds from the code, and the code for wiring up
>> the espdma/ledma and respective devices is also a lot more readable.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> The whole series:
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> If you don't accept my comments (or don't have time) about keeping
> "hw/sparc/sparc32_dma.h" generic and moving network/scsi parts in
> "hw/sparc/sun4m.h" you can still add to your series:
> 
> Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks for the review, I've added your R-B tags to the individual
patches. Note that while potentially I could move the network/scsi parts
to hw/sparc/sun4m.h I feel that it's a slightly better match for the
SPARC32 DMA container device to remain in sparc32_dma.c. So for these
patches I've just added your A-B tag.

> Also while testing your series on a Debian image, I noted your series
> results faster, I timed:
> 
> master: 104s
> your series: 85s (>20% faster!)

Really? Is that for just this patchset or also with the v2 IOMMU
patchset applied on top? I can't immediately see how moving the logic
into sparc32_dma.c could make a difference here...


ATB,

Mark.
