Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D269720720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfBf3Qgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D269720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJg3-0001Hh-Vk
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJfJ-0000dy-J5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:39:49 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJfH-0002XX-SF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:39:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id j19so93885pgm.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7ZboWJxS0N+CSgusXstPnnIsHtDyEy1TBuACGgOpANE=;
 b=TfBf3QghA0TOAOM5XlIVksakdzaFQ7DNg9LwTsScpdrUxBweLHIBLtPTilFSLsjeB/
 7Vk4vjneQVx5RVlz2Cj+iuGp6auslX8DSLVLMBuUEJir0cnsHHDQLI4XdzHHXNZpGksf
 f6R46QoiZhOpwoseINZBsWvFP4LacUWJ4z0OdifEBzBXOPlXGmv/KZtRJeIXwYxmlECM
 G9Nab5pak4NjAKOvPDFdejjr/P6ovtRLROSahYEdzgIbD+0xSBHq4KdZSkujlj9Jk/ey
 pglZkaRT2XY0v+G17pdwRoW4fCiDxZgBpPuKi8Hh/2c0TLr74NdMmEr9m7JogES+8Neg
 XBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7ZboWJxS0N+CSgusXstPnnIsHtDyEy1TBuACGgOpANE=;
 b=ESMN8BNInkbvgVJsOdLRdxreMA2vX/Me26Qfx/0oSSPXWcze1Vz6d8A9HjjdDfQGbO
 d/zPaR+cCt4aqXO/Oq/udgG5WbRRuQ/sM2SyQUtAo49NS/Ctdbbf2dIplZhEzB2Ul4dr
 6D8yCkxWLsmXRQ6/gJ9zAWPo882/xKyTHPt/nd+qavfsmzmVYvmbuXWsG05S8BPyRgV1
 EyHGeWbIuNpEpD02RX+woWgcGQyfA4rCncJSHACbE8arRDSupi0SYRxxakH2j6GVNW6G
 PtsZ1RbKrLpVLuWcBunqXUIy5zAORzCsltqG97g9RTI+pq0AOHdtbHQwbKHw61C64SM9
 Wzxg==
X-Gm-Message-State: AOAM533to+2LWYmOqvjJOO8y4ZHdhR6RkktB4TKtVAMroBrNosYF9qYs
 k4Su1f8e3Lh8AisZ1uyheSidQw==
X-Google-Smtp-Source: ABdhPJxHccbXTQfbHPGUXxsSf9KrWLvY/a2lCxoBZ4/A1lXwwIvmpM/+X0Je0zYauppKJI/OLBWc1g==
X-Received: by 2002:a62:f241:: with SMTP id y1mr45405909pfl.136.1594251585367; 
 Wed, 08 Jul 2020 16:39:45 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id d22sm755810pfd.105.2020.07.08.16.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 16:39:44 -0700 (PDT)
Subject: Re: [PATCH 5/7] hw/rtc/m48t59: Reduce timer precision to milli-second
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f2811c2-eeea-f6ef-a889-2efe7fa475ba@linaro.org>
Date: Wed, 8 Jul 2020 16:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616075121.12837-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 12:51 AM, Philippe Mathieu-Daudé wrote:
> +    timer_mod(NVRAM->alrm_timer_ms,
> +              qemu_clock_get_ms(rtc_clock) + next_time_s *
> +                                             NANOSECONDS_PER_SECOND / SCALE_MS);

I'm not keen on this last.

I would much prefer a MILLISECONDS_PER_SECOND define.  Should we in fact change
the units of the input...


r~

