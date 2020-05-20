Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF02C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC622075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPw5xPkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC622075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHSh-0000QT-1A
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbHRn-000848-Ex
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:39:19 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbHRl-00061k-Ej
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:39:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id y198so1033075pfb.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FInLJZsz7DTqWcGwjBxLaRbWeRV5xABJxDSojaES5KY=;
 b=oPw5xPkA2TMKFp1prKUSo+rayv5WQx3+L/8acQ7kvJ5WzXKD9SiUs1AVcR6OD2S5Ud
 Ov0q8I7b285SO/yGTVTjQuDfFak13rE/1bBdUiHbAmojclT97yF5Uo+KpDitVsWVrxnR
 /FH700R5Wr34EtK5xw37Bs/AJPm4UPWPf7MMru995LOdEwUZa4oEhxWrk83fsYnJYqce
 mSAz+QYfwqVt64DXni6Z+STyluThihunrv1Y9xLy47VbRbmCroX6j+7B7EyRMuDAs6Pp
 bbwZH2r8Vh+cMUGJ2gjfqQ+yAbQY8CNh+kA5f4SoioYQSAk1LwGu4AqK5a9+ylyBZqbc
 PN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FInLJZsz7DTqWcGwjBxLaRbWeRV5xABJxDSojaES5KY=;
 b=S2fZ8UiFEE/xONjPnftSrXKnB4jsfowgcKJm7V2NLk2ZuDJ1SzT+o39dNSZuCqEXmC
 iSvCYWxVP7fcBgVOl7vzy9imZJ0q5x41+/AzPC2FWJSUbnkH0vbcMVg9SQTyLz7KEZu+
 RzMtd/oH9VkY7EncpJ8TOwQprgkWbL/khe2FI+jeGJkPzsMkMusCP+3E8sTv+V1EqTWL
 q5pWcG1z9Wk7qtPDrrdxf6rRe4+EcTpXux2CNm4J14pd/fBx1BVX7aZ7I63LM56OVdMp
 ZMy8keBKqhUv/EIK+rG2IXmCFONJR1Mmn2TBVZRycdAPf2mvgbhqPHuRVZ1Zoxj85/2h
 kMcw==
X-Gm-Message-State: AOAM532hegjvbLy7s9kOeVgjBKR4azI646397gd9AniVk45NwJ/gEhYS
 34gWTMRVDMt4Q4njLdE+qmRk6A==
X-Google-Smtp-Source: ABdhPJwLb7sqsvqUu6Q29FaPEPim2OcgLc/9qs1KFVPeRYlOXneX5oVgn3PFdKu/9uRA8dXdMbxZeg==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr2757768pfq.133.1589953155824; 
 Tue, 19 May 2020 22:39:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d4sm902663pgk.2.2020.05.19.22.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 22:39:15 -0700 (PDT)
Subject: Re: [RFC PATCH 1/8] riscv: Add RV64I instructions description
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-2-zhiwei_liu@c-sky.com>
 <eb866cde-b8c1-f722-d364-1ae015bb277d@linaro.org>
 <c776b7f2-ceda-4ab8-b006-698dd41fcc48@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f84427c-8978-0e36-f4e8-d498e15ead20@linaro.org>
Date: Tue, 19 May 2020 22:39:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c776b7f2-ceda-4ab8-b006-698dd41fcc48@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 7:41 PM, LIU Zhiwei wrote:
>> Since all of sp, gp, tp are not in risu's control, why is rs1 only excluding
>> sp, and not gp and tp as well?
> When I test the patch set, I find gp and tp will be the same in slave and master，
> so they can be used as source register.

Ah, try again with different builds of risu, e.g. one with -O2 and one with
-O0.  I think you will find that these values are set by the linker for the image.


r~

