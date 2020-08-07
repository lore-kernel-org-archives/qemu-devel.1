Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F61C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 22:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9B52177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 22:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kxz74Vnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9B52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4AhJ-00073o-4w
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 18:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k4AgS-0006df-0l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 18:17:52 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k4AgP-0007MF-W9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 18:17:51 -0400
Received: by mail-lj1-x241.google.com with SMTP id v9so3750375ljk.6
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OG/wBUojSS/00nW3BrCFHx7KOwPsBnANh9eWUwG5Msc=;
 b=Kxz74VnfVWKVVqHKnDZFGXnZdrrDNUjTnF6foKDNRc+aB56ixvbEgfxkcd4rdmhvBf
 QqGiDwLbLAlfhYWI7BFzvk1UIAbeuf3/GH7fslV30F9zpXKsSqFSgDVhm2d8rh6B9aHI
 +tr0Cg/D5s46ij9kDOyaxwpDg2K2MDQ5rDRF2n6CvLh+qBP9W3YKzwJS6cVA7sdgqFxE
 tmIda3ntaJkEHJR4fwbI9ThGG44YxkI3Y4X2VKez+fHYCFOHaE7D8j9Fpcp8GcwkEYJT
 pEEEJNJzZfcnq9NBxi+ugBzvxvuNcOO/WQBZbG+nZSBiW+kQqUJC6KolqSXbo/WNqkgJ
 1Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OG/wBUojSS/00nW3BrCFHx7KOwPsBnANh9eWUwG5Msc=;
 b=rdNX32Biib/4K1VUVswvvIUFm/TPJaB+lomQZ+IylYBjIl+u3E/50gzO3NtGaSFZSc
 4XLbbSEOXSqyH//RZsmX0INLWjEVrv+F+8TOtYcJD0S+wlVfpFoPN83BsJKTzNFGZneZ
 cX5gHaGcRdKB8ndbVToKa9iP06s1Jnj5pvndtf8aVNikgwA/JBemyVtOe/gJ+zDHXn9n
 /8uv6EfeM7ctKWU3Mb4aIH31kMlWPFC3/0gS6jHWFO+EyduXMDtV8Ev1qU8y3w0/OA+/
 B7iYPJCuguJ6vdRacyN/aM9/Pj83QirKZX6u3wn/xsWzzb6QxZ4e2uIAvyrtU3IlAsMN
 8WkQ==
X-Gm-Message-State: AOAM5319apKdDCgZ+QYJaKdlH+zTtuH4x5w8qef6AMK36jLDvz2YTz6w
 gVlMJT997bdT8TmzV3rboXbYh3rMRWHw6iMwvQXSQQ==
X-Google-Smtp-Source: ABdhPJxZTOe9izNxrPFstlxdpD1GeTWKNtya9KB4r9Zkg18kSaisrNTqjn/hgBjuCmXk1ArLAabZlw0LlZuzCNr9HIE=
X-Received: by 2002:a2e:9f0a:: with SMTP id u10mr6945805ljk.140.1596838666793; 
 Fri, 07 Aug 2020 15:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
 <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
 <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
 <CAEyhzFvveC=nhpo4uyJ_89J8Wi4+9NEc2T2Mk9mg6Y9ZMQjNSA@mail.gmail.com>
 <CAEyhzFvh79ViuXYLYyihTBS3d5dviGpOXjntAt95yyuwE+HwLA@mail.gmail.com>
In-Reply-To: <CAEyhzFvh79ViuXYLYyihTBS3d5dviGpOXjntAt95yyuwE+HwLA@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 7 Aug 2020 18:18:08 -0400
Message-ID: <CAEyhzFsMgQWr=sOM43-w3jwSgNyUiKMRKFGdRGRqxM5=offsGA@mail.gmail.com>
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x241.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We found cases where a few of the *_cpu_exec_interrupt per arch functions
call CPU class's cc->do_interrupt function pointer (for example
arm_cpu_exec_interrupt does this).

This is an issue because *_cpu_exec_interrupt will hold the BQL across the
call to cc->do_interrupt, and *_do_interrupt will also hold the BQL.

Most of the arches do not have this issue because they call the *_do_interrupt
function for that arch directly, and in those cases we will change to call
the function *_do_interrupt_locked.

We see a few possible solutions to this:

1) We could go back to the option of conditionalizing the BQL inside
   these few *_do_interrupt functions, only acquiring the BQL if it is not
   already held.  I counted 3 different arches that directly use the
->do_interrupt
   function from their *_cpu_exec_interrupt.

