Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F19DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3DE2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fofgSrAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3DE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1Li-00017z-5Q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw1L2-0000FV-Ae
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:42:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw1Kz-00048F-HT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:42:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so9837395wmi.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4i+E/XD1djUTB8jHJezAQEDPSBzS1oVhfMfRV/lVR64=;
 b=fofgSrAMJ65hRk1gu4OKRsor8bn+K42n0KISHppewCSDUyngGLrrOR8gsI7Fwl5BeN
 ThDOyU98Q1eKg11JN5db/wiUoGqwqip4GsWJag0A4Dch1GfCh1/4AjLtQZlmM3iRnqDO
 5Bt4QjHaM8zrlDsBCBq661NRk5tweBC4V52WcQ5MXzoumOm1WDHCpYIpZGmraHmgizt1
 Unfkl74428letQh8GqhQZ0UMWN/MP3vM/FBzZl2diO42nszsAyzEwxwGdya2mFOvS3eC
 pKASl6lUqqqIT99hnu0QXQp4bt5ZAtrzD+Sra6cBsgoXu+oCrCsaWtgBAk7w3O/afFGA
 hd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4i+E/XD1djUTB8jHJezAQEDPSBzS1oVhfMfRV/lVR64=;
 b=Px7pjsIQaAlYXsrEDltU3T9RRZcGJ1A3iYX51B+oX27kXaVGfkT7E9HAurxl9urKzW
 SpBOdN4pscA9u36CjhYF8EUYMzXOsRQharhbyeZxVXD3VIa0xsMsFPhsGFEMvEhek/Um
 uXVqPAJNE1YdfaROOa11s4Efx+vk3hhfDm62Y+jQw8+aIEWa+pC0DmozTgTvAl8jeLMs
 QmvH4Llkv3lYWnr5dGEwrbAhYF9FHqs3Xs1bB4z6T49ldqg4iGKp9fGYJl3q6exUgwKf
 GFAmcbtVliLPhVhyqfrtBuQYcmH/2M/5nsbYgqV8n/SJF7OtgZrl/2Zz9ne7XeeIK9fQ
 T61g==
X-Gm-Message-State: AOAM5332sz6e+gFlBhqWoLTY7Zq2AFPj8D1cUqQJzH/G7snYNCJ2pA5W
 9eFp9+hYbBrzWqUujUa6nB719w==
X-Google-Smtp-Source: ABdhPJxUYT4Gp6e+G1WS6B4ZJuzG/TfiMkPx7jXnpfUOmxjjRQx56xBP9moDplv3221N95RmFM26rQ==
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr3944339wmo.72.1594896119788; 
 Thu, 16 Jul 2020 03:41:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n125sm8356997wme.30.2020.07.16.03.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 03:41:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 995A31FF7E;
 Thu, 16 Jul 2020 11:41:57 +0100 (BST)
References: <20200612014606.147691-1-jkz@google.com>
 <20200612014606.147691-5-jkz@google.com> <87h7vbyowf.fsf@linaro.org>
 <CADgy-2uOn835LrnOBDacbqznW8MR7ZQy55kBmpjDbK2Uy1xPEg@mail.gmail.com>
 <877dvy9opz.fsf@linaro.org>
 <CADgy-2tB0Z133RB1i8OdnpKMD3xATL059dFoduHOjdim11G4-A@mail.gmail.com>
 <87k0zw7opa.fsf@linaro.org>
 <CADgy-2ug-vUStvRCUivM9AYp9qBzdLtt3pwMONvjahpcJajVqw@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 4/5] linux-user: Support CLONE_VM and extended clone
 options
