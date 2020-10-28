Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00842246A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWgH0OsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00842246A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXiGj-0004c1-OG
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXiFF-0003x7-B1; Wed, 28 Oct 2020 05:59:53 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXiFD-0005HP-9D; Wed, 28 Oct 2020 05:59:52 -0400
Received: by mail-ej1-x642.google.com with SMTP id za3so2263049ejb.5;
 Wed, 28 Oct 2020 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jlCdX7cCEkH6VvDWJl/NIiiU6V4dHhOqLcW92NV4Jto=;
 b=uWgH0OsOQ1nyirdNYL5mpYPe1N+pcARLC9Ru6KkeXLgv9GND4VJ41rHyc7gGfgKa8O
 Cmnrdi72ELHmKjivzCiVZsMQds9iwOD5jeUH3kQm7rTu1A6GJorI1fOnbfbdDA0cnNmk
 ND7VS7+kBnu4nE+jqQFO7VGXFQzRNWc1yfupzxJFntayYSCGYVGcaBas0lHmKXKkWFkU
 CzjCf+SkyXexohG+0kneeSzcRd9YEdvNgqdMixAuF9z6OOZPV6QErNulSSQlfaLFsgVK
 nlJDV687fcY2skljZvofDdx8Tuhk3U6Ew5y404/0U6FBazoD1YRZgvTMufbO3e7ZIMt2
 5RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jlCdX7cCEkH6VvDWJl/NIiiU6V4dHhOqLcW92NV4Jto=;
 b=ZEDK50C+tIzzfLoG440jyyaxAXlTpR4prQtugtPTqBmw4k5bVcAUnkBocWt1qSPmg1
 N1Ye9d58uRQB18ZSSOzVdM/LMvzL5baVvS91ui8Rsd/GqpLWG6c+xsMCtm1jVg/IQ813
 nk1cl+hHnBtPX1n0IcG/Zn1FSjYCG4U4Ov3Mhl2x1LkgQmWxnJR21zDKrE4YxMxPyYeL
 JGJAQ6be76WJjMqFHaH3kx25okgTcjMnLJVtcRfmI3lbI6u2x7EP0LZVCc4T0+ca+KPJ
 KTPc2jWUg7BDIikNj71ibDp/quI/xh3Y7h4jSJMY9RBOuH7ZM5Q947rEtWZ9CFMoA6Wd
 NUDQ==
X-Gm-Message-State: AOAM531woJG2A2+PIb+EhBy1g+/q+fw4QEHWJHtMkUkalezFB59IfHSH
 nswkFql17BptD5GMcxIVvfLBHdAlt3k=
X-Google-Smtp-Source: ABdhPJwCeX/BehkDgOX45VqnxTpTTOVP4oF1w2BIwYgMiSZ3yGUvbVmG9rfI4sA/QoFFQvcojqQekg==
X-Received: by 2002:a17:907:72cd:: with SMTP id
 du13mr1410522ejc.398.1603879189625; 
 Wed, 28 Oct 2020 02:59:49 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p9sm2598741ejo.75.2020.10.28.02.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:59:48 -0700 (PDT)
Subject: Re: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-10-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
Date: Wed, 28 Oct 2020 10:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028041819.2169003-10-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: ganqixin@huawei.com, Magnus Damm <magnus.damm@gmail.com>,
 zhang.zhanghailiang@huawei.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 5:18 AM, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> ../hw/timer/renesas_tmr.c: In function ‘tmr_read’:
> ../hw/timer/renesas_tmr.c:221:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   221 |         } else if (ch == 0) {i
>       |                   ^
> ../hw/timer/renesas_tmr.c:224:5: note: here
>   224 |     case A_TCORB:
>       |     ^~~~
> 
> Add the corresponding "fall through" comment to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> ---
>  hw/timer/renesas_tmr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
> index 446f2eacdd..e03a8155b2 100644
> --- a/hw/timer/renesas_tmr.c
> +++ b/hw/timer/renesas_tmr.c
> @@ -221,6 +221,7 @@ static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>          } else if (ch == 0) {
>              return concat_reg(tmr->tcora);
>          }
> +        /* fall through */
>      case A_TCORB:
>          if (size == 1) {
>              return tmr->tcorb[ch];
> 

You fixed A_TCORA but not A_TCORB...

How the Euler Robot works? Like Coverity?

