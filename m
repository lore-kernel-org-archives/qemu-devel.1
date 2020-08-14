Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11CC20768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRl34vl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11CC20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dai-00020G-0n
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6da2-0001Ye-T1
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:33:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6da1-0000Wv-Bl
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:33:26 -0400
Received: by mail-pf1-x443.google.com with SMTP id d22so4879144pfn.5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Sh0mcx+zGwAIkzRQ4Y/acWfhxfgV0OD2tktgTJ6UKTw=;
 b=fRl34vl2kGiB9tRfgRp5FaIxU3p7ZBL+TC3qishkcNfP4FZzvumYaB6oqN+wN8QxsP
 aoX0ILV0/rkMe9uKPECZzF9kbTTtOownR8Ljukk7g7x9PzXUu09V0a1UVIgc1u/oQpJI
 vVJRaYQVMlasyqwvxlwJaYUiciETPA8QdYHD0AXFXAvIgEsWkqkpyBVOpaGT1LpQGpTe
 WTXKoopTGabplxQQLSDKQJG3wrtDMg4Hxi5CPA9x/wkX9VojKXXUTm2faQHfX8U16jXm
 v/vAL1xm6R/7SZ3CZMAjv3FR0yWXXG6apsAzDe3MtFD/fbkRxjiaJpqzkdQZkgXt6rVR
 uz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sh0mcx+zGwAIkzRQ4Y/acWfhxfgV0OD2tktgTJ6UKTw=;
 b=T+OXx+iiH+4xDApWebi0lZblvfyXvdaL+N+tmC7Nnd1A6EytT/GvljS7N7z+UwZhHW
 dlK9fo6jdQlFXEfI1jf3B2UHQbV9Iw2nYzjgtq0rbl6ced3APqe4so54e5NUbamFtzyg
 cWpABKwniSTYAN3w4Hri+YrFo+in4w3tTEHhp8cuHK0mmZORaQwo2oWCjkJBaDs4Kucs
 Ds2euh0prqcDW64hQsG08tBH/AtEChPgPB41MgtRNogBhIljC5qR4n7gzu46mh6fxvMe
 wGJbr14GVRIOu6d4How+l87jI71b9+j04nlafBSoR1WYR6imaulpn7AwOPKeXl1dGdEY
 yLcg==
X-Gm-Message-State: AOAM532w1lTHfh2c1VDQKF0sR/ysG3I95bC/Fo0B/8E2pDDj30ASZI4P
 DB3xxvKacUQMtdijESZa5MWNeA==
X-Google-Smtp-Source: ABdhPJzHutCNX7Rfbja0wBbstbn4NyUEIxmdDJx6MD1UIRFVk5TKjUPDf1eyt89Q3XKBN5MKZz37yw==
X-Received: by 2002:a63:e057:: with SMTP id n23mr2359951pgj.368.1597426403608; 
 Fri, 14 Aug 2020 10:33:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gl9sm9012826pjb.41.2020.08.14.10.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:33:22 -0700 (PDT)
Subject: Re: [PATCH 5/5] hw/char/avr_usart: Trace baudrate changes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814163924.11662-1-f4bug@amsat.org>
 <20200814163924.11662-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5933ecba-3c2f-be0e-6652-c4546f0363ff@linaro.org>
Date: Fri, 14 Aug 2020 10:33:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814163924.11662-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 9:39 AM, Philippe Mathieu-Daudé wrote:
> +static void avr_usart_update_baudrate(AVRUsartState *s)
> +{
> +    unsigned baudrate = (clock_get_hz(s->clkin) / USART_CLOCK_DIVISOR)
> +                        / (((s->brrh << 8) | s->brrl) + 1);
> +
> +    trace_avr_usart_update_baudrate((s->brrh << 8) | s->brrl, baudrate);

Would you pull that brrh|brrl expression out and give it a name?

I do wonder if one division would be better, e.g.

    baudrate = clock_get_hz / (DIVISOR * (regval + 1))


r~