In-reply-to: <CADgy-2ug-vUStvRCUivM9AYp9qBzdLtt3pwMONvjahpcJajVqw@mail.gmail.com>
Date: Thu, 16 Jul 2020 11:41:57 +0100
Message-ID: <87eepbwxl6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> Sorry for the late reply, response inline. Also I noticed a couple
> mails ago I seemed to have removed the devel list and maintainers.
> I've re-added them to the CC line.
>
> On Wed, Jun 24, 2020 at 3:17 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Josh Kunz <jkz@google.com> writes:
>>
>> > On Tue, Jun 23, 2020, 1:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> >
>> > (snip)
>> >
>> >> >> > * Non-standard libc extension to allow creating TLS images indep=
endent
>> >> >> >   of threads. This would allow us to just `clone` the child dire=
ctly
>> >> >> >   instead of this complicated maneuver. Though we probably would=
 still
>> >> >> >   need the cleanup logic. For libcs, TLS image allocation is tig=
htly
>> >> >> >   connected to thread stack allocation, which is also arch-speci=
fic. I
>> >> >> >   do not have enough experience with libc development to know if
>> >> >> >   maintainers of any popular libcs would be open to supporting s=
uch an
>> >> >> >   API. Additionally, since it will probably take years before a =
libc
>> >> >> >   fix would be widely deployed, we need an interim solution anyw=
ays.
>> >> >>
>> >> >> We could consider a custom lib stub that intercepts calls to the g=
uests
>> >> >> original libc and replaces it with a QEMU aware one?
>> >> >
>> >> > Unfortunately the problem here is host libc, rather than guest libc.
>> >> > We need to make TLS variables in QEMU itself work, so intercepting
>> >> > guest libc calls won't help much. Or am I misunderstanding the poin=
t?
>> >>
>> >> Hold up - I'm a little confused now. Why does the host TLS affect the
>> >> guest TLS? We have complete control over the guests view of the world=
 so
>> >> we should be able to control it's TLS storage.
>> >
>> > Guest TLS is unaffected, just like in the existing case for guest
>> > threads. Guest TLS is handled by the guest libc and the CPU emulation.
>> > Just to be clear: This series changes nothing about guest TLS.
>> >
>> > The complexity of this series is to deal with *host* usage of TLS.
>> > That is to say: use of thread local variables in QEMU itself. Host TLS
>> > is needed to allow the subprocess created with `clone(CLONE_VM, ...)`
>> > to run at all. TLS variables are used in QEMU for the RCU
>> > implementation, parts of the TCG, and all over the place to access the
>> > CPU/TaskState for the running thread. Host TLS is managed by the host
>> > libc, and TLS is only set up for host threads created via
>> > `pthread_create`. Subprocesses created with `clone(CLONE_VM)` share a
>> > virtual memory map *and* TLS data with their parent[1], since libcs
>> > provide no special handling of TLS when `clone(CLONE_VM)` is used.
>> > Without the workaround used in this patch, both the parent and child
>> > process's thread local variables reference the same memory locations.
>> > This just doesn't work, since thread local data is assumed to actually
>> > be thread local.
>> >
>> > The "alternative" proposed was to make the host libc support TLS for
>> > processes created using clone (there are several ways to go about
>> > this, each with different tradeoffs). You mentioned that "We could
>> > consider a custom lib stub that intercepts calls to the guests
>> > original libc..." in your comment. Since *guest* libc is not involved
>> > here I was a bit confused about how this could help, and wanted to
>> > clarify.
>> >
>> >> >> Have you considered a daemon which could co-ordinate between the
>> >> >> multiple processes that are sharing some state?
>> >> >
>> >> > Not really for the `CLONE_VM` support added in this patch series. I
>> >> > have considered trying to pull tcg out of the guest process, but not
>> >> > very seriously, since it seems like a pretty heavyweight approach.
>> >> > Especially compared to the solution included in this series. Do you
>> >> > think there's a simpler approach that involves using a daemon to do
>> >> > coordination?
>> >>
>> >> I'm getting a little lost now. Exactly what state are we trying to sh=
are
>> >> between two QEMU guests which are now in separate execution contexts?
>> >
>> > Since this series only deals with `clone(CLONE_VM)` we always want to
>> > share guest virtual memory between the execution contexts. There is
>> > also some extra state that needs to be shared depending on which flags
>> > are provided to `clone()`. E.g., signal handler tables for
>> > CLONE_SIGHAND, file descriptor tables for CLONE_FILES, etc.
>> >
>> > The problem is that since QEMU and the guest live in the same virtual
>> > memory map, keeping the mappings the same between the guest parent and
>> > guest child means that the mappings also stay the same between the
>> > host (QEMU) parent and host child. Two hosts can live in the same
>> > virtual memory map, like we do right now with threads, but *only* with
>> > valid TLS for each thread/process. That's why we bend-over backwards
>> > to get set-up TLS for emulation in the child process.
>>
>> OK thanks for that. I'd obviously misunderstood from my first read
>> through. So while hiding the underlying bits of QEMU from the guest is
>> relatively easy it's quite hard to hide QEMU from itself in this
>> CLONE_VM case.
>
> Yes exactly.
>
>> The other approach would be to suppress CLONE_VM for the actual process
>> (thereby allowing QEMU to safely have a new instance and no clashing
>> shared data) but emulate CLONE_VM for the guest itself (making the guest
>> portions of memory shared and visible to each other). The trouble then
>> would be co-ordination of mapping operations and other things that
>> should be visible in a real CLONE_VM setup. This is the sort of
>> situation I envisioned a co-ordination daemon might be useful.
>
> Ah. This is interesting. Effectively the inverse of this patch. I had
> not considered this approach. Thinking more about it, a "no shared
> memory" approach does seem more straightforward implementation wise.
> Unfortunately I think there would be a few substantial drawbacks:
>
> 1. Memory overhead. Every guest thread would need a full copy of QEMU
> memory, including the translated guest binary.

