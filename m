Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ABAC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1826E21848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1826E21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFW3-0005qH-9X
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:06:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUFSC-0003vG-UH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUFSA-0008Ku-Cz
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:02:08 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hUFS6-0008Gs-Ax; Fri, 24 May 2019 15:02:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M9W78-1hZj4c3iQm-005bVI; Fri, 24 May 2019 21:00:47 +0200
To: Thomas Huth <huth@tuxfamily.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
	jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
	hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com,
	aurelien@aurel32.net
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<20181102152257.20637-6-mark.cave-ayland@ilande.co.uk>
	<839269a0-4b07-a084-8e9a-fcffa76bc658@tuxfamily.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e1c4101c-81a9-396e-af5a-995349e50a49@vivier.eu>
Date: Fri, 24 May 2019 21:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <839269a0-4b07-a084-8e9a-fcffa76bc658@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eSm/2qJWAyFAEw+o8CezUCYN1zfD2YJ3QKia3Z/ZrFUuVGOksJt
	kPkTBVxZyeMm3U5OrnR9G37AALiV75b/jmYtSTYDIU7PG9/H8diZP+imX19UPaITY43mKOn
	nSTlxYBfh9JPVT3JEXX4tvNm7qvkq/PktiuBdv1W0WZvws82Xb9KHT5Qyjq7tvEW5+B1GPI
	vZmqX+1PbbG4phBSh97PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wj2Z1dZ+k4E=:3dF6pYBocIH9QkQe0ifVYp
	v0pzN+oAnww4nA/K0iFr1pJqZ5+LQPYGOj7qKwNGYNYnAxDI31luSHoGYi5n3Ifd/olSDBsG1
	xhap4D9T6wogYrmOc3cHoB1z3m9794FPJopbeOJTTXytxPs8PrtgI286nGHyA8tMkzPQt3mmB
	N63vW3qJ9OTHadXOxEHEYqtMRSwLquHLJdVvQBhOJEhkzjS4kqymzIXADxWzqoaLAtpY+Fvfr
	7g5jrf10jOJOCqZp+jOjg2F5wRiW1SKXIAAwrakvxotPdPSMhEuxUK2iR38QRrXXrtsEFF1Xt
	PO1xI1NsioU0kGrgcBwgx9mVaXACFVpHRE5ablAo3UnkSc6eun3tyd6W9F2efdiTrNNJIg9+J
	KkiSWp0uPN9SUqjFJix65680HFI7V9/U1xjMookbjenp6ONQyOV2lz7qGeth/zGung982NfdD
	zGpgBM52IJq4mRnRTGYnuqDxsblFyaWTPwaHVWiGytZbJF9drEXPRcwRvLhInOnycW+okdkbl
	0IE7gWgqVrHutM3GO5wOJtNet/jmL+xe5cV0/SomEquU0UWfl5+ayqrgidQWUxTJsbC2JlGVE
	z9yH3vF8xj2du/vuIEizX+q6GrXcyg3AiqQfWDiHf3i+jhffiGkaHsU6qcjJWaUilLRAZosMJ
	ZTNJXUtXP2jO4Ul7XEJCjstLMgJ3GwN5O71uXzhpUE1q9Qfk70WhiTemM4MHpvmYp6FSGf40n
	sZSFY7aibyowUVXQTExJwP5zgM4TaVPJXZEOkXw2Y3ltpm3llNyfm3CJtz4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v6 05/10] esp: add pseudo-DMA as used by
 Macintosh
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/01/2019 06:48, Thomas Huth wrote:
> On 2018-11-02 16:22, Mark Cave-Ayland wrote:
>> From: Laurent Vivier <laurent@vivier.eu>
> 
> I'd suggest to add a patch description that contains the text that
> Laurent provided as a reply to this patch in v5:
> 
> ---------------------------- 8< --------------------------------------
> There is no DMA in Quadra 800, so the CPU reads/writes the data from the
> PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies them
> to/from the memory.
> 
> There is a nice assembly loop in the kernel to do that, see
> linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().
> 
> The start of the transfer is triggered by the DREQ interrupt (see linux
> mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
> transfer after a SCSI command has been sent (in Quadra 800 it goes
> through the VIA2, the via2-irq line and the vIFR register)
> 
> The Macintosh hardware includes hardware handshaking to prevent the CPU
> from reading invalid data or writing data faster than the peripheral
> device can accept it.
> 
> This is the "blind mode", and from the doc:
> "Approximate maximum SCSI transfer rates within a blocks are 1.4 MB per
> second for blind transfers in the Macintosh II"
> 
> Some references can be found in:
>    Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
>    Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8
> ---------------------------- >8 --------------------------------------
> 
> ?
> 
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/scsi/esp.c         | 291 +++++++++++++++++++++++++++++++++++++++++++++-----
>>   include/hw/scsi/esp.h |   7 ++
>>   2 files changed, 269 insertions(+), 29 deletions(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index 630d923623..8e9e27e479 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
> [...]
>> @@ -356,8 +511,7 @@ static void handle_ti(ESPState *s)
>>           s->dma_left = minlen;
>>           s->rregs[ESP_RSTAT] &= ~STAT_TC;
>>           esp_do_dma(s);
>> -    }
>> -    if (s->do_cmd) {
>> +    } else if (s->do_cmd) {
> 
> I'm not sure about this change... is it required? It could also change
> the behavior of the other users of this device...?
> 

The "else" is needed because this code has been duplicated inside 
esp_do_dma() to be executed only in the case of "real" dma and not for 
pseudo-dma.

Thanks,
Laurent


