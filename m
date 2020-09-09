Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB02206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdwL9rIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB02206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2we-0002XO-4J
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG2vs-0001E2-DS; Wed, 09 Sep 2020 12:26:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG2vq-0008FY-AA; Wed, 09 Sep 2020 12:26:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so3622381wrp.8;
 Wed, 09 Sep 2020 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+slD6iVjN/ljxVLGr18dBu6NG9xCNi0MEhdUze1ZLrI=;
 b=UdwL9rITPuhHuSEe55gw4yqQPOwRE+UrbL2BVYumKirwoi5egETbwkuFzvDVp1zK+F
 RpcJc+DShuVZw1JtTGt+h7mTtTNXGitDgPhpezGEAfORK4GsIrd+V9D65rHpomjXdKJK
 iUTerDlki+PQvZL3Gcq9JWmzOHq1jJzPhtPWfVtdKsG3qHYoo97E29nRRA4szag+cTcf
 hsQ0rjR1RllYFdlCgQfeSWp7oDrAgq0JW6WJBIVVQq1giq8vfw1lRcv9TpwkLf7pIXXb
 RKDYcwyN9mio4hN8c8d9bZDzlkmjB9xMmCcVIA0yoZyejqPqpzFn2ZBjL8H/ZY6mgcxu
 8dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+slD6iVjN/ljxVLGr18dBu6NG9xCNi0MEhdUze1ZLrI=;
 b=HDbgtBdjKaBtjkFYHxrzBuFNevF81axSJBkbQ5FFqHh6PH8MuQHtzT4NePNbBY3rVd
 Vhjm+Te4OmVdQvwytKR1psiYyphY4CyYgPxfDPEXSYBtCTs3HfDHajMcYhl3tJhRUzBh
 bWH1rGuCi4SDKpLc/JZin6ZBURP+j6nYr++FbZJG25In+BN6oT3Xlivoxi2+OAhJbpdi
 JBmdZXktGfuTxePnYZdJe5jEEWVXu/EBuGV5yktqOkPvQy+EEXojbFLSPNR0ZXEqRxvt
 nnCVGrYr/DEv5xNtevDvNrGr5oWhc+7IkIB++AHkWBGQJGct8tiPNYTJh4F9CJADQZya
 K6QA==
X-Gm-Message-State: AOAM531bSDZ/iEj6e/4MlZQFKTS1y0+5+SaPUucEQNql34XK8emBlXx0
 QVYiUZIrJvgla32tojsjOvs=
X-Google-Smtp-Source: ABdhPJylYEhPX2153uV+7MOetX7nHlkgYEJODZWfIAQLJMD7/b4M5NWrkrhqDi45RoPoaB5rH1ZXfg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr4646824wrs.227.1599668808158; 
 Wed, 09 Sep 2020 09:26:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i11sm4658512wre.32.2020.09.09.09.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 09:26:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] hw/arm: versal-virt: Correct the tx/rx GEM clocks
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200909161514.622998-1-edgar.iglesias@gmail.com>
 <20200909161514.622998-2-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b413810-f302-35f5-4b2b-2c22565c3d5b@amsat.org>
Date: Wed, 9 Sep 2020 18:26:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909161514.622998-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 6:15 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Correct the GEMs tx/rx clocks to use the 125Mhz fixed-clock.
> This matches the setup with the fixed-link 100Mbit PHY.
> I also avoids the following warnings from the Linux kernel
> driver:
> 
> eth0: unable to generate target frequency: 125000000 Hz
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/xlnx-versal-virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 4b3152ee77..43d74b850f 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -212,7 +212,7 @@ static void fdt_add_gem_nodes(VersalVirt *s)
>                                s->phandle.ethernet_phy[i]);
>          qemu_fdt_setprop_cells(s->fdt, name, "clocks",
>                                 s->phandle.clk_25Mhz, s->phandle.clk_25Mhz,
> -                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> +                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
>          qemu_fdt_setprop(s->fdt, name, "clock-names",
>                           clocknames, sizeof(clocknames));
>          qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> 


