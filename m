Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF17C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2430424653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V10ioBFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2430424653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1x4-0007Rz-BF
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 17:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iu1wB-0006bv-9x
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iu1wA-000100-4S
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:23:55 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:35590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iu1w9-0000zj-TP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:23:54 -0500
Received: by mail-lj1-x233.google.com with SMTP id j1so4563329lja.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 14:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nJk4y5mkxBJ+C2OvzwqFOIksV3F4aLb+cOk3t8I3kKE=;
 b=V10ioBFvUuYtBWuQjtoMbJZ6m3ps9f2D50oH2OMxAUqShqRdobbM2daWj4da0w6v3R
 Wbfk1EB7ofbUdXI+TnfK+g9qEocedaFin3vyPbMFI0BvHTMx0H5KKXr7DbQ2a0jbb1Oh
 tohvM/81eveu1ijgVCnnbiC1Eh8jutly/8IeaaKbi26nhb69PR0Cdd7mHMrGcqSGNoWu
 jJVXW6ogruwWCMELUmjOyIQYkL5KlTqXXjzgpM/hoGG03wlsYfBy53q7c3BdgVAAaUf+
 QkBd6pXP580efZF8YWJXq9dJYHM0C21Zglya1tcxwsOt+SQ5Er7OZZs5gaqnmCDAk3U+
 PeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nJk4y5mkxBJ+C2OvzwqFOIksV3F4aLb+cOk3t8I3kKE=;
 b=ADzHIsQZFEcdcAuMZZDXxTBrwKgEYFKfYljeHbWtHuwEJvhc8hbB/bmGlDDfnGC86F
 CaO7Atsd0uPAYiT8dRi1A/9gJKRZxCdDaSuXIpITEVpcvvMSQkqQvJZHHwHQ/wwJO8Cs
 U8POMQMwiMZl3jdzCPwS9y1x74DnNkZsKe39v9864yRhlVvsMbD04GLDfYrC1TkelGPR
 Der9tidu3ql/CIoo7G7/F5L3mbMoYl0KhmsRI5HbHxo9p/2GhTwVgtN5J3Pf0SoGZbm+
 KkxTZ3O8ZQORiNEiSsru1G9zSZkPg1evTga6g1fLpn72mH8jV3KNlPZ/kEMIA9CSRm0W
 rAjQ==
X-Gm-Message-State: APjAAAU2C9LalMItb3cj9lscvL1ZBRKr20qCMqgh2wLkpkh4mY4JIkXQ
 HSI/XXZ6ygbqsty2f/L3QnqcUyg39i/dQjfFPNHfFJ9n
X-Google-Smtp-Source: APXvYqzxZ4Z1/8ZulTxsx1mSsK3sZMfxujHiNvCX0p08CHgXQvEY9lbvhYkNK/cyitMW29P0PDxxEO7b8MFVPYxNbsI=
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr17370457lji.87.1579645432521; 
 Tue, 21 Jan 2020 14:23:52 -0800 (PST)
MIME-Version: 1.0
References: <CAMAD20n_9Xj6HqgYzB-_Ra71f=_YyS4WkAFJK6VExOA50Bfcjw@mail.gmail.com>
 <CAKmqyKNzFeWcNP7Stz5TnjzEysGt3pSe8qNvq4rTtM4guaLDTg@mail.gmail.com>
 <CAMAD20nF6oxJSAv=Vfk9qpoczxB2L5amWGe03aRu8gAf32iuKA@mail.gmail.com>
In-Reply-To: <CAMAD20nF6oxJSAv=Vfk9qpoczxB2L5amWGe03aRu8gAf32iuKA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Jan 2020 08:23:24 +1000
Message-ID: <CAKmqyKP6b-2T9YednQE91KvTLQ7gVMUoObRfb7bH-DnpwTS1oQ@mail.gmail.com>
Subject: Re: riscv: How to check floating point support is currently enabled?
To: Ian Jiang <ianjiang.ict@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::233
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 8:22 AM Ian Jiang <ianjiang.ict@gmail.com> wrote:
>
> Alistair Francis <alistair23@gmail.com> =E4=BA=8E2020=E5=B9=B41=E6=9C=882=
1=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:50=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Tue, Jan 21, 2020 at 11:12 AM Ian Jiang <ianjiang.ict@gmail.com> wro=
te:
> > >
> > > The function riscv_cpu_fp_enabled() is used for checking whether floa=
ting point support is currently enabled. In fact it checks the FS field in =
the mstatus MSR.
> > >
> > > target/riscv/cpu_helper.c
> > >  76 bool riscv_cpu_fp_enabled(CPURISCVState *env)
> > >  77 {
> > >  78     if (env->mstatus & MSTATUS_FS) {
> > >  79         return true;
> > >  80     }
> > >  81
> > >  82     return false;
> > >  83 }
> > >
> > > This will cause a problem that the SD bit in mstatus is not set to 1 =
when  FS in mstatus is modified from '00'b to '11'b with write_mstatus().
> >
> > Thanks for looking into this.
> >
> > There are patches on list fixing floating point errors. Can you check
> > if this branch fixes any issues you have:
> > https://github.com/palmer-dabbelt/qemu/commits/for-master
>
> Yes, there is:
> https://github.com/palmer-dabbelt/qemu/commit/82f014671cf057de51c4a577c9e=
2ad637dcec6f9

Great! This should make it into master soon.

Alistair

> Thanks!
>
> >
> > >
> > > file target/riscv/csr.c, func write_mstatus():
> > > 350     dirty =3D (riscv_cpu_fp_enabled(env) &&
> > > 351              ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS)) |
> > > 352             ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
> > > 353     mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
> > > 354     env->mstatus =3D mstatus;
> > >
> > > So checking fields D and F in the misa MSR (bit 3 and bit 5) may be a=
n better way. That is
> > > bool riscv_cpu_fp_enabled(CPURISCVState *env)
> > >     if (env->misa & (MISA_F | MISA_F) {
> > >         return true;
> > >     }
> > >     return false;
> > > }
> >
> > This doesn't seem right, just because the HW supports it doesn't mean
> > it's enabled.
>
> OK.
>
> >
> > Alistair
> >
> > >
> > >
> > > --
> > > Ian Jiang

