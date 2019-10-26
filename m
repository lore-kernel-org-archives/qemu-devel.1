Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D13CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2E92084C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2E92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOOv0-00072E-TN
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 12:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iOOu5-0005Uj-3G
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iOOu2-0002oV-56
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:27:01 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iOOtx-0002la-Aq; Sat, 26 Oct 2019 12:26:53 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MEmAV-1iEBDJ45Pv-00GEsB; Sat, 26 Oct 2019 18:26:23 +0200
Subject: Re: [PATCH v14 1/9] esp: add pseudo-DMA as used by Macintosh
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191022111738.20803-1-laurent@vivier.eu>
 <20191022111738.20803-2-laurent@vivier.eu>
 <815dc0fe-02e1-fb75-9012-fe0378bd0fee@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0089ce93-577b-f905-855e-b2f755a991a7@vivier.eu>
Date: Sat, 26 Oct 2019 18:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <815dc0fe-02e1-fb75-9012-fe0378bd0fee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VLASSBvgj0pcedEVyMhRjGAxxhTMAIpel9ZWpQvXxJuWQMktAbE
 39swcZSlIEjpH76c1NWkKYZIW1t4prdR0V56fk7urRqentM5PufC0HabzDyTtLtVhW4IhWE
 TiDZoHNoQjivEZsWE8GV7CPuBASCi0aa2DK9tBz8WTdmfKdLqVDzJbGuFplRW7dHIXfwUpN
 kWuSBEroOUjEw7hXmtrDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3sDXZk+Atxg=:jhbQ6TXxR8yPcw269JhP4g
 c1rf0PCw4fe0cJxnt5bSn7zNqcxpJOpzF27TFaV9JDzHrWl/sAgOxvTQxG8QOWm074ASRy4N3
 LdSyXgBRgEoJ6Qd/RwemR6rqJzlOOSLD3CyNvWGnl/46ZAPgJcpI/BwwXAsz9drYa1JxE9YVS
 wzCfyYkFqArNsTPLU0o/yBHHKzlyjqtRFxio2TDpWmZNBLSlrvz2xwNQx/kENaGi9/2d6LKeR
 8YTDBrbqAkn9iMe/RWnnJS510gHKAxXQFQrJsUg+qevVezjeIEl2FEynIv47jneTQRqpBBMSj
 1Njz6bmYf7BchqOU0BJYSMEHVgpJBmyNVshLSoNoCazg42QYbND8fVe8D64OYkIU/SmfgLUaI
 8e19zeF95tuITKscEKncsmwoaYSnvoW4qfWGUjdPXT2NBVq1L8SfXcBZlYXK2EvAZAvj68UdV
 tiCvoyyHq9SQQNkvxACcnpOEYk8ssbfABuQLkoenhzlSxPqq6FgxTyITbzDFT9hmWCjwxNoNM
 OWSEEGT4A/SoDP3uYv30Yzpfke9B6WWpOhZq3qqBl1i8lBeayI+krXS6wW27eanuQoEi6HpEY
 dF9CFOwHMUNxWdt8AZ/SbWKurUSMEd8TEIaUCNwNNxIGpgEyBbwpYx/3z94wTCeyDe3Y2aAYi
 0BGdbmGhZjw0JUSU6jtfkBd7orQzSQvLoIWSB8lH22B/rT8+kxH75rWydMtBPhffuDeISVmot
 hElXMxMuCQQRXrkQP2CWmc8SgArs+VUMyBxgMyzmTdE1s02VeYUs/23+EZZr8pAmeqrGmO9Ss
 XnKhiqpfHEOkhwgqGVSyUAuPrdkfpZWUg5InwwfP7TLQK2pgKn0i9/Zfhe/l/pPxzgkauGLwz
 jPvyLV19wjI8rg25yqt6WpUFx0NACtg7cjtSSrQQI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