2) Another perhaps cleaner option is to add a new cpu class function
->do_interrupt_locked.
   This lets callers like *_cpu_exec_interrupt call to ->do_interrupt_locked
   with lock held and solves the issue without resorting to conditional locking.

   Another benefit we could gain from this approach is to simplify our solution
   overall by adding a common do_interrupt function.

   void cpu_common_do_interrupt(CPUState *cs)
   {
        CPUClass *cc = CPU_GET_CLASS(cpu);
        qemu_mutex_lock_iothread();
        cc->do_interrupt_locked(cpu);
        qemu_mutex_unlock_iothread();
    }
   cc->do_interrupt would be set to cpu_common_do_interrupt by default
in cpu_class_init.
   In other words, the base cpu class would handle holding the BQL for us,
   and we would not need to implement a new *_do_interrupt function
for each arch.

We are thinking that 2) would be a good option.

What are the opinions on these possible solutions?  Or are there other
solutions that we should consider here?

Thanks & Regards,
-Rob


On Thu, 6 Aug 2020 at 16:04, Robert Foley <robert.foley@linaro.org> wrote:
>
> The comment around documenting the cpu_mutex fields and critical sections
> got us thinking and revisiting our locking assumptions in cpu_handle_interrupt.
>
> Initially we were thinking that removing the BQL from cpu_handle_interrupt
> meant that we needed to replace it with the cpu mutex to protect the per cpu
> data that is accessed like interrupt_request.  We are reconsidering this and
> now thinking that the cpu mutex might not be needed here.
>
> BQL is clearly needed to protect the critical section around the call to
> ->cpu_exec_interrupt.  What else is the BQL protecting in cpu_handle_interrupt
> that we need to consider?  Are we missing anything here?
>
> It's also worth mentioning that we did give this approach a try.
> We tried out changes to cpu_handle_interrupt(),
> dropping the BQL from all but around ->cpu_exec_interrupt, and not using the
> cpu_mutex at all.  It seemed to be functional, passing all the tests that
> we tried (so far). :)
>
> Thanks,
> -Rob
>
> On Thu, 6 Aug 2020 at 12:11, Robert Foley <robert.foley@linaro.org> wrote:
> >
> > On Thu, 6 Aug 2020 at 05:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > On 05/08/20 21:18, Richard Henderson wrote:
> > > > On 8/5/20 11:12 AM, Robert Foley wrote:
> > > >> This change removes the implied BQL from the cpu_handle_interrupt,
> > > >> and cpu_handle_exception paths. This BQL acquire is being pushed
> > > >> down into the per arch implementation.
> > > >>
> > > >> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > > >> ---
> > > >>  accel/tcg/cpu-exec.c | 19 +++++++++++--------
> > > >>  1 file changed, 11 insertions(+), 8 deletions(-)
> > > >>
> > > >> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > > >> index 80d0e649b2..8e2bfd97a1 100644
> > > >> --- a/accel/tcg/cpu-exec.c
> > > >> +++ b/accel/tcg/cpu-exec.c
> > > >> @@ -517,9 +517,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
> > > >>  #else
> > > >>          if (replay_exception()) {
> > > >>              CPUClass *cc = CPU_GET_CLASS(cpu);
> > > >> -            qemu_mutex_lock_iothread();
> > > >>              cc->do_interrupt(cpu);
> > > >> -            qemu_mutex_unlock_iothread();
> > > >>              cpu->exception_index = -1;
> > > >>
> > > >
> > > > This patch is not bisectable.  The removal of the lock here needs to happen at
> > > > the end, or something.
> > >
> > > Indeed the series should be structured like this:
> > >
> > > 1) rename all *_do_interrupt functions to *_do_interrupt_locked
> > >
> > > 2) add back *_do_interrupt that takes the BQL and calls
> > > *_do_interrupt_locked, point ->do_interrupt to it, remove the BQL from
> > > cpu-exec.c
> > >
> > > 3) modify the cpu_mutex and BQL critical sections around
> > > ->cpu_exec_interrupt, so that the BQL critical section covers just the
> > > call to ->cpu_exec_interrupt.  Document which fields are now covered by
> > > cpu_mutex.
> > >
> > > 4/5) same as 1/2 for ->cpu_exec_interrupt
> > >
> > > Patches 1/2 would be pretty large, but they're trivial to review just by
> > > grepping for "->do_interrupt\s*=", and likewise for 4/5.
> > >
> >
> > Thanks for the details !
> >
> > It seems like we will have 3 separate patches for this series, 1/2, 3, and 4/5.
> >
> > We will go in this direction.
> >
> > Thanks,
> > -Rob
> >
> > > Thanks,
> > >
> > > Paolo
> > >

