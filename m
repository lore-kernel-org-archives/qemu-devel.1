Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A29A20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6W8Lvr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A29A20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B5A-0005wc-Mr
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1Ari-00038f-OM
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:53:07 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1Are-0004cg-UX
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:53:06 -0400
Received: by mail-oi1-x242.google.com with SMTP id u24so14246463oiv.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+IMqDkH3Yx+rnYKl9GUMAPJpANuQ/vc8DzNV0oiunpA=;
 b=y6W8Lvr2JetNvz5HQsgEpqon74FE+Uj97qKt+bvRl5x105BUqxy+f+B8WHtx9Xvgp9
 5PKZY80sESt7oAIwPoHQR+x4H8hln6IS47jQiDgDK6e7ZBs599I9ccs+HwF++8VORxrg
 KXIIJ73IA427ICJGY0BEoQcZQAqmgSDlp4nA0Mich3dhz1EFeqlP6GWJYho2NP0xyghQ
 /ErJHApPFRUtP/HQ88e9ELqopTEA1Pn4+hKqK2VPXs0ttUMfhJGgGzEenGHRHU1N5KhC
 MPpeh0p1p+u3sRUzdy0/ax+830KLb5Vcv4J+p75wrcSbi6PNKR8I6k4f/Ckf3x6QIXCK
 nr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+IMqDkH3Yx+rnYKl9GUMAPJpANuQ/vc8DzNV0oiunpA=;
 b=LLCAucc2mLHej3FWpPtXGLEzgMMkjFABcthZp21eHVc5rplx+rZ/JgYHloo1EqgUkd
 z16CNEm14eeJf1G27PHgRY+37IOlzMcJehNwBr5P5oTDqGKrMMaid6fsOWDA351Q0F4Z
 YAofu9DBptRJCRAJycjQHDW4kEtYmXo83pbqdrbxZcXm/wJq9UijOGQIzUowRxGAZCTv
 6jO4Ug153EkWwOO/7vuRz2pwQhs4EkqEi2M90WhN9UEeiyRkv7nG8NB6WDREdPCz6Bs5
 R0tDORwEbFHiPVzK3KGQs9nUzuQd1aavaCY9PrFA/XcklDjjhUsDcIL2RizA8E0rjPRt
 56tA==
X-Gm-Message-State: AOAM530TH9s3pzLCnsGfm+fcBDx7+ttqKpZVJBYxXdpEY6HnYLzDle24
 FYrVcEr1SDh8zSH3/MEl7zonnwNzb88fi17FcToxaA==
X-Google-Smtp-Source: ABdhPJyXRzF2I+Ws0AWNK+Ok5vxMrH7xi3vhFQsySKA1MNuQTOhD4sxOfKp9BfmSDcXq2hOtiNe1J8xmD5Iusfo0dTY=
X-Received: by 2002:aca:48d8:: with SMTP id v207mr5068681oia.48.1596124380496; 
 Thu, 30 Jul 2020 08:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 <87k0ylvy0t.fsf@dusky.pond.sub.org>
In-Reply-To: <87k0ylvy0t.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 16:52:49 +0100
Message-ID: <CAFEAcA-AYJ64HE698TMRS6cV=u4ig6S6TU2xufns7fCVbcQXrg@mail.gmail.com>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 16:11, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 28 Jul 2020 at 16:17, Eric Blake <eblake@redhat.com> wrote:
> >>
> >> On 7/16/20 10:41 AM, Peter Maydell wrote:
> >> > Add a documentation comment for qemu_get_thread_id(): since this
> >> > is rather host-OS-specific it's useful if people writing the
> >> > implementation and people thinking of using the function know
> >> > what the purpose and limitations are.
> >> >
> >> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> > ---
> >> > Based on conversation with Dan on IRC, and prompted by the recent
> >> > patch to add OpenBSD support.
> >> >
> >> > Q: should we document exactly what the thread-id value is for
> >> > each host platform in the QMP documentation ? Somebody writing
> >> > a management layer app should ideally not have to grovel through
> >> > the application to figure out what they should do with the
> >> > integer value they get back from query-cpus...
> >> >
> >> >   include/qemu/osdep.h | 14 ++++++++++++++
> >> >   1 file changed, 14 insertions(+)
> >>
> >> Do we need a counterpart change...
> >>
> >> >
> >> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> >> > index 4841b5c6b5f..8279f72e5ed 100644
> >> > --- a/include/qemu/osdep.h
> >> > +++ b/include/qemu/osdep.h
> >> > @@ -515,6 +515,20 @@ bool qemu_has_ofd_lock(void);
> >> >
> >> >   bool qemu_write_pidfile(const char *pidfile, Error **errp);
> >> >
> >> > +/**
> >> > + * qemu_get_thread_id: Return OS-specific ID of current thread
> >> > + *
> >> > + * This function returns an OS-specific identifier of the
> >> > + * current thread. This will be used for the "thread-id" field in
> >> > + * the response to the QMP query-cpus and query-iothreads commands.
> >>
> >> ...to the qapi definition of query-cpus and query-iothreads?
> >
> > Well, that was my question above. Currently the QAPI documentation
> > says absolutely nothing about what the thread-id values mean
> > for any host OS (beyond "ID of the underlying host thread"), which
> > means that any management layer application needs to look in the
> > implementation to find out what they actually are...
>
> ... which they will have to do to actually use it for the purpose we
> have in mind, namely:
>
> >> > + * The intention is that a VM management layer application can then
> >> > + * use it to tie specific QEMU vCPU and IO threads to specific host
> >> > + * CPUs using whatever the host OS's CPU affinity setting API is.
> >> > + * New implementations of this function for new host OSes should
> >> > + * return the most sensible integer ID that works for that purpose.
> >> > + *
> >> > + * This function should not be used for anything else inside QEMU.
> >> > + */
>
> Do they?

Well, I suspect that management-layer code currently has
gone for "assume we're always running on Linux" and was
written by people who knew they were getting a Linux tid...

> The PID is quite unlikely to be "an OS-specific identifier of the
> current thread".  Shouldn't we fail instead of lie when we don't know
> how to compute the truth?

Yeah, I think the default codepath is pretty bogus too. Should
the QMP functions have a mechanism for saying "we don't know
a thread-id on this platform" ?

thanks
-- PMM

