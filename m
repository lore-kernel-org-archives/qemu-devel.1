Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40107C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9B620767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/SNvrbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9B620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofR7-0004Lh-9u
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof9l-0008Gj-JE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:36:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof9j-0003w0-0j
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:36:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id l63so4337065pge.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S5hTNrTg53V+kvgMrMI5iFhgsZe445N0WGrm/PvSJ98=;
 b=y/SNvrbD3dXtvEkLgIpgDJQ8pITtgayPjeuk5CTFoNbcT3CFf8mnYKRQlxXv/ztUa5
 zPc5XbO6YT7lViWaWIIBNnLssTJ2tByKzfIC4pCRoguHnsMsA9FHaUSwwO/LSpkgI8hs
 W1Qv3SbdL3IOk7kVfV3BQgSgDa4pwGTYhHOtV9F5i9CQhEGhVNVDgQe8ykgKjaVW7zIr
 ilYDpc5ZnX+KQTatYv1aw0aFEq+OpkPzIv0WzfwowvCl7muIcrx+AYfsXaY/XVFhls2a
 kOpAahrSy2hs/e3+btL9nA0KZHl1TlVhJagges6RLHt8FblpoZVl2i8G59Ihvi84sV03
 g/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S5hTNrTg53V+kvgMrMI5iFhgsZe445N0WGrm/PvSJ98=;
 b=MxNCKe9ZAaPvSyMLKJ1l3xJqhpn4ArwXkSHOAguZC2AzTT36Iexh6t3vX8GBtH3k0p
 b3oxbuK5OL9i+w6IjsBkRg70q1g++hR9KZqgfe2X+OHJOVQUnKxDJBJiCz+hKfo5IjT+
 e5YGmVxg24/23wkTRw9Z4G2TrCH2RXXuQCUVtGEPDdbK4tD9cu10zMTzB6lYSkpkjdaj
 1uL2I3KnoVtRhhfEanlGdG0s0ZzFrvRs+nNrYQE92Bgl/RlshHJBscsWmgpdaYu5N+Z4
 c5qJtB55kf1h7dEZuO7OhM5vPuVCY3V0MX8dieBmDx0bsiD1yUb8ZbNxswpr99E1Ck+y
 UPNw==
X-Gm-Message-State: AOAM530dGT17o61Vj/u4OLHDidYQq3lm4Ws18GRGLVdWpz9ussD2Cx0E
 tgbZSuWlEu75biF87qiYM3dB2Q==
X-Google-Smtp-Source: ABdhPJzUArUa/eD1DNlfQ8+lJ04XX3pCwbtpZjwKye8glGdauyBz0IZRZ6FEbV032IBEP2MIKavUTQ==
X-Received: by 2002:a05:6a00:15c7:: with SMTP id
 o7mr820935pfu.51.1593142557733; 
 Thu, 25 Jun 2020 20:35:57 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j13sm9892374pje.25.2020.06.25.20.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 20:35:57 -0700 (PDT)
Subject: Re: [PATCH v9 00/46] target/arm: Implement ARMv8.5-MemTag, system mode
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200626033144.790098-1-richard.henderson@linaro.org>
Message-ID: <64b21a5f-b7bc-8031-95a5-fa03c2800eda@linaro.org>
Date: Thu, 25 Jun 2020 20:35:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 8:30 PM, Richard Henderson wrote:
> Version 9 incorporates some review:
> 
>   * Adjust some commentary.
>   * Added an assert for tbi in aarch64_tr_init_disas_context
>   * Split arm,armv8.5-memtag to a new, final, patch.  We might
>     just leave this one out of qemu mainline until the kernel
>     patch set that requires it gets merged.

Meant to say, the following patches lack review:

43-target-arm-Create-tagged-ram-when-MTE-is-enabled.patch
44-target-arm-Add-allocation-tag-storage-for-system-.patch
46-target-arm-Add-arm-armv8.5-memtag-to-dtb.patch

That last one of course is new.


r~

