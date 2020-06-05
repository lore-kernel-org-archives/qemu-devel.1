Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829ED2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN6owu5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829ED2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFA1-000841-N1
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jhF9I-0007Qp-S6; Fri, 05 Jun 2020 12:24:53 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jhF9H-0004DT-Vj; Fri, 05 Jun 2020 12:24:52 -0400
Received: by mail-ed1-x542.google.com with SMTP id c35so7940071edf.5;
 Fri, 05 Jun 2020 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IALAckFyq3HFVGOZWWV2ma1W2lw+akLCsk2z4st9pxs=;
 b=VN6owu5cmx+zWH0wEDKfuIUQLWECkD22fdMzqkvXqgorwcakdpb8MgYpsbOHVOg6FQ
 55mEWe7YJd2ND73WEai5SJP7JR/0d7+sTHAGueOPRAfwWk3ant3PRRb8Ir2AKdNJkVAW
 M46sRYaNwMbsXVuljXw3ihTO8eWVt9IZCNIo2LgxfZO6kgo5bGrkfQGnGbEAeZAq5rPR
 N+kyvY3HseSofZUPd6WJydWz/2Q1P71m9vTcPn6+fIf6hRhSkkgcrD/V2leBE/EwOHcK
 h3Y6p7/aOxiRpjg34C5EeUs3wh9zhPYA/3S/Pq6xspCSk1+M3A8YTJdFXtaJ5qx4fIb6
 iAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IALAckFyq3HFVGOZWWV2ma1W2lw+akLCsk2z4st9pxs=;
 b=Y4YqyG/DoFPsywHPzBNWaV9qN4rEeP+nhvWkN7muDfl2VZqfMqI+PFkjq6cIcPctWG
 iu4nVxQW0INdS3imWJWC2730Nhq7nyakTnaP1b5jb/S/60BAxj1uYLZljlnbR3nJDgQT
 kMUS1oY26VjEDMr9U4aISgAmQE+0ZWJdtzhbvSTxYmRcE6y+WE9EfgL/JPWq8Rylngln
 01JO+731Re4iRh16NUzXCf9l7Nk63sebZFg145dM6jRHMqTmruxk5y4xQlVINzTHFyLV
 mHNmbndbgrU+PUSJ7Ijnf+8QN/F/8+mkkY9dRN/DO9h6d+KEbPy7cKgVWmVyG/rH+ZXu
 7gXA==
X-Gm-Message-State: AOAM531wpslTfO6A7izUkKpiU71dTDmNKj3hcfeKFowOWf0hC2jMzTCZ
 qHWzKsbvcuXNdux6Khle9TQj0zy96egwdoVcXO8=
X-Google-Smtp-Source: ABdhPJy3f9igV439Q+pdX9A5jmh5oa8cQSyshI9Ej21blKxx4qvCUy1Fy4SmlGWgwzlwxIJLo6oqtcBQTfCYrJJkC64=
X-Received: by 2002:a05:6402:1750:: with SMTP id
 v16mr10399102edx.137.1591374289500; 
 Fri, 05 Jun 2020 09:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
 <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
 <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
 <ee2dcfe2-66f0-63f4-33a0-e5731e5d9d08@redhat.com>
 <CA+XhMqxsgsLVZDUTiXT8RPZ_K9B1sYitRSDNEWitSS7vV5uEWA@mail.gmail.com>
 <CAKBkRUxb6XiWhL7aHKDewXW+WUi5Q5wyKRYrcDuVtoo3_k0YwA@mail.gmail.com>
In-Reply-To: <CAKBkRUxb6XiWhL7aHKDewXW+WUi5Q5wyKRYrcDuVtoo3_k0YwA@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 5 Jun 2020 17:24:38 +0100
Message-ID: <CA+XhMqyPuZu-MM4V8bqNy2Ed-8gchRnZnAr=fhUjCY7SGVj-Jw@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD
 and NetBSD
To: Li-Wen Hsu <lwhsu@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 pbonzini@readhat.com, qemu-trivial@nongnu.org,
 Edward Tomasz Napierala <trasz@freebsd.org>,
 qemu-devel <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 bauerchen@tencent.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 5f0b74a75906a9a043ce4874e7f09dedcad7e6e7 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 5 Jun 2020 17:18:25 +0100
