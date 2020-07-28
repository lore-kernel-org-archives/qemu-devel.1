Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C9AC433F8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2830206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4rRI+QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2830206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RUK-0003cl-71
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0RTi-000365-Ln
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:25:18 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:34258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0RTg-00020N-RL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:25:18 -0400
Received: by mail-oo1-xc41.google.com with SMTP id k63so1043413oob.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=puUEZluVTYddP3iAs7PLgPzAU7pxv47sI3hjBMoxUv8=;
 b=J4rRI+QMf76qHd3H6GI+kt2upGMAvBMVJdXWU8LUx+qeFbLD2PkbguMQBvPgyMrEqw
 9PsY5/z7NlpI1VHJ2BGuCCMSFehCuLyYycghpU4XYehXr1mGwpJLU3sD9PsvVqntCiqi
 fhnlxeqUiTc3M5ngKabaD/TnocsjVyRbFecWDYK9B6T9Zo9gRHGenq8uQINPUdgRdCf9
 QmisLKOPplx/oBAunhDOOwKWGtc+3HGBGmTzeLPFQ80tPolyP9KqvuLMqhzdciEs7+cL
 gnyAHN2JUWwDy5JpiPHg0ZwayYOZrwN2/9a320KrNQL6yfRJJsheuDB0wMlQif9mVdME
 KY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=puUEZluVTYddP3iAs7PLgPzAU7pxv47sI3hjBMoxUv8=;
 b=e57iVeAC9IjGFUKPQptaRZWQj539+ljYHE7ItAdMr4kN4F95jVAut4qL1T+Z9N0p3Y
 tAfil3LfTqzhmVvp2LiXkzpYIvCJvFXDn1LwUjLKNa5RAaKJ+cA0h2L5VspInGkHtHDP
 5nIgO42NWRb3JdZvOeOm4SQdfWllxNhWghqPe0097JGaM5B7nwZ0o3eEox+aDlNNiSIJ
 NAWWQOMUrC2fEwHhL6+Yq6YZnLGdzwl5oSVz7fxAYHmJj3GKXzov+sWEu16V/RmuixvE
 1u4/v2P/jf/rVA52YQe730gEyrxnMuo50MhqYFDtvYA67RyTMql1O0pkAQh0D845Ujwe
 k+pg==
X-Gm-Message-State: AOAM530R/kTdfbYMZCS3rbsym0CUA6RVSZzkNoNNdqH6dgFZZX+KYTHV
 E+lXI5pki53CHSvY7XFDrp/QmdkBOw2RKHHib6CQSg==
X-Google-Smtp-Source: ABdhPJxYWgWJXeffKQqCgsclnAvhnZJrJ9o0j8ZncEfUgq+jOHU/rhvrJgmx1bUFusDffTUA3ACHFNhsOt9sQYshYbo=
X-Received: by 2002:a4a:4949:: with SMTP id z70mr22371460ooa.85.1595949915447; 
 Tue, 28 Jul 2020 08:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
In-Reply-To: <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 16:25:04 +0100
Message-ID: <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 16:17, Eric Blake <eblake@redhat.com> wrote:
>
> On 7/16/20 10:41 AM, Peter Maydell wrote:
> > Add a documentation comment for qemu_get_thread_id(): since this
> > is rather host-OS-specific it's useful if people writing the
> > implementation and people thinking of using the function know
> > what the purpose and limitations are.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Based on conversation with Dan on IRC, and prompted by the recent
> > patch to add OpenBSD support.
> >
> > Q: should we document exactly what the thread-id value is for
> > each host platform in the QMP documentation ? Somebody writing
> > a management layer app should ideally not have to grovel through
> > the application to figure out what they should do with the
> > integer value they get back from query-cpus...
> >
> >   include/qemu/osdep.h | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
>
> Do we need a counterpart change...
>
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 4841b5c6b5f..8279f72e5ed 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -515,6 +515,20 @@ bool qemu_has_ofd_lock(void);
> >
> >   bool qemu_write_pidfile(const char *pidfile, Error **errp);
> >
> > +/**
> > + * qemu_get_thread_id: Return OS-specific ID of current thread
> > + *
> > + * This function returns an OS-specific identifier of the
> > + * current thread. This will be used for the "thread-id" field in
> > + * the response to the QMP query-cpus and query-iothreads commands.
>
> ...to the qapi definition of query-cpus and query-iothreads?

Well, that was my question above. Currently the QAPI documentation
says absolutely nothing about what the thread-id values mean
for any host OS (beyond "ID of the underlying host thread"), which
means that any management layer application needs to look in the
implementation to find out what they actually are...

Improving the QAPI docs would probably be something like:
 * add a list of host OSes and semantics to the doc comment
   for CpuInfoFast
 * add cross-references to that definition from everywhere
   else in QAPI that uses a thread-id/thread_id
 * add a comment in the C file to say "if you're adding another
   OS ifdef here please update the QAPI doc comment"

thanks
-- PMM

