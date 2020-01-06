Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF6FC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A0020731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ou1icnTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A0020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUXB-0003sE-Ur
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioULm-00043a-HJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioULl-0004HF-Ac
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:31:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioULl-0004Fc-4Y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:31:25 -0500
Received: by mail-oi1-x243.google.com with SMTP id z64so9827999oia.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PSt786zdUr+RZhsCyf9cMWSNjSK1NSrxJJSQuMhHSrk=;
 b=ou1icnTeP8B1y+qcAeVqUWa6Sy+efIFjlCk8aWDdWclflqS5NoEHkcyM4avEykyg0N
 4U0PAIHkadwD0XJ0C68kKZxro/yUmapo/LtSwD2yF3UgyJGUUpvvPqJ2g39chqmINwja
 xS0PZ9hJru5P+1Nhsn3o36uZXlYZ0LFJNUlDuZnbgiCdHV9bGzDcCJdEgCPGW8JWjiGp
 DkEy/zQPoMisJI9bF5tcHPWTw8HMCXM+j8H3F2Znjy1O5V9LrpQeAZWM81pdG0kqQSRN
 wqjV2WrNX3kcP77v62Y7re88Z5kRXy5QMrOINOCT4TrxWyLT1/WG27O7Niq2mlyNvWGR
 5LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PSt786zdUr+RZhsCyf9cMWSNjSK1NSrxJJSQuMhHSrk=;
 b=PZyyihPLihuTtQ7RFrBnLwoqn54ra4AG+6WBQuYac1M2seLxztaClL5afaKaSzOXNb
 PYUVL4rpZhb864Sxw2ZZrpPXP7skbNuLvgRdso7vrLmUYSkb18a+PW2LS3kbuN+f5APv
 qnfXjyFB1Jat/sqYZjH5ZmjOG7fRAQVgPnM++bpg9m8I/+gS2Dmo/tiQ13YCPIGuVchu
 1PpCriZuYtSQbnqa98S/oi17Hv9jtsspNq5JG2jY6b5frGTGjSLw1fo20drzEhlt0xJ8
 Brj9ehiyEhR620kSTRXZCO3G1lPNKaNvcnQMHew1+ZyePJ9eJxUvAnrCCbqhLojHxD6d
 LsDg==
X-Gm-Message-State: APjAAAUhCwPKn9K1+Isa8NaCUD795RH+/LNkhtx+kV+IPR6vkG6ymxBo
 IFXYaigr8FEM3a/teQfOyv6eBU7DQcLwzNFE2DfMHA==
X-Google-Smtp-Source: APXvYqxVl73SBr6Fa9s27kaQkLGP/JyDV7CJct/dOP5ups20G/k4QCMk5l1DQqa94BhIML/f11czyvG6dK3AKHM5OmM=
X-Received: by 2002:aca:f484:: with SMTP id s126mr5253711oih.48.1578324683886; 
 Mon, 06 Jan 2020 07:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20200106144552.7205-1-peter.maydell@linaro.org>
 <CAJ+F1C+PcER4eQhJwwE6Q-xrfn4+rTr=z+otyg2O=ZQA+sD4FQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+PcER4eQhJwwE6Q-xrfn4+rTr=z+otyg2O=ZQA+sD4FQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 15:31:12 +0000
Message-ID: <CAFEAcA8-_vT3dX9aT5UZVmsnS3qkohZk8LrgTQRymsitAFNAZg@mail.gmail.com>
Subject: Re: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 15:22, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Jan 6, 2020 at 7:03 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >
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

> >  static void *iothread_run(void *opaque)
> >  {
> >      IOThread *iothread =3D opaque;
> > @@ -44,6 +57,20 @@ static void *iothread_run(void *opaque)
> >      my_iothread =3D iothread;
> >      qemu_mutex_lock(&iothread->init_done_lock);
> >      iothread->ctx =3D aio_context_new(&error_abort);
> > +
> > +    /*
> > +     * We must connect the ctx to a GMainContext, because in older ver=
sions
> > +     * of glib the g_source_ref()/unref() functions are not threadsafe
> > +     * on sources without a context.
> > +     */
> > +    iothread_init_gcontext(iothread);
> > +
> > +    /*
> > +     * g_main_context_push_thread_default() must be called before anyt=
hing
> > +     * in this new thread uses glib.
>
> in/if, I suppose

No; it means "before anything in this new thread specifically" as
opposed to "before anything in the whole process". (This comment is
verbatim copied from the main iothread.c, incidentally).

Thanks for the review.

-- PMM

