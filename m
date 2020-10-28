Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3760BC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F66246A2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRFJaOMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F66246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXi7m-0000kQ-PE
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXi6P-00086M-D3; Wed, 28 Oct 2020 05:50:46 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXi6L-0001zn-DL; Wed, 28 Oct 2020 05:50:45 -0400
Received: by mail-ed1-x542.google.com with SMTP id o18so4444914edq.4;
 Wed, 28 Oct 2020 02:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7rcqOUgGpPWm5Nn7fhEiGwGbSvogxqhTXe49HW3eu0A=;
 b=eRFJaOMiRcsTdp2+mrI1pT6j2PrdLz3Of5nKsIaFPYf2yA/tDG1xlzYstYEOlg25JR
 7LLpdWD0biBNs6sfOsd7S0Gdj3JLVBUyw2ZnFNdeyIiOwomfetAUMusA+rKdRy3ChxqF
 MmqejvC7D+ZgKnl/HEQW7d/AFIbKmH3BvDO4mJOsxDpLcmnNUcWcXw0CH8aTdpwf8FXL
 dHZoNEmZtAq4rm8lRpZ0jHI3mAmDooL4UBIj7wx0hI101BKX1lBpsE/5oS97C+sehSlk
 RAOn6bl9eiGDs+x9Fly46BZeImxZ+3jQZ6egsFujbtAE2IecY/LDplc9OO6YQsxNlbUH
 k/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7rcqOUgGpPWm5Nn7fhEiGwGbSvogxqhTXe49HW3eu0A=;
 b=jv7P9OThdi+B1bCexpPHSEJpTTnY7idN8OnyYrnap1sbBztMtSpjv8lX/5i7AlRnN2
 hImkH5eW3iIjyPb7iq7MQzcJ4CgIhTCJbtCktZTFCuqMrxqxdb+4K6klvJ/7mR30HJNC
 e9iH3m/+dFIAg187eT7zwDtgv42I2w1XeJRjBGJ2kbYlSSaILwpY09l7FSsQTTNGVOoZ
 5vPe8awlQdD0uDmYFjOwoXTob6xDil9VfMQLaZ7QS4lizotZRmofmakfDheytTZQjOLy
 DsYQ2MaPOhJKUyCKPRGL0iS/QptOyy17ceAGUKOlaHYOhGLA8pQPjGFk3IBTEWpTsRUp
 yAnA==
X-Gm-Message-State: AOAM532VjYeFkAwQ62uQFvXCPL4RKxcUIQFBfv7yc7M7gHaeDpad5dEk
 OCjQS/t2iZbpUkpXNckZs24=
X-Google-Smtp-Source: ABdhPJyCSlrwJ6lm2qE1mtTsdLCT3ebz6wpXO8+Kzk/PLCvI0hibJmRiWZm5BO3rRdlnmQkNgAHHfA==
X-Received: by 2002:aa7:c2c4:: with SMTP id m4mr7165061edp.172.1603878637406; 
 Wed, 28 Oct 2020 02:50:37 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id k1sm2568021edl.0.2020.10.28.02.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:50:36 -0700 (PDT)
Subject: Re: [PATCH 5/9] target/sparc/translate: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-6-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83258829-a9c8-cf82-1e1b-0ce2129701d4@amsat.org>
Date: Wed, 28 Oct 2020 10:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028041819.2169003-6-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
> target/sparc/translate.c: In function ‘gen_st_asi’:
> target/sparc/translate.c:2320:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  2320 |         if (!(dc->def->features & CPU_FEATURE_HYPV)) {
>       |            ^
> target/sparc/translate.c:2329:5: note: here
>  2329 |     case GET_ASI_DIRECT:
>       |     ^~~~
> 
> The "fall through" statement place is not correctly identified by the compiler.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  target/sparc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 1a4efd4ed6..a3d9aaa46b 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2324,8 +2324,8 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
>          }
>          /* in OpenSPARC T1+ CPUs TWINX ASIs in store instructions
>           * are ST_BLKINIT_ ASIs */
> -        /* fall through */
>  #endif
> +        /* fall through */
>      case GET_ASI_DIRECT:
>          gen_address_mask(dc, addr);
>          tcg_gen_qemu_st_tl(src, addr, da.mem_idx, da.memop);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


