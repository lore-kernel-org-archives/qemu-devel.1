Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFC620775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bv4z/6Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFC620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKFd-000660-TT
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jkz@google.com>) id 1jtKEt-0005Ny-L1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:16:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jkz@google.com>) id 1jtKEr-00076P-Fj
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:16:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id u185so216190pfu.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WE/1zqYFZ8Zbu2PyPgx/xwOi3MoytYCM38ELMcZLIwk=;
 b=bv4z/6TvZUN8K1BNlevEXisttQH3edjuqOnQuw80RLeHoXfjEZ2Gr6Umy7XsAoqFz3
 //5qG0doIRd3pHvRRyv6CYR4pshrjKMZonCovTT2oYUjFyx1tKwwiczUL8KA4jJpCpZb
 jZjayYQO0UVihCQtD0G7xGd6ZbXq74vkPlTsdTWuS6BsmlwsP6qakmhi0wa9oC+Kdmtq
 Lvq4/lRoSbqQAs1eyc8oXtgONf/PbtwBHI6jCMtgKioK3k+igil419bIGUFm9vv8fcoY
 0OUbLeWaSBIjyUuzK9kXa0hn5R1H2tXXYRYafZSXHe60eqKwbCx3J+Eg3g7CohjSSU8K
 w9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WE/1zqYFZ8Zbu2PyPgx/xwOi3MoytYCM38ELMcZLIwk=;
 b=GFFaBKj1NxqSCAkoGLGoKITJCOyWiS9BKJBbQSay7kYXwaK17v16AUnlRCslmID2Oy
 TTUvkmH7e5IOv1y0RYW84EwMr/Dy6fKDH57QIWexqzfUIOZz/uBY+t4VY9aJlQML0nKK
 tmmkGBFHCIvaYuys5NdrU7Sy77hEhdd3jDa2TOTBqEA3HUNPesu0g0eL0MtMYangtI4U
 Ne69txn+sx2RgGb+AY05ZvdWj5nseCEXtkz//wue710mK6s4L2h1pbVfCGEz7xPETi/f
 ET5ElhmvgsxNBsGFME1qTDEkeYhtyQ9WOoS4DSSmbI9ViOAban4lbQB5IDqOvPxTiSfy
 sHDA==
X-Gm-Message-State: AOAM5335XsWGY07ZlVgWCJ68G5BUnI4zsCQA/+oRmU94aWsyY6vodbTg
 WOTfSmC3p5COCleTae1JaICTtEkfLmMT5DKJPrjBWA==
X-Google-Smtp-Source: ABdhPJx4f/ozuThmaM9TbWIVect3j9CxlXNAPSNcV543AIwwr/E0yRsJSLZGfwwj2TjFpRwnNhBT2ULtIo8KhxWIPvY=
X-Received: by 2002:aa7:9ac3:: with SMTP id x3mr45149389pfp.261.1594253789943; 
 Wed, 08 Jul 2020 17:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
 <20200612014606.147691-5-jkz@google.com>
 <87h7vbyowf.fsf@linaro.org>
 <CADgy-2uOn835LrnOBDacbqznW8MR7ZQy55kBmpjDbK2Uy1xPEg@mail.gmail.com>
 <877dvy9opz.fsf@linaro.org>
 <CADgy-2tB0Z133RB1i8OdnpKMD3xATL059dFoduHOjdim11G4-A@mail.gmail.com>
 <87k0zw7opa.fsf@linaro.org>
In-Reply-To: <87k0zw7opa.fsf@linaro.org>
From: Josh Kunz <jkz@google.com>
Date: Wed, 8 Jul 2020 17:16:17 -0700
Message-ID: <CADgy-2ug-vUStvRCUivM9AYp9qBzdLtt3pwMONvjahpcJajVqw@mail.gmail.com>
Subject: Re: [PATCH 4/5] linux-user: Support CLONE_VM and extended clone
 options
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=jkz@google.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry for the late reply, response inline. Also I noticed a couple
mails ago I seemed to have removed the devel list and maintainers.
I've re-added them to the CC line.

