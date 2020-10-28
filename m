Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41166C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BEB247CC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OgqKk/kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BEB247CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXomG-0002Xe-Cd
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXoaN-0004rv-5e
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:46:07 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXoaI-0001w2-A5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:46:06 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a17so105462pju.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9y0gLI3VAg1Yf3eusDjTAOZVyOe4Sk1qSFyx62/73ow=;
 b=OgqKk/kLq2HFQgLo3BryPsL8BN6nZF2U0dPKUFSIjVEe2gA4JJG1MqW3hEkPIXgpjE
 JAb480c50SZLdyTm9GCFqs0CoweMti7ysz3RiBawZfsUoXEfhV85lM/pZgPCK5vW8bQO
 1gDarnE1gz5vpeuSPUdL4LjozkjG6/jeMujZdvEsbTS2gMP4fx5Azk3H+V/kaod/eFNr
 jHqPRwoHHxM/XpEIrPOPpDWJToaINk1VeP0Ezc8T9f9/QRweoxhwG/HfnCVLgqkXsjzx
 XY2LZEH9E1IbXuDDwa3+RhAlpZEAFYW5kKaaVY96rNeygbYbwB1mUdAJFsz2pTje5Rg9
 fWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9y0gLI3VAg1Yf3eusDjTAOZVyOe4Sk1qSFyx62/73ow=;
 b=hxU3epSfMnc/t/Kw6qOpE2fPneZWFkV2twp1xO6kJaHeyKS0sirAUNXWQi+xpHRWa4
 jIosJloyMxAs5qpwupxdto1sp4Ne+vhzMs29s/d0xriIHZM2BPzfgXMk0IvDtSFWkYx4
 d+vNlOI8VLs3jkgn6B1fp7Dslaratcpzv/cAfLA+OIYSil+uu9vAeCOM065EoMgSfOlc
 +x/VoLu97KgBuCCTx6ovHbSU1C6Jts2tQZzmOcnNjwhf81PXyDNa+vBIbLUrfVAYBAam
 Z+N9Stkzsh8Qo2Hy/I5c8ddK8qzTuHmziW2m9bjdAB/UdahKRGERCxAAI9F/WkrDxhhp
 vgOg==
X-Gm-Message-State: AOAM532a+w86kxv1saVs8xuBEMfEvUO6vV1DJ7jR7bGZkDiVRdU0TfOH
 03JvYSiXpFrfcumKKonhsMaW9Q==
X-Google-Smtp-Source: ABdhPJy6YjJITvbaX+VcEkhw+zIyV1mI47cniDeLCP7eXzCWheW6qwip4lxvry/iDjQABfT+XsXLFw==
X-Received: by 2002:a17:902:9042:b029:d5:eef1:c9c8 with SMTP id
 w2-20020a1709029042b02900d5eef1c9c8mr209643plz.0.1603903560717; 
 Wed, 28 Oct 2020 09:46:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q2sm121052pfb.106.2020.10.28.09.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 09:45:59 -0700 (PDT)
Subject: Re: [PATCH V15 2/6] target/mips: Add unaligned access support for
 MIPS64R6 and Loongson-3
To: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
 <1603858685-30701-3-git-send-email-chenhc@lemote.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be14673f-c210-5546-e4aa-b14698516a69@linaro.org>
Date: Wed, 28 Oct 2020 09:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603858685-30701-3-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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

On 10/27/20 9:18 PM, Huacai Chen wrote:
> MIPSR6 (not only MIPS32R6) processors support unaligned access in
> hardware, so set MO_UNALN in their default_tcg_memop_mask. Btw, new
> Loongson-3 (such as Loongson-3A4000) also support unaligned access,
> since both old and new Loongson-3 use the same binaries, we can simply
> set MO_UNALN for all Loongson-3 processors.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  target/mips/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

