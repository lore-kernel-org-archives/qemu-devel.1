Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A416220774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrvHJxhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A416220774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vx4-0006Bw-Qk
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5vv1-0002RC-2L; Wed, 12 Aug 2020 14:56:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5vuy-0005PK-LC; Wed, 12 Aug 2020 14:56:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so3011025wrx.9;
 Wed, 12 Aug 2020 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7B2qr/BUzGQOKH4il/G8YhlkCNVM/EenlUe+FeUmbTk=;
 b=qrvHJxhzdMIrFw1I5M5BQ/+dtS8WZPOIEyfszHxLxTSbNLSUFnNGLXI85Kmlt2/KYV
 R4qPZCqBhjogA7DI1sV+/6Yd06b2UC57nxBXMKmigPJGVVU+p5sm0FmHlKmMFISjkIeZ
 +jCvzu91Xc1A1XsihiTO4moOLEplWs6NM3hQl+La68LuLj2N3/Ie/1s893DqbnkL7sV1
 AEX7gEmrjDE3Tai0aOcRg/jej9cbycEZRRj2P7i9GvlMSkoeZiKSBpfGHfabRbQC/FmX
 P6+UvgjZiSMjyh+d8I2D3Lg6gzpkCmFjZXrsGJJEgFRf2ak+gEzm3yXxQE6Me46RwPYV
 Pscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7B2qr/BUzGQOKH4il/G8YhlkCNVM/EenlUe+FeUmbTk=;
 b=V4DAFYYdaIsBjMt/1Gy+yMYfG+e/7M5Ps6TFu3+VDABpeKtvP+V7aSFbUgu2oC3v4K
 +8mks50zHTr4nX9DhWnw6hjg7TECXg5cm6wo9Zx4xpDUmfRap5ajo2XnsWioCqEApVoH
 tUCWdd7kq0TpOhAGrvqjIbp5y3mpLtqtvgDdDt5wlPAlRFz+4rKiSF+JNu6O0qz7IzG4
 bitT7vEFjuZBws9R4lD1q99+RVrpoJpign9LNbu/RJPieeeVhVlXuOZ0TiSYCg241R65
 DSTB5pxPyVsNOJd75+JFPHW9iHPQ83jRQqnEp2wLDmeK67UBcOys9p4vH0CxLsSarggJ
 aWzw==
X-Gm-Message-State: AOAM531fey9tWO4kB7HFyzMk1IWghCjMjzM23V7kKenNk170DlaPWR3/
 6Unjl5Qdc00pQ9oj3YFhg5A=
X-Google-Smtp-Source: ABdhPJyw8TFzrAyDALNLv5nsYsoc9D5aGK+BoRIoptqol1+5X1X6x+Bq4W2n9wIiMXpPJCj3l+cglA==
X-Received: by 2002:adf:de08:: with SMTP id b8mr537555wrm.4.1597258566344;
 Wed, 12 Aug 2020 11:56:06 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t189sm5400623wmf.47.2020.08.12.11.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 11:56:05 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] hw/intc: ibex_plic: Honour source priorities
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1595655188.git.alistair.francis@wdc.com>
 <a697ca8a31eff8eb18a88e09a28206063cf85d48.1595655188.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7899d7e1-f33f-fb40-cace-a20b218cc89e@amsat.org>
Date: Wed, 12 Aug 2020 20:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a697ca8a31eff8eb18a88e09a28206063cf85d48.1595655188.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/20 7:34 AM, Alistair Francis wrote:
> This patch follows what commit aa4d30f6618dc "riscv: plic: Honour source
> priorities" does and ensures that the highest priority interrupt will be
> serviced first.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/ibex_plic.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
> index 669247ef08..f49fa67c91 100644
> --- a/hw/intc/ibex_plic.c
> +++ b/hw/intc/ibex_plic.c
> @@ -57,6 +57,8 @@ static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool level)
>  static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
>  {
>      int i;
> +    uint32_t max_irq = 0;
> +    uint32_t max_prio = s->threshold;
>  
>      for (i = 0; i < s->pending_num; i++) {
>          uint32_t irq_num = ctz64(s->pending[i]) + (i * 32);
> @@ -66,14 +68,17 @@ static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
>              continue;
>          }
>  
> -        if (s->priority[irq_num] > s->threshold) {
> -            if (!s->claim) {
> -                s->claim = irq_num;
> -            }
> -            return true;
> +        if (s->priority[irq_num] > max_prio) {
> +            max_irq = irq_num;
> +            max_prio = s->priority[irq_num];
>          }
>      }
>  
> +    if (max_irq) {
> +        s->claim = max_irq;
> +        return true;
> +    }
> +
>      return false;
>  }
>  
> 


