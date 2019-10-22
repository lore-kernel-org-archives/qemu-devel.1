Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BCCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D621783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D621783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMu4c-00027v-CZ
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMttG-000869-Of
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMttE-0001Ps-WA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:07:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMttA-0001NO-W8; Tue, 22 Oct 2019 09:07:53 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MRVy9-1ihz0V0dNd-00NPlu; Tue, 22 Oct 2019 15:07:26 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191022111738.20803-1-laurent@vivier.eu>
 <20191022111738.20803-2-laurent@vivier.eu>
 <815dc0fe-02e1-fb75-9012-fe0378bd0fee@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v14 1/9] esp: add pseudo-DMA as used by Macintosh
Message-ID: <78334413-96b8-2cbe-e905-30c752c85478@vivier.eu>
Date: Tue, 22 Oct 2019 15:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <815dc0fe-02e1-fb75-9012-fe0378bd0fee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oVSDj7keEc5nr/GaKj66LYQP+/RSQfE5c5LIi40qmYSu5aSb5E2
 0K9qbz59FXb345Y+ttTJ1ZqwfIE4xklk1dVVGD6UAK7GH9Z2XOYfuo/D98W0q5hrQpxIzAQ
 8N4VNPpL6nlywekspziAb9WR3HjVveKCEVQeB3K6aO123zswhEJPaKoRBVVSefRyPijh+EO
 yR0uIVtXWditBerORG9hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEyWRlIqY/Y=:KxTwd+r90lODzUUvQxXLal
 IzQDiNvqXTPkPiJ9ej22wTSq1DGSwK4BRLqVhdsrf4kon+upmXiU/MWsNu5BqCbpDrmSjgsgq
 hnW+mIVcjNhibZcOjB9pCs6zlBTa1KVBL61SbnSpKkRlNq4y33gxgfJs9BGpiPlBOdho9ZP7t
 BDfI9MmSi2gTmnqWoXjoJ8BLoVDLQtJR/SueMcVh/pRSIpaiqHsC8nwfNiRXnZgxAgXTbNMOu
 Wp9QhzoVWhGCgLCmmGYKzS4lYZnqPEc683uQ0oxeLIIbw3xrPySnFI65KyjNt5xJ+58V0z0O5
 Ky+AF52i3/4AL4uxEsPCYsteaOH7/+d0WIXkwrLpcfYt9HCR77myQ1FPaFAHL3JbiGOvDQ+BL
 Gy/nozv25WjPG0YhKTXwcRy6BAEMU1KVK+0T1E9/ReKlde1JrL9riFsMg6geZ0Bip9fdMkvQA
 N2Rf11XjpcEHvGRYjXS8dSEmoFqQtfztY8G4sThKh70ZQ/G15EDZQzfWw4g/KR8XSZ1nYEG8Y
 SJlXA/g7wBELuyxo9wXaTgUWxyVd0289PecstH6szTk+0DVnSkwx7kAURzmlDU+ATeqcbMVg8
 Oevs32DxauS3tx8zaN/0banu/9mtDQC8+hoHi/g+HhxzpdcaiNi7SijfBqRiitCAaDHWB0Zhn
 ALGA/DIbmLY2Pr95/sEeRRYI6s9F+woZghhvQKSiG2DzQdB0biMGwViI5i1WYFTYrgCXv0g6G
 iPNIm7NpOnG62hnZjsXhEDXlP+z2TFfPd+LkckL2Tao3trIVCzQitau+Ouh/1BwjxcjFjcBqL
 zw019CNdK8wCOcywo7LWJFd3gep91MHA9553TWzT0VtiwZO1fqgQpW+y0ha892I+urVhFJrxP
 XbcR9LnuAVw+QoX8H8Vp2UbM/yfl4BKY8iqaXKR9M=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/10/2019 à 14:21, Philippe Mathieu-Daudé a écrit :
