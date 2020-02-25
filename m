Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8297C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FBE21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNT2RgT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FBE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cA9-00047I-K4
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6c95-0002jQ-59
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6c93-0001VT-Vo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:29:14 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6c93-0001Sb-Og
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:29:13 -0500
Received: by mail-pj1-x1044.google.com with SMTP id m13so1419772pjb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5ImIjWhSehVxzDpaBur3BbMv19BT6lWkYCax4VIOM24=;
 b=pNT2RgT8CR0LzZ2/5BzG+vFyL6rAcO2bcftgDaSYCnKFQJF8q1JTl92V2gZRe2eJeb
 goP7JGpCGFnZBmu4FYd35bPZLojCGLvnmmAWK3uWm9IYUoLGUgEUmSAg42KLCassFatN
 3rFnT9tvGVvfp8eOnbj664I5X1pW55Og/ST9FZP+RucG+NYu2FitqbRPgfzsUF0K+bpm
 sj6wS3hNE9osiTzIV7dW2Hfy7a6cBhzOCGeia2dbgutKiqrzgjES1rA3JfJCvQSYpIqw
 VrhBg0Lk11yxsbE8utO8bcL/LEkmdkqwK6s8e4ROGIypFgLYtVOTgch3iCmBDdlm5Mpn
 mfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ImIjWhSehVxzDpaBur3BbMv19BT6lWkYCax4VIOM24=;
 b=Do72sIzviiWDUPEwxHJKzdVigRG/B6nkM78KUL8/x3I6dT7wqu5ZV8KK+D5lL5o4gh
 2ngLBngml1HIQ/MC01qkV8vOMHXNMj/NKYblU1j2WxweyxQM/hhzTW9bR5chwb7jk4Mw
 EtrhAg0IZLR9tQFxWQFcdb/bcoMyxLODtcU+CZzNPB8q+hNW1vBo64yjILKf/z0lGi6D
 VOPFLKh92+jB/VIp4lnr8xUENbivTU0AY3kVHUU2r2yBYm6+EjRkzbIXULfgauwcspic
 0dTUMyqCqsCUiP2jWj1WM95xVo5LlarEdap5sspd7a67pdesORCuDNby4Y8rojEy98Q7
 OiWA==
X-Gm-Message-State: APjAAAULlQo7K+L7BmAqYPuF4C/QvFK1PU87w2uIHR4/Q+M090/pfpGF
 uLRTH3xZ4elDNr8k/geOPRdPrw==
X-Google-Smtp-Source: APXvYqzkXGlGSxGJicATPy89dleDuhXfzrKaHxIhdC2IcCseukanwSJSz+aVFlF/HmwJYbWhUf/E+A==
X-Received: by 2002:a17:90a:2e86:: with SMTP id
 r6mr5788249pjd.104.1582644549334; 
 Tue, 25 Feb 2020 07:29:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 l1sm3918371pjb.28.2020.02.25.07.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 07:29:08 -0800 (PST)
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
 <ee2ef44a-737b-e989-7f20-18a69e19d430@linaro.org>
 <160d077042713fc46b36650946712a43e6e89b51.camel@linux.intel.com>
 <7b8fd7a0-9cb8-aab8-0f1b-4a77dd7a6378@linaro.org>
 <1c4cf8366513c96063d7f6e2bc9d2e959ad08d6c.camel@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49afa76c-ec18-45b8-19cc-69e63c1385f0@linaro.org>
Date: Tue, 25 Feb 2020 07:29:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1c4cf8366513c96063d7f6e2bc9d2e959ad08d6c.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: robert.hu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 11:34 PM, Robert Hoo wrote:
> Considering the length's dependency on sse2/sse4/avx2/avx512 and the
> algorithms, as well as future's possible changes, additions, I'd rather
> roll back to your original suggestion, use a companion variable with
> each accel_fn(). How do you like it?

How do I like it?

With a modification to init_accel() so that the function and the minimum length
are selected at the same time.


r~

