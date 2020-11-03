Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BC720870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqDMmW4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BC720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZznJ-0007Cf-4P
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzjz-0002jW-23
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:05:04 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:34182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzjw-0000vL-HZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:05:02 -0500
Received: by mail-pg1-x52e.google.com with SMTP id t14so14171337pgg.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 09:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A9TmnCBZIlx9QCghQVLdBUbJhN2pzDz32l6cbIU6DRI=;
 b=jqDMmW4UC/Ppov1LXIoFxmqv+LbZkb5UgLPkWJgWQQXcxAm5vr1yyGdvLuHlaIqbsV
 ZSrPEPyM01gl3lvfRnDgu7WUUKv3LGKL0Uep04ZmmxNSNEDdyYKaIt7tLYDF+6e8vGkn
 WlsO+QHas3civxFkpM9PAobZYM0SS4N5Qir3YcdkSSIlYXM9mTLscJ0xneiGz/AyQUlb
 KGHa5XST5Ioc4dAFmv0ZfLHOOdf+/U2V9CDXD5Qx6+4M2TVSJGqd+71Ij+GsyMPDbOhR
 TBGmBMXwT36MVtHWqk3ejtKDbhJEYt0i3Rzw2r3RDHI/9rfO5Bf1Hc4ivBJ84RD7igi5
 QSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A9TmnCBZIlx9QCghQVLdBUbJhN2pzDz32l6cbIU6DRI=;
 b=f8oECHRGi0ZHf/FfPnfnQsuvc2QIFTTzn2T0n1xhbytD8L+hEbRQeJbQfHgysx+LYi
 tdguNlDygCnYXc28HiBoM+T0LlItdJ5u4JQTWNDrwgs94JA/R5VUWgRE7T2R6oiOZKWd
 SWbuuxk5Epk9YHfvD2WjLMrLAmgEfM0LeiAhCYWJT8uZq30DP+M0XTD5U+IAzLSTYbZX
 r1k9Txu/5ACa7oSVujLS3hokG4bF1x8bERo6HSbylcIkz+8Ixsa9kgjkShoyRyDplK+K
 vxxX3sznY5XafdOOSaoBnLJePKwrCIY3CLazFFhS30n2H41fsFJJHdNFYT3lilM99tGi
 FtZQ==
X-Gm-Message-State: AOAM530ycYG92YviXTV2DM6wdFJtNKOFcq9hhdqoxOI2fSgHGraYzflw
 oFvphYluk3LLv8FMCQMoF5nF3hHnI6csjw==
X-Google-Smtp-Source: ABdhPJxZihxR38bt8L0lm1FI2li5Kp6O4DLeMQAj/jDTfd9RoycHL3Y+uRKQ0tDW9FzAE5lIp9vCdg==
X-Received: by 2002:a05:6a00:22c6:b029:18b:3bb8:8b6d with SMTP id
 f6-20020a056a0022c6b029018b3bb88b6dmr2425999pfj.31.1604423097680; 
 Tue, 03 Nov 2020 09:04:57 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id e184sm17776281pfe.146.2020.11.03.09.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 09:04:56 -0800 (PST)
Subject: Re: [PATCH 07/14] target/arm: return the stage 2 index for stage 1
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-7-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d42125dd-2151-3d33-5fa9-921965b3259e@linaro.org>
Date: Tue, 3 Nov 2020 09:04:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-7-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> +        if (s2_mmu_idx != NULL)
> +            *s2_mmu_idx = ARMMMUIdx_Stage2;

Missing braces.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

