Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7426DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A392078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEQIEcWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A392078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDE3N-0003L1-3B
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDE2b-0002se-KA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:42:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDE2Z-0004pY-Ry
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:42:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id q3so1210337pls.11
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kdnyboq6+SFRa3OdB4biI2dSTCS2b7JwjUN9K9hwkdQ=;
 b=kEQIEcWzbyya45VEFxaoOQjBMPBjQPacVwx8kt6JVQd2TeJe31KwTZjCPDNaLY9uzb
 TMPMmuIfsqtoCRAEqujv1nrqXxLc2TrrkkT6W5bpkJn55cJiEhcErsmPZXGazrqPBfzv
 GX2KMSapP/RtU2hXCVVGbVNu7RTg7/cIDefgDNC6PqaoS2GdjWujVPc7G2Yx+/xzUZ3l
 GuvhgNHIlWwJC9xR7ErtmrTgYfkzMLDTtjcY5dXg6L9tGYMb/nd4ashNKR6+J+DrtQkA
 h0VsdDrzgG1uVqAGPaqpjbfLpE/SlQHyor9pIEmoi8V1LB1tbQOdb93EZ7mZ0qGrVK3u
 Kv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kdnyboq6+SFRa3OdB4biI2dSTCS2b7JwjUN9K9hwkdQ=;
 b=qhvmJBoV84MuwA+BL0BjI9NiIMcIF321hafuiJ3UBicrKrkQhb6Ks+rC56ug/PG1P4
 flXZzesbcSObUnPgNQTxVksXpfH5u1VEFh92TTYZVzdKJsUp0xM1f7FEPVN8QDjfH4Qb
 FbZcTgReceoTsnZSGWeFGvEjqb3VA2n9Om9W6s4p3gO6CjBo08nvQ99D+D3U8iOcFMxF
 1TnMJHYJx4qwrVETNZYofMaR7j+hiFEnszDvfTRregLc2lhaBZFSC8pkpk+G0A6cyyho
 sG1t/VV0Ddj+KdEbcmGoffwtNrguhhHBgxk3fw32Q27VHJrCw0CLW5wduwicgF4Vsp5M
 PB+g==
X-Gm-Message-State: AOAM532twrC2t+a6jzYJibFN2ghH1kjR1Jc6f3X0iqMvxDmkbReB48Fq
 EkdN9sblRl8+pwX5qyPezRhF1Q==
X-Google-Smtp-Source: ABdhPJyY4RRZ0EKy0bAMnwAjNfFuliPjsxhwV2PdQmyrKKA/iAEOhdYtRVE7Zat9nLxNNe9GGkJApQ==
X-Received: by 2002:a17:90b:4b89:: with SMTP id
 lr9mr3641530pjb.190.1598996525975; 
 Tue, 01 Sep 2020 14:42:05 -0700 (PDT)
Received: from ?IPv6:2607:fb90:27d2:4b79:8545:2b44:3b48:7db9?
 ([2607:fb90:27d2:4b79:8545:2b44:3b48:7db9])
 by smtp.gmail.com with ESMTPSA id u14sm2988819pfm.103.2020.09.01.14.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 14:42:05 -0700 (PDT)
Subject: Re: [PATCH 5/7] hw/hppa: Add power button emulation
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-6-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96245595-b16c-5ed3-8f46-4883b60c0120@linaro.org>
Date: Tue, 1 Sep 2020 14:42:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901183452.24967-6-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:34 AM, Helge Deller wrote:
> Emulate a power button switch, tell SeaBIOS the address via fw_cfg and
> bind the power button to the qemu UI.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/machine.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