Sure although I suspect the overhead is not that great. For linux-user
on 64 bit systems we only allocate 128Mb of translation buffer per
process. What sort of size systems are you expecting to run on and how
big are the binaries?

> 2. Performance overhead. To keep virtual memory maps consistent across
> tasks, a heavyweight 2 phase commit scheme, or similar, would be
> needed for every `mmap`. That could have substantial performance
> overhead for the guest. This could be a huge problem for processes
> that use a large number of threads *and* do a lot of memory mapping or
> frequently change page permissions.

I suspect that cross-arch highly threaded apps are still in the realm of
"wow, that actually works, neat :-)" for linux-user. We don't have the
luxury of falling back to a single thread like we do for system
emulation so things like strong-on-weak memory order bugs can still trip
us up.

> 3. There would be lots of similarly-fiddly bits that need to be shared
> and coordinated in addition to guest memory. At least the signal
> handler tables and fd_trans tables, but there are likely others I'm
> missing.
>
> The performance drawbacks could be largely mitigated by using the
> current thread-only `CLONE_VM` support, but having *any* threads in
> the process at all would lead to deadlocks after fork() or similar
> non-CLONE_VM clone() calls. This could be worked around with a "stop
> the world" button somewhat like `start_exclusive`, but expanded to
> include all emulator threads. That will substantially slow down
> fork().
>
> Given all this I think the approach used in this series is probably at
> least as "good" as a "no shared memory" approach. It has its own
> complexities and drawbacks, but doesn't have obvious performance
> issues. If you or other maintainers disagree, I'd be happy to write up
> an RFC comparing the approaches in more detail (or we can just use
> this thread), just let me know. Until then I'll keep pursuing this
> patch.

I think that's fair. I'll leave it to the maintainers to chime in if
they have something to add. I'd already given some comments on patch 1 and
given it needs a re-spin I'll have another look on the next iteration.

I will say expect the system to get some testing on multiple backends so
if you can expand your testing beyond an x86_64 host please do.

>
>> > [1] At least on x86_64, because TLS references are defined in terms of
>> > the %fs segment, which is inherited on linux. Theoretically it's up to
>> > the architecture to specify how TLS is inherited across execution
>> > contexts. t's possible that the child actually ends up with no valid
>> > TLS rather than using the parent TLS data. But that's not really
>> > relevant here. The important thing is that the child ends up with
>> > *valid* TLS, not invalid or inherited TLS.
>>
>>
>> --
>> Alex Benn=C3=A9e


--=20
Alex Benn=C3=A9e

