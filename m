Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D04C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 00:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573A220661
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 00:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGk7opCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573A220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3XL-0001Hb-Jl
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 19:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3Wo-0000qg-Fy
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 19:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3Wn-0000Al-0H
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 19:54:21 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3Wm-0000AN-Pn
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 19:54:20 -0500
Received: by mail-pj1-x1044.google.com with SMTP id j17so4731807pjz.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 16:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KM/b8HhP4FCke3Voc4f93DBA0+K6CEFmlI/BfCw4oJ4=;
 b=AGk7opCGSY48HbC7arMtaOJDcK/jSogM86eVbhWCJAYnBEl+Mp8L82QZoqdmnvv/aO
 ybxrwDhtRnBcrS7Gvbll5SAJ6Ju0KT1zA+8eaJo3miY28F+qZ5dVPIZBDRniIyvH57XL
 YrjiZj4aDoGamwzacDe+TWcvw3azccbH14jx1qEFmRaPt72Sds63JT7R1+7fihjfAvIU
 bNItpF4mugRcxXYXkB37cotgSEmSalf8TLE8+5FJ89JWKh6GzA7M7Q/mQY2Flayc1Cl1
 wl+/XKy4bHlReKaR/2IZtF19ib8af2aSTBjjSu6sNvuoFU7xC3gGubDWWuLes4DoQzAK
 5fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KM/b8HhP4FCke3Voc4f93DBA0+K6CEFmlI/BfCw4oJ4=;
 b=EzLlDEzequG4+aG9cGeQ/G+GcTjn97SNTgfrYrhcBAXDZnwMeCJmeMC5QUkWqS+nNx
 ZBiyIGT9tXgzjicHQnVdIkZfJeICpWMizhiJVrfHHyEDAWrY1KlJzfemk17/MLkWa060
 tXf7bMHVnFeY4zoAxW9CvYWFx+vG94vAXYAW2W1pfXo4JyiYXJiF0vqCOLtgNXGQ+f+x
 QwO0z9nvP9NXaOr6xZ0RCek8PkRsWNmi4BG1VJzMVXglU43hWb9ILdyTTBFVRWi/AkmM
 68m1kVQCC35SpF7wzeCWiNtEDBk1lsQNjk+PdpUcdv4Z/npAoXI9lPuEe+mlAxl3yzG5
 jFGw==
X-Gm-Message-State: APjAAAXaYrOrebSHYFudOxkQQneUxoM1zaS2t7WR8uWT+O+7RjyffHYJ
 OVwVYvKOfOdoZSYRMZgVPy6HONkA6Pg=
X-Google-Smtp-Source: APXvYqzGxYw9XeqYlfApS7ObQqZrnLR9rfCdeyN8YxMQ0eZIddQATO4RlQd/i5mWggIlFTtrSNmSkA==
X-Received: by 2002:a17:90a:f0d1:: with SMTP id
 fa17mr20598391pjb.90.1580604858653; 
 Sat, 01 Feb 2020 16:54:18 -0800 (PST)
Received: from [10.1.1.100] (h210.212.133.40.static.ip.windstream.net.
 [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id c1sm15132917pfa.51.2020.02.01.16.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 16:54:17 -0800 (PST)
Subject: Re: [PATCH 1/4] target/arm: Add ID_AA64MMFR2_EL1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-2-richard.henderson@linaro.org>
 <CAFEAcA9wOmOdddzr+5RfBsTJ+nHF4bqTVs0C1Uj228f28U_SMA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7fc8b19-e004-cf10-c2a0-58f38371c5ac@linaro.org>
Date: Sat, 1 Feb 2020 16:54:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9wOmOdddzr+5RfBsTJ+nHF4bqTVs0C1Uj228f28U_SMA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 10:19 AM, Peter Maydell wrote:
>> @@ -549,6 +549,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>                                ARM64_SYS_REG(3, 0, 0, 7, 0));
>>          err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
>>                                ARM64_SYS_REG(3, 0, 0, 7, 1));
>> +        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
>> +                              ARM64_SYS_REG(3, 0, 0, 7, 2));
> 
> Do current KVM kernels definitely handle the request for this
> new register (ie don't return an error)?

Yes, ID_AA64MMFR2 was added to the sys_regs table in the same commit
(93390c0a1b20b) as all of the others here.


r~

