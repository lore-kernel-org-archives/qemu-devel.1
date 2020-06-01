Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C20C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB9A2076B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKtLpGFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB9A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jftYe-0007M7-RO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftXc-0006mN-OH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:08:24 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftXa-0002zi-V1
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:08:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id b5so1292581pfp.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=2opHqdEGBYyYvRfqGA7MHjnnPqX/mrrwqx5O7Vtm8rE=;
 b=RKtLpGFzEgG2JoYYg6ExVAAyU1zNXDoFcxW3RoBRTvi7Nuw7mF6mawRjVI5zDFC0X2
 wtJnhi5nxrB2iVlO2BotObmVFlNixl76ztmAL9eV5kFYzx9mkvwjT9h0aGOpNuBgkJcN
 EoR/s5R5EHtHxdqYAGbL3lEmkV5rVcohMmufwCRHn1KhkpxGkxt+XdMEjfCiHoGYc5r8
 AMhDr8HKLQ7fQq0vU4u88hoIvdLACTVHp0exk3ocHqnd06sUEo2RCVK2ZZ/b2YbsJLl3
 PoCHfAcAHnyQ2LX4mv/oujp/sTdwVHAJ5uSihTW5RaSaHSBiKYxvPvVo5PaFGagcMC7J
 KbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2opHqdEGBYyYvRfqGA7MHjnnPqX/mrrwqx5O7Vtm8rE=;
 b=ltt0pyPBbvdlz3wcj1KOnmpQMPSSRZ6w5chuEsYRg0XyAsZhRaY8fsHoBvfnuZ6nlR
 ER91QFUx9meWJo0dEBlmwvPa+qavhnGOgtJghRsAPhRDLc6c3SO2zg9IW2xPOAN1P1mG
 jVayU2VvJe8R4yWXUIDL66fXBo1b+PrgCPi1Pw6dwtxNkLqmIQxjnWfFW/gA9sFJkmHD
 nqZaSpsPZsu1Cyh4cUcVP2gDwpOJNibj0gY1VtN4tG9nsfyuiSpePYfVpraPelFP/P5B
 qxNMbSAC5YtnMYxLCZTe5F883VijYgkutYr4WSmWOoztvSxx++18T9IrrJQ4e170qQ2d
 Cs0g==
X-Gm-Message-State: AOAM532o5uudy5/f4X1baXyy3Stzn10hKmPYZLwAKMsIfTl4OqnXN/k8
 6NcZW9dYmbBUNGnh4yY3RLjJGU0wOJw=
X-Google-Smtp-Source: ABdhPJyRxN+5Bkn3aH2mPYXRLUM74PBrU8Wp77YMeE3N4Nb2nO+sfknxNiI63HQQ1EPcq7yu+rXhrQ==
X-Received: by 2002:a63:c5a:: with SMTP id 26mr20783421pgm.270.1591052901059; 
 Mon, 01 Jun 2020 16:08:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d12sm397623pfo.153.2020.06.01.16.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:08:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] target/arm: Convert Neon VSHL and VSLI 2-reg-shift
 insn to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200522145520.6778-1-peter.maydell@linaro.org>
 <20200522145520.6778-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3c7861c-7687-70e7-dad8-0ea4dd640c35@linaro.org>
Date: Mon, 1 Jun 2020 16:08:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522145520.6778-2-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 7:55 AM, Peter Maydell wrote:
> Convert the VSHL and VSLI insns from the Neon 2-registers-and-a-shift
> group to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 25 ++++++++++++++++++++++
>  target/arm/translate-neon.inc.c | 38 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 18 +++++++---------
>  3 files changed, 71 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


