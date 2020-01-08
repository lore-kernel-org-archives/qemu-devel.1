Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D727EC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A150220692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ph9Ysv0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A150220692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0nH-0001Rh-M0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip0lm-00081p-1c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip0lk-0000uu-LM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:08:25 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip0lk-0000tx-Dn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:08:24 -0500
Received: by mail-pl1-x644.google.com with SMTP id p27so450408pli.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 18:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3fuuhX0eJM0s+kyXhD/xA6Ut4i7rclacySX8jl6CuB4=;
 b=ph9Ysv0twycmmUpyXjw4eNsE0I4aJon4eXE9gFHW5mSF7CCOwVAhQq4iqOMgaabcT5
 v13Q2Hfx9n1AisSD9oUuMzhKRIUatHvdn5c1/4cAkngv8nv8f34wrVxwfUXvnhctre8Q
 avSWqO+QxcFcNzJI5tiYeNZ4+16gPMeIIKNJFL7CSjXTgQT5nZrjlOpslscDceJSc/a5
 Kludwddhs2kXp3Q4noTs0+4C3ibDqP4h/v7xucHXr4RQiceuAyYZIOEq62Am86w3k0dn
 ngY+kCzgMNicPF8ZDDb/yNJKHmo/D5InwTH/a58nhbuo4p7OimbAKipEOcdnjxGcBZ3h
 F67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3fuuhX0eJM0s+kyXhD/xA6Ut4i7rclacySX8jl6CuB4=;
 b=DGw7ny87/H0myTW8V/hGi0ujJ4w27FbSSI0yBTitauxIbs3mJKCD8+yU5QlGXsERsu
 rrdztqJch37cnRkR1sET9cTA09CKfK6kY2llJVQJIruHkfOVO/4POtdcOlwLKqQLYayX
 GVyCyp3u+dzUr5MiSQ1qHGITuJ0FGF+t9g6QLaMbpX9CPpufuLVetD4hQY7tefQ28nck
 xy3CXC15MWI9HC++fzKEgi/uJgJxmRHP4U1laFQQxCdnJkRzM9KF8qSGmaiEItuKsYDc
 ZdtC6iQ3mJyqgopTB175KxX7umlVF+1rr9gJ/henVA07N9443apSNPXNXgOe1ElcULgq
 vHcQ==
X-Gm-Message-State: APjAAAUfxQDc7C4uTeBryvxQFMhwVl5gDPKo6PspwieUsdZGp11oW0G7
 /3GL7Dg53J10j+aVpCrv77W1bCnfK6YPDQ==
X-Google-Smtp-Source: APXvYqxwzm8yecKqfZJ8RcKzbUlP95DbsDwr/XEYafYFdFyr/YzlSRyukoSrmi3yYvU2vL4Z9L7JNg==
X-Received: by 2002:a17:90a:ac18:: with SMTP id
 o24mr1792794pjq.33.1578449303170; 
 Tue, 07 Jan 2020 18:08:23 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id n4sm1025409pgg.88.2020.01.07.18.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 18:08:22 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 05/17] RISC-V: add vector extension load
 and store instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@dabbelt.com, Chih-Min Chao <chihmin.chao@sifive.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-6-git-send-email-zhiwei_liu@c-sky.com>
 <4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org>
 <b927f28a-2057-ed1e-c426-63cf9fade27f@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3a10c873-f293-a37b-e98c-f1964702efe8@linaro.org>
Date: Wed, 8 Jan 2020 12:08:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b927f28a-2057-ed1e-c426-63cf9fade27f@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: wenmeng_zhang <wenmeng_zhang@c-sky.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 11:32 AM, LIU Zhiwei wrote:
>>> +            switch (width) {
>>> +            case 8:
>>> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
>>> +                    while (k >= 0) {
>>> +                        read = i * (nf + 1)  + k;
>>> +                        env->vfp.vreg[dest + k * lmul].u8[j] =
>>> +                            cpu_ldub_data(env, env->gpr[rs1] + read);
>> You must not modify vreg[x] before you've recognized all possible exceptions,
>> e.g. validating that a subsequent access will not trigger a page fault.
>> Otherwise you will have a partially modified register value when the exception
>> handler is entered.
> There are two questions here.
> 
> 1) How to validate access before real access to registers?
> 
> As pointed in another comment for patchset v1, 
> 
> "instructions that perform more than one host store must probe
>       the entire range to be stored before performing any stores.
> "

Use probe_access (or one of the probe_write/probe_read helpers).

Ideally one would then use the result, which is a host address, and perform
direct loads/stores using that.  The result may be null, indicating that the
operation needs the i/o path.  But in any case, after the probe we are
guaranteed that the page is mapped and readable/writable.

Note that probe_* does not allow [addr, addr+size) to cross a page boundary.
So you do have to be prepared for the vector operation to consist of 2 pages,
and probe both of them.

> I didn't see the validation of page in SVE,  for example, sve_st1_r,
> which directly use the  helper_ret_*_mmu  that may cause an page fault
> exception or ovelap a watchpoint,
> before probe the entire range to be stored .

Yes, this is a bug in SVE that will be fixed.

Note that you should not use helper_ret_* anymore.  I've just introduced
cpu_{ld,st}*_mmuidx_ra() that should be used instead.

> 2) Why not use the  cpu_ld*  API?

It's possible to use cpu_ld*, but then you need to store the results into a
temporary, and copy the result to the register afterward.

But I think it's better to probe first and avoid a second copy.

> I see in SVE that ld*_p is used to directly access the host memory. And
> helper_ret_*_mmu
> is used to access guest memory. But from the definition of cpu_ld*, it's the
> combination of
> ld*_p and helper_ret_*_mmu.

This is all changed now, FWIW.

> I will take it.  However I didn't have  a big-endian host to test the feature.

You can apply for a gcc compile farm account, and then you will have access to
ppc64 big-endian hosts.

  https://cfarm.tetaneutral.net/users/new/


r~

