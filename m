Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC7C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703542086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703542086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcY8-0003Tz-8w
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFcWb-0002uo-Sy
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFcWX-0002l2-TL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFcWV-0002hR-UX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:10:25 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FC9B7FDF0
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 11:10:19 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id h6so7315065wrh.6
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 04:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NESuV4AbC/y15hvZPB6oAn+H9pl06C32ji3EESUbE/Y=;
 b=E13oAo/1sYS4WRwIi63BDy/MhrqPAZ9LVpGsD8N891fsXTqC5svnIKA2Ccftl1Br/F
 KSfjvnqi0mZQQ7133EgqFScTedYXGvz4rqJhYMTIagbpgPj0YL1WYGHh2vws3PHEcIwU
 zcr2cxaIWcGpgHlyCT4AhsbuA2MPGqP01jxsQlgnwzdRvhaGZGz8L9AmYrROAmvCTf9g
 3LsdM7TDTEpZvdsKak8s2AcnvqDBc8EPK5WFNarr9CL8z9wgWdpTUNMjo06Nq+UnqgmI
 7YhL44c6dCszD6Phw941b/Oxkx6qIpnF8RL+ls+foXpYtpz6JelcSzNL2gyvFUIQ15IU
 k1fg==
X-Gm-Message-State: APjAAAX6DC7EGx6xH97CwxLUCfijwTonUrbr0Qmh5sJcqjgECuw1mV8N
 14LBKc7HoV8tzfArbBSbErncYfnUPazAC/ZEl3p252J5IFTijPqAY/bXV7yb81F1ajwAfAMHPDl
 roX0IXf+BS66v5hk=
X-Received: by 2002:a5d:67cc:: with SMTP id n12mr683279wrw.359.1570014618149; 
 Wed, 02 Oct 2019 04:10:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXp+gGSoafkPhBMWPmX0sdwhe8Xz1v6OEGolirqCh2iMyccuErKr/y06PTIaZ0OeeXJVzqxQ==
X-Received: by 2002:a5d:67cc:: with SMTP id n12mr683245wrw.359.1570014617753; 
 Wed, 02 Oct 2019 04:10:17 -0700 (PDT)
Received: from [10.201.33.15] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id t1sm16337489wrn.57.2019.10.02.04.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 04:10:17 -0700 (PDT)
Subject: Re: [PATCH v13 1/9] esp: add pseudo-DMA as used by Macintosh
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190927090453.24712-1-laurent@vivier.eu>
 <20190927090453.24712-2-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84f1108e-cc69-558d-4d67-ebb0b7b5f42a@redhat.com>
Date: Wed, 2 Oct 2019 13:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927090453.24712-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On 9/27/19 11:04 AM, Laurent Vivier wrote:
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
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/scsi/esp.c         | 338 ++++++++++++++++++++++++++++++++++++++----
>   include/hw/scsi/esp.h |  15 ++

I recommend you to install the scripts/git.orderfile file.

