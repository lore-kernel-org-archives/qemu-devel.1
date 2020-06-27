Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE7C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 20:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEEA20663
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 20:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zx0aIqJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEEA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpHgl-0007ns-Da
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 16:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jpHfu-0007NA-Ah
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 16:43:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jpHfs-0002tI-3j
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 16:43:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id d4so6544982pgk.4
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+WQjJGh2V3T30xcJjGPaL5lDoZ33TmpzpIRKf2o/+y4=;
 b=zx0aIqJcV3FjhsiYFF17LiIb4Yu1XEjXBWc0KlhYGDLDawKCZSx29lZNaCCOH7Hrim
 W5FXWfln2yi/ah1BFUXLQs3GE87+WousVhuV4hN3Ajw2u2wGkI22pFUUVGzGGfEbWpYj
 gLUbahyDQBF4XxihimZvmaIjxOdlGSpeRImPA8QMel0kaG1vvMHOxMdD1ieBPQcntSg4
 5xbJGDNZSw/X5UIXrzoHBENNupqXhagfB+BqOyUw8GvJ3eQ08Pk1TS1cPiGLCGa9Mf+g
 FKvZnKUgY8gz5bKkX4tYii4x0iGlr1OTrD/s/AgKmLvhiOsjbzabM+EIl3DAw408ReXT
 /uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+WQjJGh2V3T30xcJjGPaL5lDoZ33TmpzpIRKf2o/+y4=;
 b=sivJTXqJAYYscLLTCiLienLDD4l1753f9kIUHg6ws8OCReENkI7yEriNJpXfniwtfX
 J5teAl2oaKzu7TaUSIVEkrzH9B4Li9Y+S/lkajiFIokWW60FJkUlxt00PcVnZFZdovOi
 lMvfllq0w+yBR5S6GWjBCtEhOPhCcQfkNOfs4hHFvVmQ5vhfRz+e6Uk8BUZ1CSRgzYrT
 KSweVFFNzAH1xdSAa4lgClUvZRmR+H09DtnPQNRqawmf3OC+2MySHmbk9UyAPtw9+9Dv
 dNsF57M6wjKqh+IlEhfoYIcA9BQB+POT2vDFDSsdEh0Ozps04FHHYxKPIxEb7GQzAAph
 lVCw==
X-Gm-Message-State: AOAM530cUgRAXjPd/5NEgIzeS9ZdbfesN03GVqvDuEiI64YiJ95j56Cs
 nH0gnLfl4QuYRmIKNXPDvPkO6Q==
X-Google-Smtp-Source: ABdhPJyRjuOvhuG8isx6RGiXSAXMt0E8S1vBJd9MBMYcgjAyxoJ03/yMkxLDFcrLhlHDeoIxJyFjkw==
X-Received: by 2002:aa7:9af0:: with SMTP id y16mr8641625pfp.231.1593290620163; 
 Sat, 27 Jun 2020 13:43:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f6sm31531065pfe.174.2020.06.27.13.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2020 13:43:39 -0700 (PDT)
Subject: Re: [PATCH v5] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200625162602.700741-1-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c63269f4-e2da-4490-97b3-b2b260ed14d7@linaro.org>
Date: Sat, 27 Jun 2020 13:43:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625162602.700741-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:26 AM, Eric Blake wrote:
> I'm not aware of any immediate bugs in qemu where a second runtime
> evaluation of the arguments to MIN() or MAX() causes a problem, but
> proactively preventing such abuse is easier than falling prey to an
> unintended case down the road.  At any rate, here's the conversation
> that sparked the current patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
> 
> Update the MIN/MAX macros to only evaluate their argument once at
> runtime; this uses typeof(1 ? (a) : (b)) to ensure that we are
> promoting the temporaries to the same type as the final comparison (we
> have to trigger type promotion, as typeof(bitfield) won't compile; and
> we can't use typeof((a) + (b)) or even typeof((a) + 0), as some of our
> uses of MAX are on void* pointers where such addition is undefined).
> 
> However, we are unable to work around gcc refusing to compile ({}) in
> a constant context (such as the array length of a static variable),
> even when only used in the dead branch of a __builtin_choose_expr(),
> so we have to provide a second macro pair MIN_CONST and MAX_CONST for
> use when both arguments are known to be compile-time constants and
> where the result must also be usable as a constant; this second form
> evaluates arguments multiple times but that doesn't matter for
> constants.  By using a void expression as the expansion if a
> non-constant is presented to this second form, we can enlist the
> compiler to ensure the double evaluation is not attempted on
> non-constants.
> 
> Alas, as both macros now rely on compiler intrinsics, they are no
> longer usable in preprocessor #if conditions; those will just have to
> be open-coded or the logic rewritten into #define or runtime 'if'
> conditions (but where the compiler dead-code-elimination will probably
> still apply).
> 
> I tested that both gcc 10.1.1 and clang 10.0.0 produce errors for all
> forms of macro mis-use.  As the errors can sometimes be cryptic, I'm
> demonstrating the gcc output:
> 
> Use of MIN when MIN_CONST is needed:
> 
> In file included from /home/eblake/qemu/qemu-img.c:25:
> /home/eblake/qemu/include/qemu/osdep.h:249:5: error: braced-group within expression allowed only inside a function
>   249 |     ({                                                  \
>       |     ^
> /home/eblake/qemu/qemu-img.c:92:12: note: in expansion of macro ‘MIN’
>    92 | char array[MIN(1, 2)] = "";
>       |            ^~~
> 
> Use of MIN_CONST when MIN is needed:
> 
> /home/eblake/qemu/qemu-img.c: In function ‘is_allocated_sectors’:
> /home/eblake/qemu/qemu-img.c:1225:15: error: void value not ignored as it ought to be
>  1225 |             i = MIN_CONST(i, n);
>       |               ^
> 
> Use of MIN in the preprocessor:
> 
> In file included from /home/eblake/qemu/accel/tcg/translate-all.c:20:
> /home/eblake/qemu/accel/tcg/translate-all.c: In function ‘page_check_range’:
> /home/eblake/qemu/include/qemu/osdep.h:249:6: error: token "{" is not valid in preprocessor expressions
>   249 |     ({                                                  \
>       |      ^
> 
> Fix the resulting callsites that used #if or computed a compile-time
> constant min or max to use the new macros.  cpu-defs.h is interesting,
> as CPU_TLB_DYN_MAX_BITS is sometimes used as a constant and sometimes
> dynamic.
> 
> It may be worth improving glib's MIN/MAX definitions to be saner, but
> that is a task for another day.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

