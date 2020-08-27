Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D49C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35AE22B47
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czsSxRKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35AE22B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDxN-0002o8-2r
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBDwU-0001Lj-6E
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:11:34 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBDwS-0001yz-L8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:11:33 -0400
Received: by mail-lj1-x244.google.com with SMTP id g6so5558286ljn.11
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fDHlh8kb9xxLWdRs7n7qhEa0ipMfi7lZ9cad/daw3mc=;
 b=czsSxRKLByekiY7e3cKsDu4bXhwrZSqdPklpkBDWzvoH0aeCM5sBGWz1qxhfXndpRE
 cZYQ1/vO4mVfiNguXp1hUMGiqDdp7U0kxy6qGM0gVaCZDd0y1fLF2aE/uGEjkE3nnYKC
 9izKvlpyVbcNWqZUhY4fdiXixaL30JMZkwPhOiEEf/tong/qS4CLRwmjjxge8PK5GtQL
 Dd9nCOiiKBjLOumLrmHCbJiczqvwfByfihxCi89nFSoXfWu239Db6bwaQFf1ndsf4QXH
 rjKJkVkc8sHnck+Oe2dEEZMFG5pVHGlgFt5QdPFf/k+hktMzgJ2cVALmhmMeqnLCz4e4
 BVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fDHlh8kb9xxLWdRs7n7qhEa0ipMfi7lZ9cad/daw3mc=;
 b=YG+b+1iJeQeyFCSAIsMbqUM3c5+JLv776Cp99d1kXrdfwtNhfSsAARUm05NhiZyvna
 IFoNty9qo7anLZsIjuj+6fCtZInH7+y/MLYajqtWzznY5xqolYkQKRscCHWnGjA/+bSc
 amL+idB/vGgCAE3Ze03Qc4J6Ko/olkZWq2iQ+29rhL5Q7kPx49E0qEbj5hD1IOfJAaZA
 JGT6RRbmfwqTQ8C6GojLPSIYuGAcwURcIoTADw9hhPUUjggbgbuHb9QlB+6Id6kN8d/W
 IreDw5+oIIoW0lqd6NuW7GAy8p7Zzdnvt9mjSWs4iAWMsLgouBMMWtdVw1flJlX3Hd1Q
 Qv5g==
X-Gm-Message-State: AOAM532mrd80yvvIrEfZjUiPU3jj7P9KMk916e1HJu76aHlst6JsJ1lT
 BwjKsWGQWHhgNgJdnMxiQ4w=
X-Google-Smtp-Source: ABdhPJw11Z3zdP5kOPracqhDEiJEV4Tx6W2Gkgbz5dLi7A/yswjNVa1WSc1B7XTQdorEK6D9LVEy1w==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr8594870ljm.393.1598519490679; 
 Thu, 27 Aug 2020 02:11:30 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y26sm332416ljm.132.2020.08.27.02.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 02:11:29 -0700 (PDT)
Date: Thu, 27 Aug 2020 11:11:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/77] target/microblaze improvements
Message-ID: <20200827091128.GK2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:58:33PM -0700, Richard Henderson wrote:
> Well, this is larger than I expected.
> 
> I started off thinking conversion to decodetree would be quick,
> after I reviewed the mttcg patches last week.  Then I realized
> that this could also use conversion to the generic translation loop.
> Then I realized that there were a number of bugs, and some
> inefficiencies, that could be fixed by using tcg exception unwind
> properly.
> 
> Hopefully most of these are small and easy to understand.
> 
> I begin by adding enough stuff to test/tcg to make use of a
> self-built musl cross-environment.  I'll note that linuxtest
> does not pass before or after this patch set -- I think that
> linux-user/microblaze/signal.c needs work -- but that the
> other tests do work.
> 
> I also have an old copy of a microblaze system test image,
> which I think used to be hosted on our wiki.  After basic kernel
> boot, it contains a "selftest" script which runs a bunch of
> user-land isa tests.  That still works fine too.
> 
> HOWEVER: That's not nearly complete.  There are cpu config options
> that aren't default and I don't know how to change or test.
> 
> In addition, the manual is really not clear on what's supposed to
> happen under various edge conditions, especially with MSR[EE] unset.
> E.g. unaligned access: Does the insn get nop-ed out?  Do the low
> bits of the address get ignored?  Right now (before and after) the
> access simply happens unaligned, which doesn't seem correct.
> I assume the reason for having this configure option is to reduce
> the size of the FPGA so that the unaligned access handling hw
> simply isn't present.
> 
> Lemme know what you think.

I merged this to our internal tree and run some of our tests,
unfortunately it causes quite a few regressions. I'll try to
get you details as I go and respond to individual patches if
related otherwise here.

So a first general regression is that opcode 0 no longer
traps as an illegal instruction (seems to be treated as an
add with all r0).

Cheers,
Edgar