> 
>> +}
>> +
>> +static uint8_t *get_pdma_buf(ESPState *s)
>> +{
>> +    switch (s->pdma_origin) {
>> +    case PDMA:
>> +        return s->pdma_buf;
>> +    case TI:
>> +        return s->ti_buf;
>> +    case CMD:
>> +        return s->cmdbuf;
>> +    case ASYNC:
>> +        return s->async_buf;
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static int get_cmd_cb(ESPState *s)
>>   {
>> -    uint32_t dmalen;
>>       int target;
>>         target = s->wregs[ESP_WBUSID] & BUSID_DID;
>> -    if (s->dma) {
>> -        dmalen = s->rregs[ESP_TCLO];
>> -        dmalen |= s->rregs[ESP_TCMID] << 8;
>> -        dmalen |= s->rregs[ESP_TCHI] << 16;
>> -        if (dmalen > buflen) {
>> -            return 0;
>> -        }
>> -        s->dma_memory_read(s->dma_opaque, buf, dmalen);
>> -    } else {
>> -        dmalen = s->ti_size;
>> -        if (dmalen > TI_BUFSZ) {
>> -            return 0;
>> -        }
>> -        memcpy(buf, s->ti_buf, dmalen);
>> -        buf[0] = buf[2] >> 5;
>> -    }
>> -    trace_esp_get_cmd(dmalen, target);
>>         s->ti_size = 0;
>>       s->ti_rptr = 0;
>> @@ -125,8 +143,46 @@ static uint32_t get_cmd(ESPState *s, uint8_t
>> *buf, uint8_t buflen)
>>           s->rregs[ESP_RINTR] = INTR_DC;
>>           s->rregs[ESP_RSEQ] = SEQ_0;
>>           esp_raise_irq(s);
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
>> +{
>> +    int target;
>> +    uint32_t dmalen;
>> +
>> +    target = s->wregs[ESP_WBUSID] & BUSID_DID;
>> +    if (s->dma) {
>> +        dmalen = s->rregs[ESP_TCLO];
>> +        dmalen |= s->rregs[ESP_TCMID] << 8;
>> +        dmalen |= s->rregs[ESP_TCHI] << 16;
>> +        if (dmalen > buflen) {
>> +            return 0;
>> +        }
>> +        if (s->dma_memory_read) {
>> +            s->dma_memory_read(s->dma_opaque, buf, dmalen);
>> +        } else {
>> +            memcpy(s->pdma_buf, buf, dmalen);
>> +            set_pdma(s, PDMA, 0, dmalen);
>> +            esp_raise_drq(s);
>> +            return 0;
>> +        }
>> +    } else {
>> +        dmalen = s->ti_size;
>> +        if (dmalen > TI_BUFSZ) {
>> +            return 0;
>> +        }
>> +        memcpy(buf, s->ti_buf, dmalen);
>> +        buf[0] = buf[2] >> 5;
>> +    }
>> +    trace_esp_get_cmd(dmalen, target);
>> +
>> +    if (get_cmd_cb(s) < 0) {
>>           return 0;
>>       }
>> +
>>       return dmalen;
>>   }
>>   @@ -165,6 +221,16 @@ static void do_cmd(ESPState *s, uint8_t *buf)
>>       do_busid_cmd(s, &buf[1], busid);
>>   }
>>   +static void satn_pdma_cb(ESPState *s)
>> +{
>> +    if (get_cmd_cb(s) < 0) {
>> +        return;
>> +    }
>> +    if (s->pdma_cur != s->pdma_start) {
>> +        do_cmd(s, get_pdma_buf(s) + s->pdma_start);
>> +    }
>> +}
>> +
>>   static void handle_satn(ESPState *s)
>>   {
>>       uint8_t buf[32];
>> @@ -174,11 +240,22 @@ static void handle_satn(ESPState *s)
>>           s->dma_cb = handle_satn;
>>           return;
>>       }
>> +    s->pdma_cb = satn_pdma_cb;
>>       len = get_cmd(s, buf, sizeof(buf));
>>       if (len)
>>           do_cmd(s, buf);
>>   }
>>   +static void s_without_satn_pdma_cb(ESPState *s)
>> +{
>> +    if (get_cmd_cb(s) < 0) {
>> +        return;
>> +    }
>> +    if (s->pdma_cur != s->pdma_start) {
>> +        do_busid_cmd(s, get_pdma_buf(s) + s->pdma_start, 0);
>> +    }
>> +}
>> +
>>   static void handle_s_without_atn(ESPState *s)
>>   {
>>       uint8_t buf[32];
>> @@ -188,18 +265,36 @@ static void handle_s_without_atn(ESPState *s)
>>           s->dma_cb = handle_s_without_atn;
>>           return;
>>       }
>> +    s->pdma_cb = s_without_satn_pdma_cb;
>>       len = get_cmd(s, buf, sizeof(buf));
>>       if (len) {
>>           do_busid_cmd(s, buf, 0);
>>       }
>>   }
>>   +static void satn_stop_pdma_cb(ESPState *s)
>> +{
>> +    if (get_cmd_cb(s) < 0) {
>> +        return;
>> +    }
>> +    s->cmdlen = s->pdma_cur - s->pdma_start;
>> +    if (s->cmdlen) {
>> +        trace_esp_handle_satn_stop(s->cmdlen);
>> +        s->do_cmd = 1;
>> +        s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
>> +        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
>> +        s->rregs[ESP_RSEQ] = SEQ_CD;
>> +        esp_raise_irq(s);
>> +    }
>> +}
>> +
>>   static void handle_satn_stop(ESPState *s)
>>   {
>>       if (s->dma && !s->dma_enabled) {
>>           s->dma_cb = handle_satn_stop;
>>           return;
>>       }
>> +    s->pdma_cb = satn_stop_pdma_cb;;
>>       s->cmdlen = get_cmd(s, s->cmdbuf, sizeof(s->cmdbuf));
>>       if (s->cmdlen) {
>>           trace_esp_handle_satn_stop(s->cmdlen);
>> @@ -211,16 +306,31 @@ static void handle_satn_stop(ESPState *s)
>>       }
>>   }
>>   +static void write_response_pdma_cb(ESPState *s)
>> +{
>> +    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
>> +    s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
>> +    s->rregs[ESP_RSEQ] = SEQ_CD;
>> +    esp_raise_irq(s);
>> +}
>> +
>>   static void write_response(ESPState *s)
>>   {
>>       trace_esp_write_response(s->status);
>>       s->ti_buf[0] = s->status;
>>       s->ti_buf[1] = 0;
>>       if (s->dma) {
>> -        s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
>> -        s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
>> -        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
>> -        s->rregs[ESP_RSEQ] = SEQ_CD;
>> +        if (s->dma_memory_write) {
>> +            s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
>> +            s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
>> +            s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
>> +            s->rregs[ESP_RSEQ] = SEQ_CD;
>> +        } else {
>> +            set_pdma(s, TI, 0, 2);
>> +            s->pdma_cb = write_response_pdma_cb;
>> +            esp_raise_drq(s);
>> +            return;
>> +        }
>>       } else {
>>           s->ti_size = 2;
>>           s->ti_rptr = 0;
>> @@ -242,6 +352,41 @@ static void esp_dma_done(ESPState *s)
>>       esp_raise_irq(s);
>>   }
>>   +static void do_dma_pdma_cb(ESPState *s)
>> +{
>> +    int to_device = (s->ti_size < 0);
>> +    int len = s->pdma_cur - s->pdma_start;
>> +    if (s->do_cmd) {
>> +        s->ti_size = 0;
>> +        s->cmdlen = 0;
>> +        s->do_cmd = 0;
>> +        do_cmd(s, s->cmdbuf);
>> +        return;
>> +    }
>> +    s->dma_left -= len;
>> +    s->async_buf += len;
>> +    s->async_len -= len;
>> +    if (to_device) {
>> +        s->ti_size += len;
>> +    } else {
>> +        s->ti_size -= len;
>> +    }
>> +    if (s->async_len == 0) {
>> +        scsi_req_continue(s->current_req);
>> +        /*
>> +         * If there is still data to be read from the device then
>> +         * complete the DMA operation immediately.  Otherwise defer
>> +         * until the scsi layer has completed.
>> +         */
>> +        if (to_device || s->dma_left != 0 || s->ti_size == 0) {
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* Partially filled a scsi buffer. Complete immediately.  */
>> +    esp_dma_done(s);
>> +}
>> +
>>   static void esp_do_dma(ESPState *s)
>>   {
>>       uint32_t len;
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

In fact, dma_left cannot be equal to 0 here, esp_do_dma() is called from:
1- esp_transfer_data() only if s->dma_left != 0
2- handle_ti() and s->dma_left >= 0x1000

So I will remove this change.

Thanks,
Laurent


