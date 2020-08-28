Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90954C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B31207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oImM6asA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B31207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeIM-0000oB-K2
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBeHl-0008W9-9D
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:19:17 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBeHj-0004Oz-Pg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:19:17 -0400
Received: by mail-lj1-x241.google.com with SMTP id f26so1256572ljc.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hgN8r/CRyBxvOK+TVAegx67yWSlkhaeXjKw7dOXe6mU=;
 b=oImM6asAfvisoZProu5t0TW1HWXbn5uKPdoWCWfAyyfnk6r+7c6tM8Q3L9WWi6gsHA
 z4EK2gJvCPkwLSB489bmV0k46aqILxLaFQMwmFn1ngQLJqXSf+Cj6gyfV+iznPuyBE9R
 dpU6EeyjirX52bJxTvvvqbber+Ic7AiUg9QWWTOsK73bcsISaA4Dxod5bsfFMB3qQR4y
 pXxYxdtTIYdBNYHO/heyCJNCdNH4RdwvMaW0xR6dLv+WyvZ4Bq5MgnkB8aOAhe2DtPHS
 +iEmKUufs1nq9y3T48RCPuGTZwjSZv7mLQtCEEFiwyhIoAeb+3K8N/bcpgxQ4BjAvWww
 T3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hgN8r/CRyBxvOK+TVAegx67yWSlkhaeXjKw7dOXe6mU=;
 b=mcYYb4WOAsG8Mbbng6UmoGWjAjEMzME860iSZwjpfKFUOK15mcFxMUZH3LrhSzh0U2
 MDnKX9hZQJIyzr/b/1gAT2CpVsCbTiApCp+fRvyuAyiALJfRqVLtTvBdynHo8kqE3fhk
 zRhwHAl2YkvD7uHK+hkGCsNIyTWaPUEgCG5IJNMH8BsJauD4h7ilit21gKpF3LxUcdGf
 ypdUGEsfe+6D2517CjcdUeeZ+mcz6POIqJvYbL53OpS4q23ennXP93MQ/9quq2+SqEWu
 yUr8UomZowUAmt9jhRgk3g/qDyAaF3+0tLGUB3urmntGFVjNJAIBEcQumX2F1SQwY4dQ
 lhSw==
X-Gm-Message-State: AOAM530W+GU3ToZqlVwcUpmuQhpFkVIEHWCxraUWkJ8T/BgGxf9slq4z
 UUd7t03YDfNoyFPub/dvQbU=
X-Google-Smtp-Source: ABdhPJyvsysPL0CHLyfDpAw1cudws2ZiAOC+rnvyb1f+7cla+LR8NMaSdaVDjUy7QG4wf1nB0mauqA==
X-Received: by 2002:a2e:b00c:: with SMTP id y12mr900022ljk.18.1598620754062;
 Fri, 28 Aug 2020 06:19:14 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 1sm202520ljr.6.2020.08.28.06.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 06:19:13 -0700 (PDT)
Date: Fri, 28 Aug 2020 15:19:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/77] target/microblaze improvements
Message-ID: <20200828131912.GU2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.425, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
> 

It looks like our tests pass after adressing the issues I've mentioned
so far. Don't know whats going on with the tcg_gen_lookup_and_goto_ptr
issue, I'll double-check next week to make sure I didn't mess something
up.

Thanks,
Edgar

