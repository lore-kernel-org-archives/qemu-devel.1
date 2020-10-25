Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E57AC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 20:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E9022284
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 20:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E9022284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWn1H-0007Da-0f
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 16:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kWmzZ-0006lZ-HU
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 16:51:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kWmzX-0007hv-Ia
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 16:51:53 -0400
Received: by mail-il1-f196.google.com with SMTP id k6so1056693ilq.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 13:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FgyF6qmsn7SgDi5+izG2Ej+KqwRwkaH5zKU53icTgZ4=;
 b=F95AhAGWSCExuSZ49vKR377Kg2JMK4gG+JV0qyedzKy54TSsR7HTql436iti8ZYQ4V
 pF1FQotdnJixiW6JJV+qmW6ah18hWzDNLr7hEE9VymutGQ9yjimwqX8tqMaHzq9tHv1g
 EStsMKqvbiJBGjJhXm7kmgp4caZ8id2JAy/ZbAnngYclY8cHQa1KyFPMbOQPrnCelssM
 H+zcy4JHh4Fr/cgJQWvitwMWQjd/yzxQI5n5BiN0vAGtb25CEFn52IShrWRY6MMNqUjK
 HlzrahCCuV/G8msZv7MXdIqeMASqqiMxWXHBfWg+joC+/TNp0wqEJ2gqIZIb2Lhjlu0i
 Uo/w==
X-Gm-Message-State: AOAM533tFPcoV8HVe1TvWU04oypLEIBH42+jtGArLsrpdkGbU1PDTnu8
 Jlb2LZ+EmpCMlMXvTMQjMorEiBrZGjA=
X-Google-Smtp-Source: ABdhPJwa7muEDG5leupdRXjK1FzKc6zqta9ePEHLqOb1GVtRQ1lNi0lUdHZNjKUwjKjp/U1B2eZliQ==
X-Received: by 2002:a92:7d11:: with SMTP id y17mr7673127ilc.124.1603659110083; 
 Sun, 25 Oct 2020 13:51:50 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com.
 [209.85.166.180])
 by smtp.gmail.com with ESMTPSA id r17sm4166871iov.7.2020.10.25.13.51.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 13:51:49 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id q1so6316544ilt.6
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 13:51:49 -0700 (PDT)
X-Received: by 2002:a05:6e02:931:: with SMTP id
 o17mr8740523ilt.273.1603659109355; 
 Sun, 25 Oct 2020 13:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-7-j@getutm.app>
 <aa4c227-c33-72dc-92c6-75792f60b58e@eik.bme.hu>
 <CA+E+eSAYV50ACGaAvd_e-eR3FoSiBq6EXqDVRH7vJZyYHvhA8w@mail.gmail.com>
 <b1a9e0c9-4327-6950-bc58-8c79dbe8b8a0@linaro.org>
In-Reply-To: <b1a9e0c9-4327-6950-bc58-8c79dbe8b8a0@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sun, 25 Oct 2020 13:51:38 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBh7fQnn+PapM_hnuo=jeKih6Q+Vmbjyz3ci2Y_c-okZw@mail.gmail.com>
Message-ID: <CA+E+eSBh7fQnn+PapM_hnuo=jeKih6Q+Vmbjyz3ci2Y_c-okZw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] tcg: implement mirror mapped JIT for iOS
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 16:51:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Finally, I'd like to have this implemented on Linux as well, or I'm afraid the
> feature will bit-rot.  This can be trivially done by either (1)
> MREMAP_DONTUNMAP or (2) mapping from posix shared memory instead of MAP_ANON so
> that you can map the same memory twice.  Thus virtually all of the ifdefs
> should go away.
Just spent an hour trying to implement this for Linux and running into issues.

1) Doesn't work because MREMAP_DONTUNMAP does in fact remove the entry
from the page table. According to the man pages "After completion, any
access to the range specified by old_address and old_size will result
in a page fault." Seems like the feature is designed around memory
locking, not mirror mapping.

2) I tried doing shm_open() and mmap() but you can't PROT_EXEC on shm
(see https://stackoverflow.com/questions/25275777/shared-executable-memory
)

I think it may be possible to map a file on an executable partition,
but I can foresee countless issues there including some security
issues. Anyone have any other ideas?

-j

On Mon, Oct 19, 2020 at 5:20 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/19/20 3:39 PM, Joelle van Dyne wrote:
> >> Explicit cast may not be needed here so this could be a macro if caling it
> >> differently helps or why don't you just use tcg_mirror_prr_rw directly
> >> everywhere?
> >
> > There are quite a bit of code that depends on tcg_insn_unit * type such as
> >
> > *tcg_code_ptr_rw(s, code_ptr) = insn;
> >
> > and
> >
> > (tcg_code_ptr_rw(s, p))[i] = NOP;
> >
> > I think it's cleaner to not have to manually cast in every one of 30+
> > instances of this. In v1, I used a macro but was told to use an inline
> > function instead.
>
> Yep.
>
> >> Is that !defined or are you missing an implementation and #else here?
> > No, `flush_dcache_range` is only needed when mirror mapped (after
> > writing to the RW mirror). Now there is no iOS compatible compiler for
> > any other arch than x86 and ARM. However, in the slim chance that
> > Apple decides to change arch again in the future and moves to RISC-V
> > or something, then we get a nice compiler error.
>
> *shrug* As opposed to the nice compiler error you get for a missing function
> declaration?
>
> That said, I think __builtin___clear_cache() may be the target-independent
> runtime function that you need.  Both GCC and LLVM support this, and I'd be
> surprised if that doesn't carry through to iOS.
>
> >> Maybe this patch could be split up some more, making the RW offset
> >> handling and cache management separate patches even if they don't work
> >> separately just to make it easier to review.
> >
> > I can probably do that for v3 but imo most of the LOC here is because
> > the same change has to be done to every TCG target. No matter how you
> > split up the patches, it will look like a lot of changes.
>
> It occurs to me that the majority of the code changes in patches 5 and 6 are
> due to your choice that code_gen_buffer points to the RX copy and not the RW copy.
>
> Swap the two, and instead have an inline function that produces the executable
> pointer from the rw pointer, and suddenly there are very much fewer changes
> required.
>
> For the most part, tcg/$cpu/ generates pc-relative code, so it need not
> consider the absolute address.  There are a few exceptions including,
> obviously, 32-bit x86.  But the number of places that occurs is small.
>
> There's the assignment to tb->tc.ptr of course, and
> tcg_ctx.code_gen_prologue/epilogue.
>
> In any case, each of these changes (generic, per tcg backend) can occur before
> you finally add a non-zero displacement that actually separates the RX and RW
> mappings.
>
> Finally, I'd like to have this implemented on Linux as well, or I'm afraid the
> feature will bit-rot.  This can be trivially done by either (1)
> MREMAP_DONTUNMAP or (2) mapping from posix shared memory instead of MAP_ANON so
> that you can map the same memory twice.  Thus virtually all of the ifdefs
> should go away.
>
>
> r~

