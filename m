Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F7C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0D620675
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0D620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHmvS-0004KH-Si
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 06:08:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hHmrm-000119-FZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hHmdG-0005HP-Qj
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:50:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hHmdG-0005GV-M6
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:50:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so2646097ywd.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 02:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=uPZMuDMlGaCp2rapKSCjbRyYcNHndAfiGIXs+jwZ4Vg=;
	b=lpe2cNjkR4rAUNSsGLxJtqvRe0S7IHX+kY/qgpGVTAMprX1SPbXpLd5SgKtRwEU38d
	V+Ixwk4JO3e5GUT7uWsrGj0p4kEWlKEg9LF6n6Jk1WnHQ+eUcVoJFD+c4OOVKIevLDfM
	higIcQtG1OeClj1QIckUxZW1ZE2+GLs+r5ItVv8+vl7TwyWtzT2I+MlPeQQPMI5z98Qe
	FcZ0CWLdE3d/5v/B2nAa2rjjZ1wYhLG331Y04juKZ0dC02SMnzLMwlKRDJFszkTtKODE
	ETISln851uNARtZ68Tv746wxSpJusLnkQMDeMiE4d2qsari0vZKe3i3NG/EOvI1H/N9t
	TDlA==
X-Gm-Message-State: APjAAAXuJRqAMzjE4+nkTCmgKa9TksosRMgonfc+n3yF5zvD8nbKqqNS
	W5juFU/BSwUbnCGhs31mJJYVPt2V1iIqlnmap54=
X-Google-Smtp-Source: APXvYqwDRgjT5X0NEudKMnJlFCkuPTy6RwevvI7fcvRf7ghPW6oKTZBd/XWB/boGqXcJSBpsoJfGlkiL7jwxm+u6T+Y=
X-Received: by 2002:a81:a312:: with SMTP id a18mr6849770ywh.370.1555753801018; 
	Sat, 20 Apr 2019 02:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190419103722.17062-1-shahab.vahedi@gmail.com>
	<871s1xha0f.fsf@zen.linaroharston>
In-Reply-To: <871s1xha0f.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 20 Apr 2019 11:49:48 +0200
Message-ID:
 <CAAdtpL5yj3dDoxQ+_V32MDPE3bYa15wGHKSBOEgGdDSujPxgxw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.161.68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420094948.LhCJNqmOIbQr-fxavHmLB3h2cqVrteVH7ICEcEBhsWg@z>

Hi Alex,

Le sam. 20 avr. 2019 01:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> a =C3=
=A9crit :

>
> Shahab Vahedi <shahab.vahedi@gmail.com> writes:
>
> > This change adapts io_readx() to its input access_type. Currently
> > io_readx() treats any memory access as a read, although it has an
> > input argument "MMUAccessType access_type". This results in:
> >
> > 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> > 2) Considering only entry->addr_read as the tlb_addr
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
>
> This bug talks about the distinction between DATA_LOAD and INST_FETCH
> but...
>
> >
> > Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> > ---
> >  accel/tcg/cputlb.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 88cc8389e9..0daac0e806 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env,
> CPUIOTLBEntry *iotlbentry,
> >          CPUTLBEntry *entry;
> >          target_ulong tlb_addr;
> >
> > -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> > +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
> >
> >          entry =3D tlb_entry(env, mmu_idx, addr);
> > -        tlb_addr =3D entry->addr_read;
> > +        tlb_addr =3D
> > +            (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  :
> > +            (access_type =3D=3D MMU_DATA_STORE) ? entry->addr_write :
> > +            entry->addr_code;
>
> ...why do we care here about MMU_DATA_STORE?
>
> We could just assert (access_type =3D=3D MMU_DATA_LOAD || access_type =3D=
=3D
> MMU_INST_FETCH) and then have:
>

Is asserting the best we can do here?


>   (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  : entry->addr_c=
ode
>
>
> >          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
> >              /* RAM access */
> >              uintptr_t haddr =3D addr + entry->addend;
>
>
> --
> Alex Benn=C3=A9e
>
>
