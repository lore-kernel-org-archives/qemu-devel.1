Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD7C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E72F217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcIYvKLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E72F217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvmXx-0003fx-0B
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmXZ-0003G5-QA
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmXY-0006dO-Vr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:49:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvmXY-0006c8-Ly
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:49:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id n190so3628219pgn.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dphI86sCXWnd8H0zk4n5M41XQSbtdx1eBl31RMl+ko4=;
 b=XcIYvKLx9wA2+eBXyIhAoAagwG9Zl1DyMnCTrVqxTZw0aDHCz562eicAH8EqfBX5Mn
 xTMI3GgncCj60gs1yioftsyVZvmb2yh1rw0PJ78AstZOdjskKmYs8WqV5/6u1aZ+pwKZ
 7PaliC7wkKEv9fbPODAwUaH9xKbHL1jZNpSKpQPggxT3VCSCFndENbBgNAKJSqXvaNAg
 eaSybcbQGVUTp4Gdl4V7pu0nihUFmJV2mNkSmWCLCubT8T7sUVq+RZ34mR23ugnlBhm7
 b8ZgoXfePP1YtdbvWr2YdnaScTBj7TIg5RJa58L6nlHZvs/AC4bId4XGZEHVo2KO3ELy
 unYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dphI86sCXWnd8H0zk4n5M41XQSbtdx1eBl31RMl+ko4=;
 b=g9Vv+bcLpiDOKYDixqgBx09Gl/XYn96txxbfMWQeg3xzWqaetB6mEV8eN5V/cFuCB5
 ltbx5/GhH7v4k06NiBznRd6ubva65JeS29rCQV9+hNNqstO6bsMmvuA46XpgjHN5cr/7
 +HfwFCVlkzC8VR/haymiVa0KkpGUkJGJmVvSSKsrHp3iUDzZSJnaOSm6YqmxJWwK5+BN
 seu0041L1+nzEbwa0qvwZNjJNV7nofleJDxAaliUGS1bidVCuIigGeb5KagM/XlbD9YJ
 nHS/kF70YNBCLcUMLKJbD9QfukVv8LT/2+XOaOrxXwlL34yt426Yp8uE2SmUk3XXXGLy
 o4MA==
X-Gm-Message-State: APjAAAWF9yg/dTdaHnz5E3T7KkfMfdlrbnanPu937AFkfkgOkR4mJBqm
 ev7qLqW3GXQuwFSilND34WxC8A==
X-Google-Smtp-Source: APXvYqwmTiGLETcb7nHuEDvI3hvWZcV4HzUTglSrAAxNKIriVG0G0V4RpJR77VuRprzO1Q8K9UQsHw==
X-Received: by 2002:a63:4823:: with SMTP id v35mr13844378pga.138.1565286567067; 
 Thu, 08 Aug 2019 10:49:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h129sm90488925pfb.110.2019.08.08.10.49.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 10:49:25 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3b04cb99-57ac-2b9a-a608-99e340ae3ee4@linaro.org>
Date: Thu, 8 Aug 2019 10:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808164117.23348-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 3/7] fpu: make softfloat-macros
 "self-contained"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:41 AM, Alex Bennée wrote:
> The macros use the "flags" type and to be consistent if anyone just
> needs the macros we should bring in the header we need. There is an
> outstanding TODO to audit the use of "flags" and replace with bool at
> which point this include could be dropped.

Indeed.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

