Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC429C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 16:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EEE206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu9vRkIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EEE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkVqj-0007yD-P3
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkVpx-0006VI-4X; Sun, 14 Jun 2020 12:50:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41568)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkVpv-0001HJ-LP; Sun, 14 Jun 2020 12:50:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id j10so14678440wrw.8;
 Sun, 14 Jun 2020 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jyx+bEMgCuG5cAy962G8eiAKSPrlmGGreQlxP/44PF0=;
 b=Pu9vRkIQs87bAatP3U7ZBY+M7PvoCP8LUw/DiMpY9L7xSu97n9Wz7C14X3hTN1JF88
 S0MtJaK44Wn4QQ6ToDrL4BiSMJqXa15mYVvYhghDHLtBMNekKWtInAeW2jBYpZ1ULhbg
 K7XjAi58XJTQ1XHFFzuIkQQwxFRWtPXfRDsQBvFMhOnnkrrC4Ej0mqc3pmUw8ynq5qM4
 yxUJZEo+CZSKjF7Sfdp55ysnGWjVo6UaSTXK86yIP8vjDZ2qm7fAtwiZ6EAtt9v+oPkd
 yeqEbI71RdR9hctzhJ61e9HUHADo41rrcoljvbmXA67dvoB++EPJACkZ3tB+1p9cdrpw
 Ne0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jyx+bEMgCuG5cAy962G8eiAKSPrlmGGreQlxP/44PF0=;
 b=dUeDQag7SaMzHh30BulV1z1Sy6daXNtAVC4U9L7VP+X1nrzCQfPiaWqSllCqnRxeD8
 PF/PxjEqlP8CGOhcdYAY9bXCWPh6XTVWOJFlXRsBu0t+/IAdIF3x6rMg8xdivzL1PCZf
 7B7b669p8rJMVZtlLxztf1YouU2sAgxpHVFfou3f8meCgEEM0BQLWTSkdMjDFisGoO8a
 NnKbDgPI8dDKNRzU0n1NLIlL3zAcqoTiVraWoi3IK22IUpcgIxxe+yPAGAvm7+BnQmvg
 AKNt4AGuiqAaYY5TVJ6pyTnxdLlLp4FS2VdBoBgML1Xsdr5/v9UQJddBvWGGoipyRy6Q
 U9DQ==
X-Gm-Message-State: AOAM532skoFHAritI8g70jETHHCAS11BWIG3iH10SvL9uqlpKxDo6c++
 P92V59J55PKYlS2Bgr8Hw7w=
X-Google-Smtp-Source: ABdhPJwdfAKCWkKZ3eXk3RO8WLmebChcELGzKNnQlb2PbSRFU43g697ccx3Xh8c4ERccumQY1cpyvA==
X-Received: by 2002:adf:f251:: with SMTP id b17mr23695663wrp.289.1592153411755; 
 Sun, 14 Jun 2020 09:50:11 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d18sm19767811wrn.34.2020.06.14.09.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 09:50:11 -0700 (PDT)
Subject: Re: [PATCH 03/22] cuda: convert ADB autopoll timer from ns to ms
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, laurent@vivier.eu, fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b773d333-c99d-73f8-3ecb-bad209536c11@amsat.org>
Date: Sun, 14 Jun 2020 18:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200614142840.10245-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
> This is in preparation for consolidating all of the ADB autopoll management
> in one place.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/macio/cuda.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index e0cc0aac5d..a407f2abc8 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -208,8 +208,9 @@ static void cuda_adb_poll(void *opaque)
>          obuf[1] = 0x40; /* polled data */
>          cuda_send_packet_to_host(s, obuf, olen + 2);
>      }
> -    timer_mod(s->adb_poll_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -              (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
> +
> +    timer_mod(s->adb_poll_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +              s->autopoll_rate_ms);
>  }
>  
>  /* description of commands */
> @@ -236,8 +237,8 @@ static bool cuda_cmd_autopoll(CUDAState *s,
>          s->autopoll = autopoll;
>          if (autopoll) {
>              timer_mod(s->adb_poll_timer,
> -                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                      (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
> +                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                      s->autopoll_rate_ms);
>          } else {
>              timer_del(s->adb_poll_timer);
>          }
> @@ -262,8 +263,8 @@ static bool cuda_cmd_set_autorate(CUDAState *s,
>      s->autopoll_rate_ms = in_data[0];
>      if (s->autopoll) {
>          timer_mod(s->adb_poll_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                  (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
> +                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                  s->autopoll_rate_ms);
>      }
>      return true;
>  }
> @@ -539,7 +540,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>      s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
>      s->sr_delay_ns = 20 * SCALE_US;
>  
> -    s->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
> +    s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
>      s->adb_poll_mask = 0xffff;
>      s->autopoll_rate_ms = 20;
>  }
> 


