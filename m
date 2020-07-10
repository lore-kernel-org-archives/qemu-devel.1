Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CB72075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUqx9LRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CB72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxjF-0006tI-8a
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtxiG-0006Gt-FE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:25:32 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtxiF-0005U2-2c
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:25:32 -0400
Received: by mail-pl1-x644.google.com with SMTP id d10so2591783pll.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oZx5zNpDuCVQIImo8UZ34arIH8i7Ln286Ic8aFPR3ko=;
 b=nUqx9LRKXs3zqQqZdmgK/Xn2XXAjd93o0CpdQL03Vnagw55m2/z9pCkzfivHo7HtRn
 P6L/CkyUuermBv4/EqjpJ+8r1SAPvr02ATfIx1oFjnklOHH27SZEI9tb+Tu0sWQXHFV9
 nImzkfN6uqE8x/x8tTQZRGF2TV6CUaR3j/7egIDq9lBAl+Kog84GGVmjnTdSth7qg+Qr
 8cKQRIOwq8XZPGpbAMiXyJJYDBogf7qUzsug3QU7aIlWMwM6udV7SQdujw7PaIxd+fPG
 KNnyklM3hL75N9fux0Z2Ukeh6SpAFGf5dUBcFUwJVSSgBfdSy3qMDYLoPrbr+FRr8w2r
 wRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oZx5zNpDuCVQIImo8UZ34arIH8i7Ln286Ic8aFPR3ko=;
 b=nRT4pKPaCgrVPQmhn3a2rq2N0/XYY0HAx+Zx7TM5e+e3Rih53uZalMzDeo8EC4Z3HE
 wmt/kB6GrQUkqM+Lc78G0u820J7P+yT/JVfovkLTlzuYYn8g/ZLJwk+TEhuaodork6qc
 1lGIATgdG/0o/6AeNRbjvNlO2fXEc+b2DNLWd4T19SgrauOojS1UNorcxSMlHQ8Xztnj
 krHcCmAjQ/wMCqs9XFQDfz3mK7sre8wP9r5rEqg+0/2UxFLpvGcW8CVUKYO+T3zH8JJ2
 dBYhlrZqHZiJrdDWxL61LcmuzrnrhyYiLjGHujiAdnsM+Nq88gPlPZSTqIqEusUqEtBG
 uapg==
X-Gm-Message-State: AOAM530eh4D3NT3x67bs37JZpVRke+jClqLHW4+ms8Rqf8QpCE9p+mbg
 0fzskWlOc4RhDzV5vZMZIqu5Yw==
X-Google-Smtp-Source: ABdhPJxH5nlNE88caxLe1vuFtGR5wfZhUQvQ+gJ8rquMi9ItK+U//qQuaosPyjDK/P+R7zp+TUvapA==
X-Received: by 2002:a17:90a:c003:: with SMTP id
 p3mr7129114pjt.120.1594405529617; 
 Fri, 10 Jul 2020 11:25:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y198sm6654054pfg.116.2020.07.10.11.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 11:25:28 -0700 (PDT)
Subject: Re: [RFC PATCH v2 4/4] target/avr/translate: Fix SBRC/SBRS
 instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200707070021.10031-1-f4bug@amsat.org>
 <20200707070021.10031-5-f4bug@amsat.org>
 <9c799b29-baa9-82c1-7329-aa9a3bff4664@linaro.org>
 <eea7799a-9959-0fb0-3bc4-001f97cbea50@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e3c613e9-a596-cbf8-30b9-68c8cfde1ee7@linaro.org>
Date: Fri, 10 Jul 2020 11:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <eea7799a-9959-0fb0-3bc4-001f97cbea50@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 9:58 AM, Philippe Mathieu-Daudé wrote:
> I couldn't run Sarah's test suite on Fedora 30:
> 
> /usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find
> crtatmega2560.o: No such file or directory
> /usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find -lm
> /usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find -lc
> /usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find -latmega2560
> collect2: error: ld returned 1 exit status
> 
> I'll try on some Debian based host.

I believe the debian avr-libc package will have those, and should be pulled in
by gcc-avr.



r~