> Hi Laurent,
> 
> On 10/22/19 1:17 PM, Laurent Vivier wrote:
>> There is no DMA in Quadra 800, so the CPU reads/writes the data from the
>> PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies them
>> to/from the memory.
>>
>> There is a nice assembly loop in the kernel to do that, see
>> linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().
>>
>> The start of the transfer is triggered by the DREQ interrupt (see linux
>> mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
>> transfer after a SCSI command has been sent (in Quadra 800 it goes
>> through the VIA2, the via2-irq line and the vIFR register)
>>
>> The Macintosh hardware includes hardware handshaking to prevent the CPU
>> from reading invalid data or writing data faster than the peripheral
>> device can accept it.
>>
>> This is the "blind mode", and from the doc:
>> "Approximate maximum SCSI transfer rates within a blocks are 1.4 MB per
>> second for blind transfers in the Macintosh II"
>>
>> Some references can be found in:
>>    Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
>>    Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8
>>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   include/hw/scsi/esp.h |  15 ++
>>   hw/scsi/esp.c         | 338 ++++++++++++++++++++++++++++++++++++++----
>>   2 files changed, 324 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
>> index adab63d1c9..6ba47dac41 100644
>> --- a/include/hw/scsi/esp.h
>> +++ b/include/hw/scsi/esp.h
>> @@ -14,10 +14,18 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void
>> *opaque, uint8_t *buf, int len);
>>     typedef struct ESPState ESPState;
>>   +enum pdma_origin_id {
>> +    PDMA,
>> +    TI,
>> +    CMD,
>> +    ASYNC,
>> +};
>> +
>>   struct ESPState {
>>       uint8_t rregs[ESP_REGS];
>>       uint8_t wregs[ESP_REGS];
>>       qemu_irq irq;
>> +    qemu_irq irq_data;
>>       uint8_t chip_id;
>>       bool tchi_written;
>>       int32_t ti_size;
>> @@ -48,6 +56,12 @@ struct ESPState {
>>       ESPDMAMemoryReadWriteFunc dma_memory_write;
>>       void *dma_opaque;
>>       void (*dma_cb)(ESPState *s);
>> +    uint8_t pdma_buf[32];
>> +    int pdma_origin;
>> +    uint32_t pdma_len;
>> +    uint32_t pdma_start;
>> +    uint32_t pdma_cur;
>> +    void (*pdma_cb)(ESPState *s);
>>   };
>>     #define TYPE_ESP "esp"
>> @@ -59,6 +73,7 @@ typedef struct {
>>       /*< public >*/
>>         MemoryRegion iomem;
>> +    MemoryRegion pdma;
>>       uint32_t it_shift;
>>       ESPState esp;
>>   } SysBusESPState;
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index 841d79b60e..90b40c4cb5 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -38,6 +38,8 @@
>>    *
>> http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR89C100.txt
>>
>>    * and
>>    *
>> http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR53C9X.txt
>>
>> + *
>> + * On Macintosh Quadra it is a NCR53C96.
>>    */
>>     static void esp_raise_irq(ESPState *s)
>> @@ -58,6 +60,16 @@ static void esp_lower_irq(ESPState *s)
>>       }
>>   }
>>   +static void esp_raise_drq(ESPState *s)
>> +{
>> +    qemu_irq_raise(s->irq_data);
>> +}
>> +
>> +static void esp_lower_drq(ESPState *s)
>> +{
>> +    qemu_irq_lower(s->irq_data);
>> +}
>> +
>>   void esp_dma_enable(ESPState *s, int irq, int level)
>>   {
>>       if (level) {
>> @@ -84,29 +96,35 @@ void esp_request_cancelled(SCSIRequest *req)
>>       }
>>   }
>>   -static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
>> +static void set_pdma(ESPState *s, enum pdma_origin_id origin,
>> +                     uint32_t index, uint32_t len)
>> +{
>> +    s->pdma_origin = origin;
>> +    s->pdma_start = index;
>> +    s->pdma_cur = index;
>> +    s->pdma_len = len;
> 
> Can you pass the pdma_cb to this function, and:
> 
>        s->pdma_cb = pdma_cb;

I agree but I tried that in the past, but in get_cmd() we call
set_pdma() without setting pdma_cb, so no.

>> @@ -252,10 +397,25 @@ static void esp_do_dma(ESPState *s)
>>           trace_esp_do_dma(s->cmdlen, len);
>>           assert (s->cmdlen <= sizeof(s->cmdbuf) &&
>>                   len <= sizeof(s->cmdbuf) - s->cmdlen);
>> -        s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
>> +        if (s->dma_memory_read) {
>> +            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen],
>> len);
>> +        } else {
>> +            set_pdma(s, CMD, s->cmdlen, len);
>> +            s->pdma_cb = do_dma_pdma_cb;
>> +            esp_raise_drq(s);
>> +            return;
>> +        }
>> +        trace_esp_handle_ti_cmd(s->cmdlen);
>> +        s->ti_size = 0;
>> +        s->cmdlen = 0;
>> +        s->do_cmd = 0;
>> +        do_cmd(s, s->cmdbuf);
>>           return;
>>       }
>>       if (s->async_len == 0) {
>> +        if (s->dma_left == 0) {
>> +            esp_dma_done(s);
>> +        }
> 
> This change seems unrelated to PDMA, is this a fix?

All changes are related to PDMA. It's complicated enough to not mix
several things.

This change is related to your following comment:

>> @@ -373,8 +547,7 @@ static void handle_ti(ESPState *s)
>>           s->dma_left = minlen;
>>           s->rregs[ESP_RSTAT] &= ~STAT_TC;
>>           esp_do_dma(s);
>> -    }
>> -    if (s->do_cmd) {
>> +    } else if (s->do_cmd) {
> 
> Hmmm, unrelated too?

It's needed, see my answer to Thomas question for the v6 of the patch:

https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06028.html

"The "else" is needed because this code has been duplicated inside
esp_do_dma() to be executed only in the case of "real" dma and not for
pseudo-dma."

Thanks,
Laurent
[1] I wrote this patch 7 years ago, so no more obvious or detailed
comments come to my mind at the moment.


