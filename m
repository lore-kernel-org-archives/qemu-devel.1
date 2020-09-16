Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B517C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B0522250
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TP1gs19N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B0522250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZB9-0000jC-23
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZ9k-0008DD-2Z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:15:36 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:50329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZ9i-0004vx-7e
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:15:35 -0400
Received: by mail-pj1-x1029.google.com with SMTP id fa1so1783773pjb.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SNNmVUYKyQWfNGpul5z+UyAHVvrVWYx+hJFcAGRJbY8=;
 b=TP1gs19NgePIISe1hdy28jipe0Tc+XFrcLUPY59jdUmU9ddNbG5Tgrmjsp2f+OVK9W
 ciGUVN+ihjC/PO3lga+tuqxSYjtv9HFJ5QmkTzpiHNYNgsqdRE5Bff21HxzvxWQfJ637
 JC6kGfzv/RQuRS3qF0vah3s9f7WZyCkHApIISViK+gY/HNutn0VMWlQLeJBI8v6rohWr
 pfjeJvU7y/5dgcpz5YpKNjbkQRXI4+qGM4A+PCmLqals6DltWGCiESncx3VoG3veDDSF
 BJdXQ4hXqc0XPfJliARKPOXk1CdSELCIBDC0hXGCj9Jyy4kMzuwd209d0I/FQTl/OkEQ
 HM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SNNmVUYKyQWfNGpul5z+UyAHVvrVWYx+hJFcAGRJbY8=;
 b=LOYPFsw7cly8BNcNYONFk6zdJSN0V4tSxi288BZc5OWVvybkvRiiB6wWRC0jpzG3FO
 hGVJ/Uuvk6pvXi6fhqEeXyE0xjldGPyLbQ3iWXZg7pV7EOgRGh91bxDekUs4j3A2qJqE
 pUzCtTKilGVNyN4+5EmXa+I0KrPyv/80SdizPcO+o40kh1DcIiK/luXFR8lnq8ycNLOI
 4C9xVROIUBFvcpx4GcpTUiZxcnUfEN8v8pzl5aqs1eWdId2iW4Vf9vz7KUiqGzuvtO3S
 4qBSvESFNHLmUlkw7z5w4yG9xxJqu6hlHoj1UFoj84scvFzoPsmGLSMjRbczx92V9RGE
 315g==
X-Gm-Message-State: AOAM533vPktoX32sY2L5uDAZxaTU3JzbSr9rA/+gpfJbX8rBbaUWwGsu
 wp/BK040tpCXgZQ8jouK9Kt3qQ==
X-Google-Smtp-Source: ABdhPJzaWw0lDOlfQdVJOKV4aISXTsxEBJU2Jmbhq5nVA14t+Ol1JqlL/XmqWrwuBTGGbFajizR7uA==
X-Received: by 2002:a17:902:be11:b029:d1:f2b1:b6cf with SMTP id
 r17-20020a170902be11b02900d1f2b1b6cfmr2005003pls.64.1600269331701; 
 Wed, 16 Sep 2020 08:15:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id mp3sm2979666pjb.33.2020.09.16.08.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 08:15:31 -0700 (PDT)
Subject: Re: [PATCH V9 3/6] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
To: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-4-git-send-email-chenhc@lemote.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c19dd56-7d76-3dc8-c881-f0631e5e5352@linaro.org>
Date: Wed, 16 Sep 2020 08:15:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600222344-16808-4-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 7:12 PM, Huacai Chen wrote:
> +    case OPC_GSLQ:
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, lsq_rt1);

If rs == rt, this will compute the wrong address for the second load.

Either avoid storing t0 back to rt until both loads are complete, or retain the
address temporary and simply add 8 between the two loads.


r~