Subject: [PATCH] util/oslib: Returns real thread identifier on FreeBSD,
 OpenBSD and NetBSD

getpid is good enough in a mono thread context,
however thr_self/getthrid/_lwp_self reflects
the real current thread identifier.

Reviewed-By: Kamil Rytarowski <kamil@netbsd.org>
Reviewed-By: Edward Tomasz Napierala <trasz@FreeBSD.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..7864a7768c 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -48,11 +48,17 @@
 #ifdef __FreeBSD__
 #include <sys/sysctl.h>
 #include <sys/user.h>
+#include <sys/thr.h>
 #include <libutil.h>
 #endif

+#ifdef __OpenBSD__
+#include <unistd.h>
+#endif
+
 #ifdef __NetBSD__
 #include <sys/sysctl.h>
+#include <lwp.h>
 #endif

 #include "qemu/mmap-alloc.h"
@@ -84,6 +90,15 @@ int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
     return syscall(SYS_gettid);
+#elif defined(__FreeBSD__)
+    /* thread id is up to INT_MAX */
+    long tid;
+    thr_self(&tid);
+    return (int)tid;
+#elif defined(__OpenBSD__)
+    return getthrid();
+#elif defined(__NetBSD__)
+    return _lwp_self();
 #else
     return getpid();
 #endif
--=20
2.27.0

On Wed, 3 Jun 2020 at 16:07, Li-Wen Hsu <lwhsu@freebsd.org> wrote:
>
> Sorry that I am not familiar with this part so I asked others to help
> review (the FreeBSD related code).  It's good and please append:
>
> Reviewed-by: Edward Tomasz Napierala <trasz@FreeBSD.org>
>
> Thanks!
>
> On Wed, Jun 3, 2020 at 2:14 PM David CARLIER <devnexen@gmail.com> wrote:
> >
> > Sorry it landed in the spam.
> >
> > It does make things more accurate, thus a bit more than cosmetic, as
> > stated in the commit message, thr_self/_lwp_self represents the
> > current thread id in multi thread context.
> >
> > For OpenBSD it is syscall(SYS_getthrid) I believe
> > https://man.openbsd.org/getthrid.2
> >
> > On Wed, 3 Jun 2020 at 06:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
> > >
> > > ping?
> > >
> > > On 5/26/20 9:29 AM, David CARLIER wrote:
> > > > From 792fbcd9114f43bd80fd1ef5b25cd9935a536f9f Mon Sep 17 00:00:00 2=
001
> > > > From: David Carlier <devnexen@gmail.com>
> > > > Date: Tue, 26 May 2020 08:25:26 +0100
> > > > Subject: [PATCH] util/oslib: Returns the real thread identifier on =
FreeBSD and
> > > >  NetBSD
> > > >
> > > > getpid is good enough in a mono thread context, however
> > > >  thr_self/_lwp_self reflects the real current thread identifier
> > > >  from a given process.
> > > > ---
> > > >  util/oslib-posix.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > > index 062236a1ab..916f1be224 100644
> > > > --- a/util/oslib-posix.c
> > > > +++ b/util/oslib-posix.c
> > > > @@ -48,11 +48,13 @@
> > > >  #ifdef __FreeBSD__
> > > >  #include <sys/sysctl.h>
> > > >  #include <sys/user.h>
> > > > +#include <sys/thr.h>
> > > >  #include <libutil.h>
> > > >  #endif
> > > >
> > > >  #ifdef __NetBSD__
> > > >  #include <sys/sysctl.h>
> > > > +#include <lwp.h>
> > > >  #endif
> > > >
> > > >  #include "qemu/mmap-alloc.h"
> > > > @@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
> > > >  {
> > > >  #if defined(__linux__)
> > > >      return syscall(SYS_gettid);
> > > > +#elif defined(__FreeBSD__)
> > > > +    /* thread id is up to INT_MAX */
> > > > +    long tid;
> > > > +    thr_self(&tid);
> > > > +    return (int)tid;
> > > > +#elif defined(__NetBSD__)
> > > > +    return _lwp_self();
> > > >  #else
> > > >      return getpid();
> > > >  #endif
> > > >
> > >

