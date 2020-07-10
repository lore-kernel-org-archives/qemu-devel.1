Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB61C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABBC2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtD1cfEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABBC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyk5-0000gu-3k
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtyj4-0008BB-Vw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:30:27 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:35406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtyj3-00054Z-7U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:30:26 -0400
Received: by mail-pj1-x102a.google.com with SMTP id f16so3034377pjt.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4bncDFQ2589adXQaLAvp8m6vJONFZ6dRXrd+a4Px1rw=;
 b=CtD1cfEH2YNCr7XXFdELMv28twKfvV6AQbfCuy4t6BRdpciAv61593mWr+dRBECJ+6
 GHQSSRBzzZa2vQRsJHDS9g2eNm7XoodIxVcjPMTtzy0BBg5FWMuMlLmiQpPFfw5l5/fg
 ERl1zjnsuEoKjzXURIGMDODZ/XZB0auiChV9XEn+yAQNqXMjHxXC6kxxS2qXMBGKTZ1t
 IynIr3SWncYEp6yUsuJbQVJVdPrh+lLUF/muMKp6ZgbCSQJZ5dfalvJ+wOew62Y2cGO8
 6aeFQ/hTFy+aiFeyaDBdLeSWXCE3+FH+el8Fvi2/+mvgj2aC3yFXA4eiMq+sa76uDjDK
 tXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4bncDFQ2589adXQaLAvp8m6vJONFZ6dRXrd+a4Px1rw=;
 b=tdmTS7VWCglHV1YVLDWL2B71o82EE5xNSNKPdjayIj1R0807aZKnLIbkzimh0DrdtV
 hcG50NhZuRUDKmZCi3mjD0c5wzzu2GcghPKdBxBQIcCpg4zAaoOjQ/AeQFV/2qNvksou
 VDq6rMDE3n0yiSYyAYNAcP0fs43y3CC4oJBepmJxotxXmqAo+R8cCpwJtotLc8GC2bR+
 1uCNjAES5AGJjRfG+vDXLlBAg5OU61iijRX2c1DPxmMaI/0CpEmkwvt3sIWbzymJxnnX
 dPlFnje6+mCjwK+TyL6V9vfMnjfCUCgtenRPdPe/UQ3DzAJk3Qx2B4ay1xYN1VThO90t
 lw4g==
X-Gm-Message-State: AOAM532fJiUYYJwGEha0l+0unwVc2N/GKUgkVq6TKXbNlS2mBkn3DRqr
 3/fMlsxrEHWpZRblBAd55gBujg==
X-Google-Smtp-Source: ABdhPJwiqQX6oZyLBG3fIKN44mZgg+27fqJOzr41MS0BaQCqZFS5g2jFBUmBUQdBHvhHrVJ9W6N7qQ==
X-Received: by 2002:a17:90b:1b44:: with SMTP id
 nv4mr7333851pjb.84.1594409423648; 
 Fri, 10 Jul 2020 12:30:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm6338792pgk.40.2020.07.10.12.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 12:30:22 -0700 (PDT)
Subject: Re: Updates on libcapstone?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <16ea7c6b-d959-9df2-0603-d07e40ff4021@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6301171-a296-c65c-8e59-6a98a7b3f2ed@linaro.org>
Date: Fri, 10 Jul 2020 12:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <16ea7c6b-d959-9df2-0603-d07e40ff4021@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 6:07 AM, Philippe Mathieu-Daudé wrote:
> I remember you had a series related to capstone, but eventually there
> was a problem so you postponed it until some patches were merged
> upstream, do you remember?

I do.

My biggest problem with libcapstone is that it doesn't have an automated way to
merge from upstream llvm, so it doesn't get any new architecture updates.

What I think we should do is drop libcapstone entirely, and use libllvm
directly.  It's a bit more code to use, but llvm is where new architectures
(and architecture extensions) get merged.

A mere matter of coding...


r~

