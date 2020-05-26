Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D44C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E381720776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFDaXgua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E381720776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdco2-0001Et-34
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdciz-0002g7-HZ; Tue, 26 May 2020 12:46:45 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdciy-0005hv-M7; Tue, 26 May 2020 12:46:45 -0400
Received: by mail-ed1-x544.google.com with SMTP id k19so18231787edv.9;
 Tue, 26 May 2020 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5dc+q+V0lscs6cXnzEkH5M+IYF1zKZogiJC+dn3t85w=;
 b=GFDaXguavyRv45sHK3kwXd6gWaCQ24YuhbUn0za1/qb9MdXDAEUe3kHLhVhU1GV/9Q
 HziPyj9k3iYI7QaeXfrz7hUCr+QmpyoGx3wGFSbPkQrr/wi34nOHTHNryEEHLh/ZwUV+
 +F6e6Lms+OhsKoB3YqVC0tSk+Y0T/XeFWnZImwuckdr13zS9ipXioc6BmVQBdipCJhIa
 XuSmjjiR/PJDDBKw2Q9bUaEU3xlgv9kPsS4WpGtgPGErCoylF777dan7uWMDuXjixivO
 MC3BGcc5L0lTQJNJ1Y5+04g0o0mlauN8obCQO7Wj3HN5cStgy6FjKb3CE1oo3lYIpuJ5
 tfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dc+q+V0lscs6cXnzEkH5M+IYF1zKZogiJC+dn3t85w=;
 b=S3Ct8PbcMvYza44zY18gEk+pHeAdj1xBTWtSuXfDRdCF+iKB9/cZ+GnUCK0WqOiRGp
 MWvkWACch7rXfNXBsNPNRwngzbdMGoam0apntouFpku3Xyl4brgAg7zqEOziOm27pfuK
 X3oZAnu0AfR/E44BmeKXE+VfcxAy+PrckPiCXgAD4TsfC62CjnWadNE91a7O0qnOgr9n
 hWjbcHqpB3ESDgsJ3lAdeycegBHmmdTWU/Dj83Oek9JeDZLJF8a+7NijDHwvBpC/9/Mk
 xw3LKayvexFvBjOcE1ltDs0PV7/+8S64W24/qj+yHmQrB8o9QIlUNQ96LTYKS1uW6Rj6
 ZJXg==
X-Gm-Message-State: AOAM530LlGQaJle6WxuHLULFsbyzqjb7BGJz/19x37lzZ4e6MoPPHvQv
 qTkekufV0M22FDz6xD7D0GhgBjCWqAg=
X-Google-Smtp-Source: ABdhPJykay5hDSLsoJOR17vA7AzJ//AEN7BDDFIRx/mc6nuLklAmvNQynP9/gxQlByzVdDPkXU508g==
X-Received: by 2002:a05:6402:c95:: with SMTP id
 cm21mr20907665edb.81.1590511602757; 
 Tue, 26 May 2020 09:46:42 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id dr19sm370475ejc.122.2020.05.26.09.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:46:42 -0700 (PDT)
Subject: Re: [PATCH] hw/registerfields: Prefix local variables with underscore
 in macros
To: qemu-devel@nongnu.org
References: <20200510203457.10546-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bdb49c1-5396-0bf4-5f83-3849910e5d68@amsat.org>
Date: Tue, 26 May 2020 18:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510203457.10546-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/10/20 10:34 PM, Philippe Mathieu-Daudé wrote:
> One can name a local variable holding a value as 'v', but it
> currently clashes with the registerfields macros. To save others
> to debug the same mistake, prefix the macro's local variables
> with an underscore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/registerfields.h | 40 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 0407edb7ec..93fa4a84c2 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -66,35 +66,35 @@
>  #define FIELD_DP8(storage, reg, field, val) ({                            \
>      struct {                                                              \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> -    } v = { .v = val };                                                   \
> -    uint8_t d;                                                            \
> -    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
> -    d; })
> +    } _v = { .v = val };                                                  \
> +    uint8_t _d;                                                           \
> +    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
> +    _d; })
>  #define FIELD_DP16(storage, reg, field, val) ({                           \
>      struct {                                                              \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> -    } v = { .v = val };                                                   \
> -    uint16_t d;                                                           \
> -    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
> -    d; })
> +    } _v = { .v = val };                                                  \
> +    uint16_t _d;                                                          \
> +    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
> +    _d; })
>  #define FIELD_DP32(storage, reg, field, val) ({                           \
>      struct {                                                              \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> -    } v = { .v = val };                                                   \
> -    uint32_t d;                                                           \
> -    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
> -    d; })
> +    } _v = { .v = val };                                                  \
> +    uint32_t _d;                                                          \
> +    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
> +    _d; })
>  #define FIELD_DP64(storage, reg, field, val) ({                           \
>      struct {                                                              \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> -    } v = { .v = val };                                                   \
> -    uint64_t d;                                                           \
> -    d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
> -    d; })
> +    } _v = { .v = val };                                                  \
> +    uint64_t _d;                                                          \
> +    _d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
> +    _d; })
>  
>  /* Deposit a field to array of registers.  */
>  #define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
> 

