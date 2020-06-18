Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1914EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1DD2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPRx4Hn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1DD2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jly33-0006yC-3o
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jly2P-0006JH-9Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:09:17 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jly2K-0000f2-Jq
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:09:16 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ne5so2802679pjb.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C5wKJJ7ax7plxCcuBaWVymDM740l0fpgaLGM+LdnYQo=;
 b=jPRx4Hn5ocvCn03H8AGQnUa830kAvSEaWqg6m8il8HgIc3hVebnFaG0Zj9uMXOfp7p
 M28BzAGVTp2mb16xQHoaNMaA++FV7/m1JGPjaNh65rudasysJGKz/SZNJKcbNcIzzq9p
 qiFu7EwA+ieupBLgQvBmTX+DLhjZxVRwFKlQpbOc6J6Y9Ckpusj4VHmqerpAVOh/ujE9
 lw40+qA6uSMdxHu27b0z0x+6QvwBd7CjtLePrlhIlrIek4h6gefdkKvqD3GcOFL8prVZ
 Abvj8b60bNFKSIduwQT3zpDPdSEp+VaBkHw262eltutYeXtMrnLE+n9Mfd5NMhCARTzt
 7uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C5wKJJ7ax7plxCcuBaWVymDM740l0fpgaLGM+LdnYQo=;
 b=Wmq6KkpBK6ouo+gyx9bL0vOG/Fg6OtX6chqcUKRwPj3YLIN4kS+QnJlKOWtXQaHuLH
 VgVuD3h/DzfYXIX3HfbYrg8xGKvA6CCklAFcsTlW0qqzO5Rvh2d+fPxYrXWm+GlzOHmX
 U2LfkGescX9nRfRHojPG5V5/aEdiehk7wA/t/josLT2AOA+odbwRHRYqQKF65GQwhpxh
 ClhFF1++4OZzZtxqdu48C2+rY0+pqCkuOLoozwCj9oeJAqMPjTBkWcd8u9xbIDEsXle+
 fLpwUmF8HqN99TWAQy17ebKaDiTTu/jUI1T2EU0WGMt8eG3BZmXvYSiW3MVYMlZlC+ow
 ebJQ==
X-Gm-Message-State: AOAM531Sl7/IN70wofv0axW2GbHSQ18AYQSKMtIX1ps1Ch7IJa+PAull
 VuE5CAcFThXOKJSWvj/M0MnqFw==
X-Google-Smtp-Source: ABdhPJx6orPM1V+ZV9oEobA/aox5tlVBI5+aMARFm2fWZcClv52nK9c6jVZNCi/6M6oPDttniwIYJQ==
X-Received: by 2002:a17:90a:69c3:: with SMTP id
 s61mr5295822pjj.212.1592500150949; 
 Thu, 18 Jun 2020 10:09:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 125sm3289713pff.130.2020.06.18.10.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 10:09:10 -0700 (PDT)
Subject: Re: [PATCH v7 15/42] target/arm: Implement LDG, STG, ST2G instructions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-16-richard.henderson@linaro.org>
 <CAFEAcA8LEApobASw-D6PMdkR2sAjJfnu5DzBeD29hjdoHtuXJg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e64175f-14b6-4347-df89-866bfcf75a92@linaro.org>
Date: Thu, 18 Jun 2020 10:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8LEApobASw-D6PMdkR2sAjJfnu5DzBeD29hjdoHtuXJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 6:56 AM, Peter Maydell wrote:
> The pseudocode for LDG has an
>    address = Align(address, TAG_GRANULE);
> in it. I don't see where in this code is the equivalent; have I missed it?

Nope, I missed it.


r~

