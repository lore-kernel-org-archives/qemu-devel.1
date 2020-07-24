Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC5C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E37206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzUf4Kjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E37206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz1vD-0003ix-GA
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 13:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz1uC-0002uS-Oj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:54:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz1u9-0005BX-G1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:54:48 -0400
Received: by mail-pf1-x444.google.com with SMTP id j20so5613129pfe.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=JGxFbYG2mc4s3nmcf5IpceT25AqnfsUi/Wa0B+Qh9BI=;
 b=VzUf4KjmG6azbJ7us/JKYTrbYhhk6tVOoxs8KXVND0wzIGGoUsISv6Rp0JNRDBXe8K
 5MPe1TATx5FFPAP9CQybZagx+OsLawESfWhfYDpkY7AzTXTBaAF3Vm+soVdMqTuy7Lhp
 zCUnVh7hy0NjnRNaewatV+QFs5QHxQlymAFJQe4CPErSHFK0njhmQPS/vArzyJDQAqVk
 6sG0WCi66wPcsv8L2LNZRhrGAhmE66kGR8c9gjwlKJMYTvoTtRq+2L8KIrO75bBPkWwL
 W6s9SyFCSHQTT4kLSom9WnuYqwnKw6e41ynO/Kf87RDjxNSW5tYvaVehhwGYlIEfu+l0
 LsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JGxFbYG2mc4s3nmcf5IpceT25AqnfsUi/Wa0B+Qh9BI=;
 b=AqwxDGBNj3Q1B+j2kaA71z4DPcF/3IcPwLYsWA+663rxNa3jt3Ra0S5ji1vaBRR98l
 nNVt9bWwj6B/+O02hrlKI+QvpefIkfNaKOLeLG2qCkEP/LRHgN+/pacLu0HO+a3soarZ
 HYJz0KHjXLYwwNHhi5nHaytYynbRKGX8kaW+DWuc0bPchccZqhH8NzOWEvaODuys3m0f
 Txh/sXAiFzJoRqu4wKKb/mUVY/AGT5xTb5LYExvoJmnUUhxgTOhOMdVmvXhPpONf8oRg
 ho0oO5MJwrSTQOxZfdomsIEWY+CXzWlBaJAPKf77W8j467OTFnCcx/plxvdXM6EN/yTs
 i4AQ==
X-Gm-Message-State: AOAM531ySxzIENjdnfl5rriiLxygIR6LO41o4dw46IWkedWdjJeEUKdg
 JxkZOE584i2ak/cm62QqEH9Qcw==
X-Google-Smtp-Source: ABdhPJylGlMRGNBIgHmyZg4llzzvVy6kuPzFWO/cbUUUz8J/jK3/LyrhXZzwOoqsSf584bRt1nRMsw==
X-Received: by 2002:a65:6883:: with SMTP id e3mr9649706pgt.5.1595613283489;
 Fri, 24 Jul 2020 10:54:43 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 w18sm7127415pfi.89.2020.07.24.10.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 10:54:42 -0700 (PDT)
Subject: Re: [PATCH v5 1/6] Update PowerPC AT_HWCAP2 definition
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
References: <20200724045845.89976-1-ljp@linux.ibm.com>
 <20200724045845.89976-2-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <824a0d97-8235-b73e-238d-27a6f259bb9d@linaro.org>
Date: Fri, 24 Jul 2020 10:54:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724045845.89976-2-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 9:58 PM, Lijun Pan wrote:
> Add PPC2_FEATURE2_ARCH_3_10 to the PowerPC AT_HWCAP2 definitions.
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

We should add the rest of the bits as well at some point.


r~

