Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DAC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE04B20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snWMFXN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE04B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCooW-0000pw-Ul
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCoak-0004Y7-Hu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCoaj-0004Va-4T
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:27:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCoai-0004V8-V1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:27:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id q5so1747438pfg.13
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xZ4TF4C/Tida+D1YKtFrpYNWQ2F0Tql897YVpwLBBG4=;
 b=snWMFXN4/5r862BfKdSJgMrQ9o64tg8kg1HBZobrg4zEU5GIhGkg9I4xjumTbZ8wQC
 ruLQpzKxMC6GGNxECN4IVrN+8gG/P8Uw435meTjsG80pyFuLjwIBBtcfiBeBiWGZm+gb
 azdUtQ3DxtEaWnHdGAjOmvSBafD2PxN61Bj2CMLuKEHPKRponyBdtik64g3opoimrHHd
 q1372PwgBvOuCqs8Qgtc2WMKTdgNyxmVFy4CTPv36gZQPluD1SbHoZkr34v/HYXUoXNX
 MBNOPcfJy9eKpLy4mTQVFeceb0iTzixUmpFfdWJ4a6s1+sJiYhC+Trl0+ex9nQuyA9FH
 nG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xZ4TF4C/Tida+D1YKtFrpYNWQ2F0Tql897YVpwLBBG4=;
 b=kbQeD0HmZb/OL6La9MP/fSV9lDnRwo9G4+8zSlsUjQFg+RnrTUecjiD0I/OF17MnnZ
 frrbQednfu+F91IStCYA0aBE5hC3FgqIPZCX3vyN/9iktYPdSByFFDbPAxRpkbj499SR
 NerZGx2iQul3rIIB7nDJbBZzWIq/oNHHYcG0nk7fLHGJ2X8vo6YhlaP0FmVGeWeJhKZ5
 vwNyQ3Ov48TofgMfbMKuzRxOlSZuMVjBZWepYG+szgjtWvraRSiTyqCTCnttNJJtI3mS
 ErEXHgnxtEdmTG97cj12qr5QELHzKXz/C+I/H8OEnyPAueK0Xno87L8jee5vsHxWkyQg
 Ypew==
X-Gm-Message-State: APjAAAVGu9B7MbiMI7tu0ddptscbMrrhMMAR1lyczhn2YiZaVG8wDAcN
 ZRlXkgohfwkHsxdDxqZWx8/c8A==
X-Google-Smtp-Source: APXvYqxzsx3Oh5/C5SKjvP7Lzhq9Px5Dv6cm4mfwHtRdKGfo1f5wJamgG2NauorlaAf7aLsMP4hN9g==
X-Received: by 2002:a17:90a:1b48:: with SMTP id
 q66mr1201326pjq.79.1569346027667; 
 Tue, 24 Sep 2019 10:27:07 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id z13sm3395120pfg.172.2019.09.24.10.27.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 10:27:06 -0700 (PDT)
Subject: Re: [PATCH v4 03/16] qemu/compiler.h: Add optimize_away
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-4-richard.henderson@linaro.org>
 <25be3c2f-f686-4ab1-30cb-47b1c83d46cc@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <72ce9681-f7b4-812d-f61f-9b8a42c8c403@linaro.org>
Date: Tue, 24 Sep 2019 10:27:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <25be3c2f-f686-4ab1-30cb-47b1c83d46cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 12:47 AM, David Hildenbrand wrote:
> On 24.09.19 00:59, Richard Henderson wrote:
>> +/**
>> + * optimize_away()
> 
> I would have used the compiler-speak "optimized_out()" instead.

Hmm, that's just a matter of present vs past test.

Perhaps, qemu_build_not_reached, to mirror g_assert_not_reached and
QEMU_BUILD_BUG_ON?


r~

