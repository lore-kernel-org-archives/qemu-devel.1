Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6D420657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYHDO759"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6D420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Lp-0008SC-VQ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb4AR-0007E6-BR
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:28:31 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb4AO-00038b-Bq
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:28:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id j21so6556853pgb.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5qJv6cRYHCSoY2DRMd/7gIc7baIbvMyMHOR1QeolGxA=;
 b=UYHDO759dsFt7a8bVK/ji3X4XJhkpUkYj8AfBXJZPoLoR7ZkArMVEoTiXRTQdrmsYo
 rsJa9JtpPNEZOijsWw1cdwRR4OR3BsN+/PYeGqueTxgbVL3H92DsiPEQrcwgepl+9+dy
 MONzUdJkUpJbqGcrdC+b9gEZeM6FsnHOBDZntK0GNYAWMDXqCo0Kr2bBF2mgeqf/Ho9J
 B4YiAS+S3qzHdxWUohp7cQPJILLwJfnA7ZBXBCAYnLd0nQsIa67o/Uf7rtcqWJEHYgX0
 4yrvhW8Dy0arWfJ4YKXkXRLYIPgY24C+X5rMCd9htRA6p7WyGWldljWfeSXeUMg5qDmr
 pFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5qJv6cRYHCSoY2DRMd/7gIc7baIbvMyMHOR1QeolGxA=;
 b=uL7O3RBS4SGaM41ifGE4psHd/R6hzdSRLywMI1Z8KUI7kgmGWUQp0PLip75er57MRB
 6ekirf12uzuRExLvZKbSUAnYySkYSxWd2npO8U+DrnBstZxtvyOVtysSizMh2uCGIXE0
 55NcZ7McZ/40I/vL/HCCBrErLs71bnC4VVCyDTV8mJhifrN3w2ObGZC/d9CNvhbGMHJA
 XvIHRL9bPHEslD1wA+sRhjbOFr3ncfSm/LHCRbBuGOQYfJ4/G8wM9dhtJz76A52IO+oc
 x/F5pMtGary0mpqd/+1iEOXXmiHv6Ixdnwku79vFUPDXp7tAUqOYsUSuyvQsW8/Eiiqh
 fPDw==
X-Gm-Message-State: AOAM532Dl4lXJvmH9Nay98d8RfArNcAXySQ0y7MMhNxhnnie0MLj2Qmc
 vOeG5s0qp9mQhTEcsGhkq3JISQ==
X-Google-Smtp-Source: ABdhPJw4wlRYDZ8yjQfhbs6wV4PCoTV5qhCRS6vltBa3NB71guqOcm2fS+0vLn903wQa98S8cXu2bg==
X-Received: by 2002:a62:e707:: with SMTP id s7mr8260869pfh.208.1589902106834; 
 Tue, 19 May 2020 08:28:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i3sm11544992pfe.44.2020.05.19.08.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:28:26 -0700 (PDT)
Subject: Re: [PATCH v2] hw/display/edid: Add missing 'qdev-properties.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200518174523.18076-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce656f41-afa3-dee0-d5f4-0e8f47b9a5cb@linaro.org>
Date: Tue, 19 May 2020 08:28:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518174523.18076-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:45 AM, Philippe Mathieu-Daudé wrote:
> When trying to consume the DEFINE_EDID_PROPERTIES() macro
> by including "hw/display/edid.h", we get this build failure:
> 
>   include/hw/display/edid.h:24:5: error: implicit declaration of
>   function ‘DEFINE_PROP_UINT32’ [-Werror=implicit-function-declaration]
>      24 |     DEFINE_PROP_UINT32("xres", _state, _edid_info.prefx, 0),    \
>         |     ^~~~~~~~~~~~~~~~~~
> 
> Headers should be self-contained, and one shouldn't have to
> dig to find the missing headers.
> In this case "hw/qdev-properties.h" is missing. Add it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v1: reworded description (rth)
> 
> Supersedes: <20200504082003.16298-1-f4bug@amsat.org>
> ---
>  include/hw/display/edid.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

