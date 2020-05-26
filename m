Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA3D2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVSnhq9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA3D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdU2E-0008GC-Ha
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdU1b-0007oe-Fg; Tue, 26 May 2020 03:29:23 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdU1a-0006Ar-Ed; Tue, 26 May 2020 03:29:23 -0400
Received: by mail-ed1-x542.google.com with SMTP id g9so16774917edw.10;
 Tue, 26 May 2020 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dR+EizNvfj9caOiPGhJAmpnFn4HgCsOvZzwglCD9HNw=;
 b=dVSnhq9msDkouNMoSoqwUZjkNd6X9d0+ItxiM4lHBle4tcfWre/DdJe4V3fH8/Tned
 K/0pFAtbeWuesq4gIBfRQuHiTuPrjPF+bx/2L9JBHAvj0Ye+zjJBrHcHFO7LVl7hvpB8
 oFwMxri1PzSLVA5RpwRagcusgjwkYLUZH64gLkxbJQ0oiUTO/751JfVfckad0jMbIU0a
 +fLFPGZ/evZLWLCekpNxrXSukiy+sc5KxpslNzOfeh55ZD3jANMMryfnLI0f3UIECdT9
 Qy6OwLYEzyhLPCdaG6HFtz/452JDBt3eBGI39Kw+QXgdpitxkWQrjgxRrnM0tMlPfGeZ
 LLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dR+EizNvfj9caOiPGhJAmpnFn4HgCsOvZzwglCD9HNw=;
 b=OSrkyj/NfkfIMmIdEzUFC398GCTpj8dn8TapF6yLL93Zkd1ew9gGVkc+l1db8flops
 UgdjbtZ9nwLijOqeEQc0xUCcCCkJQC4s4sUjc4v+2uJnBJe//qAvz3nHBKFpPV93KAhb
 qBSUlz4X3KYz4uAv6zqaCINUJJCUyr6/zUVYht8YSeYKq0a/Zgw7WJleqVMVLgolJONa
 4vy+NjJvMfwH+TYOKfHCZuODmbSam13hLesoSjxbA2dOqnzteckRB2VVciVSVMadjpqf
 63/fJy3a5JBZoUVbR87KAf0gA2fNAGcBTf4R8N3G7hk6d/HwpitdQbBqJFPgOVdOpW5M
 xWsg==
X-Gm-Message-State: AOAM533guXoxmDuhDeTEfYj1doE9yJVzmvFkAXPE9fMlHL2i+D4EnNPd
 M/2zKeKAnOgqdHTAuNjTbCNR6aDFTrmLFu/ZrMc=
X-Google-Smtp-Source: ABdhPJz+mLsFe26sLmYuyHYSu54BslNDu3uZ0K8WDMtDD5lRgl5d/0Kt5yUThGuTM+IJ+g488VOaWDa4dOEw2F8GtVI=
X-Received: by 2002:a05:6402:17e6:: with SMTP id
 t6mr1952122edy.243.1590478160100; 
 Tue, 26 May 2020 00:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
 <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
In-Reply-To: <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 26 May 2020 08:29:09 +0100
Message-ID: <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD
 and NetBSD
To: Thomas Huth <thuth@redhat.com>, pbonzini@readhat.com,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kamil Rytarowski <kamil@netbsd.org>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, bauerchen@tencent.com, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 792fbcd9114f43bd80fd1ef5b25cd9935a536f9f Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 08:25:26 +0100
Subject: [PATCH] util/oslib: Returns the real thread identifier on FreeBSD and
 NetBSD

getpid is good enough in a mono thread context, however
 thr_self/_lwp_self reflects the real current thread identifier
 from a given process.
---
 util/oslib-posix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..916f1be224 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -48,11 +48,13 @@
 #ifdef __FreeBSD__
 #include <sys/sysctl.h>
 #include <sys/user.h>
+#include <sys/thr.h>
 #include <libutil.h>
 #endif

 #ifdef __NetBSD__
 #include <sys/sysctl.h>
+#include <lwp.h>
 #endif

 #include "qemu/mmap-alloc.h"
@@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
     return syscall(SYS_gettid);
+#elif defined(__FreeBSD__)
+    /* thread id is up to INT_MAX */
+    long tid;
+    thr_self(&tid);
+    return (int)tid;
+#elif defined(__NetBSD__)
+    return _lwp_self();
 #else
     return getpid();
 #endif
-- 
2.27.0.rc0

On Tue, 26 May 2020 at 06:40, Thomas Huth <thuth@redhat.com> wrote:
>
> On 23/05/2020 09.23, David CARLIER wrote:
> > Hi this is my first contribution hope it s useful . Regards.
>
>  Hi!
>
> Thanks for your contribution. Some hints for getting your patch included:
>
> - Please make sure to CC: the corresponding maintainers, otherwise your
> patch might get lost in the high traffic of the mailing list. See the
> MAINTAINERS file for more information.
>
> - For simple patches like this one, it might also be helpful to CC:
> qemu-trivial@nongnu.org so that the patch could get picked up via the
> trivial queue
>
> > From ca7fcd85e0453f7173ce73732905463bc259ee32 Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Sat, 23 May 2020 08:17:51 +0100
> > Subject: [PATCH] util/oslib: returns real thread identifier on FreeBSD and
> >  NetBSD
>
> The body of the mail should only contain a proper patch description, not
> these head lines anymore, so that the patch can directly applied via
> "git am". Please also add a proper description, e.g. saying what's the
> effect of your patch. Is it just a cosmetic thing? Does it fix a real
> bug that you've hit?
>
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  util/oslib-posix.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 062236a1ab..4d28dfd8f5 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -48,11 +48,13 @@
> >  #ifdef __FreeBSD__
> >  #include <sys/sysctl.h>
> >  #include <sys/user.h>
> > +#include <sys/thr.h>
> >  #include <libutil.h>
> >  #endif
> >
> >  #ifdef __NetBSD__
> >  #include <sys/sysctl.h>
> > +#include <lwp.h>
> >  #endif
> >
> >  #include "qemu/mmap-alloc.h"
> > @@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
> >  {
> >  #if defined(__linux__)
> >      return syscall(SYS_gettid);
> > +#elif defined(__FreeBSD__)
> > +    // thread id is up to INT_MAX
>
> QEMU coding style only used /* ... */ comments, see the CODING_STYLE.rst
> file.
>
> > +    long tid;
> > +    thr_self(&tid);
> > +    return (int)tid;
> > +#elif defined(__NetBSD__)
> > +    return _lwp_self();
> >  #else
> >      return getpid();
> >  #endif
> >
>
>  HTH,
>   Thomas
>

