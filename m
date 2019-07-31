Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D4C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66476206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLJiiBW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66476206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsw2d-0007Cu-MC
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 17:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsw2F-0006mY-Np
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsw2E-0008Lp-NM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:21:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsw2E-0008Kz-FI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:21:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id l21so32690259pgm.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gwQKf9JynCBCAcEfM0MUjBUQbgp01wGJfoU7vnw+qTk=;
 b=iLJiiBW4jG5IPNFVqAVOmyy5gZY9garXqhmLO7ma9/ihLGF711AqtJmLTCKwsuk9MY
 1xekSlgsdpJWAefpJwAUt80L8tAg3txYNZQx71ilYg5TWWzHM2pDVyz22ZzOiNg8Zj03
 BtvKYbIc7lsk9MKSdid2NQjM6u8EDSa7TrvIGmF5/bgM7dw7U0CIucSqGAldgMD82oj3
 hhIUtg0vOidAdTzIJPJmeurabw4iKvZK0GHEBcqF95fhG8G+79+DUwOrhVgJ84o66rlk
 ySkmC5HSq6IcMuLBeGl1wZUala/vJraoKKJ5arTDWR1JLXDZQKtEfurxwzlOQu7qlmBM
 jt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gwQKf9JynCBCAcEfM0MUjBUQbgp01wGJfoU7vnw+qTk=;
 b=cZpHpb0qRLp/iz6WhCoQ10M/5pC87ApM/pUZBmmip8msJ2oQmsWzj87L0Zu0Y8Nj9Q
 v6ttDLjRjIrDAQQmERsManeZKZET9j24zH1yVzC+nKabzHbo+jQMw3GErk1y7VKVnp/D
 /he+c4VKMVnKdRJDAqNfz60CW6nNrFV1rN9aseF8czK4V5Kz8t/Li9pnAcfjTbhzabhE
 m/jbLG8YjXjkTUcJOuoDqtV7X7mMsRPyUKXoICEBDEHYtz0gI/Elitr1LGPQWJb34cbG
 /4R89QhLPOiAEWIIXucQn8aWBwz8w9Mv1kEcumnM6AjlBt1UgBck4nMHj3FMzaArmdwx
 zJhA==
X-Gm-Message-State: APjAAAU13seUPQzqj2D2XvcpYdkGJiRPJmH4NXvwKesjqYxgo3aPqnLs
 JLvv3fGzHFna5fppreDpr223+g==
X-Google-Smtp-Source: APXvYqzqzMMDF209IDqhuihrLINA8qnupgkkt8xQW8NxRaEu6RKNC5qsjFiUtqvndSrWxM7et1qiBw==
X-Received: by 2002:aa7:9591:: with SMTP id z17mr49916665pfj.215.1564608081006; 
 Wed, 31 Jul 2019 14:21:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z20sm112751040pfk.72.2019.07.31.14.21.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 14:21:20 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-9-jan.bobek@gmail.com>
 <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
 <CAL1e-=io1f_6HR_rWeG7kOSKT4Bsa0S8Hop=j-45QQvT7esjzw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fb03027c-0c7f-d0f7-27d8-a8c0ae46e8c4@linaro.org>
Date: Wed, 31 Jul 2019 14:21:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=io1f_6HR_rWeG7kOSKT4Bsa0S8Hop=j-45QQvT7esjzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [RFC PATCH v1 08/22] target/i386: reimplement
 (V)PAND, (V)ANDPS, (V)ANDPD
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 1:27 PM, Aleksandar Markovic wrote:
> 
> 
> On Wed, Jul 31, 2019 at 9:36 PM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 7/31/19 10:56 AM, Jan Bobek wrote:
>     > +#define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s),
>     (modrm), MO_64, tcg_gen_gvec_and, 0112)
>     > +#define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s),
>     (modrm), MO_64, tcg_gen_gvec_and, 0112)
>     > +#define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s),
>     (modrm), MO_64, tcg_gen_gvec_and, 0123)
>     > +#define gen_vpand_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s),
>     (modrm), MO_64, tcg_gen_gvec_and, 0123)
>     > +#define gen_andps_xmm  gen_pand_xmm
>     > +#define gen_vandps_xmm gen_vpand_xmm
>     > +#define gen_vandps_ymm gen_vpand_ymm
>     > +#define gen_andpd_xmm  gen_pand_xmm
>     > +#define gen_vandpd_xmm gen_vpand_xmm
>     > +#define gen_vandpd_ymm gen_vpand_ymm
> 
> 
>     Why all of these extra defines?
> 
> 
> Because of code clarity and safety, I would say.
> 
> This line:
> 
> case 0x54 | M_0F:                  gen_andps_xmm(env, s, modrm); return;
> 
> looks much clearer than this one:
> 
> case 0x54 | M_0F:                  gen_gvec_ld_modrm_mm(env, s, modrm, MO_64,
> tcg_gen_gvec_and, 0112)
> 
> and such organization is also much less prone to copy/paste bugs etc.

I'm not convinced.  These macros will be used exactly once.  Because there is
no reuse, there is no added safety.  There is only the chance of a typo in a
location removed from the actual use within the switch.

I agree that the goal is to minimize any replication per case.  But I don't
think this particular arrangement of macros is the way to accomplish that.


r~

