Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB0C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C71D207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anqlMZqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWNZ-0003Vp-8i
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioWMf-0002yP-5Y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioWMd-0003C0-Lw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:40:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioWMd-0003B0-Ep
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:40:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id p67so16425504oib.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+TGw75sCCKRUiB/o5W460m8kfpKxaUPp6wmPDiDqnzg=;
 b=anqlMZqnkbkBUKofl5nXyntBcM/+uo4/4C7e8Kc9zu/8/L7A5s1dEa4WvhOy0W3eK+
 rZY4zNrIF9DY7jpM50CP6FMUlYUsqzt6VBNJDj2Tyd8YPuftQzGcs2427j1w7BujPINn
 WFSAj2RxUPkRO/0ZPb+IBKVHTowGibkOR6OzNuALmWU3txBWb0fQsUGGpGZOgpF45rgP
 0nogSEkruhq8U3dKXbBmX7lQgVsOUyV5PeIshiYNOZFHnyQpPHM0wAgg9PhsxKtjEHvc
 TPgmb1TlEPzS4858TcTJyVEkGHFYOH680pMPE0mvc3G/3Hm/hG9Ti77UapUzR9eQEhcn
 8w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+TGw75sCCKRUiB/o5W460m8kfpKxaUPp6wmPDiDqnzg=;
 b=eKtRMCGeuf6DAUiKB4YORow5lXYjaEYYKMbbkGHowV84+0AeXL5JBuHQobcDNiqyxN
 8RP6O1FzWViAfDYD5oyr2ZO3t7L8KGPR+6RYQdZ0cD2Wjh5YZeGFspBPafCJAcqFKcQv
 ondeWe9Eo22AX0C2JOxxAuv/VAdboxrGeuK+PwvBsVCvToz136uO9HUDzGqOgpWfwTTZ
 o52xnu9gc8PdIBo+vbIRyvhFqcZP7tsewtmJTcKVrtYUxMzyEWITECphICQI0Rj3MjMd
 YkUEEJ/eOVeFDj2nEQ5IsGoqeDBkXKHOO2EqRW+dUnzq3gYd6SXmPHYwQIcHzynSVgBl
 Pr2A==
X-Gm-Message-State: APjAAAV5wDvFsjuC/rPQbVbMz4xOoX8q2a7DqIc6ZKZ7fEKK3ae6mGN+
 AXMK1dnZar7pRWWd5fCAzbKiLvT+dFWt7rlApzoguA==
X-Google-Smtp-Source: APXvYqwH9A+T3GqnYQETw6kUtgCHy4z5Sa1yHVImYm6IwCyZyWZwbxpFowPuHrgDBajRlORsqmS50p88r6v9puhkhh0=
X-Received: by 2002:aca:f484:: with SMTP id s126mr5603711oih.48.1578332426388; 
 Mon, 06 Jan 2020 09:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20200106144552.7205-1-peter.maydell@linaro.org>
 <20200106172808.GB219677@xz-x1>
In-Reply-To: <20200106172808.GB219677@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 17:40:15 +0000
Message-ID: <CAFEAcA89VHAyQKCeV6exxzDjLCEGUyg59um7w-VZ2K6s4ZV31g@mail.gmail.com>
Subject: Re: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 17:28, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jan 06, 2020 at 02:45:52PM +0000, Peter Maydell wrote:
> > On older versions of glib (anything prior to glib commit 0f056ebe
> > from May 2019), the implementation of g_source_ref() and
> > g_source_unref() is not threadsafe for a GSource which is not
> > attached to a GMainContext.
> >
> > QEMU's real iothread.c implementation always attaches its
> > iothread->ctx's GSource to a GMainContext created for that iothread,
> > so it is OK, but the simple test framework implementation in
> > tests/iothread.c was not doing this.  This was causing intermittent
> > assertion failures in the test-aio-multithread subtest
> > "/aio/multi/mutex/contended" test on the BSD hosts.  (It's unclear
> > why only BSD seems to have been affected -- perhaps a combination of
> > the specific glib version being used in the VMs and their happening
> > to run on a host with a lot of CPUs).
> >
> > Borrow the iothread_init_gcontext() from the real iothread.c
> > and add the corresponding cleanup code and the calls to
> > g_main_context_push/pop_thread_default() so we actually use
> > the GMainContext we create.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I've no idea on the g_source_ref() issue, but if so then a patch like
> this makes sense to me especially if it fixes up test failures.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Still a few comments below.

> > +static void iothread_init_gcontext(IOThread *iothread)
> > +{
> > +    GSource *source;
> > +
> > +    iothread->worker_context = g_main_context_new();
> > +    source = aio_get_g_source(iothread_get_aio_context(iothread));
> > +    g_source_attach(source, iothread->worker_context);
> > +    g_source_unref(source);
> > +    iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
>
> IIUC the main_loop is not required because in this case we only use
> the aio context to run rather than the main context itself.

Mmm. I wasn't sure to what extent glib expects the
GMainContext and GMainLoop to match up, so I was mostly
just copying from iothread.c.

> > +    /*
> > +     * g_main_context_push_thread_default() must be called before anything
> > +     * in this new thread uses glib.
> > +     */
> > +    g_main_context_push_thread_default(iothread->worker_context);
>
> IMHO if all the users of tests/iothread.c are block layers who only
> uses the aio context directly, then I think this is not needed too.

So we're OK to not do this because tests/iothread.c's
main loop doesn't call g_main_loop_run(), and it doesn't
provide an iothread_get_g_main_context() ?

I'm kind of inclined towards being lazy and sticking with
what this patch has, because:
 * it matches the real iothread.c, which reduces the possiblity
   of future surprise bugs due to things not matching up
 * it's already been reviewed
 * it saves me having to do a respin and retest

But if people would prefer these bits deleted I'll stop
being lazy :-)

thanks
-- PMM

