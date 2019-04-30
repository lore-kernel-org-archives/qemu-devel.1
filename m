Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBCC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59CE20854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUjkTw0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59CE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWm6-0007Rq-UH
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:42:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLWkm-0006eu-A2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLWkl-00044H-44
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:34279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLWkk-00043W-V7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id b3so7426894pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/Up6u0vtv6m18WqqLV8I1912OMepvvimuOP17VJBcwE=;
	b=CUjkTw0RXYrYTPMSUigJxYvcWoH4//q0Rj+Wlv8YDxZjQUgFUN2mq3gMGhK9LWPB+n
	4XasiNBOMzYINw/ZhKEVdFaIpcxIuTZMllI3Tz8sa/d3c3ywExuhnScaLJT/3YYwVj9T
	YRxfHCOtdMdLxlRdcjE4PtT1jHoQ5x+b6KWmYkvZGPO6mgKDEBODs/ACfB3pbQcDKm+r
	NMiNPiqBFKuUrE7hpmJJ8oa4yhN2+5KPutly+IGyigsyoWl6sC4foU7f9frMAw5okJ6/
	HbIgvGqyJBM/HcAZyH4i7axZxLQ6jCvUi5LkYqcM28uOAX259xrFVyMApvJCOCkE+iIe
	E0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/Up6u0vtv6m18WqqLV8I1912OMepvvimuOP17VJBcwE=;
	b=fstdJTKA+WjBMhNmaicNQSlfa8Q5o5vy6mV7KHJsiLIG8iEpQ5E14ZNbbik9U1cRT2
	JL40BImwUHTJiDsImURbvbTlQ35BcuqUiq+ZwZqwlogoCWvHzKh3pHYej9GQi3BGKWPl
	G6nKRory6NbhXXLCyvTWPKDId2oy9toL7iSqYlccf+zq98UH1FYFEVAG9AZX+gBKBNIa
	r/XDrtvlrF6azG8z8RSoeDF0H/1S3j+5kTfEGYBHVL8zei9izM8xLLO7tYk++7PJsYdF
	nuSqlKqA50jiQtNuoI+Sw5nJhlEPs1vH02tun3xKMVsXGzwRE3Q1OXM8T8N2nxlJRCTf
	vaHA==
X-Gm-Message-State: APjAAAXj2WBtkwajCRT3wAx2DFQvx9EQdMjM9p6306ESdT+hts+/fOXY
	n1rQFF6967nGRXz/hNdkjsirZqdst8E=
X-Google-Smtp-Source: APXvYqw5FDFzsc9jy0o+2+x3O8N1VBEqWoykgFyUejT5STJsLeH3gB4BMAy2OHN0gBBD7uMM4a8NtA==
X-Received: by 2002:aa7:8851:: with SMTP id k17mr5114107pfo.121.1556646073315; 
	Tue, 30 Apr 2019 10:41:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	c28sm27368742pgm.42.2019.04.30.10.41.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 10:41:12 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190430131439.25251-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <40ece7b0-e211-dda4-7734-7d714ab5b6d0@linaro.org>
Date: Tue, 30 Apr 2019 10:40:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: four minor M-profile bug
 fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430174053.xEq_OjGJ5QmOeOMJSkohXipck4glrri-m5kg_wEG9sM@z>

On 4/30/19 6:14 AM, Peter Maydell wrote:
> Peter Maydell (4):
>   hw/arm/armv7m_nvic: Check subpriority in nvic_recompute_state_secure()
>   hw/intc/armv7m_nvic: NS BFAR and BFSR are RAZ/WI if BFHFNMINS == 0
>   hw/intc/armv7m_nvic: Don't enable ARMV7M_EXCP_DEBUG from reset
>   target/arm: Implement XPSR GE bits

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

