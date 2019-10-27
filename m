Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10282070B
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10282070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOlxM-0002Ra-Mj
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iOlwD-000141-QY
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iOlwC-00056z-LR
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iOlwC-00056b-Bv
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:02:44 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CD743DE0C
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 17:02:43 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id e14so4931148wrm.21
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 10:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BxlNbSk8O5yCcb6MXliDESUdKnC/CjoDvktj/4OTklw=;
 b=pk6Rdho25ox0+DySA3p/A07vtusRw4boWmuK4hS9juPP4jfEqFIbK2arhew+7dj8NQ
 n3RWNOxGsK1O2HZZD4viBt3zgHoFXmCNpsSysBwmfrVLmecHdNqKUj6BC2NrvU73F1ry
 8cHVmLOZb7FkapoP6/w4ZwgsDc/zGeajSGpitzDmYyNnUk7tzCFgQUJd+zUfkNI7DqN+
 dTYLLdIINTH78HI7kUmVQGF7Bl/05ju0NEnYxRK1ZXPgGXKNsuMvGDC0sA12erJV5zEc
 8CUyd61GzkRzoXV4rRc+lsq2hn/9Qk/HL98fH2kLUOGv0Njj6M443BQXQGnmDVm8mZ/B
 ahQw==
X-Gm-Message-State: APjAAAX808HoUhI+fKJunvDFIyFw+Wc8eQTy9A1cetxwzNXrJJZLyQCq
 6aqzAXPKZYvhtgYNzFpD9w3xpvA0wLcnp5SvdiljD+g8fgjMMKeGU15uXxPqO8cvk50D0AIk2vn
 ceh9fiKpiYBaR/3o=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr11066596wmc.24.1572195761749; 
 Sun, 27 Oct 2019 10:02:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDcI4F3/RMSB8n/Sxcn/mfkPCL2tLPYEXImYfzuGUI1c06A3OmSiara8izCJD9eE/TeaIhBw==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr11066576wmc.24.1572195761432; 
 Sun, 27 Oct 2019 10:02:41 -0700 (PDT)
Received: from [192.168.42.37] (mob-2-43-145-251.net.vodafone.it.
 [2.43.145.251])
 by smtp.gmail.com with ESMTPSA id s12sm9321348wrp.18.2019.10.27.10.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2019 10:02:40 -0700 (PDT)
Subject: Re: [PATCH v15 02/11] esp: move get_cmd() post-DMA code to
 get_cmd_cb()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191026164546.30020-1-laurent@vivier.eu>
 <20191026164546.30020-3-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c5bf404d-a650-8ae5-aeab-9d0c07aea2ae@redhat.com>
Date: Sun, 27 Oct 2019 18:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191026164546.30020-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/19 18:45, Laurent Vivier wrote:
> This will be needed to implement pseudo-DMA
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/scsi/esp.c | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 09b28cba17..0230ede21d 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -84,6 +84,34 @@ void esp_request_cancelled(SCSIRequest *req)
>      }
>  }
>  
> +static int get_cmd_cb(ESPState *s)
> +{
> +    int target;
> +
> +    target = s->wregs[ESP_WBUSID] & BUSID_DID;
> +
> +    s->ti_size = 0;
> +    s->ti_rptr = 0;
> +    s->ti_wptr = 0;
> +
> +    if (s->current_req) {
> +        /* Started a new command before the old one finished.  Cancel it.  */
> +        scsi_req_cancel(s->current_req);
> +        s->async_len = 0;
> +    }
> +
> +    s->current_dev = scsi_device_find(&s->bus, 0, target, 0);
> +    if (!s->current_dev) {
> +        /* No such drive */
> +        s->rregs[ESP_RSTAT] = 0;
> +        s->rregs[ESP_RINTR] = INTR_DC;
> +        s->rregs[ESP_RSEQ] = SEQ_0;
> +        esp_raise_irq(s);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>  static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
>  {
>      uint32_t dmalen;
> @@ -108,23 +136,7 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
>      }
>      trace_esp_get_cmd(dmalen, target);
>  
> -    s->ti_size = 0;
> -    s->ti_rptr = 0;
> -    s->ti_wptr = 0;
> -
> -    if (s->current_req) {
> -        /* Started a new command before the old one finished.  Cancel it.  */
> -        scsi_req_cancel(s->current_req);
> -        s->async_len = 0;
> -    }
> -
> -    s->current_dev = scsi_device_find(&s->bus, 0, target, 0);
> -    if (!s->current_dev) {
> -        // No such drive
> -        s->rregs[ESP_RSTAT] = 0;
> -        s->rregs[ESP_RINTR] = INTR_DC;
> -        s->rregs[ESP_RSEQ] = SEQ_0;
> -        esp_raise_irq(s);
> +    if (get_cmd_cb(s) < 0) {
>          return 0;
>      }
>      return dmalen;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

