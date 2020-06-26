Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651842075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCf+KUJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651842075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqko-0008K2-Lp
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joqkB-0007py-Jt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:58:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:44118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joqk9-0003jv-QN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:58:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id bh7so4416756plb.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2lhdN63mmDCJk2rf9kYxdC9bbjrvRE6z7RO4HhFqtVY=;
 b=qCf+KUJrHZxu+366bs6fw7wj4zN0KjhDv2cLfohXnwjR5nbRhVUTs9s4nLrUNo93XI
 6vTjW3pDbNVTGY/AiQGdFN8lR07qa6ogIeSTYF8Vpii7lUuFkY15EilJl416ApZAhNxx
 RX3xgNXLOE88jZjNOB2Xed6/vvJqk199tmzk/ZVbz+FUDqn19Ij5demSE9KNwK6HXn+M
 5+o7A0R0mIBHqNncDhBauR2aS7jldJM0ID8tdQwhmsVrj74vXe+gCczfwE+S5wFBUnjw
 UgRJZx+FEERYAgV2sQUa2ruqm58Eh70zwC8drbYK0mGl4jXi5zzKCnZw4NB4rQLdqhaI
 jz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2lhdN63mmDCJk2rf9kYxdC9bbjrvRE6z7RO4HhFqtVY=;
 b=AC8PXNi7iHoA4eVyWPu1r5vsD3IMQezUx3zgvyw0vmQ2SnvboP8Mc2pgw/yyBFYeD5
 jahLD7UBRgc2sIBq4kfOg+facpJ1oSphqAfKbuF5OBkoiQk0BWiSdhTb8/KDbIKxd3np
 beuV2e1H5JeHHaX5vYZbvcuLH7HHkkqe3C8RtYU19cZ5KqTdHDsmDsfLGSpPSiKuDGBB
 nkphhw8Xn42ta6ArZQRjdijAeHEMh1lIKgJF3iSpOQHzfz2PpLZqag2HB7vs8lnqUCQA
 nKYPkcgSaAmcyWdoQXEyvt549SvGYs6RtC9kk8y7sf2seud1MUb/Z/KlEOH/idyv0xUT
 NQkg==
X-Gm-Message-State: AOAM533dxdV8dm7PErTM2xtl+ZIoAvduz5ulLakpRdCBFHUkHcA2ocAy
 QzpHJMFN/Mi0FYQ30rGF3NIQcOC7NF0=
X-Google-Smtp-Source: ABdhPJyEuCseWTRndebunrq03hSJQZ8dgYfijXp/v39rjR2minBAYAWlcJhonmKrCW1hpznNBQociA==
X-Received: by 2002:a17:90a:b781:: with SMTP id
 m1mr3930176pjr.14.1593187099843; 
 Fri, 26 Jun 2020 08:58:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j19sm5220171pjy.40.2020.06.26.08.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 08:58:19 -0700 (PDT)
Subject: Re: fpu/softfloat: a question on BFloat 16 support on QEMU
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
 <87img15zfv.fsf@linaro.org> <29d37daf-ced3-8555-7d25-00baacbb4449@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a12aa2e-ee66-ffb5-8598-775615e6ba24@linaro.org>
Date: Fri, 26 Jun 2020 08:58:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <29d37daf-ced3-8555-7d25-00baacbb4449@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 12:09 AM, LIU Zhiwei wrote:
> If I want to test bfloat16 interfaces, could you give some advice? Should I
> need to modify berkeley-testfloat-3 to support the bfloat16 test.

I think we'll have to write some new code for this.

Easiest might be:
  (1) shift left to convert bfloat16 to float32,

  (2) if the current rounding mode is directed
      (float_round_{down,up,to_zero}), use that;
      otherwise use float_round_to_odd so that
      we can get the correct bfloat16 rounding later.

  (3) use the float32 arithmetic routine.

  (4) round to bfloat16 as per the current mode.

This should not require too much new code.


r~

