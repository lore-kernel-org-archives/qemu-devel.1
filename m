Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5176C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 03:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E4120809
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 03:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dm0XL9LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E4120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBrX1-0004nV-M0
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 23:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBrWS-0004Ns-KP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 23:27:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBrWQ-0004cR-Pa
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 23:27:20 -0400
Received: by mail-pg1-x541.google.com with SMTP id 31so1324047pgy.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 20:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s0Kcns4S6hlakk6yl4dq8a0Dj/Hs1wmyj0QmxMqKIns=;
 b=dm0XL9LDi2yVr8pvkenfE7h8eFy9T90h/Aja0jUDJdL2wVUHiIMGvJWHyBfLGjl1tB
 /MKqQOuKTsa3FErnt0ti7s4oBx/5k0W5xt9uUEU2JJA+8oMyEUxnCH9WEP20pH3lVgom
 FomumtyNd1aph1aZGFP3d2jDvvvl5rP9JUOp7akdZAFBFemoq32QOXSsENxb5FszPPyM
 A9I/iDsp7lih5lmJLcUNxTIWny1g4PXTb++X4OJLq+LMb/GGDbgvoi4towo2SIYe7ASG
 VjOiMouZHo1XGdtQQKcu0Ub83L4LiDfupx8ABNyQ6JYXXR5DsD4CQmAgiDtjbtSylcPX
 RHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s0Kcns4S6hlakk6yl4dq8a0Dj/Hs1wmyj0QmxMqKIns=;
 b=bmPHuH6OqwI82+D5r7FEic7BuW75vU6Tlw6pWjVcHfjYN8k2vpATRW4JLogoh0gNsH
 LfkmnkOIZGFb6Wbf+7Sa0xf+HRg9kWYjOgX/ZdEkpaOADJNv4jmo2fyIUGkpkywjgt5g
 u0jEurynUpYY0bjgisI1dlV8BKPd1VuX5VBBc3CwasEvi2Fhu8WVO2TgOwCTCU9ybOux
 tborzS9zxMeNPUeXF+SFvCEriOYJZA0e3JtLTz5+uWA+N3a63Z4/YobkjGzPPgHWdJhc
 mnePToHLGNIVKap4ZRFBhkt2aXPTqpv3denEmgeRoLvxibr6zAmK4uL+lKRt9owbfPZv
 IOQw==
X-Gm-Message-State: AOAM530Don6/hhkEATKtjZF05X2GN7F/TO8NUIOcegyIukqL3F2exlhA
 aa9zBbjbvwMMMiVB4zLXZ9hXUw==
X-Google-Smtp-Source: ABdhPJyWo+3saSJkgd/OeyFNgbMkvU+7binLH09QWwpUZxQp2L50dZW6ArroJ5hPzDXOjOEptI+9Mg==
X-Received: by 2002:a65:58c9:: with SMTP id e9mr1290335pgu.66.1598671636950;
 Fri, 28 Aug 2020 20:27:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j13sm864512pfn.166.2020.08.28.20.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 20:27:16 -0700 (PDT)
Subject: Re: [RFC PATCH v3 00/34] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
Date: Fri, 28 Aug 2020 20:27:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> This series adds support for the Hexagon processor with Linux user support
> 
> See patch 02/34 Hexagon README for detailed information.
> 
> Once the series is applied, the Hexagon port will pass "make check-tcg".
> The series also includes Hexagon-specific tests in tcg/tests/hexagon.
> 
> We have a parallel effort to make the Hexagon Linux toolchain inside a docker
> container publically available.

Oh, excellent.

> *** Future items under consideration ***
> Use qemu softfloat

This is a blocker.  It's definitely not hard.

> Use qemu decodetree

This would certainly clean up all of the string processing that I mentioned.
It seems like it would be just as easy to convert into the decodetree format as
what you're currently doing for dectree_generated.h.  Indeed, easier, since you
only need the ones that are TERMINAL().  All of the other things labeled
TABLE_LINK are handled by decodetree itself.

Anyway, I've completed what review I planed to do against this version.


r~

