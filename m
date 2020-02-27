Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62447C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAAD24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPF2ZPdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAAD24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Itz-0003s2-BJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j7ItM-0003So-7e
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j7ItK-0000X9-OR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:07:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j7ItK-0000Wr-I5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:07:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id j7so3205221wrp.13
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IEHCLjENEyCVQC+RrGMaazdbswLCiSmYrZRSvmrRl2k=;
 b=EPF2ZPdVgQlI/gC5Nj5e7To2VXn4ttFI4Om/W8wwPd8zVdRVLKJAeVkbnqJtl1JR6u
 OtkF34YlfrJrOl30o/KZZOaQOQmoye4LXH9ZgCarWbvPXAQ+VtoTSAybAZAKT9johRMj
 XBA9FdKPga3kBq+Wa0StSR0wXe77pbXiaY06wiVX1zGA3EZX5FyockjTxum+48SgrpEr
 89EOzhGbPGrwG4GKtdxVovo+08aPkHZ+kK5yzTA8lVqkb3Dw5WwfqV59i81d4kyiCWlB
 lQO7QJTYyHSwjfT6XYm4DOaqwvDSn+Pf6wLhsEP75x2lZ/68TjxBeKEcu/PEJCDMuokJ
 LvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IEHCLjENEyCVQC+RrGMaazdbswLCiSmYrZRSvmrRl2k=;
 b=r4GAfs3r5C9r0dnLHi8AGpughslBC50z9jk4+Td0vrVtF8o3CUnaEAsF93aJLpI0RF
 XOAQNuzVPP+VkRNBFmflyJfBL2xhdj+VO3Mj6sCwECYCB8ItqYHpAHPbi65zyyzuNWlt
 TRbng1spwUnLE8G7gu+MWFQJuSvDxvs14iTzl68FsMm2QM3uIq2zRBaAesPAzEBlZ0SH
 BTkOj9QexurvSgtvv6PQUlof1AlikPhuu2KIME76UcHHuH6XuaJ/4WCITRYvwO2b6x3v
 I/WhOojbvMGxlvzrJOtuIDcoR+r2M+w8eS8CrYdOsSa9/6Rcj5S5/TxI22Kx/B6Pi7is
 9H6g==
X-Gm-Message-State: APjAAAUfj/DEYyhMwGQTUSbYkCcw9PTqhl7C/6hz9chXxKttY79WEmy8
 2XrAw+3qiVZmXpm4q9N4KBMNOjwcew6uDlXLjYk=
X-Google-Smtp-Source: APXvYqw+GWzFT9ftuMqx+H0RXo9vzACuHG9HJpHXMI7p8lQOo7TGTb+PHdJF2cnzFFOV0o0yrFGdLNHqNzP6BWYg+0k=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr4788325wrj.196.1582808869175; 
 Thu, 27 Feb 2020 05:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200219163815.GD1085125@stefanha-x1.localdomain>
 <CAJAkqrXaqmT2pR4K1x06AeQZHvUWp-fcqnbKZq_45czO96v5PA@mail.gmail.com>
 <20200227074114.GB83512@stefanha-x1.localdomain>
 <CAJAkqrWUJWLdT+6b_XmHFwnzhhbYei2SakCKVW0Rf92HJgoZDw@mail.gmail.com>
 <20200227100206.GA7493@linux.fritz.box>
 <CAJAkqrW_Euur3HjWaK6E-TAjT1dmjA1fz1oPwKSt7_pOC3=S+w@mail.gmail.com>
 <20200227105528.GC7493@linux.fritz.box>
 <CAMxuvay1vLosHTpXP7b3pXQvfRPOMp0z3ML66khLSrK-iLf7aQ@mail.gmail.com>
 <20200227111958.GD7493@linux.fritz.box> <20200227113814.GI1645630@redhat.com>
