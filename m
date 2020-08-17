Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A91C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD872067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzxRLaVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD872067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7c50-0001Tm-HB
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7c2W-0006V3-6Z; Mon, 17 Aug 2020 06:06:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7c2U-000687-M3; Mon, 17 Aug 2020 06:06:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so14369847wrw.1;
 Mon, 17 Aug 2020 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xrq1Ped2wCMWwFa4TAfKFe7kJsRnW5aQJuuYBRy4Mks=;
 b=TzxRLaVDLogpHIf41zVB3oCOwjvWPkCrlPuwjEp1YVzI8LK7aAzQ5vklyAJsi7MaES
 VX1R82iMZTQ9ZpVhefkXsBYk6Fm14/6ntosLNeAC3GRm3x7oFo27rDQFqN8agDEdc+F5
 7c3+pUV2LoZBWb3TU8AKNHBlMypNodokTsdg8+N7/D9A7kvujg4Y1sjoRyeJxqbIhcoS
 J3UuxO1J08TfNj1iQPGjiVxmK6rPVY2265ELJkCyJJk/Rku7jpDdRF0OVAvX83tQxc8v
 hZGgiI0gJADjVnNrKD4O3HUYN6KRnf38KlYPEicEV1L+MU210YgfdPD4elc3iiw8swp4
 5+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xrq1Ped2wCMWwFa4TAfKFe7kJsRnW5aQJuuYBRy4Mks=;
 b=X6KEiy2eUKp+I9zQAEhqm1VoUbQkYCSfp8jMmCyhLeVTR4TBV0hQOuGz91HhydrJ1P
 nfd7WJXf8soPYc4HG0rUF8kPezxrzJcqlIETicO+rWuOTkRMnKDhs8QXpP4VGDyKmGR3
 9rIjv/3/W9mhWMauuRSPfmICYMHtZKum8LD03GB5s8Y+35OQ9kZlt8K/kgobM0nbmbEI
 x2S+wDhtQdTCt3jzj08Xju9giHp/ejdbvlv9ljWFZWM8e9d5W7JBsADtOD7gqRv8jaPe
 EZGuP8pRtFisJR2F/3SQ/RKL1GKF5kmOnfZ245YGiukccOFuMxdWoOqj97QUj6soo7Px
 nx+w==
X-Gm-Message-State: AOAM530IiHaE/VTHFwdNfCPaTZrfBZEPj+jzN+t+WkP7lWNrnFMqn1KT
 kKgsPMVzCurX5sQtykueWUx+9Qmij5Y=
X-Google-Smtp-Source: ABdhPJzEYckIXs+fFGxnUGWEgYpSxzH2EEv580ny90hY60eIgMb+J6oCcGczYEjtGsC5P8dfNsVljQ==
X-Received: by 2002:adf:ab55:: with SMTP id r21mr13981213wrc.332.1597658804529; 
 Mon, 17 Aug 2020 03:06:44 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k204sm29620832wma.21.2020.08.17.03.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 03:06:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] hw/sd: sd: Correct the maximum size of a Standard
 Capacity SD Memory Card
To: Bin Meng <bmeng.cn@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
 <1597658633-12802-3-git-send-email-bin.meng@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb5fe99a-9437-9491-7f2e-1557e6ddc8e1@amsat.org>
Date: Mon, 17 Aug 2020 12:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597658633-12802-3-git-send-email-bin.meng@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 12:03 PM, Bin Meng wrote:
> Per the SD spec, Standard Capacity SD Memory Card (SDSC) supports
> capacity up to and including 2 GiB.
> 
> Fixes: 2d7adea4fe ("hw/sd: Support SDHC size cards")
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> Changes in v2:
> - fix SDSC size check in sd_set_csd() too
> 
>  hw/sd/sd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3226404..254d713 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -50,6 +50,8 @@
>  
>  //#define DEBUG_SD 1
>  
> +#define SDSC_MAX_CAPACITY   (2 * GiB)
> +
>  typedef enum {
>      sd_r0 = 0,    /* no response */
>      sd_r1,        /* normal response command */
> @@ -313,7 +315,7 @@ static void sd_ocr_powerup(void *opaque)
>      /* card power-up OK */
>      sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
>  
> -    if (sd->size > 1 * GiB) {
> +    if (sd->size > SDSC_MAX_CAPACITY) {
>          sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
>      }
>  }
> @@ -385,7 +387,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>      uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
>      uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
>  
> -    if (size <= 1 * GiB) { /* Standard Capacity SD */
> +    if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
>          sd->csd[0] = 0x00;	/* CSD structure */
>          sd->csd[1] = 0x26;	/* Data read access-time-1 */
>          sd->csd[2] = 0x00;	/* Data read access-time-2 */
> 

