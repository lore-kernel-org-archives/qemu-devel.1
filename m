Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B1CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB59206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB59206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUzs-0006Ik-Pa
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jgUzA-0005rZ-5C; Wed, 03 Jun 2020 11:07:20 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jgUz9-00040G-60; Wed, 03 Jun 2020 11:07:19 -0400
Received: by mail-yb1-f193.google.com with SMTP id t9so1223392ybk.9;
 Wed, 03 Jun 2020 08:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7vWzCbFglf0Oi/JAGYSC2AnpnieDi1YvoLX8KMxU9Lc=;
 b=oBk/M8JC7Q/J3hDoOSBnPq8hzS4NiXSg/rQS94vnld9YcBdZ1ntrvFkJk5jbG0tP4v
 sgsYwB+kmWR7/Hu+isd1mkLHw7UTRHPnci7aNHI2kz0hBgNrlT50EcwoGNsRz+56xVg6
 VpnIi8e/Gkwef2BuHOfzPLb+xOXbPlzIfEhTV0ik1oQawgvQo7xExdR6Bpq2rwQLzUnU
 yYO26dJv3m92299tTLMzgutZBHJ43FhDdJMddi6fb3ckfF2mYhaB6HLWGmatUJorO/UM
 V/JTRcRnZMWRZ4CZHowy0iF/MGMEi+NXuVPjbr2B9ZT4aN51Fw7q6JwyNEwYItyziHBX
 KiNQ==
X-Gm-Message-State: AOAM533dB6A4s8XlbJWgVQRFQipsq6pK2ozR+Ot5gJbAE/9HnYofQsqp
 KFK/jdhobin5powX+XMvyphTX8my7tGualhpe8s=
X-Google-Smtp-Source: ABdhPJx3kYYFFi+6wtyMG6oXz6cm2oy4eyHSyEUoTF2mPPaEpbiw3TqZt02RyfUHmbI6Ezv/v0ETidhLBhrxIqZY1BQ=
X-Received: by 2002:a25:6b4a:: with SMTP id o10mr470873ybm.405.1591196837170; 
 Wed, 03 Jun 2020 08:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
 <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
 <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
 <ee2dcfe2-66f0-63f4-33a0-e5731e5d9d08@redhat.com>
 <CA+XhMqxsgsLVZDUTiXT8RPZ_K9B1sYitRSDNEWitSS7vV5uEWA@mail.gmail.com>
In-Reply-To: <CA+XhMqxsgsLVZDUTiXT8RPZ_K9B1sYitRSDNEWitSS7vV5uEWA@mail.gmail.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Wed, 3 Jun 2020 23:07:05 +0800
Message-ID: <CAKBkRUxb6XiWhL7aHKDewXW+WUi5Q5wyKRYrcDuVtoo3_k0YwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD
 and NetBSD
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.193;
 envelope-from=lwhsu.freebsd@gmail.com; helo=mail-yb1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 11:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 pbonzini@readhat.com, qemu-trivial@nongnu.org,
 Edward Tomasz Napierala <trasz@freebsd.org>,
 qemu-devel <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 bauerchen@tencent.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry that I am not familiar with this part so I asked others to help
review (the FreeBSD related code).  It's good and please append:

Reviewed-by: Edward Tomasz Napierala <trasz@FreeBSD.org>

Thanks!

On Wed, Jun 3, 2020 at 2:14 PM David CARLIER <devnexen@gmail.com> wrote:
>
> Sorry it landed in the spam.
>
> It does make things more accurate, thus a bit more than cosmetic, as
> stated in the commit message, thr_self/_lwp_self represents the
> current thread id in multi thread context.
>
> For OpenBSD it is syscall(SYS_getthrid) I believe
> https://man.openbsd.org/getthrid.2
>
> On Wed, 3 Jun 2020 at 06:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> >
> > ping?
> >
> > On 5/26/20 9:29 AM, David CARLIER wrote:
> > > From 792fbcd9114f43bd80fd1ef5b25cd9935a536f9f Mon Sep 17 00:00:00 200=
1
> > > From: David Carlier <devnexen@gmail.com>
> > > Date: Tue, 26 May 2020 08:25:26 +0100
> > > Subject: [PATCH] util/oslib: Returns the real thread identifier on Fr=
eeBSD and
> > >  NetBSD
> > >
> > > getpid is good enough in a mono thread context, however
> > >  thr_self/_lwp_self reflects the real current thread identifier
> > >  from a given process.
> > > ---
> > >  util/oslib-posix.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index 062236a1ab..916f1be224 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -48,11 +48,13 @@
> > >  #ifdef __FreeBSD__
> > >  #include <sys/sysctl.h>
> > >  #include <sys/user.h>
> > > +#include <sys/thr.h>
> > >  #include <libutil.h>
> > >  #endif
> > >
> > >  #ifdef __NetBSD__
> > >  #include <sys/sysctl.h>
> > > +#include <lwp.h>
> > >  #endif
> > >
> > >  #include "qemu/mmap-alloc.h"
> > > @@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
> > >  {
> > >  #if defined(__linux__)
> > >      return syscall(SYS_gettid);
> > > +#elif defined(__FreeBSD__)
> > > +    /* thread id is up to INT_MAX */
> > > +    long tid;
> > > +    thr_self(&tid);
> > > +    return (int)tid;
> > > +#elif defined(__NetBSD__)
> > > +    return _lwp_self();
> > >  #else
> > >      return getpid();
> > >  #endif
> > >
> >

