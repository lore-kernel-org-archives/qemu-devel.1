Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 01:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A360C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 01:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P55v7Fxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A360C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i23x7-0005wR-Qc
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 21:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i23wL-0005KZ-60
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 21:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i23wG-0004zx-2J
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 21:36:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i23wF-0004yN-Pn
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 21:36:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3so9514113pgb.10
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OsiSZTEerTwA/BISofCm82PmC6rCQ7KB1dG//WLxaMw=;
 b=P55v7FxjTYkpVOXAen1hFE6tPtspj1YH6dKm0ZeMyK0yyP8aFAZvecBalN8gd2yRqs
 MTdNls+IdqrCk8rojK2EgZVC7sgtrZyBDWfFIkTE+f0ClMNVuTFo8v9uc03jR145mEv+
 zt+K+cZquzDUcmm/0+Z1jF0wVx4dqgv1u7xCr9uZ+aNWyghZ6B8O0kDKc3bmZe9xSuIx
 VL3IpuQ/sGdNVpA3Pv7ujp05N3cKoKuMGMmUXADtZGRfSAmxEFj3NuI9SqlgKf742OaY
 vwYZ9Pnrfw/YLT9mcjfJzZBU0zQcezNMjT+2NNez3AJyZ2nT7S/c6y3ngJNHBnO9TLr0
 L2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OsiSZTEerTwA/BISofCm82PmC6rCQ7KB1dG//WLxaMw=;
 b=qX681aGKsXkAQ5ofzIby+Cx6I+PmFHwc+tYiSVRiIul91MsrkNmnGQyTKT3KOFZW9I
 FTiTS6xTfrmgz6aNI3NNUNq1IbeGIBn2QEldK3ziARC4SiK2+g2pPRirHQ8K43DgAauA
 K6n8MuJK+OVPGU7LZUUL4bqszHCXG+2Hw00yoNQv65AGY312tOHx4I0/Ganx11XsgvYe
 XAVGFGD15yM7kkMutewmH44S3UfMX1525CcL1Bsj1hvzn8BhnoWqztmv+ownAS1wyfJ9
 iXjVvYYswEE236qkJata2k+ZFqYALTYGjZagPJkFhl1K+dqXV8PVQZFo5yxOELgmxqyt
 8/Dg==
X-Gm-Message-State: APjAAAW1uN6rl6m8kpsye+9c0lxktSFtq7yqJHdf35b7JCKDP+c4gk51
 MxPUpc2LcC0nNNTvwbylQaI+/iGUStE=
X-Google-Smtp-Source: APXvYqyJ0/WKQZI4v1kdIWGkdPD7zGEc508o0JMM+x0ZfALvpy7RaWZE8h0631TyE9TdaMZFNTjL1Q==
X-Received: by 2002:a62:6489:: with SMTP id y131mr8500332pfb.124.1566783414218; 
 Sun, 25 Aug 2019 18:36:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g2sm15000746pfq.88.2019.08.25.18.36.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 18:36:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-36-richard.henderson@linaro.org>
 <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
 <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
 <CAFEAcA-m76JW2=t8uX6nC8E54TMKLe4nbCGvd8bOKx+wSYRtGg@mail.gmail.com>
 <516fa14a-2e6c-9496-9318-920ccd164b6a@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f8b85485-ab43-cbce-c5f3-25b6fdc8b07a@linaro.org>
Date: Sun, 25 Aug 2019 18:36:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <516fa14a-2e6c-9496-9318-920ccd164b6a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 35/68] target/arm: Convert CPS
 (privileged)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/19 6:10 PM, Richard Henderson wrote:
> On 8/25/19 1:43 PM, Peter Maydell wrote:
>> I'm still confused, I think. The hint space is
>> +  NOP            1111 0011 1010 1111 1000 0000 ---- ----
>> (plus the more specific hint insns before that pattern with
>> fixed values in the [7:0] bits).
>> CPS falls into that space; but you've placed it with
>> SMC and HVC which don't fall into the hint space, because
>> they have 0111 in bits [27:24], not 0011.
> 
> Oops.  I see what you mean.

So, I've moved the line up immediately following the hint space, and added a
comment:

+    # If imod == '00' && M == '0' then SEE "Hint instructions", above.
+    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
+                 &cps

The line *was* still within the same group (which is large), so it doesn't
actually make a difference to the decode, but I do agree it makes more sense in
the new position.


r~

