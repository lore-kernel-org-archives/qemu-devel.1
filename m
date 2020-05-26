Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617CFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E1320723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpNblQNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E1320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbPh-0000ra-Bb
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbOd-0008F9-EI
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:21:39 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:47005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdbOb-0004sR-NF
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:21:38 -0400
Received: by mail-lj1-x243.google.com with SMTP id z6so24952982ljm.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZlJV+KqNE++mTmkWnpoKoKL3hIAPFJrf/jiCMS7sux4=;
 b=SpNblQNMTv1gcdVMibasgBlcnOnjt3sdl1d4o59HSwrTs0aEKkO/EIK0VXUSaCSg5T
 to//J69hbQQAkdGMEQ4jBuIdYK0U1BqHvsly5EE+7KcfcLpK0XeHEY4NliZhFNqUG144
 NzYp1mbYc1VjCJjM5bxMSYgq6MXSmweWtfXFW4PfCyS7QfCrFP0wz8Qz1hawGZdYIz2k
 ltDVFEiU7vkSiZpJw9zltvEmThO35rddt/nfAkV0oFkZ4ECaRP6H16pztx0KU0iSlXbp
 dM/2pXasxHkHCZ9x/TE+yOgVFTZLtsBVNjulDgx1wTZh5s9e35Xqn46gg2QvwqfmxyPQ
 6U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlJV+KqNE++mTmkWnpoKoKL3hIAPFJrf/jiCMS7sux4=;
 b=qdfIyzQA9AmIlcDf7v2YLbL6+Ekfk5URafBxhnw8no5WRyqJoXwNRac0S0QBitFXzK
 irbGXfs2JwMh4A3dEUb9Rnwcz25+/14IiZXfY7Fxhq9NsKloFThNMAoibz5tx0gHnFJ8
 5Xf9P1ok4+AxC4ay6rdPmPOAmLhQQHUq2CHrrbtCC2DUOdmcvvqOJ53qighlEQrawhET
 dDG1enELdDwRYIc/BfeOltGwpKG4sOfFwUFyjtqCNzJCV6oOnqjuKCSpF1bAgiOOp9ev
 VzhkCVvDjTFLLw5wfMFSQlAiyjHR0OScZPkC89zegMJwko+0pxHrqWq/eqR7G5XicFdG
 7izQ==
X-Gm-Message-State: AOAM5317BRi8rA+ucA8D+GJxH+vrCBzKAJcpbnGcfC3CQPjcklYtQt1w
 ro3F8+Mgd8Z0V6LY1M0kHJ7DwhERSFHa0Fh0NgHnk42ed+g=
X-Google-Smtp-Source: ABdhPJzNr+lzFEJZYNjWWFtCS05s72OnFXhD+x5W9iNNf/h8kCR9qwc9OQmK6gxZ5JDQrb3z4zMV+3JGOGw68C5ZV1Y=
X-Received: by 2002:a2e:8811:: with SMTP id x17mr847532ljh.140.1590506495036; 
 Tue, 26 May 2020 08:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-15-robert.foley@linaro.org>
 <20200526103218.GB3189@stefanha-x1.localdomain>
In-Reply-To: <20200526103218.GB3189@stefanha-x1.localdomain>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 11:21:30 -0400
Message-ID: <CAEyhzFvWs9foeJ94rtWHnXZh-a00k-7v5znP1hhVOmxJRu3Zfg@mail.gmail.com>
Subject: Re: [PATCH 14/19] util/async: Fixed tsan warnings
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On Tue, 26 May 2020 at 06:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, May 22, 2020 at 12:07:50PM -0400, Robert Foley wrote:
> > For example:
> >   Atomic write of size 8 at 0x7b4800113c28 by main thread (mutexes: write M30):
> >     #0 __tsan_atomic64_exchange <null> (qemu-system-aarch64+0x386f85)
> >     #1 aio_bh_poll util/async.c:146:5 (qemu-system-aarch64+0xcd1f61)
> >     #2 aio_dispatch util/aio-posix.c:380:5 (qemu-system-aarch64+0xcd8abb)
> >     #3 aio_ctx_dispatch util/async.c:298:5 (qemu-system-aarch64+0xcd31b0)
> >     #4 g_main_context_dispatch <null> (libglib-2.0.so.0+0x4c416)
> >     #5 qemu_main_loop softmmu/vl.c:1664:9 (qemu-system-aarch64+0x5cc6d6)
> >     #6 main softmmu/main.c:49:5 (qemu-system-aarch64+0xc62857)
> >
> >   Previous read of size 8 at 0x7b4800113c28 by thread T3 (mutexes: write M81):
> >     #0 aio_bh_enqueue util/async.c:81:9 (qemu-system-aarch64+0xcd2267)
> >     #1 qemu_bh_schedule util/async.c:181:5 (qemu-system-aarch64+0xcd2267)
> >     #2 worker_thread util/thread-pool.c:113:9 (qemu-system-aarch64+0xcd473c)
> >     #3 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xcde280)
> >
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Fam Zheng <fam@euphon.net>
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  util/async.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
>
> Please explain why these warnings should be ignored in the commit
> description. I have been CCed on this patch, am unfamiliar with TSAN
> annotations, and now need to figure out:
> 1. Is ignoring the warning safe or should async.c be fixed somehow?
> 2. How do the annotation macros work and are they being used correectly?
>
> It's likely that people coming across this commit in the future would
> also benefit from information in the commit description that makes these
> things clear.
>
All good points.

I think we need to add a whole lot more details on TSan and its use
along with the use of the annotation macros among other things.
Will CC you on the updates to testing.rst, which will contain this
information.
This will hopefully provide the context, information and resources needed to
make the kinds of determinations we're looking for in 1. and 2.

As for the annotations, I think we are going to re-focus the patch and
remove the annotations for now.  However, we will plan to update
this commit description with more details on the changes to use atomic reads.

Thanks & Regards,
-Rob
> Thanks,
> Stefan

