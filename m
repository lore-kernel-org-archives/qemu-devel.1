Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B0921556
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luqtsmGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B0921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmOOT-00033D-00
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 17:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmONB-0002KB-Vo
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:16:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmONA-0004fq-8m
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:16:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id k1so4422169pls.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IDVowvuDcIr7e7o+nP6FdV3lxtuajzSse/hqxBEV4yo=;
 b=luqtsmGmdEzlJJOlYv6fRgDFZ9x53ofek9LMJAyCIuF7A1OSLj2YLGv1J3k6ojA79c
 EEh0HLHR3BMdu+ighCQO+wFysC40Bx1jekTLABCkFSTHO+Y9xi2qCJHXwWYZGftoETYD
 /YGU330XHOhbzixm0jZZLATAxM3pH/K6T1LvkwtVkYKeR4+T+rVZEdNquyTF8OBZW1bN
 DGGt/szYoigcdv0iIxbP32ZTNbZnh7T6b4IW8BctZYe6bVN2XH/EhbnX329yOp9PWMLc
 OCsHGMD/JkPoWLRrysWFYbySq2r17QFzy54ECaLuMzbF9dd7OPAihutJupm/l3X5XrLU
 cTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IDVowvuDcIr7e7o+nP6FdV3lxtuajzSse/hqxBEV4yo=;
 b=eVbf6Z/I/7GFeC1qNtbNEZA6khnScr2n9mnaxrKr6cwt3cnIYU5D3TXOID2YWTQmgj
 el5sf4/gdxstmH6U736+8FMCO/JmIhbSpkC3a1mK5uKEyJ9hZ3jDJm47h/GbH0WEkC7l
 wOazNmoXp+bQ8nadXE1yuWm6g+cAYmIf6+QmTCVmbf90jEav+ZiziM2juzRzSQC/svG+
 NWdG4ZbUp+TWSNsm9ntXrDOppz9yGv7J6RQKjoRm4pUEnROBY6JR8Yz9lOV+eCzJfhJl
 9BdHlfV3lx+xKvaclTFB605q94kMnxeHvvk4Q8hCN0q5h4oaMR81KsubA9Z8nKVLIhpn
 ebiQ==
X-Gm-Message-State: AOAM5304lTn3YaFPEsBl1EpLH2w0jXmy2hZPe4PEtV7Un7Fh2DgacN2a
 BXIUUd+tRMayB2jnIOnAFUfJ3MfghEc=
X-Google-Smtp-Source: ABdhPJxfDmBmDGSMxBoP6WIAC8pu9ndr7F3TCqN0ahoi6Ahq+VEm5A59H+A/aACmp9yrPD+Gc4ZFrA==
X-Received: by 2002:a17:902:b40f:: with SMTP id
 x15mr9079741plr.164.1592601385303; 
 Fri, 19 Jun 2020 14:16:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm6550634pfb.118.2020.06.19.14.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 14:16:24 -0700 (PDT)
Subject: Re: [PATCH 2/6] target/ppc: add vmulld instruction
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-3-ljp@linux.ibm.com>
 <4341c9e1-162f-d640-e733-d69d2f894353@linaro.org>
 <B805D51A-00EA-4A6F-92BC-A30B7F3D2B41@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b161c797-659e-d3d2-d1c7-c1d53dfe4756@linaro.org>
Date: Fri, 19 Jun 2020 14:16:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <B805D51A-00EA-4A6F-92BC-A30B7F3D2B41@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

On 6/18/20 10:30 PM, Lijun Pan wrote:
> Why do we need to convert
> to tcg_gen_gvec_mul, which seems to me very convoluted?

Because that way we can generate a single host vector multiply instruction in
the compiled translation block.


r~

