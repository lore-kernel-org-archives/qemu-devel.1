Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC89C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC50B21841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TX+E98aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC50B21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtIN-0005d2-FG
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDsh5-0004gp-EP
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDsh4-000526-2C
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:02:07 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDsh3-00050X-NW
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:02:05 -0400
Received: by mail-pf1-x441.google.com with SMTP id v4so1851823pff.6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5g7jeL1vSvvX2Y4CzVUQDIU4G0S+C286IUV+Xu0hH5E=;
 b=TX+E98aJXLxy/ik1gu6IYXFN9n06UqzQNDc01OTDINIGmdzuhqOh1bGUlBTj26FyIO
 UKR9UOmyRp34SL9h3D0cH+05JXSxMGedEKjbniPV0jnBYHtL5f2jrhMDUiWAfDfWLv0N
 sgSRHtQ8AslxYqq6yjbvQn6scgxEiWAuVW+vHXfeaHPAmYrTTTDt3cabrvInOqYGCVn0
 iSaaSQYza6KCzlhbfZ3pOSkeLargpZIAV3JdqMU4DcaaK0rXavLvM4m8WLpgDbPL4wIE
 g7C7st81iWZ8TUoe38qxqvNYCoXTWkPBy5Y7BWc4pHfZTLz3eAyEeECBevJNlVveIpLd
 UJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5g7jeL1vSvvX2Y4CzVUQDIU4G0S+C286IUV+Xu0hH5E=;
 b=ZqPYsSSqSXsCUBcjrFQqRgLb/l2Y8MX48p/n7m5T4VSfos+GPuasGGthRBZz3hnrWt
 8yHU0THbb1liTcPFndm2rbovXXvxamOYLRAB1biCSxqG1S7J5ZyzCZNjBeSrpV8KOBZ5
 uMi2CP5+y5lRkGgrB7hTqxIsUN9xV2XdTyWoKIfqtDUDymQAvgtZ9JWSd3y0FLVj/tJ5
 Uq6xJYcXdIe/hNTTOyWH9Z2co7luk8oIb6vG/hzCDRexXVVT420f6Wwy5qrMcu8WJIM5
 SymJJa8sWfgt/pq4T8zPxcQb7yKaazd7CFPwMObxHd0KX84Bb1bo0E9JvBPfB5+3dozp
 D0xw==
X-Gm-Message-State: APjAAAUv0iLO6VwyQiE5ySrYNHiJ5vBDPDVnZhBfbU5zWVX2Z9mtW9TU
 MIAq7SMmGrSfJT37zGTqmqxGKw==
X-Google-Smtp-Source: APXvYqz4KZA14iFOllu+bpyKR4keY5ztHpE5/vQ4EdBeSZhQl0AQvF8m5rkfYPGUe559i+0kscnkiw==
X-Received: by 2002:a17:90a:8001:: with SMTP id
 b1mr11305990pjn.56.1569600123995; 
 Fri, 27 Sep 2019 09:02:03 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id p190sm6220304pfb.160.2019.09.27.09.02.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 09:02:03 -0700 (PDT)
Subject: Re: [PATCH v3 02/18] target/s390x: Add ilen to unwind data
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-3-richard.henderson@linaro.org>
 <4d1f9fbc-a6b3-cb7d-63a7-8d9568bc7406@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <164856f8-fc7e-7a97-65b8-e1be2cf354be@linaro.org>
Date: Fri, 27 Sep 2019 09:02:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4d1f9fbc-a6b3-cb7d-63a7-8d9568bc7406@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 3:30 AM, David Hildenbrand wrote:
>> +    /* Update ILEN, except for breakpoint, where we didn't load an insn.  */
>> +    if (ilen) {
>> +        env->int_pgm_ilen = ilen;
>> +    }
> 
> I am not completely sure about breakpoint handling and which
> implications we'll have when not setting int_pgm_ilen ...

Yeah.  Possibly to make it simple I should simply assign 2 as the length of a
breakpoint, bearing in mind that there is no a s390 exception to be delivered
-- this is purely a qemu-internal thing, raising EXCP_DEBUG to get back to the
gdbstub interface.

> I wonder if that change can help to better handle exceptions during
> EXECUTE, whereby we have to indicate the EXECUTE instruction and the
> ilen of the EXECUTE instruction (so the pc and ilen of the original
> EXECUTE function, not of the EXECUTE target).

Yes, that's already there.  The ilen of the execute insn is placed in the low 4
bits of env->ex_value, and that's what we record as ilen within extract_insn().

> I don't completely like the current interrupt handling when we have
> "env->ex_value" in "s390_cpu_exec_interrupt()". I'd love to see that
> check go, then we can reuse that function easily e.g., in MVC to test
> and inject exceptions while processing such an interruptible instruction
> - like MVC.

I don't think that reusing s390_cpu_exec_interrupt directly is a good idea.
There's other cleanup that needs to happen when exiting a TB.

What I think you should do instead is check env_neg(env)->icount_decr, exactly
like we do at the start of every basic block, and use that as an indication
that you should exit back to the main loop.


r~

