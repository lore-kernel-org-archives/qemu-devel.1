Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96850C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536DD2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEJB0TZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536DD2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9dy-0001FQ-Ig
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9bh-0007Eq-RU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:17:06 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:52566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9bc-00047O-58
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:17:01 -0400
Received: by mail-pj1-x1030.google.com with SMTP id a5so223278pjh.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tqERRQ9NlIrPSlCvoNuPcbBtEV4qZ7UPxNJTKqvl3NU=;
 b=pEJB0TZABwbAeB9ltjOpSnqXPp1Rja0QU/gqyFSvwB9mM5j9Llt9nDHhZ9dDLafPSI
 H9zfTEA5IFiiS6O4F4e/wt6XsbwvYpqaZMGKpFZ0B4LVV5AbVjBHr7bF4H9WAGY84kmu
 E456SsGO4POgYbXOBuuGCNhkonvrnfrBlxfWp6tjagk7Jf9ygocC8BfZsMnteUaAcdZ9
 OZYRoYdJ4GAPj4drxMgjBTec/NcZzjdBREBe8X5TPAP84mQO4SsXyc5/rldMgvhMM+PU
 vWLKCs/knKvZoAjK0V2SJtcuw4w+DJrJtY5LFGp5smSC0Sff+6FPzy28OWNUhF9Om8+j
 h4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tqERRQ9NlIrPSlCvoNuPcbBtEV4qZ7UPxNJTKqvl3NU=;
 b=PywbhxtMGerMH8m/EuQSx3AdA35J9KHfYfqEZc10D3l4t7drn4TGA0vtVdE6VJiAAR
 D2eVo5Jl9vFJRtY4kusvpaNtrJpSSRnx866WHD0+1CqKHWLBLMzMPJ9cAWBhtVypYR5g
 3YVydx4WXhueg8obwnmRdSmpATNhjHOIsjmOdW9p5NkbGkB6SUGRWQZ0rCDEke0yKxy6
 oONwksmBcUCmvRV8sjt57NygaHCZmCGnzm5dhx3CtwDm+6BuwvXPB2ZAmvl6DAdP+mVS
 tc1jj+wx5UuUm60GQnnz9chf0a6MtB/GOVLhFC0jJzND6HJ2fktURdXvexlrZ0szrzHJ
 WT9Q==
X-Gm-Message-State: AOAM530Rpd8Cbm2xe1KGUI4HymF1GOgmoHAQY2u3HPYNJ9IsOk3MbKoG
 vVEkzrMMRJNo0kzEYrSy8y5/pQ==
X-Google-Smtp-Source: ABdhPJxsvz/MAxNCr+GhlkgUPtm1+902VhN83AyDWN0bpOzPWLMoDXqdeQnyiaLxat84zvF0slC7eg==
X-Received: by 2002:a17:90a:8d0a:: with SMTP id
 c10mr1448359pjo.151.1589923014605; 
 Tue, 19 May 2020 14:16:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q5sm322646pfl.199.2020.05.19.14.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 14:16:53 -0700 (PDT)
Subject: Re: [RISU v2 14/17] Add magic and size to the trace header
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-15-richard.henderson@linaro.org>
Message-ID: <0cba90b4-e1c3-8cb9-a405-c5447a1aa17f@linaro.org>
Date: Tue, 19 May 2020 14:16:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519025355.4420-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:53 PM, Richard Henderson wrote:
> +    if (master_header.magic != RISU_MAGIC ||
> +        master_header.risu_op != op ||
> +        master_header.size != extra_size) {
> +        res = RES_MISMATCH_HEAD;
> +        goto fail_header;
>      }

Hmm.  This isn't ideal.

Consider e.g. an insn being tested that should pass, so master steps past the
insn to the UDF and sends OP_COMPARE.  But there's a bug in the emulator being
tested so the apprentice gets SIGILL on the insn and so op == OP_SIGILL.

So risu_op != op, but we only report the header difference.

Perhaps that's good enough to understand the this particular problem, without
the clutter of printing the rest of the reginfo frame -- at least if
report_mismatch_header is improved to print risu_op names instead of numbers.

Consider if master and apprentice are run with different --test-sve=<vq>
values.  That will produce a mismatch in size.

Which could be a serious problem, if master_header.size > sizeof(master_ri) --
we can't even receive the data.  In that case, what I'm doing here printing the
size mismatch is all that's possible.

But suppose master_header.size <= sizeof(master_ri), so we can receive the
data.  So long as master_header.size == reginfo_size(&master_ri), then at least
the data is self-consistent, and we *can* print out the difference in
report_mismatch_reg().  Which in this case is going to be the difference in the
two ri->sve_vl values.  That difference is likely to be easiest to understand
for the end user.

I should probably split out this receive logic from
recv_and_compare_register_info so that it can be reused by dump.


r~

