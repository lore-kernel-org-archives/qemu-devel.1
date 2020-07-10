Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E612C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5BA206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4S5gQWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5BA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw4b-0001FD-2k
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvsK-0003ir-7B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:27:48 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:56251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtvsI-0006wu-FO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:27:47 -0400
Received: by mail-pj1-x1036.google.com with SMTP id ch3so2830084pjb.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CYS9TLyYkHg1F2blr6tDCqhey8HUKUq7La1KlDpHz8k=;
 b=b4S5gQWEmeRUXSw1LPYVFF2h9xp+Ew4iv9DDRyleCx/HMg8nLCeoQxTzpWbUUoeaZL
 /UOQlihvkVXi/87FNPtY/5EOs/rOLupVdvnFxOKvQ2MI6HwZVSZKQg16s9t2NtbzBo6X
 4NJLALFdMZMawQZC+sPMQwQExEaKTvgaARgi1TMsz0g0fh2Z/aCJz3XCVni/Qhqwxqrg
 kzW1q8QZmkTk/Ofr6O97S8AM4ymzlgaotQrzjn1QjALB23N/GmAyzEcKKqPcxBhGsvA/
 ktoXb8pSkvQdgsufNXK1NF6+xFUzo51veZkzhhi32sXKl9oEE3zQI8RuxvCgzSok9NH+
 vmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CYS9TLyYkHg1F2blr6tDCqhey8HUKUq7La1KlDpHz8k=;
 b=Ywq2cft11DDWLxh+S+2i4xNRyQE7VtxEff9jSZ0ek/OJnfTLqh43ojeDdeZJ3f7Ce2
 ynzF6Rjyciz4JH98gYrWnEuxQPDzlyMxfQZsTbwC1UHKsTTV0QDB4fwRNJuhHBE+LZ1t
 MYKlpC7m6LDuX0zIQ72b6EaZewp6LWO1HagJLqoasm/UoLyt7rUqY+HzkklWSS0zXy8n
 VgDPLXdsS4V6ecv1k3KdEUM16bb+b+VLaTfpNNobtaW7gTv6iEyw1vi3FZgqWch2Y5HX
 rsZ4Ax0ku9hO2v4NSb03352Hx4jezi0NYmaNWY5LHjcyz7nSX8w5xZM4ZU7vJP5JRgnB
 N4Ag==
X-Gm-Message-State: AOAM532ANeSqhF25OnBe+nM5v6IYFrlofvZ4m8PM0G1KerRt6a0S11Od
 kPIrlOZgWnOPBQlKT3jxS9v7Pg==
X-Google-Smtp-Source: ABdhPJzN+X7DCHttvgPvNeovPz1niVw7u+tNAOzvoA0AxISFI/W9plhWXjdfiLed4lZs1PdL+YFXyg==
X-Received: by 2002:a17:902:326:: with SMTP id
 35mr60162464pld.301.1594398464793; 
 Fri, 10 Jul 2020 09:27:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 129sm6648788pfv.161.2020.07.10.09.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:27:43 -0700 (PDT)
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
Date: Fri, 10 Jul 2020 09:27:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-6-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> vsll.vi, vsrl.vi, vsra.vi cannot use shli gvec as it requires the
> shift immediate value to be within the range: [0.. SEW bits].
> Otherwise, it will hit the assertion:
> tcg_debug_assert(shift >= 0 && shift < (8 << vece));
> 
> However, RVV spec does not have such constraint, therefore we have to
> use helper functions instead.

Why do you say that?  It does have such a constraint:

# Only the low lg2(SEW) bits are read to obtain the shift amount from a
register value.

While that only talks about the register value, I sincerely doubt that the same
truncation does not actually apply to immediates.

And if the entire immediate value does apply, the manual should certainly
specify what should happen in that case.  And at present it doesn't.

It seems to me the bug is the bare use of GEN_OPIVI_GVEC_TRANS and thence
do_opivi_gvec.  The ZX parameter should be extended to more than just "zero vs
sign-extend", it should have an option for truncating the immediate to s->sew.


r~

