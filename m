Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C556207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycVbGSEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C556207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxyj-00042Q-F0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxwl-0002E5-M5
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:02:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxwk-0002yw-4W
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:02:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id p30so4293870pgl.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jBFcQkdt7ugXdzCzgVoVWf2iAP2CLTFTZix8fB+Dgo0=;
 b=ycVbGSENvilNAYCR/pXgXaqmCrWRi6RdUjLoreKK3va7LzHzg4WzxKeIqfmQfmGluY
 wstFv0uSoiuk+FtIyqjdgw78uysTKFbb2ffdA082lKLNZkcl9XJvM1D+R2k+lJFWCJBE
 pfF6DuNGyuhCCrQeCVx0w4bsakQ93dgLZncToH05yCozzNnoIBmwVgktkI6FPlOnC7gl
 4JWLwHTPqjdZP+aG+tdhQrqZfcREPvZzAwGKMmpSwYEei7ZvjHIff/9xxf2TSkPWdG5j
 vzgrzV+bLtZPo16LP9rFXni816QHFrH5/mOvUjI5If/X7uNVsxOh+vCxECgrWzhMeARk
 +wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jBFcQkdt7ugXdzCzgVoVWf2iAP2CLTFTZix8fB+Dgo0=;
 b=ARIjFvP2fnsYbcEXHltBAdQFYr3PILGhiP6Qq5BVk8KbJb1GQqXQAWO35EU21R/mH2
 R0AHsA1lj+0UqX05gYZZ7kLEmiKbHu8t5L9uTDYdvWaLFbBoEnFSLp6H86kYHMQ1pPfQ
 iqZssL5DtzfPcnF57+lZGAhXeMmw+jRKjkjY0p3FIH2etpRdBki05fU2ZCqYhmvI1+Jz
 lW6FnJxWJ8W1pOXc5IvXWFyPf3aUouc/NgM/o7VXq7jnzJAxRHwQpiDxoMPBiDMqA/+Y
 hipf9lJAtVy+j91tCQYlDAvPHSKV6RGQgHGoCaN0FRkM7fFKpVcuP0k6/mTwqU0tF5cs
 izHA==
X-Gm-Message-State: AOAM533oXv1jlNw3DR3qIvmd18kM6t9LHZA1cmaVlMWtcnOkNwC5ed0Z
 nlWddnmdWyTkASUdeINz5zXmaA==
X-Google-Smtp-Source: ABdhPJzyX2ENJ708T6m7AafF111qJOLamumO+O+GF/gyDHlsdzudf9jdalte/BwGjhcvl6o/SKLTvg==
X-Received: by 2002:a62:5ac5:: with SMTP id o188mr1837613pfb.37.1590116524660; 
 Thu, 21 May 2020 20:02:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 131sm5074925pgf.49.2020.05.21.20.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:02:04 -0700 (PDT)
Subject: Re: [PATCH v1 10/15] tests/docker: use a gcc-10 based image for arm64
 tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <612763ac-f669-c2e5-a50f-2d218fdc5dcc@linaro.org>
Date: Thu, 21 May 2020 20:02:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> As we enable newer features that we want to test on arm64 targets we
> need newer compilers. Split off a new debian-arm64-test-cross image
> which we can use to build these new tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                       |  2 ++
>  .../dockerfiles/debian-arm64-test-cross.docker      | 13 +++++++++++++
>  tests/tcg/configure.sh                              |  4 ++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-arm64-test-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


