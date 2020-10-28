Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79593C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC2724650
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joUOM70K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC2724650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXi8L-0001FN-J6
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXi77-00008p-41; Wed, 28 Oct 2020 05:51:29 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXi75-0002JX-Bf; Wed, 28 Oct 2020 05:51:28 -0400
Received: by mail-ed1-x543.google.com with SMTP id l16so4447915eds.3;
 Wed, 28 Oct 2020 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=m/atS6S/QMVltX7VWGQurXqA6xg/vo3rgTsJT1dTn3c=;
 b=joUOM70KKonhCJhH6rXkXPC2C1KIxcM4K9Ptzp4QpkoF/F4p4liN5pfKJKKEGRuxek
 L6NRfJg7zyJ8ElRMpvk1dnMf2zKD8F1b/Ow6RrzNXsiK6HK1M3LNXhXTEzFhHG9DoD1R
 +EsnUaa+Nn+3Wz9lUJCjbw1+IvhewUVoHGcJxepvGK1jKYR8E+mrfaI7CHc3fD2X+CDP
 qacrhIDW7TUrV/Xbsj2KioNhB31EPwzqQhOw2pm6hcG5OaO03/x9A5iFM/metsyRfWcH
 YVvmRENtE27BtTazchrNdutJtBot4GK4+N6qk1E7DiKOA0IgPWXL6KjfDLeGK3LSBGvA
 dyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m/atS6S/QMVltX7VWGQurXqA6xg/vo3rgTsJT1dTn3c=;
 b=g30Am60RCTIAdil4N8WTK/SP/LeZ98bj1pHp3+cjnCyTCdtbbIJaBcr5ysDD+FkDI/
 xsPrP1i3YoP+kR1WK777jl/Nzx0J6SqLQD2cryIYQL+Kk3EsGNw7Z5e/6mzx6g2/7CM/
 xnQX9bDW7/Ao+IZFrJHWKT+wDsZy2hlToXLK2m+saTvCOO8TbhEy54exa0ydaS9Thf6c
 K0GXl8v3qywdYUN7Bzi5yPfwqU8wZ8z/P7FQjhnDOmd4NnSJh1zOBzAd7J7RRHwIXRXO
 jfkskYVxWY4geHgZ3VozurdvD4/kgexKi0JlcMBnNAJq8/4V+xoS+Z/kBCIM6m5JLRnp
 93jQ==
X-Gm-Message-State: AOAM533S1d6vE0/jJlWF2f3uhSYxeranf6AecIpsnhNbunRy6xt6wtF2
 Yyqi/x3rFzHHuVXXjKnVL/596t6yu/E=
X-Google-Smtp-Source: ABdhPJz/ZGfc4EDOfyeguddpqup8qPXfbrFIkgiGBXEO8S57w5gDr6RpicYcdgqTnJ+2OaRgk3t1Hg==
X-Received: by 2002:aa7:c358:: with SMTP id j24mr6850808edr.265.1603878685620; 
 Wed, 28 Oct 2020 02:51:25 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id yw17sm2626966ejb.97.2020.10.28.02.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:51:25 -0700 (PDT)
Subject: Re: [PATCH 6/9] target/sparc/win_helper: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-7-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9fad34a2-56e1-9c67-bb8a-205640b92544@amsat.org>
Date: Wed, 28 Oct 2020 10:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028041819.2169003-7-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 5:18 AM, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> target/sparc/win_helper.c: In function ‘get_gregset’:
> target/sparc/win_helper.c:304:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   304 |         trace_win_helper_gregset_error(pstate);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> target/sparc/win_helper.c:306:5: note: here
>   306 |     case 0:
>       |     ^~~~
> 
> Add the corresponding "fall through" comment to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  target/sparc/win_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
> index 8290a21142..32eacc05e6 100644
> --- a/target/sparc/win_helper.c
> +++ b/target/sparc/win_helper.c
> @@ -303,6 +303,7 @@ static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
>      default:
>          trace_win_helper_gregset_error(pstate);
>          /* pass through to normal set of global registers */
> +        /* fall through */

Can you keep the comment, doing s/pass/fall/?

>      case 0:
>          return env->bgregs;
>      case PS_AG:
> 


