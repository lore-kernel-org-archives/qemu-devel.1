Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C56720786
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9laT7XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C56720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCix-0007QA-7t
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtChz-0006Tk-NF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:14:07 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtChx-0003Um-O7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:14:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id u18so4862086pfk.10
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=yRszIO+asOdMN81y4SKo72hakbQ2LURyUSdgABBh96Q=;
 b=u9laT7XMXQXFhXpvDTVrfVM1XEq0x5acrq5l32VbZAKts0J2dBFwe2wW1tsiphKhl4
 hxa6uW9XiJQZdVz3/KoMoIjLYk1tMuqJhDtjnzhPrnzKl+pzOEDodIppd5V8kNL+1LVa
 SLSz85BYKJfFA9QBQSCW0dw/3bMvVjEku/pGGQUhOwug2dlLUhW3LbqsWB6pxjobXqNy
 jhIEnCLA2SU0NjIS26/TNE5I8iuSMbHgXPI7dlYNrAmaAKgzLGRxdDFojPZuHlMNCb9c
 98fV1yXXrjpkmxa2ciaDOjp8M4gTXeHjfqtsvTVNTHuANIYn9grr+60msWnJWN9dhG0k
 WzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yRszIO+asOdMN81y4SKo72hakbQ2LURyUSdgABBh96Q=;
 b=QWJQJvJWyjKQDIORInYTnKlty+hxQRe1fbYVrwFQ0DDkCHN050ni3dU32Qkm47ztQv
 HZTwN2/X7/YHv52vsV8SU7OgMEifQPYRl99o+N6Ys8YV4Wn5xVDYOhsYZ2TNTYq2RkmN
 UMwRwe06JtT2yoa9Xi9i0WGNLaorbgzzi5RvjM4IQa15hDb0W2LEhDTPhuNJ86P6VQmA
 8879Sz09iLhUUIvJ6za7XwBXYuBiCZcMCRPODJ9vUf73/DxxRJ40ffxDHwTvosll2cHr
 D8WAAO9WgFiBtKURpn9cl+d0HyuAn6ICURuYgfzvkFyyU7mXGVJAz9GxdB7dYdVAGtRy
 f2dg==
X-Gm-Message-State: AOAM532v7ZYJJpxYaxKw9ASjzVBIkmyc1VNWV/SBy9Lu0j92g+EYsNnf
 jBoaC4VbX5a3ng4JUOW1zdm4i6XKZGc=
X-Google-Smtp-Source: ABdhPJzcqdlEqRnXEobD/djKbPVKGZmxcfNyHhnahmqABZvAbKW7Pl/GyMob8silVYrzLN6HNiteXQ==
X-Received: by 2002:a65:5682:: with SMTP id v2mr49794309pgs.231.1594224843644; 
 Wed, 08 Jul 2020 09:14:03 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id a19sm273046pfn.136.2020.07.08.09.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:14:02 -0700 (PDT)
Subject: Re: [PATCH 05/21] target/xtensa: support copying registers up to 64
 bits wide
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-6-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f591058-a694-81a6-ee1b-a426b7402ae9@linaro.org>
Date: Wed, 8 Jul 2020 09:14:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706234737.32378-6-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 4:47 PM, Max Filippov wrote:
> +                if (arg_copy[i].arg->num_bits <= 32) {
> +                    temp = tcg_temp_local_new_i32();
> +                    tcg_gen_mov_i32(temp, arg_copy[i].arg->in);
> +                } else if (arg_copy[i].arg->num_bits <= 64) {
> +                    temp = tcg_temp_local_new_i64();
> +                    tcg_gen_mov_i64(temp, arg_copy[i].arg->in);

This shouldn't compile.

You can't assign both TCGv_i32 and TCGv_i64 to the same variable.

What's going on here?


r~

