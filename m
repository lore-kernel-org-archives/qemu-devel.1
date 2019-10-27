Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCC421726
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCC421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmH4-00038A-BV
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iOlw8-0000oj-St
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iOlw6-00054S-9k
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iOlw5-000549-Vk
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:02:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C0153DE04
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 17:02:36 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e14so4931029wrm.21
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 10:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yBnoaiF4jfKVB78WhgkpYafHEmxESv12cKOIG6F6K5s=;
 b=SKUUBCjMJw9jVg0UAl6aPVO32KF3zjtGgXLshh5wkmqI39Yd7Mm33htiO76Enh+xv8
 pW080/O3rJMobwxQHYVg6jouSofH9ChyzpAK/QqaeahIib4braPCfGBiuHvIo1vha3Wh
 XzsEAFsov1oy2JiY84nJodsJzvPzgP35FQBZFdMtaPAdy8KSW92PL3EdKIvOStl3xlwS
 /1HqqRdPLPtI1YGOWzrM2ybheng+v9HVddjx6LC1y4EyGQgs/5E7h1bdOd7YNXezch+H
 /GL2loosNwKCvWPzRJmgekcpWL35FTpzBZKr1mylEqKu1R8hFQOx1MND/1jXws4sOzeD
 9LrQ==
X-Gm-Message-State: APjAAAU52UUFXMF7Dx6XHks7dFXFXq1sWFk5uBrVIaUxLCGCESxo00kf
 GbFzChTZJVyKjbXu7vlvJbzHGXY5zECENfJeSfl4fLToIVBE6VoaIP9WXYSJlCLBAQyJl0qOp9v
 T5N2dtB6RnqYaw5U=
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr11191535wmi.123.1572195755175; 
 Sun, 27 Oct 2019 10:02:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwMWWmMaHRxtU2BborGGKZoi+4Y9RBRF4YNlHpTjLcbawUs3dBxBoF+7Sp2OCTG61Zs16yyA==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr11191509wmi.123.1572195754897; 
 Sun, 27 Oct 2019 10:02:34 -0700 (PDT)
Received: from [192.168.42.37] (mob-2-43-145-251.net.vodafone.it.
 [2.43.145.251])
 by smtp.gmail.com with ESMTPSA id v11sm8118994wrw.97.2019.10.27.10.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2019 10:02:34 -0700 (PDT)
Subject: Re: [PATCH v15 01/11] esp: move handle_ti_cmd() cleanup code to
 esp_do_dma().
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191026164546.30020-1-laurent@vivier.eu>
 <20191026164546.30020-2-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <67c0e72a-c923-8ce3-5c9e-b41275425d6a@redhat.com>
Date: Sun, 27 Oct 2019 18:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191026164546.30020-2-laurent@vivier.eu>
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
> To prepare following patches move do_cmd and DMA special case
> from handle_ti() to esp_do_dma().
> 
> This part of the code must be only executed with real DMA, not with
> pseudo-DMA. And PDMA is detected in esp_do_dma(), so move this part
> of the code in esp_do_dma(). We keep the code in handle_ti_cmd()
> in the case no DMA is done.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/scsi/esp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 841d79b60e..09b28cba17 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -249,10 +249,19 @@ static void esp_do_dma(ESPState *s)
>  
>      len = s->dma_left;
>      if (s->do_cmd) {
> +        /*
> +         * handle_ti_cmd() case: esp_do_dma() is called only from
> +         * handle_ti_cmd() with do_cmd != NULL (see the assert())
> +         */
>          trace_esp_do_dma(s->cmdlen, len);
>          assert (s->cmdlen <= sizeof(s->cmdbuf) &&
>                  len <= sizeof(s->cmdbuf) - s->cmdlen);
>          s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
> +        trace_esp_handle_ti_cmd(s->cmdlen);
> +        s->ti_size = 0;
> +        s->cmdlen = 0;
> +        s->do_cmd = 0;
> +        do_cmd(s, s->cmdbuf);
>          return;
>      }
>      if (s->async_len == 0) {
> @@ -373,8 +382,7 @@ static void handle_ti(ESPState *s)
>          s->dma_left = minlen;
>          s->rregs[ESP_RSTAT] &= ~STAT_TC;
>          esp_do_dma(s);
> -    }
> -    if (s->do_cmd) {
> +    } else if (s->do_cmd) {
>          trace_esp_handle_ti_cmd(s->cmdlen);
>          s->ti_size = 0;
>          s->cmdlen = 0;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

