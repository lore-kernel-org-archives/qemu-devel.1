Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B55C3A5A0
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 01:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E49722CEC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 01:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq0DieCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E49722CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzsrL-00051R-6p
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 21:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzsqF-0004a2-3U
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 21:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzsqD-0003vL-Pu
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 21:21:43 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzsqA-0003rG-RH; Mon, 19 Aug 2019 21:21:39 -0400
Received: by mail-ed1-x541.google.com with SMTP id f22so4201790edt.4;
 Mon, 19 Aug 2019 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FyDhifdM46kGL6wLXdrdr45V4T4oPGnjGga7555czzQ=;
 b=Qq0DieCZIiippwewBm34jX5rUEpVBi8bgJGXDxL5Ao2UdBM3eIHdfr7q2PPYvzIr7/
 fweuPSl+bXT7N3/GIXSz3jTyf5Dx0PEYn5nnAB6P51XcivVlPajMfKfLZDFZoqXsRw6F
 HEUS5uUTDfa9yMRJeB+d4DhijMh6U+rRqlzYu2wQI2pvJVbXJYRzCbEUl72Am8/h6fnL
 kn3plSPDrAitv+nohjp6XPS7tbn6AVnQRTC9gSoBCNTyjA2TtLNsXsgIFFhlGfX4AP/N
 l1y6t7atOaD4vhCj5Eu1vi1lkXFaqi4KFvFGwr37F7VtQDDxO0gfo7DYiheRm8ijiWYs
 AasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FyDhifdM46kGL6wLXdrdr45V4T4oPGnjGga7555czzQ=;
 b=Hs/DOf1LN/Mlh9bA7X3N2aDtXTJnOZDaSh1O9L6RMz2A6FlWJ7WRrWJEWACDd1FHiY
 jy6gbkYICdsFdHAffKXazTzdRT1O/o+ig1s4lZ2GoQ1qjMgOxOI7UHkIzZxwZ0gH9obB
 PhAUk9HmfAKp1HkLIXghdV4flGexBLhds0bl1UcqtDg0WtWjNfAtyz1G+4c5ayDy8i0/
 2yzK7/z2/M14w3DKi1UyKTO6K179t7QsS2oXg5q6qAVtbTZSabphtd241A+LlOy3KIkK
 qEOi02DmGC+iDkeowJ8Z50k9ZqjOnQu0/rXXCH32qE+hoOWhbPMZaZ0YaPJnSlwy7Jbg
 ynPA==
X-Gm-Message-State: APjAAAUy2IgBVA0SrmtDYBNyjodTiBA3tnbdBAy/Rb0tDfelff0FMvSf
 +ahMS6McPpMsJQeVMmflhf06Og7KzW1/UX7fKUw=
X-Google-Smtp-Source: APXvYqygNxQ5Apj56i01NcfLDCzmWJFTd+VCE9jjO9Ea63vQAbGu6MyMy4nEE9LxXWDDydbTMiqhWDWWr/Bip2AJjy4=
X-Received: by 2002:a50:8687:: with SMTP id r7mr28216214eda.137.1566264097355; 
 Mon, 19 Aug 2019 18:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
 <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
 <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
 <CAKmqyKPa2YbAASRsQ8cAm+LR58Z3i_bCXDd7tYtD5TtXvv4YdQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPa2YbAASRsQ8cAm+LR58Z3i_bCXDd7tYtD5TtXvv4YdQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 20 Aug 2019 09:21:26 +0800
Message-ID: <CAEUhbmWsySubx0W__c6-6pWznfYb71JZfGm-EVKJ0iFeOWGKkg@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] RISCV: when will the CLIC be ready?
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 3:09 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Mon, Aug 19, 2019 at 6:44 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
> >
> >
> > On 2019/8/17 =E4=B8=8A=E5=8D=881:29, Alistair Francis wrote:
> > > On Thu, Aug 15, 2019 at 8:39 PM liuzhiwei<zhiwei_liu@c-sky.com>  wrot=
e:
> > >> Hi, Palmer
> > >>
> > >> When Michael Clark still was the maintainer of RISCV QEMU, he wrote =
in the mail list, "the CLIC interrupt controller is under testing,
> > >> and will be included in QEMU 3.1 or 3.2". It is pity that the CLIC i=
s not in
> > >> included even in QEMU 4.1.0.
> > > I see that there is a CLIC branch available here:
> > > https://github.com/riscv/riscv-qemu/pull/157
> > >
> > > It looks like all of the work is in a single commit
> > > (https://github.com/riscv/riscv-qemu/pull/157/commits/206d9ac339feb9e=
f2c325402a00f0f45f453d019)
> > > and that most of the other commits in the PR have already made it int=
o
> > > master.
> > >
> > > Although the CLIC commit is very large it doesn't seem impossible to
> > > manually pull out the CLIC bits and apply it onto master.
> > >
> > > Do you know the state of the CLIC model? If it's working it shouldn't
> > > be too hard to rebase the work and get the code into mainline.
> > >
> > > Alistair
> > >
> > Hi,  Alistair
> >
> > In my opinion, the CLIC code almost works.
> >
> > Last year when my workmate ported an RTOS, I once read the CLIC specifi=
cation and used the CLIC model code. It worked through  all the tests after=
 fixed two bugs. I also had sent the patch to Michael, but without response=
(maybe a wrong email address).
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 7bf6cbc..95d80ab 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -505,6 +505,9 @@ static target_ulong riscv_intr_pc(CPURISCVState *en=
v,
> >       if (!(async || clic)) {
> >           return tvec & ~0b11;
> >       }
> > +    if (clic) {
> > +        cause &=3D 0x3ff;
> > +    }
> >
> >       /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D r=
eserved */
> >       switch (mode1) {
> > @@ -645,6 +648,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >           riscv_cpu_set_mode(env, PRV_M);
> >       }
> >
> > +    if (clic) {
> > +        env->exccode =3D 0;
> > +    }
> >       /* NOTE: it is not necessary to yield load reservations here. It =
is only
> >          necessary for an SC from "another hart" to cause a load reserv=
ation
> >          to be yielded. Refer to the memory consistency model section o=
f the
> >
> > After that, the specification has updated and the code may changed. I d=
idn't pull new code again.
> >
> > If the CLIC model may merged into the mainline, and no body maintain th=
e code, I'd like to work on it, fixing the bugs and updating the code accor=
ding to latest specification.
>
> Yes please! We will be happy to merge it!
>
> If you would like to it would be great if you could update the code,
> fix the bugs and then send patches to this list.
>

Is the spec here?
https://github.com/sifive/clic-spec/blob/master/clic.adoc

Which silicon is going to have this CLIC?

Regards,
Bin

