Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A97C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C2A20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="St77CbLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C2A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAfDA-0003Tv-OS
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 16:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeZc-00077i-1G
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:25:36 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeZX-0006hQ-QJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:25:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id l191so5411160pgd.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Vl2wvYes1LVzVyAGXqUfvKxadFKaJVw4GEr+AwGhehk=;
 b=St77CbLP/7u1ai3nL9pCBygPa2vg9b23xe+a5BZzbOU05NhLPg9hJowouViXdZVTP1
 N69hNfLy+6Qy6+1D/kakb4Qz0/t7jKHls3aLg88FFsGzjsx062g0Uh6YmMmwD234pqjn
 zVnpHpeEjT7Q6ChDG76XDoHvJVXiTTWMSZfEtKrE9v2/PJeA39loVgzbFSYgRLMRKugK
 vYITXkmgUXG/nuT7KV0cisjRJ+cSsXN+KfR46+yYggJFAVEZo4UYMcs0ETq7RSq6I2Uv
 Fv0Pz2DBwtjBcTDiesf3FHmT9tHuPZDyY/EuMXd2JlgvFKoobYwroJGea0jAgaUtIoFK
 oFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vl2wvYes1LVzVyAGXqUfvKxadFKaJVw4GEr+AwGhehk=;
 b=NLWerSDrEcOBU21cxhygV+7z2/YSh4mVGDOe02SBP/TfiSz+70AVBP0c0K1XdPeCn4
 r43SD37L92Znxw99d24n4zLLj8RXXdJoVHemQL3yzGRYOzoHWU7qD3wRLpNa/O3zmRLj
 R1bBEpF5kC+uH3E/+WpKB8BiwHe901oiedX2so+pA/RYHRQftQRyS6y5V1C3JJHieGTi
 60O+fQHREHhbpcTRu95AvKn/8GQuViZkoXI0kGTcCGzFkebYBbeB6JVGzGAAVK4u0dP3
 pp1eVb3KuoMRMCop8B1HadHVE8c9ySnaE5GxApt8taPoDG6pMwoalfJ97Kl25Ik4D7cq
 5AQw==
X-Gm-Message-State: AOAM533QofIkjtP2S5s/CH3NXE6+ophqGlX2G8FYUkEcegk0+c8kd9cD
 1rY3nuLZMSyZ2+J5isebYU+lVAKhbuEFVA==
X-Google-Smtp-Source: ABdhPJzFPzzwiDMDo480PQ+IYOnjLhHaR5xW0DyJDfcENKCGOYWO5NDo4xYTIMTimo9TQCGuN5iahQ==
X-Received: by 2002:a17:902:c3d3:: with SMTP id
 j19mr9339443plj.62.1598383530149; 
 Tue, 25 Aug 2020 12:25:30 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id e16sm19685pfd.17.2020.08.25.12.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 12:25:29 -0700 (PDT)
Subject: Re: [PATCH 20/22] target/arm: Implement new VFP fp16 insn VMOVX
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd00def9-8fd7-6259-ff4c-44d65664f3d5@linaro.org>
Date: Tue, 25 Aug 2020 12:25:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 7:29 AM, Peter Maydell wrote:
> The fp16 extension includes a new instruction VMOVX, which copies the
> upper 16 bits of a 32-bit source VFP register into the lower 16
> bits of the destination and zeroes the high half of the destination.
> Implement it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp-uncond.decode   |  3 +++
>  target/arm/translate-vfp.c.inc | 25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

