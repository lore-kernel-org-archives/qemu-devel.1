Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67FEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2792068D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDdAKy3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2792068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgMg4-0007Fi-M7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jgMfW-0006k2-8Q; Wed, 03 Jun 2020 02:14:30 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jgMfU-0002z5-BD; Wed, 03 Jun 2020 02:14:29 -0400
Received: by mail-ed1-x541.google.com with SMTP id s19so700741edt.12;
 Tue, 02 Jun 2020 23:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZvYhDCr9Ug/PqV3UdNwMtCoJhjjej1gQWp/1v5FGP9s=;
 b=CDdAKy3u1ZE5uUAz/nDc5Vv1vLwIk56tbnHY7upPIoDx0VwTkMCPDZdkGXKVqn0X/Y
 YsXbJotLQnTsYX/IPwxWxBR54ezvUgku4/QIjjWyKH0ym7cq6kxndArKYkyIpRYehciD
 alVDrRfTYgSsOkHOP47iX/OXpr2rhSI9X9wkXdMqeamx9ylUBOruG+tq8EQf3IVLZqBf
 VHgwF5FGsdn8lMtWVjQZQkde9XdDxgXS02uxmImbx9P+pGtRty2fbt+HFE6NBalfV+fm
 1aaFOkBIeTrHCiqgavmfevQn14ilHEoMXYflK3llyCE23Fnaw8PstCKoo/IeTTG7bLAP
 xzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZvYhDCr9Ug/PqV3UdNwMtCoJhjjej1gQWp/1v5FGP9s=;
 b=G2jZ28i5gj2AN67jmdvBlHqp6BqmXKoTl/UCD2aF2cD1mf7CD8qMi8CdeDtPjMFmB4
 BpK480GAQZerkJJkIWOscCIaFJnfUXZGMk5PKJhpwNaaI/dW/lFGXTkYsMRR4SpCV2h6
 bnBpWXtdzCZNyJDXqFzZ2/A0XhamEowfE1zEfTWWR6R9OcaZauN8dHxVWEU4tg+G/Qiy
 HYgyOo0QCHQDBqh9N6cR6jfI4gDOdatQlWZC4FRrTcWsKUF1+7cJAe4ECE6uPB/Y6CjN
 sA7+/0+XGLBt30UT778EdHKh2HscDgERKa4imwuTxAImvMn3ARDKGPUSxk8RBzV9P4tn
 xBYA==
X-Gm-Message-State: AOAM531kJ4OEJ9WrRYs2Gh5Gz/z3LgrHAAsnaGz1wq5LOuw0BD4Lq5SV
 0EstqSMrvVRE45xO7gtLyQw4G7LYfwn7IUIKmR4=
X-Google-Smtp-Source: ABdhPJwd4bPYGdv7uIlo/oObkUPRC00HzKtMZuQYBFEd5gkhTleV7Ozgf9QfyXKaYgw+kY4+zmTJ6K2K5QX9vYNfYhY=
X-Received: by 2002:a05:6402:52:: with SMTP id
 f18mr30145348edu.7.1591164866566; 
 Tue, 02 Jun 2020 23:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
 <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
 <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
 <ee2dcfe2-66f0-63f4-33a0-e5731e5d9d08@redhat.com>
In-Reply-To: <ee2dcfe2-66f0-63f4-33a0-e5731e5d9d08@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 3 Jun 2020 07:14:15 +0100
Message-ID: <CA+XhMqxsgsLVZDUTiXT8RPZ_K9B1sYitRSDNEWitSS7vV5uEWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD
 and NetBSD
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x541.google.com
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
 pbonzini@readhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, bauerchen@tencent.com,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry it landed in the spam.

It does make things more accurate, thus a bit more than cosmetic, as
stated in the commit message, thr_self/_lwp_self represents the
current thread id in multi thread context.

For OpenBSD it is syscall(SYS_getthrid) I believe
https://man.openbsd.org/getthrid.2

On Wed, 3 Jun 2020 at 06:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> ping?
>
> On 5/26/20 9:29 AM, David CARLIER wrote:
> > From 792fbcd9114f43bd80fd1ef5b25cd9935a536f9f Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Tue, 26 May 2020 08:25:26 +0100
> > Subject: [PATCH] util/oslib: Returns the real thread identifier on Free=
BSD and
> >  NetBSD
> >
> > getpid is good enough in a mono thread context, however
> >  thr_self/_lwp_self reflects the real current thread identifier
> >  from a given process.
> > ---
> >  util/oslib-posix.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 062236a1ab..916f1be224 100644
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
> > +    /* thread id is up to INT_MAX */
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

