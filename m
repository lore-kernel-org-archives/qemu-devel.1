Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92F5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831AE20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyx1BKFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831AE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6O2-0002Ql-Gc
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iO6CW-0002Cm-Ai
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iO6CV-0004GW-0W
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:28:48 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iO6CS-0004F2-5u; Fri, 25 Oct 2019 16:28:44 -0400
Received: by mail-lj1-x242.google.com with SMTP id c4so4182083lja.11;
 Fri, 25 Oct 2019 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=74txzN/hJtYpBLyMGLJtucp74h4g7fv6LlmMqvR82HU=;
 b=Dyx1BKFLqMWOPsmFgvc0oL730/qEHropt/mxB9txmLeOdXeGPeWnmO0kUH+l7gDWlZ
 lOfHOlZoQclGXuVfbx+9rh0jYeiTdPcMZfQfp5Guo42BYk3j1xUYgJWVaD+8fMTHmKNQ
 rtmQnCfVUBAmtCD+xDvt/q5vMzP9QRaXlnzhdvQ1TYrzcjM1ex33SBBHKobEshFfI3XF
 f2+YW/nQFqUlI4xKQYnnmr/QAtWlpIEdr1yya7XX2IDIDqqn0/+1FbkuZ8Ul+WRjTJBk
 mzMQwP57VJMcYm12CVA2FuyoKPsoSSHWcd2pnoLKHpeHhCAifuprcaXNK/vOqizSB6+3
 2eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=74txzN/hJtYpBLyMGLJtucp74h4g7fv6LlmMqvR82HU=;
 b=I1J71UHtoLZBZzzIS50mOSTykno5oCOVyCatX8IUdanjC7HVLkG7cHbibaEV+5DmtK
 Zg9X1UFRWMUtJpqzL9qXd9y3kj3VrfAhLyfKXzxETUz+Qqgg3iAS18GJdC2chk9bqmRa
 LRw+ak+cudVvkgDiTyYuYgdeNvpa04ams2NlJgkmypmwh+k9kDV7TeEJJ6OehPd9M1AJ
 UyTlOzMyOFtjukciG/yMAja8b6eQ2GM1xNHlj8C4jCdiCJBv33d12yLi+HKXNewho0sv
 OXICilrxi8esG3CH1VJGGWlwH/OJNxJ1PGNC6X04Woo/VavoNxrRsvGV6m8yrQyECq1a
 eRhg==
X-Gm-Message-State: APjAAAW2IlMFRguGVH888JwTBUdF3Fn6iZ0GrzJZ/vIUGeT9VBmCONjy
 LT/36MZYlh6teYDDuaBL2gy+q3Q9LesTe3cxeC0=
X-Google-Smtp-Source: APXvYqwF6bpJR7bbKemxjTOyNfrNgSMeJlc99SIFKPzFVAa8NwY28yZG8h5VddzPagdaJDfnqlHpqbBpNhWMV96/RZ0=
X-Received: by 2002:a2e:82cd:: with SMTP id n13mr3767871ljh.156.1572035322961; 
 Fri, 25 Oct 2019 13:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <850360df8fc15a3671bf2237f972ebaf09110015.1566603412.git.alistair.francis@wdc.com>
 <mhng-b813f03d-c23e-405a-8213-c4c9b22a6831@palmer-si-x1e>
 <CANnJOVFNqXEg9KkJC4CHkt0KTt2_6HjyhU2CvMROW+e79mDncA@mail.gmail.com>
 <CAKmqyKMfODSjbBm5ZgmHYYzzrf3B_4WEbANeKXo6rSO6V5Pzeg@mail.gmail.com>
 <CANnJOVGPW1ppNdx+=KAvgNhgGQPvJxjyGY=rxunicu=f++xhiQ@mail.gmail.com>
 <CAKmqyKPQPrPKdkaRjZ7P75jamuqEq6BABir56VrYGm=ZSFpAww@mail.gmail.com>
 <18b87754-d5b2-e4f1-bdc5-92ad26b97379@linaro.org>
 <CANnJOVEsF57FBbNxJ_WvL3O7iJ_mZijYikC_aNhxKcP856qTzw@mail.gmail.com>
In-Reply-To: <CANnJOVEsF57FBbNxJ_WvL3O7iJ_mZijYikC_aNhxKcP856qTzw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Oct 2019 13:28:16 -0700
Message-ID: <CAKmqyKP=2a+0sbDu78JFm2ZW_TZKWYdh5gsvrtu8W13Zt=DCFQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 10/28] target/riscv: Convert
 mie and mstatus to pointers
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 9:59 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> On Thu, Sep 19, 2019 at 10:50 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 9/18/19 4:47 PM, Alistair Francis wrote:
> > > I'm not a fan of the pointer method that I'm using, but to me it seems
> > > the least worst in terms of handling future code, keeping everythign
> > > consistnent and avoiding complex access rules.
> >
> > FWIW, I prefer the "banked" register method used by ARM.
> >
> > enum {
> >     M_REG_NS = 0,    /* non-secure mode */
> >     M_REG_S = 1,     /* secure mode */
> >     M_REG_NUM_BANKS = 2,
> > };
> >
> > ...
> >
> >         uint32_t vecbase[M_REG_NUM_BANKS];
> >         uint32_t basepri[M_REG_NUM_BANKS];
> >         uint32_t control[M_REG_NUM_BANKS];
> >
> > The major difference that I see is that a pointer can only represent a single
> > state at a single time.  With an index, different parts of the code can ask
> > different questions that may have different states.  E.g. "are we currently in
> > secure mode" vs "will the exception return to secure mode".
>
> This makes a lot of sense to me. It means that any individual control register
> has an unambiguous name that doesn't change based on context. They aren't quite
> the same names as used in the architecture specification (mie & vsie
> vs. mie[NOVIRT] & mie[VIRT]), but they are reasonably close. It also means other
> parts of the code can't ignore that there are two different versions of the
> registers in play. Perhaps the biggest benefit though is that you can sidestep
> swapping on mode changes *and* avoid needing any super fancy logic in the access
> functions:
>
> int read_mstatus(...) {
>     target_ulong novirt_mask = ...;
>     *val = env->mstatus[NOVIRT] & novirt_mask | env->mstatus[virt_mode()];
> }
>
> int read_vsstatus(...) {
>     *val = env->mstatus[VIRT];
> }
>
> int write_mstatus(...) {
>     ...
>     target_ulong novirt_mask = ...;
>     env->mstatus[NOVIRT] = (env->mstatus[NOVIRT] & ~novirt_mask) |
>                            (newval & novirt_mask);
>     env->mstatus[virt_mode()] = (env->mstatus[virt_mode()] & novirt_mask) |
>                                 (newval & ~novirt_mask);

The part I don't like about this is that it then requires all of the
RISC-V implementation to be affected by the Hypervisor extension. The
current way means that if you aren't interested in the extension you
can just ignore it and not worry about breaking anything. For ARM this
isn't as big of an issue, but RISC-V is much more modular (there will
be lots of platforms without the H extension) so I don't want people
to have to worry about it.

PS: Sorry for the delay here, I have been looking into some other ways
of doing this, but I still think the current way is the least bad.

Alistair

> }

