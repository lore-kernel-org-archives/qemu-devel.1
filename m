Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3492C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 19:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E1E21569
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 19:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqOekRws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E1E21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1xhJ-0005W3-RW
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 14:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1xgZ-0004z5-MH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1xgX-0001VR-Sg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:28:35 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1xgX-0001UT-Ie
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:28:33 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d5so1287513pjz.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 11:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VzX5fZdMXet860J5nqoU7jijjZtWDUjHCSpcSvWlf68=;
 b=JqOekRwsKI0HLeeiPGVjrFLm01QbRefDuQJ1od5blTW54IygSKNK0YNJG/uqvpB9sD
 BZSCApz3yTKe8OmH3Mr4CjK8KfrL7rxQjF2vCKxhyKmalg1agQ/5EljfVgvW5KllF2Mt
 vihbgeCsnDfgAtI7DZ4PJCFrX8lcp81Zxa0yG1UPYUgJt3Rbrx7FsR0zyzNiREgfDF0d
 YRC/J2pbF+AblcXetL1QZK1EpaZI0vvQanpbbGl6dVX9Fi5ZArPnaR0gNYUXPi3B2BIb
 /DRgoqQsHiSXx9WB6i7P1uX/MUs84T14BDgB6ve85pV5NB2a8R3l1SGMWEdCjBnOhWpX
 lRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VzX5fZdMXet860J5nqoU7jijjZtWDUjHCSpcSvWlf68=;
 b=NMh+vn34YnXPsO3fZJRCS6YrQncDDHzOCRheLOAT86vxlLRQZhc759ZgGgbBMDqnKa
 JDNXfSYqElYMpZAorU/QtEGoM09HQDr77pnvqGCL056Lf2/jBj32fsn64a3nvYiObloD
 5IJYRf5B681gxPrMgVGgh736sMczpMAz/pIvVRLlzGw8khxYD2dVFc453rFKq6U8QARG
 v39QFl5Q8jStYKa4VLbXj1V2FbcRepJfYVlTDFSNwW0a8LcVABlXF4pvMBVBanPbHawK
 qnQjzMhBxvCmH3ws85S0VRvQjbmaQKi1jF2XY8IZtI6QsXUsGDYdOBl8gxLgD6a7DCWc
 arIg==
X-Gm-Message-State: APjAAAXxIV/VDp1pEV5NfiP0HvWicd98f0YkaEenXi1fvNUrPVbWKAvL
 ttQGIb1Ir6IL/IVFun10Y7AexA==
X-Google-Smtp-Source: APXvYqwJsy4QBFrkbCfhSaogBblmqVjiJIqzmwt05iKrUtfJk3W0hWuuO46t+ROW/AsfwbDkcKTKjg==
X-Received: by 2002:a17:90a:6545:: with SMTP id f5mr724869pjs.42.1581535711650; 
 Wed, 12 Feb 2020 11:28:31 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c184sm36953pfa.39.2020.02.12.11.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 11:28:30 -0800 (PST)
Subject: Re: [PATCH v4 4/4] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-5-zhiwei_liu@c-sky.com>
 <053777e2-7180-5584-cf7f-7876800d9dc8@linaro.org>
 <bb1f595d-fbe8-93a2-c67c-25be7996aec3@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae088484-c0ac-6e69-0b50-1d2e1455a591@linaro.org>
Date: Wed, 12 Feb 2020 11:28:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bb1f595d-fbe8-93a2-c67c-25be7996aec3@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 12:09 AM, LIU Zhiwei wrote:
> 
> 
> On 2020/2/12 0:56, Richard Henderson wrote:
>> On 2/10/20 8:12 AM, LIU Zhiwei wrote:
>>>   static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>>> -                                        target_ulong *cs_base, uint32_t
>>> *flags)
>>> +                                        target_ulong *cs_base, uint32_t
>>> *pflags)
>>>   {
>>> +    uint32_t flags = 0;
>>> +    uint32_t vlmax;
>>> +    uint8_t vl_eq_vlmax;
>> bool.
> OK.
> 
> Is it clearer to use "bool" here? Or it's wrong to use "uint8_t "?

It is clearer.  Using uint8_t makes me wonder what else you were going to put
in that variable, but the answer from the code below is nothing.

>>> +    if (sew > cpu->cfg.elen) { /* only set vill bit. */
>>> +        env->vext.vtype = FIELD_DP64(0, VTYPE, VILL, 1);
>>> +        env->vext.vl = 0;
>>> +        env->vext.vstart = 0;
>>> +        return 0;
>>> +    }
>> You're missing checks against EDIV, VILL and the RESERVED field == 0.
> This implementation does not support "Zvediv" . So I did not check it. I'm not
> sure if I should check(ediv==0).
> 
> I missed check  "VILL" filed.  Fix up it next patch.
> 
> I'm not quite sure if I should set VILL if  the RESERVED field != 0.


The manual says

  # If the vtype setting is not supported by the implementation,
  # then the vill bit is set in vtype, the remaining bits in
  # vtype are set to zero, and the vl register is also set
  # to zero.

So yes, you most certainly have to check ediv == 0.

By extension, I believe the entire RESERVED field should be checked.
Otherwise, we don't get the same forward compatible behaviour for the next
vector extension beyond Zvediv.


r~

