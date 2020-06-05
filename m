Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25174C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF997207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQPWR5uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF997207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhIw7-00029E-4Q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 16:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhIvR-0001br-NR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:26:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:33022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhIvQ-0000Pv-Ie
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:26:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id b201so5511261pfb.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I0m4gQtgOxbXsXvrTW4iPCfPqswBVXNS8q13bKTght0=;
 b=OQPWR5uYlJVngS7fE72xA6l5Gmflquls2OJviz7NtWx5/1SEj9UZi+0jOPxfKCLzwA
 hobz0xmXHcBlEZ7unS+RDcPYbd6jiI8YVgkdweGwgZCq7LYmOU2RoxTXUThnn5tMy2lC
 tfU/TNHSLR6/6Xbuj4n8CAeKE4sol5FxPjRWpod5SAbmEgYiZAmojUKer2ru847zEQXz
 kZFopwC9yv+EtrP2cmMIx7n3h0A92y5VBjs1boDoaBIhsOekHP3ax23h37VOXxKiVs1N
 5aTUo51CCb6c16qyV3rCtFtJnG6Kx2Y6idnyVNjjlKpwXslzgLLrJwFMbKUedCfufPta
 X9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I0m4gQtgOxbXsXvrTW4iPCfPqswBVXNS8q13bKTght0=;
 b=BL5xLZwxSZ4F3HHNjF0mcn9ZXBYrhxirPsQG7EoWeJkj1nrFqZfkUqmWXv7nR8l6De
 +q+51oz9lzGwOQTKeh+I25NTH9AP8awGNrN6Sch3VGiO19VDnWGDEloyUKCsZ8RJNEJ3
 7smMWMx4hSYCZyJoTmuk8iFirtD2Ut57QUQqpRa/bsq48D/6IYl+5NUsgMrJI/hZsSUf
 KNBK13nO1uw3WtnkJAeG9c/Fqx4g9JRj4XA+LH+phg0Vua0DCUnxFx4FpGUHlib+EaTs
 b1NZwdLb9GuU+dNn1O0BYB6427e1uxn9RZx3ttR2wOE6xehCG+jAZPtctbTjbbVFGIgw
 ISCA==
X-Gm-Message-State: AOAM532DAhaNBMjFNQHWuX7pifHJemVZroopZB0aL68OwTXd7W7gTGDy
 Atf7kyEISnvpj+nRuJTuFpuJIg==
X-Google-Smtp-Source: ABdhPJy82lRqcMw8LxqQ5Bz19W3iw4JUYyV9/dlZq80EzJgSJkKQYlSjHhcwnctMGw8HlyEY1VLR0Q==
X-Received: by 2002:a63:4d5a:: with SMTP id n26mr11421490pgl.85.1591388806902; 
 Fri, 05 Jun 2020 13:26:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x25sm338661pge.23.2020.06.05.13.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 13:26:46 -0700 (PDT)
Subject: Re: another tst-arm-mte bug: qemu-system segfaults
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <20200529120427.GB18623@arm.com>
 <9aa721e6-e72f-20bc-73b4-19fc3f493241@linaro.org>
 <20200603135053.GD21536@arm.com>
 <7ca0e091-7797-12cd-0c6f-41e453580e0a@linaro.org>
 <20200603171706.GH21536@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb0a8d9e-e8fc-6738-1851-74320585b7ab@linaro.org>
Date: Fri, 5 Jun 2020 13:26:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603171706.GH21536@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 10:17 AM, Szabolcs Nagy wrote:
> The 06/03/2020 09:21, Richard Henderson wrote:
>> On 6/3/20 6:50 AM, Szabolcs Nagy wrote:
>>> thanks my tests now get further but later i run into
>>> the previous assert failure:
>>>
>>> target/arm/mte_helper.c:97:allocation_tag_mem: assertion failed: (tag_size <= in_page)
>>>
>>> i might be able to reduce it to a small reproducer
>>> this time. i assume that will help.
>>
>> Dang, I had hoped that the one fix would cover both -- it's definitely in the
>> same area.  Yes, a small reproducer will help, but I will also try again with
>> your larger reproducer.
> 
> reproducer .c and static exe attached.
> 
> the referenced __memcmp_aarch64 is again
> from the arm optimized-routines repo.

That assert is just wrong -- it's attempting to sanity check a virtual address
against a property associated with the physical address, and even doing that
incorrectly.

I've pushed a fixup to the branch to remove it, and I'll look into adding a
correct assertion later.


r~

