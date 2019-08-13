Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D8DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7953A20840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zETaudjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOsi-0002pR-QV
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 00:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOrR-00007U-BE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOrQ-0006GQ-9l
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:56:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOrQ-0006Fx-2G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:56:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id j16so4229014wrr.8
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+OMWq7eHj5PmfgF0L4NQkrLmtbvDkCvKMstRZ78nXhA=;
 b=zETaudjS1ZKW1UIDBF+V2UZhXdfZB6rKQd0L0vM0n2x+mYAS6CS8IHTnMCzgxQb+Lv
 iVzOcGyRCBzgm+aPrPhZO5snP/4qHRE1i916VqfgkmEpzTZYKoGVc7/ZngUeSD3QZ049
 yQWhETCJGYfzCYjyXBU5kikh0pdJpuUuh3F5HIZtSMEf3yjGjW/Jc53zeIZ1HsGp6jed
 fy1TZQADCDLzk2jShImUslL2FUWuZ/cGX5616Du6+k8DkXtUQNRwdatJ69z6TCAD7jkJ
 eRpVy3lVNOX/wkl4O2F3LvNoJ73m7N3b8zjlR08juHJ/XwCIfaeTDxHzJMMjsEcsrwk3
 xMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+OMWq7eHj5PmfgF0L4NQkrLmtbvDkCvKMstRZ78nXhA=;
 b=kh6CWVYxelA1zD2Ip5HKHDWaP7BVmRtB/yZ61Sw9f+16oGel6lEIDcAKjR5jF6S+5I
 DxRT9ha+o++Y1yifbA5Eme/D/nURkfhANRYrPm+SV9/JFvCQyS/1H0XhywMhp8U1P7XH
 9d5OjGnHvuVHGCrNJ/KGYbqbUzoNHoPqsIRlNuO3PBAC510VrojfhVPxyJlpScqhTuBv
 HLihh9LOGda5yBX5Th7HM5SXKN1gUvJtInw6Hbn/4jZJxp10AqLDvYvBgoNtrASUvxBW
 YudF8Wsur8IMSbjnXj78lHaYWfF8SnJ+ioiUjwoJPaUNS550UgyAABiV/1ty7QtQ8fBb
 bFoA==
X-Gm-Message-State: APjAAAUn7dJtXNHKk99ITlN+dUoLv5Oyz3FY6F/nKg3DyKIho0g/8mzK
 uB3kRGVPOjn/Z6sMt0KqB7ViZuN1f1HSdw==
X-Google-Smtp-Source: APXvYqyRu6CbQBQ8oK9j77xUWLQbdRWcqlIqGcVSPI6x05rSZFb+a5vrozuk+sN7OxZDDQlsTbG69Q==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr43027573wrn.198.1565672198892; 
 Mon, 12 Aug 2019 21:56:38 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id f197sm711587wme.22.2019.08.12.21.56.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 21:56:38 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-12-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <49f77c1d-9fa7-000e-fffb-52278cda0664@linaro.org>
Date: Tue, 13 Aug 2019 05:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-12-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/39] target/i386: introduce
 gen_(ld, st)d_env_A0
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> Similar in spirit to the already present gen_(ld,st)(q,o)_env_A0, it
> will prove useful in later commits for smaller-sized vector loads.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


