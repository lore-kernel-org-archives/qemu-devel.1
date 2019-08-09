Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160DFC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66462171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFUWhPJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66462171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6Vd-0008G2-TF
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45504)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw6Uy-0007fD-2p
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw6Ux-0002GU-3x
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:08:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw6Uw-0002Fb-SR
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:08:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id i189so46215731pfg.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YpRqjcQKhm6IQBdYAtFahqS6Fx4MEgw+xF1y50+3TSA=;
 b=pFUWhPJmeef18ocqbbW2QX78DInbj9Nd/wN+B7eqCtkcZffI9dCa28+M5mHybc6FLQ
 6/7AMA7bHm7AjjxMhZiH9qssXRXombEfIAOLmQ5dRfC068B4j1xZJ8dBdUL0K/zhH3VG
 ltSXKtwkjBaYaH+CuYu/0m/kbQ0+N2HVrSuJDmsI/WOaojZ6vlCxmjGLf0BAozZK6m82
 dABE7Wehi1BreplYWojpX52dFUMjSQEDwoE1p+FzrN3FQ43S+WMB4UCq/dNZth/D+lAt
 kjj+hGah4GsfNxKU2QSA74nfyH3tHExRHRfnrnUpMFxTgaRWdJkIQ7n2HcsTZLRKZXWz
 QiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YpRqjcQKhm6IQBdYAtFahqS6Fx4MEgw+xF1y50+3TSA=;
 b=gyn5yYG0PFSpc9qiwlxI6gaIfxc/BeRfcYHFgAYNSfs2YaMwdgA5AWpefj4Ld679xh
 91pvaQO6O32daMcwXBQO5HF2lauanrZaGPKJhRVWvQr6h3EQFCSmP+Hr4RiXMn9lXgku
 bsDU/g2E4kUOSZKc/+Lw+hljVgoOG5a5xcVV1uN2sJC6y6zTxYvdoGsgw+N16pBPRTF9
 6LwNS/p0slTZd1vfbfzccX9VnDiLXe9U/9FrfCmeXDvLvbSwKE2wOuxztQq6afkf18d4
 nGr3bbzdr+cZi98I91V5PEgnl83/JOzMqbiX5cOfPFXoEA/iiA+vaeXuHGqI5y1HbNn8
 zsJA==
X-Gm-Message-State: APjAAAWQiIVM/CtvgHqzsWC3Tr3UE0Z5O2ZFU9uGy8tl+kh/rBjflOzW
 KVnNYTvkFGeAlQCYVnuJUO7uynMtVL8=
X-Google-Smtp-Source: APXvYqy148uUg6OykZaSBtJTva+HTBOcxBlVTSy+MSfzjCCVA+Z00QFGluSy8Pks0gJOHPhqL8psoQ==
X-Received: by 2002:a17:90a:258b:: with SMTP id
 k11mr9541401pje.110.1565363284997; 
 Fri, 09 Aug 2019 08:08:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x25sm134382666pfa.90.2019.08.09.08.08.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 08:08:04 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
 <20190305165051.26860-10-peter.maydell@linaro.org>
 <CAFEAcA8vfxjW6hVnKiBu7jeiFSGXzqdaQ_ytUXgEwJ91JLDf=g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a4857913-8551-14a0-aa5c-f0cc089d79ec@linaro.org>
Date: Fri, 9 Aug 2019 08:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vfxjW6hVnKiBu7jeiFSGXzqdaQ_ytUXgEwJ91JLDf=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PULL 09/22] target/arm: Implement ARMv8.5-CondM
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 2:53 AM, Peter Maydell wrote:
> Hi -- it's just been pointed out to me that if our 'max' CPU
> supports v8.5-CondM then we ought to be setting the HWCAP2_FLAGM2
> bit in the hwcaps for linux-user mode. (Maybe we implemented this
> before the kernel defined the hwcap bit?)

Yep.  We added CondM in March and this hwcap bit was added in June.

I keep thinking that they'll stop adding hwcap bits that can now just as easily
be "read" (trap and emulated) from id registers.  They've filled up HWCAP, and
only have 23 left in HWCAP2.

> I guess we should also cross check whether there are any other
> recently introduced hwcap bits we now should be setting.

I'll have a look.


r~

