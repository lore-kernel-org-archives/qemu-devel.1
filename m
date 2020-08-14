Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68C2206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNqKc/RH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68C2206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6fOJ-0004C9-T0
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 15:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6fNQ-0003Qc-Hi
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:28:32 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:56173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6fNO-000558-5Z
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:28:32 -0400
Received: by mail-pj1-x1044.google.com with SMTP id 2so4867931pjx.5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aCHU/3by+V6bpLNXZLdWi0og0hkOZhifiWdD2LpfZJc=;
 b=hNqKc/RHL2RylkfktI4b7CG+2NWfuVeFSGCVg3QiDIFeLWPXVh9vQXSnSLPvAKfOWd
 Fare1V56nrFLyJoaX1OHxUCkDWbF4F9GNjpthqEAQB1XuaBbHbXJisjvczd4/Wz/5x9R
 WGQ8q0f3sXo32OibPkbcFkNKwZ/xC225w+pr73zistVOi5W9N8VB7KNS2sEtlGMf393j
 4IU3n7XWRxS4nMnwEB08K+D6x3pW1OXDWzxxIQiiX6tcmFM1PtK/jULkNIfcbea+Q5bL
 wWBjyFypidKcl3Ah9owvzAoMionbK9Kn5v8N0neXQYLkYKwCf7xAbwaGl3FwMLyYr2JI
 4omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aCHU/3by+V6bpLNXZLdWi0og0hkOZhifiWdD2LpfZJc=;
 b=eHbPYD211AZh102ABt7swp3EaSdsNaIfCy5S/cFxiCgLz08KIoR7aID5dQUCppU+5g
 yIBJt1WBXEwDmzJZjCLdBJ6l2Zuo7GrbohRLDviG0dk9UDyYuyB1udx5r7FHmUhBBfuZ
 OBRyfDmJAeZC8NURodT2molcxq+vCqw3DtsQXyiHwZ6uKTf8bntbJ6U5c+Iw16tvE8yv
 9TaBX7h/CWfxGpr3Qw1H3985nEYf++DcIQvBq5MJvzvRsr/ykyAnKfsPyWVSREHHTJWJ
 BXW7BW5LbVprFFu0T0axi3LssjPbGJC84+o+E/ovR1uvL1Y0es7CViZE7njSwZrV5jqr
 XHrg==
X-Gm-Message-State: AOAM530xkhN4P4xOD/oZAuEohM7/0fFzUEgnlQBAsxTudokY0+KcHsw1
 vwcOcEX2gN7kRCNJ0MlwkpdQKnOMZOx1jw==
X-Google-Smtp-Source: ABdhPJycSmQTNnzIpDGKwxUrvdctMhXgiF1hPjviAby/vwjDX4Eyn4pz1BW/0CKcH5ic+GEgC21yyg==
X-Received: by 2002:a17:90b:128e:: with SMTP id
 fw14mr3511447pjb.66.1597433308462; 
 Fri, 14 Aug 2020 12:28:28 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w23sm9038217pgj.5.2020.08.14.12.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 12:28:27 -0700 (PDT)
Subject: Re: [PATCH 7/7] target/arm/cpu: spe: Enable spe to work with host cpu
To: Andrew Jones <drjones@redhat.com>, Haibo Xu <haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <bf909c1f4904a22be0804cae9fd6f38ba4862563.1596768588.git.haibo.xu@linaro.org>
 <20200810111640.ykejphmuyirncjwv@kamzik.brq.redhat.com>
 <CAJc+Z1F_vFdJuy2kZnj0gZSOd_8-=rSfWFHjQSPU5XEKQ2KZkg@mail.gmail.com>
 <20200811164954.s2sdjzpqpdh2orks@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13da2df2-7d90-9512-d1b1-8d7c5f43971c@linaro.org>
Date: Fri, 14 Aug 2020 12:28:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811164954.s2sdjzpqpdh2orks@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 9:49 AM, Andrew Jones wrote:
> Yes, except you need to drop the ARM_FEATURE_SPE define and use the ID
> register bit instead like "sve_supported" does.

On a related note, I think we have a latent bug, or at least a mis-feature:

    sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
...
    /* Add feature bits that can't appear until after VCPU init. */
    if (sve_supported) {
        t = ahcf->isar.id_aa64pfr0;
        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
        ahcf->isar.id_aa64pfr0 = t;
    }


Should it in fact be

    if (!sve_supported) {
        t = ahcf->isar.id_aa64pfr0;
        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 0);
        ahcf->isar.id_aa64pfr0 = t;
    }

?

Forcing the value to 1 here is going to be wrong the moment we have an SVE2
enabled cpu.

Similarly, SPE has more than one "enabled" value for PMSVer.


r~

