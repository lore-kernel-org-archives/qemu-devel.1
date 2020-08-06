Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD46CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA54D2312D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukR4yQGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA54D2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3g1H-0006oa-S0
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3g0S-0005X4-RX; Thu, 06 Aug 2020 09:32:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3g0R-0002Iu-38; Thu, 06 Aug 2020 09:32:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id g8so8867549wmk.3;
 Thu, 06 Aug 2020 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9aaer6B+l6r0/2j30kyoaXbrV/oJL88UAt/4vG+WnQg=;
 b=ukR4yQGBmgzWl28her50cmlzvRqE9MtjqnIdLyS1eg/2Rez9+IDRwn97SnFD8xEQhX
 NpbnNozNBI/dBv+0mJYnK6poUOaZfvrIWPTLy2qwZJov6BlaBL7Ddeh0n+DEoDSklOut
 hwz2IF7LC7y8Mx11PxhRgFxPQ5IgRcMFZgnFMFLf1qdVCZ3e4HLY68ZefbDwNZxg21r6
 n+PXX9Zsh5rA/kYGWLF7ca68YDeJnYRuIMfnu1uRXS08MFsotrr2ZaEBikFbvD2JjjeP
 UTAZB324CtNo7EPwbzPVv5BVwMqkpF3bxjcyx6SkBx/8+ZwXInuQ1WdrhjSXqhNktnyj
 9dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9aaer6B+l6r0/2j30kyoaXbrV/oJL88UAt/4vG+WnQg=;
 b=FeutYJlWWs6fLyYcyG0lYsHvaIe933RPK2vSsncJ9zbL5D1c+rK7i3kG/ch+UU4fFU
 UOFliI2U5bVIMhX8X26p1YEPUO7jzim/SZ8Gc82AqUphoUmwMw1LPCgPX1oENuKBkZr+
 R7dWFhcCmmBfYLJz/TLf16e4JT85+t4YRr9JNLl9lyI5TyN8XAeyRtJpvYLRjN/1fSyA
 YMxJF4zvXLKSvzeGXNXuc3qxr9jLre9AZCuGpdqb17rn+ubCxVylqMar/05MdibiM6Zt
 3PQ/yS/00KoOXS/9RsR9jHLPYvwL41I4yb3bvmBIhy+7GHfXWZALpNPgSOvxfhyW3aUC
 eOUQ==
X-Gm-Message-State: AOAM53296c47tcDThasLQGsLF/naEQVtIxR6MRVjXZewTn8zAzZwDCOh
 MwqKM2PBfyctPmKyu7argTE=
X-Google-Smtp-Source: ABdhPJzsZEqGB6xQKx5MSTA6qgT3dSLVgHPhwspXZ3yEtltWr6NUXKVnY1MI8E3zrGbDIIgjvgLbnQ==
X-Received: by 2002:a1c:49c6:: with SMTP id w189mr7620397wma.97.1596720744960; 
 Thu, 06 Aug 2020 06:32:24 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm6664783wre.44.2020.08.06.06.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 06:32:24 -0700 (PDT)
Subject: Re: [PATCH for-5.2 04/19] aspeed/scu: Fix valid access size on AST2400
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a41f234-ab81-d078-0fcd-c1b20fceb1e9@amsat.org>
Date: Thu, 6 Aug 2020 15:32:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806132106.747414-5-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, erik-smit <erik.lucas.smit@gmail.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:20 PM, Cédric Le Goater wrote:
> The read access size of the SCU registers can be 1/2/4 bytes and write
> is 4 bytes. Set the min access size to 1 byte to cover both read and
> write operations on the AST2400 but keep the min access size of the
> other SoCs to 4 bytes as this is an unusual access size.

From your description it seems you need to implement .valid.accepts().

> 
> This fixes support for some old firmware doing 2 bytes reads on the
> AST2400 SoC.
> 
> Reported-by: erik-smit <erik.lucas.smit@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/misc/aspeed_scu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index ec4fef900e27..764222404bef 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -328,9 +328,10 @@ static const MemoryRegionOps aspeed_ast2400_scu_ops = {
>      .read = aspeed_scu_read,
>      .write = aspeed_ast2400_scu_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size = 4,
> -    .valid.max_access_size = 4,
> -    .valid.unaligned = false,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
>  };
>  
>  static const MemoryRegionOps aspeed_ast2500_scu_ops = {
> 


