Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC13C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5351A20672
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za4NkfDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5351A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Q7-00085h-9V
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0BC-0004zI-1L
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:07:39 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0B7-0006df-Sb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:07:31 -0400
Received: by mail-oi1-x241.google.com with SMTP id n2so5921312oij.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ONkJIrbK1torrDdBGJJRgeh6kaC1KL96oZt5PF7RaCQ=;
 b=za4NkfDvWN13fGfHboT8pvEUjuwwCA5EtexythSanAihYxOnDZWA8VRW0Ni+Ix2NSy
 XVc3JDU0FtNDuHrSxnjuU9N3h4c3Y184susuYGN52YY39OMtb7mZFLdqTb0KWlN6jPI6
 tSGwV1ly3j+ciq+pPccJdlxfwv2qcWpEawqpYDeQJKhf6cnPOpWwzSb58EVAx8ZH2DdP
 NxuPnFm5h3m0uVPdW0lLq3hKDjCFNIAMIfLIJFaiBeVB168b3l8M3Q6aAecsggrrC7kq
 4FMiYqYKhr312MPrmiy4nz8l1AGS8FzyfpuQV47tiSF8pr6j4mV4P4pyk9Yg8S92mn4/
 RxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ONkJIrbK1torrDdBGJJRgeh6kaC1KL96oZt5PF7RaCQ=;
 b=eaRreIGT0kcovGZXQlUgmzsRg+d9Tp7G1DFlIPCYwQRZS7jjeXB9VMa7vpOzO274Ci
 xZ6eus6+EqrmaML3v1OWAK7po3+2vX4L5/P/zd8uGzsdJezWgaJ0/8qGEhAv9wLKLNKs
 WTIVIHFEoXUTTfGOXSnUyQYRkRB36+pJJ7QdcVt8kgrpjH+Xpha8FG/1V0zl6RVVhwIC
 uY430gUV3MqGC2GUgzNt4aNoeJwA6Dh+S//SNCvWqMWmbx46YKSMBmGlXZGlfQQxVCWo
 hsbh3ipXlRQWtOklB/J+Yfr2mfjNHfndusHpWrVnb/35TLdHwjwCUO8SIUk6Rv5leuZB
 boyg==
X-Gm-Message-State: AOAM530HIcaa7DVUDc8VljxbUEE1dGS8d9Sn7YVmZBujKaJb7kqaeRyB
 JAcbdQFD1FJcajN6BN/otajsPw==
X-Google-Smtp-Source: ABdhPJzApCoMru70RR/TeB1THPIUStEW2ZhYghkU4YNToQFenvAvI66QXMb34m98QzSthuaM+fxpyA==
X-Received: by 2002:a54:4501:: with SMTP id l1mr234140oil.165.1601564848549;
 Thu, 01 Oct 2020 08:07:28 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id y69sm648484otb.69.2020.10.01.08.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:07:27 -0700 (PDT)
Subject: Re: [PATCH v1 00/20] s390x/tcg: Implement Vector enhancements
 facility and switch to z14
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5f9e3398-d84c-17af-42b2-c011cb5074f3@linaro.org>
Date: Thu, 1 Oct 2020 10:07:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> This series adds support for the "Vector enhancements facility" and bumps
> the qemu CPU model tp to a stripped-down z14.
> 
> I yet have to find a way to get more test coverage - looks like some of
> the functions aren't used anywhere yet (e.g., VECTOR FP MAXIMUM), writing
> unit tests to cover all functions and cases is just nasty. But I might be
> wrong - I'm planning to at least test basic functionality of all new added
> instructions.

This is where RISU can be helpful.  Auto-generate 100k random variations,
record known good results on hardware, verify that replay on qemu produces the
same results.


r~

