Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C1C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 16:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5516B206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlTJdi/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkVrl-0000q0-MK
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 12:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkVqH-0007N3-Lm; Sun, 14 Jun 2020 12:50:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34318)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkVqG-0001S4-8T; Sun, 14 Jun 2020 12:50:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id u26so12450084wmn.1;
 Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vUcM1ihOKVXqNtoAtuXcDT2vmQmpU5UXjRa6M54amGM=;
 b=tlTJdi/KUhIoayL6P9hVKgI2UanZWQG42Z/XLAWwvYMpFJDwbPWWHEi4IBUadv98WD
 ZH3asHbP6aUE8cPJNolgzNsT8pdyjNO5NVO9REIMwGj8Kdiw7l3/16DhyNlVxXfpONmH
 CXqnHRg3CnQlzRgtpIXc9FWxljjk8+Oo3A5Vo0SXx2Sb/4hDo0vI09yO2acb72RUNoO9
 JQ3xy/S/HX3bVraXV2lqOIjnX/YVepcC6d2+3qfdtcgUwECSGYIT4XXekn6B/QGCNroO
 6zL+8kZw5U+pQgIneWRnBtUOiNHAcIrBifskZtk6LvcJMhZcQxuqn4vebbs1nzccCAmD
 fkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vUcM1ihOKVXqNtoAtuXcDT2vmQmpU5UXjRa6M54amGM=;
 b=kaKUQHI4Ffu1+3JvfLwsIax441/qyZSFfZH7LYKDplf7WQtWgNla6ASu8ltB/7NNEt
 wc0OZ9zNx1XjM3Y00CaD8HX1ZleZe6yS/nsvC8Y7id/80hzjs7FeNFu3M3fAgKz2l2QM
 Cbf6zw49ofS1tLxjruNZM612lvRc5o1sn8fMdHVW/97EfAceDa822Q2p40NJTO8reuw6
 JQr+euN4OUjTQUff/fEsHkohrax9pOJF/Fzp72AcUBE/DxWAn00SPr74Gb8lpZbYkEVR
 hW7b39dgwamg7A50vBDi4fg3sPE4fR/azyG8Mv4WuQaN4oG5K8LuU48LCn1VSi6xN0hh
 xECg==
X-Gm-Message-State: AOAM533levQvyDna0UEjmukAHNJ3UcMF3k1TIXxEgIvYzsU9vNMbtkKH
 Bqvd9RlyJsNtgcmMtxohayMilrkZ
X-Google-Smtp-Source: ABdhPJwOQjyaPKMBPOvqnj5fB9Adisw2iBamJzKHZjepg75JJekvDUAASA1HPZx1kisdMzZDFC2kbg==
X-Received: by 2002:a05:600c:1403:: with SMTP id
 g3mr8622825wmi.136.1592153431726; 
 Sun, 14 Jun 2020 09:50:31 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z6sm20312524wrh.79.2020.06.14.09.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 09:50:31 -0700 (PDT)
Subject: Re: [PATCH 05/22] pmu: honour autopoll_rate_ms when rearming the ADB
 autopoll timer
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, laurent@vivier.eu, fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7fef2e6b-3533-9e75-1268-6a33fdea70ca@amsat.org>
Date: Sun, 14 Jun 2020 18:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200614142840.10245-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/14/20 4:28 PM, Mark Cave-Ayland wrote:
> Don't use a fixed value but instead use the default value from the ADB bus
> state.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/macio/pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index 3af4ef1a04..edb061e417 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -104,7 +104,7 @@ static void pmu_adb_poll(void *opaque)
>      }
>  
>      timer_mod(s->adb_poll_timer,
> -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 30);
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->autopoll_rate_ms);
>  }
>  
>  static void pmu_one_sec_timer(void *opaque)
> @@ -180,7 +180,7 @@ static void pmu_cmd_set_adb_autopoll(PMUState *s, uint16_t mask)
>      s->adb_poll_mask = mask;
>      if (mask) {
>          timer_mod(s->adb_poll_timer,
> -                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 30);
> +                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->autopoll_rate_ms);
>      } else {
>          timer_del(s->adb_poll_timer);
>      }
> 


