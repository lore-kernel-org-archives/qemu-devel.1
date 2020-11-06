Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840872065E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTYxWRE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840872065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6XT-0003Wz-7V
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6W4-0002D1-Uk
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:31:16 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6W3-0005ps-FV
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:31:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id d142so2376776wmd.4
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4S5EHSOhe3KRg5YDUFaFDV2yZBRJM7s955Tyd+1W/60=;
 b=JTYxWRE6+1vA2VQ6FvVxfR3vpR96HtczEFKCmqZwGWfhKBwCQZa9XP+lvEemv0Ej1a
 veYwaJrop3J2WdaFQznyOBzW6QBzlB7EX+djjE2P/TYe0avzSlssjVgvSXtfkXT0VeEF
 62Skim8pEi9IS1O3nXAdG3YmslzonBdBGrpiEbxbXDTH0H3Z5YtExnJM2yAt3y9EtQc7
 /M9Rit8WjPgGoLddEkrOBBsAY0AR88VpyWdyI32KaYtJw/SSPs4uWxkYg1GbrmPNNtCJ
 eol3a+Mh1/itg4R68IgKxaMan5+tGOh+/QDQ2WhAhhmgVs8GAbI9abfAFPT6UzQ7OqTG
 Egnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4S5EHSOhe3KRg5YDUFaFDV2yZBRJM7s955Tyd+1W/60=;
 b=ejBdZgdVDsekSp8mZvzrnk6lhQFx1ONlBjEmGKdzyRMMdjl3eVuezvFZPCa8vjinL2
 k+OwIvzbWO0oSd0LSVGGbkpFrlhrlEbteyNAol/fPCtbhIFshFoGTucBLTYAPkp/jFYk
 QX6ERQLwUqjnGM75gw+OWnsKKS7/baLqTEXExmTZIaM4Xs9qporaNkAZshOK8RDDyo2O
 2+UQgGSKd9BRsmlRend+yeKBJsHf/LdZO0kELOpBg5gOXloCbJatFBM/0q52jUydPYmM
 77o2pBMB/Wecgg41e4Uq1IsM735KTv0caFy7BWrz8To6RVNqZmdRoXYUyyQgmnpkWTMc
 L+kA==
X-Gm-Message-State: AOAM533GzxvX6vtSUnOlp9TLozTWa6RAr0FrnvI7tySaC6o53wQ4sLRR
 /Z7DHYY/IbBJHKBnZCm3MHo=
X-Google-Smtp-Source: ABdhPJwt+at82tGhWpXp5wyLNflDkNdmXaoOkjkM2McbLGKuinWhU77fx+kw66svNdHA2wFtUpQxVQ==
X-Received: by 2002:a1c:e286:: with SMTP id z128mr939878wmg.33.1604687474229; 
 Fri, 06 Nov 2020 10:31:14 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c8sm3358734wrv.26.2020.11.06.10.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 10:31:13 -0800 (PST)
Subject: Re: [PATCH for-5.2 4/4] hw/net/ctucan_core: Use stl_le_p to write to
 tx_buffers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b545a78d-7b11-7c6d-cdf7-bf20272b8fd6@amsat.org>
Date: Fri, 6 Nov 2020 19:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106171153.32673-5-peter.maydell@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 6:11 PM, Peter Maydell wrote:
> Instead of casting an address within a uint8_t array to a
> uint32_t*, use stl_le_p(). This handles possibly misaligned
> addresses which would otherwise crash on some hosts.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/can/ctucan_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
> index f2ce978e5ec..e66526efa83 100644
> --- a/hw/net/can/ctucan_core.c
> +++ b/hw/net/can/ctucan_core.c
> @@ -305,8 +305,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
>          addr %= CTUCAN_CORE_TXBUFF_SPAN;
>          assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
>          if (addr < sizeof(s->tx_buffer[buff_num].data)) {
> -            uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data + addr);
> -            *bufp = cpu_to_le32(val);
> +            stl_le_p(s->tx_buffer[buff_num].data + addr, val);

Out of curiosity, how did you notice? Passing by while reviewing?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