On Wed, Jun 24, 2020 at 3:17 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Josh Kunz <jkz@google.com> writes:
>
> > On Tue, Jun 23, 2020, 1:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >
> > (snip)
> >
> >> >> > * Non-standard libc extension to allow creating TLS images indepe=
ndent
> >> >> >   of threads. This would allow us to just `clone` the child direc=
tly
> >> >> >   instead of this complicated maneuver. Though we probably would =
still
> >> >> >   need the cleanup logic. For libcs, TLS image allocation is tigh=
tly
> >> >> >   connected to thread stack allocation, which is also arch-specif=
ic. I
> >> >> >   do not have enough experience with libc development to know if
> >> >> >   maintainers of any popular libcs would be open to supporting su=
ch an
> >> >> >   API. Additionally, since it will probably take years before a l=
ibc
> >> >> >   fix would be widely deployed, we need an interim solution anywa=
ys.
> >> >>
> >> >> We could consider a custom lib stub that intercepts calls to the gu=
ests
> >> >> original libc and replaces it with a QEMU aware one?
> >> >
> >> > Unfortunately the problem here is host libc, rather than guest libc.
> >> > We need to make TLS variables in QEMU itself work, so intercepting
> >> > guest libc calls won't help much. Or am I misunderstanding the point=
?
> >>
> >> Hold up - I'm a little confused now. Why does the host TLS affect the
> >> guest TLS? We have complete control over the guests view of the world =
so
> >> we should be able to control it's TLS storage.
> >
> > Guest TLS is unaffected, just like in the existing case for guest
> > threads. Guest TLS is handled by the guest libc and the CPU emulation.
> > Just to be clear: This series changes nothing about guest TLS.
> >
> > The complexity of this series is to deal with *host* usage of TLS.
> > That is to say: use of thread local variables in QEMU itself. Host TLS
> > is needed to allow the subprocess created with `clone(CLONE_VM, ...)`
> > to run at all. TLS variables are used in QEMU for the RCU
> > implementation, parts of the TCG, and all over the place to access the
> > CPU/TaskState for the running thread. Host TLS is managed by the host
> > libc, and TLS is only set up for host threads created via
> > `pthread_create`. Subprocesses created with `clone(CLONE_VM)` share a
> > virtual memory map *and* TLS data with their parent[1], since libcs
> > provide no special handling of TLS when `clone(CLONE_VM)` is used.
> > Without the workaround used in this patch, both the parent and child
> > process's thread local variables reference the same memory locations.
> > This just doesn't work, since thread local data is assumed to actually
> > be thread local.
> >
> > The "alternative" proposed was to make the host libc support TLS for
> > processes created using clone (there are several ways to go about
> > this, each with different tradeoffs). You mentioned that "We could
> > consider a custom lib stub that intercepts calls to the guests
> > original libc..." in your comment. Since *guest* libc is not involved
> > here I was a bit confused about how this could help, and wanted to
> > clarify.
> >
> >> >> Have you considered a daemon which could co-ordinate between the
> >> >> multiple processes that are sharing some state?
> >> >
> >> > Not really for the `CLONE_VM` support added in this patch series. I
> >> > have considered trying to pull tcg out of the guest process, but not
> >> > very seriously, since it seems like a pretty heavyweight approach.
> >> > Especially compared to the solution included in this series. Do you
> >> > think there's a simpler approach that involves using a daemon to do
> >> > coordination?
> >>
> >> I'm getting a little lost now. Exactly what state are we trying to sha=
re
> >> between two QEMU guests which are now in separate execution contexts?
> >
> > Since this series only deals with `clone(CLONE_VM)` we always want to
> > share guest virtual memory between the execution contexts. There is
> > also some extra state that needs to be shared depending on which flags
> > are provided to `clone()`. E.g., signal handler tables for
> > CLONE_SIGHAND, file descriptor tables for CLONE_FILES, etc.
> >
> > The problem is that since QEMU and the guest live in the same virtual
> > memory map, keeping the mappings the same between the guest parent and
> > guest child means that the mappings also stay the same between the
> > host (QEMU) parent and host child. Two hosts can live in the same
> > virtual memory map, like we do right now with threads, but *only* with
> > valid TLS for each thread/process. That's why we bend-over backwards
> > to get set-up TLS for emulation in the child process.
>
> OK thanks for that. I'd obviously misunderstood from my first read
> through. So while hiding the underlying bits of QEMU from the guest is
> relatively easy it's quite hard to hide QEMU from itself in this
> CLONE_VM case.

Yes exactly.

> The other approach would be to suppress CLONE_VM for the actual process
> (thereby allowing QEMU to safely have a new instance and no clashing
> shared data) but emulate CLONE_VM for the guest itself (making the guest
> portions of memory shared and visible to each other). The trouble then
> would be co-ordination of mapping operations and other things that
> should be visible in a real CLONE_VM setup. This is the sort of
> situation I envisioned a co-ordination daemon might be useful.

Ah. This is interesting. Effectively the inverse of this patch. I had
not considered this approach. Thinking more about it, a "no shared
memory" approach does seem more straightforward implementation wise.
Unfortunately I think there would be a few substantial drawbacks:

1. Memory overhead. Every guest thread would need a full copy of QEMU
memory, including the translated guest binary.
2. Performance overhead. To keep virtual memory maps consistent across
tasks, a heavyweight 2 phase commit scheme, or similar, would be
needed for every `mmap`. That could have substantial performance
overhead for the guest. This could be a huge problem for processes
that use a large number of threads *and* do a lot of memory mapping or
frequently change page permissions.
3. There would be lots of similarly-fiddly bits that need to be shared
and coordinated in addition to guest memory. At least the signal
handler tables and fd_trans tables, but there are likely others I'm
missing.

The performance drawbacks could be largely mitigated by using the
current thread-only `CLONE_VM` support, but having *any* threads in
the process at all would lead to deadlocks after fork() or similar
non-CLONE_VM clone() calls. This could be worked around with a "stop
the world" button somewhat like `start_exclusive`, but expanded to
include all emulator threads. That will substantially slow down
fork().

Given all this I think the approach used in this series is probably at
least as "good" as a "no shared memory" approach. It has its own
complexities and drawbacks, but doesn't have obvious performance
issues. If you or other maintainers disagree, I'd be happy to write up
an RFC comparing the approaches in more detail (or we can just use
this thread), just let me know. Until then I'll keep pursuing this
patch.

> > [1] At least on x86_64, because TLS references are defined in terms of
> > the %fs segment, which is inherited on linux. Theoretically it's up to
> > the architecture to specify how TLS is inherited across execution
> > contexts. t's possible that the child actually ends up with no valid
> > TLS rather than using the parent TLS data. But that's not really
> > relevant here. The important thing is that the child ends up with
> > *valid* TLS, not invalid or inherited TLS.
>
>
> --
> Alex Benn=C3=A9e

--
Josh Kunz

