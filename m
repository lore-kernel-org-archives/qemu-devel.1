Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A475DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616620665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPnxuLj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLBO-0002ZV-7O
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL9y-0001cv-Mw; Mon, 05 Oct 2020 03:43:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL9w-0002G2-Vf; Mon, 05 Oct 2020 03:43:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id j136so7700045wmj.2;
 Mon, 05 Oct 2020 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jNZgGSdv00Vt+eNZ9kI38Vs96Vi60bucTcGiMo5uk9M=;
 b=SPnxuLj/HBbggkEGW5iUw8hrdpU3zi+xMkWI5rXDVrcOdPlPoqVji/6Y7ToiTy+7S0
 x+NIbRw09F9u/HZzDihnrrgUE7NZbTM9HgcvfPj0wd6LzgdkNYHfKlTi5rcpaK41dbEt
 RNTzf/OOl8VsW/uk9ZvdxXS1s0AVgfeOHaqIuMwfuMr3hiLn6ZCHcw3BwSX1URZlKu9p
 FxDgWPexjfIl1TVAR0jkYwrKOAQmzjFWmH3QhMIyK/Rh8rTGSZA/4lQnrGT4k8TpDB7G
 RDK/FYOtlz2lhFLjKV37Xt/tpi6kOrX9zqlxEdrHh6Y0EuZzuscyrrMSSjveFvkc0IZs
 Ce2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jNZgGSdv00Vt+eNZ9kI38Vs96Vi60bucTcGiMo5uk9M=;
 b=rB4TvqZQMWS+9MhmgrkIs/kS25tu8A5kLx8xY6QdE349q8HjBvcO+vPeJ4TwYBqtzg
 95gBezkU3joE5dOPTaVFLENYXjlXV39BxhCnnY+VQX1p2p5zEHIBijkCxRCAWMf6LF5z
 MymX3cEJHCyoLYQSfNL0ry/25pBkfry4JtrIskCy6kseVLHlXyB5jcWF48L/vDnrFDiW
 pbWyArTcfJpS23Cejnt9xITN+2+ZLjVoqWFDAQ24z0K2vDGcK1/Q6qswCn+uXxtlUsbU
 faojGPXb4kacecG4augsbVBPqdxw0/2ESeVSrFzmg90nIcaM2yxN9zjSvohCOOkTSyOq
 OMKQ==
X-Gm-Message-State: AOAM530tMig5susdz1pSWHK7G8OM9i+0LDapU2NHwonh+6Rw4GQOf/ie
 x7iKBzfZmwF0vCCWwMeftMQQgk1k5QVAMA==
X-Google-Smtp-Source: ABdhPJyveU01Ibp8c+5qd7JBolrBUzC0N+LkVLTt4BK0L+58fraUJK7m7bSSJoxJrPQler2k1A8jAg==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr1219323wma.131.1601883826320; 
 Mon, 05 Oct 2020 00:43:46 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s6sm5259972wrg.92.2020.10.05.00.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 00:43:45 -0700 (PDT)
Subject: Re: [PATCH] hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
To: qemu-devel@nongnu.org
References: <20200919132435.310527-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e35e3c67-2f45-c1e2-b8ea-6f3512829fe4@amsat.org>
Date: Mon, 5 Oct 2020 09:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919132435.310527-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair@alistair23.me>,
 Havard Skinnemoen <hskinnemoen@google.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Can you take this patch via your qemu-arm tree?

On 9/19/20 3:24 PM, Philippe Mathieu-Daudé wrote:
> Fix integer handling issues handling issue reported by Coverity:
> 
>   hw/ssi/npcm7xx_fiu.c: 162 in npcm7xx_fiu_flash_read()
>   >>>     CID 1432730:  Integer handling issues  (NEGATIVE_RETURNS)
>   >>>     "npcm7xx_fiu_cs_index(fiu, f)" is passed to a parameter that cannot be negative.
>   162         npcm7xx_fiu_select(fiu, npcm7xx_fiu_cs_index(fiu, f));
> 
>   hw/ssi/npcm7xx_fiu.c: 221 in npcm7xx_fiu_flash_write()
>   218         cs_id = npcm7xx_fiu_cs_index(fiu, f);
>   219         trace_npcm7xx_fiu_flash_write(DEVICE(fiu)->canonical_path, cs_id, addr,
>   220                                       size, v);
>   >>>     CID 1432729:  Integer handling issues  (NEGATIVE_RETURNS)
>   >>>     "cs_id" is passed to a parameter that cannot be negative.
>   221         npcm7xx_fiu_select(fiu, cs_id);
> 
> Since the index of the flash can not be negative, return an
> unsigned type.
> 
> Reported-by: Coverity (CID 1432729 & 1432730: NEGATIVE_RETURNS)
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ssi/npcm7xx_fiu.c | 12 ++++++------
>  hw/ssi/trace-events  |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> index 104e8f2b963..5040132b074 100644
> --- a/hw/ssi/npcm7xx_fiu.c
> +++ b/hw/ssi/npcm7xx_fiu.c
> @@ -103,7 +103,8 @@ enum NPCM7xxFIURegister {
>   * Returns the index of flash in the fiu->flash array. This corresponds to the
>   * chip select ID of the flash.
>   */
> -static int npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu, NPCM7xxFIUFlash *flash)
> +static unsigned npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu,
> +                                     NPCM7xxFIUFlash *flash)
>  {
>      int index = flash - fiu->flash;
>  
> @@ -113,20 +114,19 @@ static int npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu, NPCM7xxFIUFlash *flash)
>  }
>  
>  /* Assert the chip select specified in the UMA Control/Status Register. */
> -static void npcm7xx_fiu_select(NPCM7xxFIUState *s, int cs_id)
> +static void npcm7xx_fiu_select(NPCM7xxFIUState *s, unsigned cs_id)
>  {
>      trace_npcm7xx_fiu_select(DEVICE(s)->canonical_path, cs_id);
>  
>      if (cs_id < s->cs_count) {
>          qemu_irq_lower(s->cs_lines[cs_id]);
> +        s->active_cs = cs_id;
>      } else {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: UMA to CS%d; this module has only %d chip selects",
>                        DEVICE(s)->canonical_path, cs_id, s->cs_count);
> -        cs_id = -1;
> +        s->active_cs = -1;
>      }
> -
> -    s->active_cs = cs_id;
>  }
>  
>  /* Deassert the currently active chip select. */
> @@ -206,7 +206,7 @@ static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
>      NPCM7xxFIUFlash *f = opaque;
>      NPCM7xxFIUState *fiu = f->fiu;
>      uint32_t dwr_cfg;
> -    int cs_id;
> +    unsigned cs_id;
>      int i;
>  
>      if (fiu->active_cs != -1) {
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> index 2f83ef833fb..612d3d6087a 100644
> --- a/hw/ssi/trace-events
> +++ b/hw/ssi/trace-events
> @@ -19,4 +19,4 @@ npcm7xx_fiu_deselect(const char *id, int cs) "%s deselect CS%d"
>  npcm7xx_fiu_ctrl_read(const char *id, uint64_t addr, uint32_t data) "%s offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
>  npcm7xx_fiu_ctrl_write(const char *id, uint64_t addr, uint32_t data) "%s offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
>  npcm7xx_fiu_flash_read(const char *id, int cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
> -npcm7xx_fiu_flash_write(const char *id, int cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
> +npcm7xx_fiu_flash_write(const char *id, unsigned cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
> 