In-Reply-To: <20200227113814.GI1645630@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Feb 2020 14:07:37 +0100
Message-ID: <CAJ+F1CLNu9Q8e8sEU+6_LMHySraAJA+QkcPStfjjGacu4YK3=Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>, bharatlkmlkvm@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Feb 27, 2020 at 12:39 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Thu, Feb 27, 2020 at 12:19:58PM +0100, Kevin Wolf wrote:
> > Am 27.02.2020 um 12:07 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > > On Thu, Feb 27, 2020 at 11:55 AM Kevin Wolf <kwolf@redhat.com> wrote:
> > > > Am 27.02.2020 um 11:28 hat Coiby Xu geschrieben:
> > > > > > > we still need customized vu_message_read because libvhost-use=
r assumes
> > > > > > > we will always get a full-size VhostUserMsg and hasn't taken =
care of
> > > > > > > this short read case. I will improve libvhost-user's vu_messa=
ge_read
> > > > > > > by making it keep reading from socket util getting enough byt=
es. I
> > > > > > > assume short read is a rare case thus introduced performance =
penalty
> > > > > > > would be negligible.
> > > > >
> > > > > > In any case, please make sure that we use the QIOChannel functi=
ons
> > > > > > called from a coroutine in QEMU so that it will never block, bu=
t the
> > > > > > coroutine can just yield while it's waiting for more bytes.
> > > > >
> > > > > But if I am not wrong, libvhost-user is supposed to be indepdent =
from
> > > > > the main QEMU code. So it can't use the QIOChannel functions if w=
e
> > > > > simply modify exiting vu_message_read to address the short read i=
ssue.
> > > > > In v3 & v4, I extended libvhost-user to allow vu_message_read to =
be
> > > > > replaced by one which will depend on the main QEMU code. I'm not =
sure
> > > > > which way is better.
> > > >
> > > > The way your latest patches have it, with a separate read function,
> > > > works for me.
> > >
> > > Done right, I am not against it, fwiw
> > >
> > > > You could probably change libvhost-user to reimplement the same
> > > > functionality, and it might be an improvement for other users of th=
e
> > > > library, but it's also code duplication and doesn't provide more va=
lue
> > > > in the context of the vhost-user export in QEMU.
> > > >
> > > > The point that's really important to me is just that we never block=
 when
> > > > we run inside QEMU because that would actually stall the guest. Thi=
s
> > > > means busy waiting in a tight loop until read() returns enough byte=
s is
> > > > not acceptable in QEMU.
> > >
> > > In the context of vhost-user, local unix sockets with short messages
> > > (do we have >1k messages?), I am not sure if this is really a problem=
.
> >
> > I'm not sure how much of a problem it is in practice, and whether we
> > can consider the vhost-user client trusted. But using QIOChannel from
> > within a coroutine just avoids the problem completely, so it feels like
> > a natural choice to just do that.
>
> It isn't clear to me that we have a consitent plan for how we intend
> libvhost-user to develop & what it is permitted to use.  What information
> I see in the source code and in this thread are contradictory.
>
> For example, in the text quoted above:
>
>   "libvhost-user is supposed to be indepdent from the main QEMU code."
>
> which did match my overall understanding too. At the top of libvhost-user=
.c
> there is a comment
>
>    /* this code avoids GLib dependency */
>
> but a few lines later it does
>
>   #include "qemu/atomic.h"
>   #include "qemu/osdep.h"
>   #include "qemu/memfd.h"
>
> and in the Makefile we link it to much of QEMU util code:
>
>   libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>
> this in turn pulls in GLib code, and looking at symbols we can see
> over 100 GLib functions used:
>
>   $ nm ./libvhost-user.a | grep 'U g_' | sort | uniq | wc -l
>   128
>
> And over 200 QEMU source object files included:
>
>   $ nm ./libvhost-user.a | grep '.o:' | sort | wc -l
>   224
>
> So unless I'm missing something, we have lost any independance from
> both QEMU and GLib code that we might have had in the past.

Yep, I think this is mostly due to commit 5f9ff1eff38 ("libvhost-user:
Support tracking inflight I/O in shared memory")

It may not be that hard to bring back glib independence. Is it worth it tho=
ugh?

>
> Note this also has licensing implications, as I expect this means that
> via the QEMU source objects it pulls in, libvhost-user.a has become
> a GPLv2-only combined work, not a GPLv2-or-later combined work.
>

libvhost-user.c is GPLv2-or-later because tests/vhost-user-bridge.c
was and is still as well. Do we need to change that?

> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

