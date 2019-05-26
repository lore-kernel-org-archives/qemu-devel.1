Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B86C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3A820657
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUvyi-0004Al-Ed
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 12:26:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1hUvwl-0002p2-7Q
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1hUvt8-0007aS-0j
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>)
	id 1hUvt7-0007Zy-QV; Sun, 26 May 2019 12:20:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so14453710wrq.12;
	Sun, 26 May 2019 09:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZgGYtXkvNtALDhltF/6yDWKbriwgg98T51bkGm9mD2c=;
	b=lQHUSIVaZQDiCvTGGyG1tad14JyD0GsdzLAMqfMl/w5aEkjLR9yIZo/Ovv+aoU2tTa
	ecdi1TzqBshCzRXxLicYOtTzWRjgrHU3w6EDSXxxxsLy0zBhR0sDdpQvkGmk7bSjucCg
	5Bfj2rsO4PznWmgfd4D10tkGQcPS8SZOHcbziTvhnwcez7Xa1dAFhdAj6QzX1RTGE8JO
	+9XJxrBSsebIPjeOW9IsoGGLAYr4zJZqY7HzAos99GxGIjWtrOyd4Q+WDfKyf7Rervj4
	NdpyqU9hppUGGn7hLqHUGgUrsVmOtsC1t9o5kNFfD5KclFm5L+igQsgs/1bNciwCVgqh
	SlGg==
X-Gm-Message-State: APjAAAUm8cHQ4ihCqzB5ux9TziObFS9rw+5ynI4p0/snJGXS90nlEIqq
	6B+TslBcVYFUWnquS5HMujA=
X-Google-Smtp-Source: APXvYqzskvP2loPjZM0R1EnBoF6Ki9rBCb3jqUaxQXIapxNGjxZIBsD7/68U9h7KNWynbnt6FxhPRw==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr7346412wrp.120.1558887644800; 
	Sun, 26 May 2019 09:20:44 -0700 (PDT)
Received: from thl530.multi.box (pD9E8362E.dip0.t-ipconnect.de.
	[217.232.54.46]) by smtp.gmail.com with ESMTPSA id
	88sm24808962wrc.33.2019.05.26.09.20.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 26 May 2019 09:20:44 -0700 (PDT)
Date: Sun, 26 May 2019 18:20:41 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190526182041.3a41e568@thl530.multi.box>
In-Reply-To: <20190525225013.13916-3-laurent@vivier.eu>
References: <20190525225013.13916-1-laurent@vivier.eu>
	<20190525225013.13916-3-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v7 02/10] esp: add pseudo-DMA as used by
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau
	<marcandre.lureau@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sun, 26 May 2019 00:50:05 +0200
schrieb Laurent Vivier <laurent@vivier.eu>:

> There is no DMA in Quadra 800, so the CPU reads/writes the data from
> the PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and
> copies them to/from the memory.
> 
> There is a nice assembly loop in the kernel to do that, see
> linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().
> 
> The start of the transfer is triggered by the DREQ interrupt (see
> linux mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to
> start the transfer after a SCSI command has been sent (in Quadra 800
> it goes through the VIA2, the via2-irq line and the vIFR register)
> 
> The Macintosh hardware includes hardware handshaking to prevent the
> CPU from reading invalid data or writing data faster than the
> peripheral device can accept it.
> 
> This is the "blind mode", and from the doc:
> "Approximate maximum SCSI transfer rates within a blocks are 1.4 MB
> per second for blind transfers in the Macintosh II"
> 
> Some references can be found in:
>   Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
>   Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/scsi/esp.c         | 293
> +++++++++++++++++++++++++++++++++++++----- include/hw/scsi/esp.h |
> 7 + 2 files changed, 271 insertions(+), 29 deletions(-)
[...]
> @@ -162,6 +196,15 @@ static void do_cmd(ESPState *s, uint8_t *buf)
>      do_busid_cmd(s, &buf[1], busid);
>  }
>  
> +static void satn_pdma_cb(ESPState *s)
> +{
> +    if (get_cmd_cb(s) < 0) {
> +        return;
> +    }
> +    if (s->pdma_cur != s->pdma_start)
> +        do_cmd(s, s->pdma_start);

Curly braces, please.

> +}
> +
>  static void handle_satn(ESPState *s)
>  {
>      uint8_t buf[32];
> @@ -171,11 +214,21 @@ static void handle_satn(ESPState *s)
>          s->dma_cb = handle_satn;
>          return;
>      }
> +    s->pdma_cb = satn_pdma_cb;
>      len = get_cmd(s, buf, sizeof(buf));
>      if (len)
>          do_cmd(s, buf);
>  }
>  
> +static void s_without_satn_pdma_cb(ESPState *s)
> +{
> +    if (get_cmd_cb(s) < 0) {
> +        return;
> +    }
> +    if (s->pdma_cur != s->pdma_start)
> +        do_busid_cmd(s, s->pdma_start, 0);

dito.

> +}
> +
>  static void handle_s_without_atn(ESPState *s)
>  {
>      uint8_t buf[32];
[...]
> @@ -370,14 +526,14 @@ static void handle_ti(ESPState *s)
>          s->dma_left = minlen;
>          s->rregs[ESP_RSTAT] &= ~STAT_TC;
>          esp_do_dma(s);
> -    }
> -    if (s->do_cmd) {
> +    } else if (s->do_cmd) {
>          trace_esp_handle_ti_cmd(s->cmdlen);
>          s->ti_size = 0;
>          s->cmdlen = 0;
>          s->do_cmd = 0;
>          do_cmd(s, s->cmdbuf);
>      }
> +
>  }

Superfluous empty line.

Apart from those nits (which can be fixed when you apply the patches),
the patch looks fine to me.

 Thomas

