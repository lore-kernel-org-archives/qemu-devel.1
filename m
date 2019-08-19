Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F7C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2772087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo7C7GXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2772087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzn3Y-0003nP-Ug
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hzmt5-0007QY-Vx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hzmt4-0003TH-IV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:00:15 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hzmt4-0003Sm-BL; Mon, 19 Aug 2019 15:00:14 -0400
Received: by mail-lj1-x242.google.com with SMTP id z17so2777888ljz.0;
 Mon, 19 Aug 2019 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XbndJ77t/JRz8dNAC/FwbHTdclXUBxE+llpURtJTt5I=;
 b=lo7C7GXz+nRGJV02k9U9Gf19yDJzXQb0DJcrQ9t1NKPpuXB4SR0VMcZruD4jpS4eXO
 ZmyIjUbDjQ6zj2ZtQuRahGuFt8ENB3AULW4+bTQOzRY2vDjqN+e600cwLpE+eXgZOJoO
 cRjfd0yuxIGRsL0wtqe0JL18bTvp4vlZ37BV2wxqR82e0rqM3BIxYDm+6IvlmDUQZ0F/
 q+65Tm1cJ5ul+Xb4Z8N94QpuVba2yFcyz4dHth+mV3q219AHCA1DK7Oym++VEStkH2d+
 s4ovSAsGGqdH6vec1SqosCUxBr+zCea1FU8kPjnmgx/X8pLtkzxt2gm2schES6+6u1xG
 5mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XbndJ77t/JRz8dNAC/FwbHTdclXUBxE+llpURtJTt5I=;
 b=tUYLZf0Ii3phMUr9poIwZc3+bKtR8t+vcgjXEOlzTnntTADQN7EHL3E2uuJsIXL/CW
 aZm87VBNdV0/hcuaCMccXC7b1aW4aHC/IAjxzJOjqNJWIa2eeJpyGWRXQpAedjcWZDr/
 UALajBRsAt8SWNchdrBggJiN5lsfKa3sdVtIoeQdcpLKMt7d0oNOT/bkIQ/EkeRrOkWJ
 sr2GbIDr2Zykq5nXvGCcdmnplpwvqv6/luEuE2jdiXNOUBpLN4Aetli6zs4XUqHj3NuY
 o4I+sEZlXD9e+gUmR//22augp98/ZIjrARKB7gIvFugYnsZovadPHLL8Nz+pxAGFX6Wg
 dIcQ==
X-Gm-Message-State: APjAAAWBHVL57xz8D89Rz6/YRnqp8too7vyM9vTAG1+mJvIPavwsF6zV
 JihME0S7GesBmnG7gvMyy8V4S+TxNZOHVHM0ElY=
X-Google-Smtp-Source: APXvYqyTWbI5KpcAyuGZ1wKrgHSH7msuJVIBQvCyfyum98YGmIHCIVqAT4BFKqcAm5nNOGlmx+anX7t7YQ4Tx3/Zx+I=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr13344006ljc.85.1566241212847; 
 Mon, 19 Aug 2019 12:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
 <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
 <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
In-Reply-To: <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2019 11:56:11 -0700
Message-ID: <CAKmqyKPa2YbAASRsQ8cAm+LR58Z3i_bCXDd7tYtD5TtXvv4YdQ@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 6:44 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
> On 2019/8/17 =E4=B8=8A=E5=8D=881:29, Alistair Francis wrote:
> > On Thu, Aug 15, 2019 at 8:39 PM liuzhiwei<zhiwei_liu@c-sky.com>  wrote:
> >> Hi, Palmer
> >>
> >> When Michael Clark still was the maintainer of RISCV QEMU, he wrote in=
 the mail list, "the CLIC interrupt controller is under testing,
> >> and will be included in QEMU 3.1 or 3.2". It is pity that the CLIC is =
not in
> >> included even in QEMU 4.1.0.
> > I see that there is a CLIC branch available here:
> > https://github.com/riscv/riscv-qemu/pull/157
> >
> > It looks like all of the work is in a single commit
> > (https://github.com/riscv/riscv-qemu/pull/157/commits/206d9ac339feb9ef2=
c325402a00f0f45f453d019)
> > and that most of the other commits in the PR have already made it into
> > master.
> >
> > Although the CLIC commit is very large it doesn't seem impossible to
> > manually pull out the CLIC bits and apply it onto master.
> >
> > Do you know the state of the CLIC model? If it's working it shouldn't
> > be too hard to rebase the work and get the code into mainline.
> >
> > Alistair
> >
> Hi,  Alistair
>
> In my opinion, the CLIC code almost works.
>
> Last year when my workmate ported an RTOS, I once read the CLIC specifica=
tion and used the CLIC model code. It worked through  all the tests after f=
ixed two bugs. I also had sent the patch to Michael, but without response(m=
aybe a wrong email address).
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7bf6cbc..95d80ab 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -505,6 +505,9 @@ static target_ulong riscv_intr_pc(CPURISCVState *env,
>       if (!(async || clic)) {
>           return tvec & ~0b11;
>       }
> +    if (clic) {
> +        cause &=3D 0x3ff;
> +    }
>
>       /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D res=
erved */
>       switch (mode1) {
> @@ -645,6 +648,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           riscv_cpu_set_mode(env, PRV_M);
>       }
>
> +    if (clic) {
> +        env->exccode =3D 0;
> +    }
>       /* NOTE: it is not necessary to yield load reservations here. It is=
 only
>          necessary for an SC from "another hart" to cause a load reservat=
ion
>          to be yielded. Refer to the memory consistency model section of =
the
>
> After that, the specification has updated and the code may changed. I did=
n't pull new code again.
>
> If the CLIC model may merged into the mainline, and no body maintain the =
code, I'd like to work on it, fixing the bugs and updating the code accordi=
ng to latest specification.

Yes please! We will be happy to merge it!

If you would like to it would be great if you could update the code,
fix the bugs and then send patches to this list.

Alistair

>
> Best Regards,
> Zhiwei
>
> >> As we have cpus using CLIC, I have to use the out of tree qemu code in=
 SIFIVE
> >> a long time. Could you tell me when it will be upstreamed?
> >>
> >> Best Regards
> >> Zhiwei
> >>

