Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47529C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5662083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rl+8fCkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5662083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmOGA-0006Ls-9z
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 17:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmOFR-0005oH-QU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:08:29 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmOFP-00035T-Cn
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:08:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id s10so5026298pgm.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1dJ3cLF8rWqPTI40VYjja+T5DhXNmNyovUN262fbRtU=;
 b=Rl+8fCkzsyL1IJzp13f+5eTqw3az1j996GlQXAE3lsolLkBX/tSXnJn1lKAbATecOa
 qowoUk+uzZaxJHoGZu31VQR5GR1wjCCVZHZON1u52Bam1sMTtXTKBvcJto7Ee66v9GGq
 v3WGS22JOrRZmRROQXqxOzYSBvfX+7idLe8kzBp7mFW7VB2d8EQELSQTh2XD/ZRb3YlH
 XMDZY0F1I7WUlatxl8pdCQ6AZfKYQnmQUUh/rc0zobftdQuROrOX7Nyj5I6v2P9fwIoE
 qF9yls+4LKfhcDqNSeBP1Y0alT+3eBu31HK7AkfPkqXBJuubw8+n8+qaK/NELnoUZvXO
 tijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1dJ3cLF8rWqPTI40VYjja+T5DhXNmNyovUN262fbRtU=;
 b=KuSzdQBlQ3dUkcZAoDc7dl96ESwH1jhgEyEtkNgPzfE7xKxA1/Z3E4rFrqUh65WAYF
 uCxQphTfuHrNDic2s+6VAURSNGDesrN4qN8cxcOXa8DZ77T8bSO7otH8Vdnc/E2Y5obB
 6GvxmTyCQBxAn6hv2UKWpYhpaso6oVPln6Eom3+NDRve1s4fD3rYpxM3ILR13MoJnQ4Z
 CrdDmDzWkDuaf1KC2l9rw2npJl0fLPiypMmR3gkd6AUH7IJv8Uk4SwnGpmEsTdvxvA9+
 iQ1t7vGt2XMQGEM/TXXs6stVRPfe29uAYOWm1W2cxRuYMjkPCo140ruwTzFaIJQ29fIQ
 atWg==
X-Gm-Message-State: AOAM530x3frIJcnnsTnXqMKKCDCxaaaOn9B3D8F1rPIIf2O1Mfy+uN6T
 lpPnMEM3n1DExtvJiFRVaWHfiHXXQZs=
X-Google-Smtp-Source: ABdhPJx6WxKR23kyhBRuHB2a8yn4Z+BHouhaAfarMgKrb6lxjfwO1bU2eAbIuCkSYXiQnmRxsaCfjg==
X-Received: by 2002:a63:ca4a:: with SMTP id o10mr4398354pgi.182.1592600905234; 
 Fri, 19 Jun 2020 14:08:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n69sm7018706pfd.171.2020.06.19.14.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 14:08:24 -0700 (PDT)
Subject: Re: [PATCH 1/6] target/ppc: add byte-reverse br[dwh] instructions
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-2-ljp@linux.ibm.com>
 <e28b81dd-96ab-78ab-52d1-d751dd38315f@linaro.org>
 <311E28F8-05EE-4530-9C5E-3DE6034AEF09@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c503c8d-297d-0024-eced-8108e38327f2@linaro.org>
Date: Fri, 19 Jun 2020 14:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <311E28F8-05EE-4530-9C5E-3DE6034AEF09@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 10:24 PM, Lijun Pan wrote:
> Why can’t I retrieve the offset via “offsetof(CPUPPCState,gpr[rA(ctx->opcode)])”?
> I would like to learn more.

The TCG compiler makes some simplifying assumptions in order to make it faster.
 One of them is that global temporaries cannot be modified via direct loads and
stores, so we do not have to check for that overlap during compilation.

I thought that was documented in tcg/README, but I can't find it.


r~

