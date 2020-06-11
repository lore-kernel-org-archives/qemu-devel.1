Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C39C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DB72053B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/eeRLIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DB72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQPb-0005qP-NN
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQO7-0004pw-8P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:49:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35000)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQO5-00043Y-Pz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:49:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id h185so2917923pfg.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=UE5IU9gvaFVB7PlZlDdnJ7N3ay9qCfXbvbBwim2PEPQ=;
 b=H/eeRLIinh3NtpXtAeElTTSjbvpQ9IjjCCraF0FISI4shbEacAj1dF5q4jsA6Xt0Ov
 II9OOXUTZBc+NJekVjxLiwz24XpbD8VWw3CHE9Z21s1YhWlII1Vgd0NvT3GgXOHxYmdC
 QmwDgyd+ZJzhn2SGFMU7xOU29ituVffTXiCI3ZEXrUyM46Nt8roGBirAIUxXk3KPKQn6
 kh41S6D3zMWXA7Zu/68Iq6VoEpdJVeLSmibHyfstz5F3S1n2ZwrNVw+hfvGmrq7Gq4yW
 sO19GL+0mTg9c6dHVX7O/6RZt19jts5DsVX8Qeiq0CARJc2TdlO0qnewHcrp7MKI546r
 uU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UE5IU9gvaFVB7PlZlDdnJ7N3ay9qCfXbvbBwim2PEPQ=;
 b=WmKCgM/SZJhwFv82kJ3ogolWW+VCjtIT3oYxgf4OROWw4/eCdw5e4/Z4YwXVcN/AUN
 TBo93mtQJEtqXgFMh8ijK1DFQSADPA6gFIbzE8x7UcDlhqhtMfEqI6QUWbK/Jn4U3Ctw
 +AILTCRkXN8wTJ0Y5zk1BRZm0NBiuk8pAGKFnyDKt2Jcx9h+coeelHoLFffV28PbLUPo
 +4HSDfPexUvz0HJNPn68kMTTXkz+Eq9fP4orZ+pdsf/bAvDWpWIIM7y0kWxOe1uew9ut
 sIltGHx7YDFf1pBGCXKDL0ks4pLihRR6QDgnZ6/I11ThUThpcQrJZMd4LrzoTeN/EBKQ
 mK6g==
X-Gm-Message-State: AOAM530ZoGdtDxj/8TMlBKiSWh1BRlAaR+DxNgCcRAS+agRBqVXBU2WE
 ZI2T8geNFme/P0/LMdq4zxkimTLqBl4=
X-Google-Smtp-Source: ABdhPJxy2wqPCZOQHOV8cQGDTQ6lkEOTMqpdiw257sD3jkzOYA8RIVDU+7C2HI80yHqUYXg9mnw2mw==
X-Received: by 2002:aa7:96b3:: with SMTP id g19mr7658013pfk.64.1591894140315; 
 Thu, 11 Jun 2020 09:49:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k19sm3873737pfg.153.2020.06.11.09.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:48:59 -0700 (PDT)
Subject: Re: [PATCH 10/10] target/arm: Convert Neon VDUP (scalar) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a985ebd7-d067-a2f6-283e-ebcc8b4f3702@linaro.org>
Date: Thu, 11 Jun 2020 09:48:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-11-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/11/20 7:45 AM, Peter Maydell wrote:
> Convert the Neon VDUP (scalar) insn to decodetree.  (Note that we
> can't call this just "VDUP" as we used that already in vfp.decode for
> the "VDUP (general purpose register" insn.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  7 +++++++
>  target/arm/translate-neon.inc.c | 26 ++++++++++++++++++++++++++
>  target/arm/translate.c          | 25 +------------------------
>  3 files changed, 34 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