>   2 files changed, 324 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 841d79b60e..90b40c4cb5 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -38,6 +38,8 @@
>    * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR89C100.txt
>    * and
>    * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR53C9X.txt
> + *
> + * On Macintosh Quadra it is a NCR53C96.
>    */
>   
>   static void esp_raise_irq(ESPState *s)
> @@ -58,6 +60,16 @@ static void esp_lower_irq(ESPState *s)
>       }
>   }
>   
> +static void esp_raise_drq(ESPState *s)
> +{
> +    qemu_irq_raise(s->irq_data);
> +}
> +
> +static void esp_lower_drq(ESPState *s)
> +{
> +    qemu_irq_lower(s->irq_data);
> +}
> +
>   void esp_dma_enable(ESPState *s, int irq, int level)
>   {
>       if (level) {
> @@ -84,29 +96,35 @@ void esp_request_cancelled(SCSIRequest *req)
>       }
>   }
>   
> -static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
> +static void set_pdma(ESPState *s, enum pdma_origin_id origin,
> +                     uint32_t index, uint32_t len)
> +{
> +    s->pdma_origin = origin;
> +    s->pdma_start = index;
> +    s->pdma_cur = index;
> +    s->pdma_len = len;
> +}
> +
> +static uint8_t *get_pdma_buf(ESPState *s)
> +{
> +    switch (s->pdma_origin) {
> +    case PDMA:
> +        return s->pdma_buf;
> +    case TI:
> +        return s->ti_buf;
> +    case CMD:
> +        return s->cmdbuf;
> +    case ASYNC:
> +        return s->async_buf;
> +    }
> +    return NULL;
> +}
> +
> +static int get_cmd_cb(ESPState *s)
>   {
> -    uint32_t dmalen;
>       int target;
>   
>       target = s->wregs[ESP_WBUSID] & BUSID_DID;
> -    if (s->dma) {
> -        dmalen = s->rregs[ESP_TCLO];
> -        dmalen |= s->rregs[ESP_TCMID] << 8;
> -        dmalen |= s->rregs[ESP_TCHI] << 16;
> -        if (dmalen > buflen) {
> -            return 0;
> -        }
> -        s->dma_memory_read(s->dma_opaque, buf, dmalen);
> -    } else {
> -        dmalen = s->ti_size;
> -        if (dmalen > TI_BUFSZ) {
> -            return 0;
> -        }
> -        memcpy(buf, s->ti_buf, dmalen);
> -        buf[0] = buf[2] >> 5;
> -    }
> -    trace_esp_get_cmd(dmalen, target);
>   
>       s->ti_size = 0;
>       s->ti_rptr = 0;
> @@ -125,8 +143,46 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
>           s->rregs[ESP_RINTR] = INTR_DC;
>           s->rregs[ESP_RSEQ] = SEQ_0;
>           esp_raise_irq(s);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
> +{
> +    int target;
> +    uint32_t dmalen;
> +
> +    target = s->wregs[ESP_WBUSID] & BUSID_DID;
> +    if (s->dma) {
> +        dmalen = s->rregs[ESP_TCLO];
> +        dmalen |= s->rregs[ESP_TCMID] << 8;
> +        dmalen |= s->rregs[ESP_TCHI] << 16;
> +        if (dmalen > buflen) {
> +            return 0;
> +        }
> +        if (s->dma_memory_read) {
> +            s->dma_memory_read(s->dma_opaque, buf, dmalen);
> +        } else {
> +            memcpy(s->pdma_buf, buf, dmalen);
> +            set_pdma(s, PDMA, 0, dmalen);
> +            esp_raise_drq(s);
> +            return 0;
> +        }
> +    } else {
> +        dmalen = s->ti_size;
> +        if (dmalen > TI_BUFSZ) {
> +            return 0;
> +        }
> +        memcpy(buf, s->ti_buf, dmalen);
> +        buf[0] = buf[2] >> 5;
> +    }
> +    trace_esp_get_cmd(dmalen, target);
> +
> +    if (get_cmd_cb(s) < 0) {
>           return 0;
>       }
> +
>       return dmalen;
>   }
>   
> @@ -165,6 +221,16 @@ static void do_cmd(ESPState *s, uint8_t *buf)
>       do_busid_cmd(s, &buf[1], busid);
>   }
>   
> +static void satn_pdma_cb(ESPState *s)
> +{
> +    if (get_cmd_cb(s) < 0) {
> +        return;
> +    }
> +    if (s->pdma_cur != s->pdma_start) {
> +        do_cmd(s, get_pdma_buf(s) + s->pdma_start);
> +    }
> +}
> +
>   static void handle_satn(ESPState *s)
>   {
>       uint8_t buf[32];
> @@ -174,11 +240,22 @@ static void handle_satn(ESPState *s)
>           s->dma_cb = handle_satn;
>           return;
>       }
> +    s->pdma_cb = satn_pdma_cb;
>       len = get_cmd(s, buf, sizeof(buf));
>       if (len)
>           do_cmd(s, buf);
>   }
>   
> +static void s_without_satn_pdma_cb(ESPState *s)
> +{
> +    if (get_cmd_cb(s) < 0) {
> +        return;
> +    }
> +    if (s->pdma_cur != s->pdma_start) {
> +        do_busid_cmd(s, get_pdma_buf(s) + s->pdma_start, 0);
> +    }
> +}
> +
>   static void handle_s_without_atn(ESPState *s)
>   {
>       uint8_t buf[32];
> @@ -188,18 +265,36 @@ static void handle_s_without_atn(ESPState *s)
>           s->dma_cb = handle_s_without_atn;
>           return;
>       }
> +    s->pdma_cb = s_without_satn_pdma_cb;
>       len = get_cmd(s, buf, sizeof(buf));
>       if (len) {
>           do_busid_cmd(s, buf, 0);
>       }
>   }
>   
> +static void satn_stop_pdma_cb(ESPState *s)
> +{
> +    if (get_cmd_cb(s) < 0) {
> +        return;
> +    }
> +    s->cmdlen = s->pdma_cur - s->pdma_start;
> +    if (s->cmdlen) {
> +        trace_esp_handle_satn_stop(s->cmdlen);
> +        s->do_cmd = 1;
> +        s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
> +        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
> +        s->rregs[ESP_RSEQ] = SEQ_CD;
> +        esp_raise_irq(s);
> +    }
> +}
> +
>   static void handle_satn_stop(ESPState *s)
>   {
>       if (s->dma && !s->dma_enabled) {
>           s->dma_cb = handle_satn_stop;
>           return;
>       }
> +    s->pdma_cb = satn_stop_pdma_cb;;
>       s->cmdlen = get_cmd(s, s->cmdbuf, sizeof(s->cmdbuf));
>       if (s->cmdlen) {
>           trace_esp_handle_satn_stop(s->cmdlen);
> @@ -211,16 +306,31 @@ static void handle_satn_stop(ESPState *s)
>       }
>   }
>   
> +static void write_response_pdma_cb(ESPState *s)
> +{
> +    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
> +    s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
> +    s->rregs[ESP_RSEQ] = SEQ_CD;
> +    esp_raise_irq(s);
> +}
> +
>   static void write_response(ESPState *s)
>   {
>       trace_esp_write_response(s->status);
>       s->ti_buf[0] = s->status;
>       s->ti_buf[1] = 0;
>       if (s->dma) {
> -        s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
> -        s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
> -        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
> -        s->rregs[ESP_RSEQ] = SEQ_CD;
> +        if (s->dma_memory_write) {
> +            s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
> +            s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
> +            s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
> +            s->rregs[ESP_RSEQ] = SEQ_CD;
> +        } else {
> +            set_pdma(s, TI, 0, 2);
> +            s->pdma_cb = write_response_pdma_cb;
> +            esp_raise_drq(s);
> +            return;
> +        }
>       } else {
>           s->ti_size = 2;
>           s->ti_rptr = 0;
> @@ -242,6 +352,41 @@ static void esp_dma_done(ESPState *s)
>       esp_raise_irq(s);
>   }
>   
> +static void do_dma_pdma_cb(ESPState *s)
> +{
> +    int to_device = (s->ti_size < 0);
> +    int len = s->pdma_cur - s->pdma_start;
> +    if (s->do_cmd) {
> +        s->ti_size = 0;
> +        s->cmdlen = 0;
> +        s->do_cmd = 0;
> +        do_cmd(s, s->cmdbuf);
> +        return;
> +    }
> +    s->dma_left -= len;
> +    s->async_buf += len;
> +    s->async_len -= len;
> +    if (to_device) {
> +        s->ti_size += len;
> +    } else {
> +        s->ti_size -= len;
> +    }
> +    if (s->async_len == 0) {
> +        scsi_req_continue(s->current_req);
> +        /*
> +         * If there is still data to be read from the device then
> +         * complete the DMA operation immediately.  Otherwise defer
> +         * until the scsi layer has completed.
> +         */
> +        if (to_device || s->dma_left != 0 || s->ti_size == 0) {
> +            return;
> +        }
> +    }
> +
> +    /* Partially filled a scsi buffer. Complete immediately.  */
> +    esp_dma_done(s);
> +}
> +
>   static void esp_do_dma(ESPState *s)
>   {
>       uint32_t len;
> @@ -252,10 +397,25 @@ static void esp_do_dma(ESPState *s)
>           trace_esp_do_dma(s->cmdlen, len);
>           assert (s->cmdlen <= sizeof(s->cmdbuf) &&
>                   len <= sizeof(s->cmdbuf) - s->cmdlen);
> -        s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
> +        if (s->dma_memory_read) {
> +            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
> +        } else {
> +            set_pdma(s, CMD, s->cmdlen, len);
> +            s->pdma_cb = do_dma_pdma_cb;
> +            esp_raise_drq(s);
> +            return;
> +        }
> +        trace_esp_handle_ti_cmd(s->cmdlen);
> +        s->ti_size = 0;
> +        s->cmdlen = 0;
> +        s->do_cmd = 0;
> +        do_cmd(s, s->cmdbuf);
>           return;
>       }
>       if (s->async_len == 0) {
> +        if (s->dma_left == 0) {
> +            esp_dma_done(s);
> +        }
>           /* Defer until data is available.  */
>           return;
>       }
> @@ -264,9 +424,23 @@ static void esp_do_dma(ESPState *s)
>       }
>       to_device = (s->ti_size < 0);
>       if (to_device) {
> -        s->dma_memory_read(s->dma_opaque, s->async_buf, len);
> +        if (s->dma_memory_read) {
> +            s->dma_memory_read(s->dma_opaque, s->async_buf, len);
> +        } else {
> +            set_pdma(s, ASYNC, 0, len);
> +            s->pdma_cb = do_dma_pdma_cb;
> +            esp_raise_drq(s);
> +            return;
> +        }
>       } else {
> -        s->dma_memory_write(s->dma_opaque, s->async_buf, len);
> +        if (s->dma_memory_write) {
> +            s->dma_memory_write(s->dma_opaque, s->async_buf, len);
> +        } else {
> +            set_pdma(s, ASYNC, 0, len);
> +            s->pdma_cb = do_dma_pdma_cb;
> +            esp_raise_drq(s);
> +            return;
> +        }
>       }
>       s->dma_left -= len;
>       s->async_buf += len;
> @@ -373,8 +547,7 @@ static void handle_ti(ESPState *s)
>           s->dma_left = minlen;
>           s->rregs[ESP_RSTAT] &= ~STAT_TC;
>           esp_do_dma(s);
> -    }
> -    if (s->do_cmd) {
> +    } else if (s->do_cmd) {
>           trace_esp_handle_ti_cmd(s->cmdlen);
>           s->ti_size = 0;
>           s->cmdlen = 0;
> @@ -401,6 +574,7 @@ void esp_hard_reset(ESPState *s)
>   static void esp_soft_reset(ESPState *s)
>   {
>       qemu_irq_lower(s->irq);
> +    qemu_irq_lower(s->irq_data);
>       esp_hard_reset(s);
>   }
>   
> @@ -590,6 +764,28 @@ static bool esp_mem_accepts(void *opaque, hwaddr addr,
>       return (size == 1) || (is_write && size == 4);
>   }
>   
> +static bool esp_pdma_needed(void *opaque)
> +{
> +    ESPState *s = opaque;
> +    return s->dma_memory_read == NULL && s->dma_memory_write == NULL &&
> +           s->dma_enabled;
> +}
> +
> +static const VMStateDescription vmstate_esp_pdma = {
> +    .name = "esp/pdma",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = esp_pdma_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BUFFER(pdma_buf, ESPState),
> +        VMSTATE_INT32(pdma_origin, ESPState),
> +        VMSTATE_UINT32(pdma_len, ESPState),
> +        VMSTATE_UINT32(pdma_start, ESPState),
> +        VMSTATE_UINT32(pdma_cur, ESPState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   const VMStateDescription vmstate_esp = {
>       .name ="esp",
>       .version_id = 4,
> @@ -611,6 +807,10 @@ const VMStateDescription vmstate_esp = {
>           VMSTATE_UINT32(do_cmd, ESPState),
>           VMSTATE_UINT32(dma_left, ESPState),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_esp_pdma,
> +        NULL
>       }
>   };
>   
> @@ -641,6 +841,82 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
>       .valid.accepts = esp_mem_accepts,
>   };
>   
> +static void sysbus_esp_pdma_write(void *opaque, hwaddr addr,
> +                                  uint64_t val, unsigned int size)
> +{
> +    SysBusESPState *sysbus = opaque;
> +    ESPState *s = &sysbus->esp;
> +    uint32_t dmalen;
> +    uint8_t *buf = get_pdma_buf(s);
> +
> +    dmalen = s->rregs[ESP_TCLO];
> +    dmalen |= s->rregs[ESP_TCMID] << 8;
> +    dmalen |= s->rregs[ESP_TCHI] << 16;
> +    if (dmalen == 0 || s->pdma_len == 0) {
> +        return;
> +    }
> +    switch (size) {
> +    case 1:
> +        buf[s->pdma_cur++] = val;
> +        s->pdma_len--;
> +        dmalen--;
> +        break;
> +    case 2:
> +        buf[s->pdma_cur++] = val >> 8;
> +        buf[s->pdma_cur++] = val;
> +        s->pdma_len -= 2;
> +        dmalen -= 2;
> +        break;
> +    }
> +    s->rregs[ESP_TCLO] = dmalen & 0xff;
> +    s->rregs[ESP_TCMID] = dmalen >> 8;
> +    s->rregs[ESP_TCHI] = dmalen >> 16;
> +    if (s->pdma_len == 0 && s->pdma_cb) {
> +        esp_lower_drq(s);
> +        s->pdma_cb(s);
> +        s->pdma_cb = NULL;
> +    }
> +}
> +
> +static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    SysBusESPState *sysbus = opaque;
> +    ESPState *s = &sysbus->esp;
> +    uint8_t *buf = get_pdma_buf(s);
> +    uint64_t val = 0;
> +
> +    if (s->pdma_len == 0) {
> +        return 0;
> +    }
> +    switch (size) {
> +    case 1:
> +        val = buf[s->pdma_cur++];
> +        s->pdma_len--;
> +        break;
> +    case 2:
> +        val = buf[s->pdma_cur++];
> +        val = (val << 8) | buf[s->pdma_cur++];
> +        s->pdma_len -= 2;
> +        break;
> +    }
> +
> +    if (s->pdma_len == 0 && s->pdma_cb) {
> +        esp_lower_drq(s);
> +        s->pdma_cb(s);
> +        s->pdma_cb = NULL;
> +    }
> +    return val;
> +}
> +
> +static const MemoryRegionOps sysbus_esp_pdma_ops = {
> +    .read = sysbus_esp_pdma_read,
> +    .write = sysbus_esp_pdma_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 2,
> +};
> +
>   static const struct SCSIBusInfo esp_scsi_info = {
>       .tcq = false,
>       .max_target = ESP_MAX_DEVS,
> @@ -673,12 +949,16 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
>       ESPState *s = &sysbus->esp;
>   
>       sysbus_init_irq(sbd, &s->irq);
> +    sysbus_init_irq(sbd, &s->irq_data);
>       assert(sysbus->it_shift != -1);
>   
>       s->chip_id = TCHI_FAS100A;
>       memory_region_init_io(&sysbus->iomem, OBJECT(sysbus), &sysbus_esp_mem_ops,
> -                          sysbus, "esp", ESP_REGS << sysbus->it_shift);
> +                          sysbus, "esp-regs", ESP_REGS << sysbus->it_shift);
>       sysbus_init_mmio(sbd, &sysbus->iomem);
> +    memory_region_init_io(&sysbus->pdma, OBJECT(sysbus), &sysbus_esp_pdma_ops,
> +                          sysbus, "esp-pdma", 2);
> +    sysbus_init_mmio(sbd, &sysbus->pdma);
>   
>       qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
>   
> diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
> index adab63d1c9..6ba47dac41 100644
> --- a/include/hw/scsi/esp.h
> +++ b/include/hw/scsi/esp.h
> @@ -14,10 +14,18 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
>   
>   typedef struct ESPState ESPState;
>   
> +enum pdma_origin_id {
> +    PDMA,
> +    TI,
> +    CMD,
> +    ASYNC,
> +};
> +
>   struct ESPState {
>       uint8_t rregs[ESP_REGS];
>       uint8_t wregs[ESP_REGS];
>       qemu_irq irq;
> +    qemu_irq irq_data;
>       uint8_t chip_id;
>       bool tchi_written;
>       int32_t ti_size;
> @@ -48,6 +56,12 @@ struct ESPState {
>       ESPDMAMemoryReadWriteFunc dma_memory_write;
>       void *dma_opaque;
>       void (*dma_cb)(ESPState *s);
> +    uint8_t pdma_buf[32];
> +    int pdma_origin;

'int' -> 'enum pdma_origin_id'

You can also declare the enum in place:

        enum pdma_origin_id {
            PDMA,
            TI,
            CMD,
            ASYNC,
        } pdma_origin;

> +    uint32_t pdma_len;
> +    uint32_t pdma_start;
> +    uint32_t pdma_cur;
> +    void (*pdma_cb)(ESPState *s);
>   };
>   
>   #define TYPE_ESP "esp"
> @@ -59,6 +73,7 @@ typedef struct {
>       /*< public >*/
>   
>       MemoryRegion iomem;
> +    MemoryRegion pdma;
>       uint32_t it_shift;
>       ESPState esp;
>   } SysBusESPState;
> 

