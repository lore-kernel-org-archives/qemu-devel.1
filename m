Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA00CC3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E8B206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1VfeHA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E8B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i52ve-0005EL-Na
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 03:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i52uk-0004pl-VV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i52ui-00035q-BI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:07:42 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:37245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i52ui-00035Y-2C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:07:40 -0400
Received: by mail-oi1-x22e.google.com with SMTP id b25so11991337oib.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QQJ5aYHHHASGNdZ81y6xT7exo0NH5izgyd29CZT6GsY=;
 b=d1VfeHA8nBjTS+QYSi4PibGYuE1pMR0CKOWCPG/9XmYwz4NSXIHGjriyjFFLGdvh8Y
 eKDXNvKCkkxQhWfLUc+nyfC7kHa4UqdizT53rzynvnUzQApmI9bZ+nBTU2M/W80l+/hT
 Qsm/e7dEqO8vvodtSogzWT684JuMo1JMBrLZwqgxLvvaiNZnHB2lblBNlZjYFsdtv+Me
 +3cIPM4vtVO/sv0JMr2gEeOh2I84c52VKUP1jWHQIiwn+ECwgnUUOtowQ8UEFlEKJIwJ
 OLi7dsK2ZJxLaIWqcrS40ffMgyVq8Te2bq2cz50s1zKTsy/GByPQqCtPE15SzJgs3nOg
 +oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QQJ5aYHHHASGNdZ81y6xT7exo0NH5izgyd29CZT6GsY=;
 b=F+15HWK2os8WZSvrK6nINaFA1C9bRhfwgUPb0F4htPcHVoyLr3GVLGrkwSh1Ce0Hp5
 YL8S9p6sFthr0XHKGayAJT/sp3na2SCztMEEENlko9qvwQ4zXjXNKVjQKRyim+c9SI66
 8CPScEJhy8Y5dXKRyr2ZYCFQe7Ai7kWKtRRBYHZpT5qzjLESgB0oAhU0C8Ht7dE5xA4m
 zwFsb7RHbMh5IkemVYWYqHOBCKJClfCVoXBUftc2lJTp5OwS4TwzbbizkADFIkBQWFxa
 Wz4bx2v3XddcWAr9EcnjT+voa+dirs/KJvWueQ5FN7zvHRsvBy6TR64sEGQzFrj3WGtt
 JRrQ==
X-Gm-Message-State: APjAAAVZ0b9e7XlJ1d/65RLUN424zl+gBJUQZik7fPIJBPAhRKpwSykV
 8d5JiWtVxMG45onz1YCTATw3QrKLdgV1kIr1FPE=
X-Google-Smtp-Source: APXvYqx1vpN8yge2cMhcQCyRPDkI1R+mSNClxvwffyOd1oUFpwlKhXJe+4PQJfQ3Mc47l1PPFUaIcjfFbn4vNfBdcYc=
X-Received: by 2002:a05:6808:a1c:: with SMTP id
 n28mr3340529oij.136.1567494459023; 
 Tue, 03 Sep 2019 00:07:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 3 Sep 2019 00:07:37 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 3 Sep 2019 00:07:37 -0700 (PDT)
In-Reply-To: <tencent_4D0D8A6738AA24B65B532FA1@qq.com>
References: <tencent_4D0D8A6738AA24B65B532FA1@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 3 Sep 2019 09:07:37 +0200
Message-ID: <CAL1e-=hc7Xi8EVXThQ0-kJQfvqs2m6wLAuEyTZaK7SUe1gbqBg@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.08.2019. 11.14, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> Thanks for explaining helper functions for me. Before getting my hands
dirty, I have some more questions. After figuring them out, I can get
started.
>
> I need to add some new registers to the CPU. In "translate.c", I found
that the registers are declared as static TCGv array (e.g. cpu_gpr[32]).
Then, in function mips_tcg_init(), cpu_gpr[i] is created one by one with
tcg_global_mem_new(...) in a for loop. Is that all I need to do to add new
registers to the CPU? I noticed another file "cpu.h", do I also need to add
my new registers, say, "my_gpr[32]" in "cpu.h"?
>
> My new instructions also include some load & stores. I see I can
implement them with tcg_gen_qemu_ld/st_tl(...) in the decode function's
switch-case statements, but I don't see how the *target* memory is created.
Shouldn't they be created with tcg_global_mem_new(...), just like how the
registers are created? I can hack the memory by creating a *super* larger
register file, and hack the loads & stores with register moves, but that
just sounds too sketchy.
>

For register definition, load/store instruction, take a look at details of
this series:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06028.html

Don't mix register and memory initialization. For memory, the existing code
should bu sufficient.

What you need to additionally do (and you didn't mention it) is to define a
CPU that will have some base instruction set (it coukd be, for example,
mips32r2) + your additional instructions. This is done in file by adding a
corresponding item in translate_init.inc.c (if you choise mips32r2 as base
ISA, you could base your new CPU on existing CPU 24Kf). And then you start
QEMU with switch "-cpu <your newly defined CPU>".

I may add more explanation later on.

> On the other hand, I would like to get it running first, without doing
any modification to the source code. I can build the user space emulation
on Linux.
>
> ./configure --target-list=3Dmips-linux-user
>
> Then I will write a testprogram.c, cross compile it on x86 into MIPS
using gcc(I am not clear on how to do it, but my team has the compiler for
our new ISA, I just want to try the MIPS version first), and run the test
program.
>
> ./qemu testprogram
>
> How do I look at the contents in the target registers and memory? I saw
that function "mips_cpu_dump_state" in "translate.c" does what I need, but
I don't know how to call it in this process. Should I use gdb?
>
> I am really sorry for asking you so many questions, but I think after
getting them figured out, I can start my project. Thank you very much in
advance, and have a good weekend!
>

The questions are always fine and welcome, just we are typically very busy,
snd can't always promptly replay.

Aleksandae

> Cheers,
> Libo
>
>
> ------------------ Original ------------------
> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
> Send time: Thursday, Aug 29, 2019 10:22 PM
> To: "Libo Zhou"<zhlb29@foxmail.com>;
> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
> On Wed, Aug 28, 2019 at 5:54 AM Libo Zhou <zhlb29@foxmail.com> wrote:
>
> > Hi Aleksandar,
> >
> > Thank you for the link to Loongson2F documentation. It has been very
> > useful:)
> >
> > I have spent several days immersing myself in the source code, now I
think
> > I have a more solid understanding about it. Just like Loongson
Multimedia
> > Instructions, I need to implement some sort of complex vector
instructions,
> > and I need to write some helper functions (e.g. my_helper.c).
> >
> > The QEMU wiki website has very thorough explanation on TCG, but I
haven't
> > found any explanation on the port-specific helpers. Is there any
> > documentation on how the helper functions are generated? I think now I
> > *might* know how to write a working helper function, but I just don't
know
> > how it works.
> >
> >
> Hello, Libo,
>
> Prerequisite for writing a helper is that you have a clear definition of
> new instruction functionality, in the sense, what operation is done on
what
> resources. "Resources" are registers - they could be general-purpose MIPS
> registers, or some special additional registers. Did you use existing
> registers, or did you define a new set or registers for your new
> instructions? Registers are modeled as fields in a structure, and both
> helpers and TCG implementations modify those fields while performing
> instruction emulation.
>
> In any case, you pass to the helper all information needed for the
> instruction in question to perform. These are usually ordinal numbers of
> involved register, derived from decoding the opcode. Alternatively, you
can
> pass pointers to the registers, rather than ordinal numbers. In turn, the
> main part of functionality is implemented. At the end of helper, you may
> want to update, let's say, a status register, if any (depending on your
> design).
>
> The declaration of helpers is a little contrived, and may still confuse
> you. But this is not crucial to you. I advise you just to copy a solution
> for a similar existing instruction.
>
> Yours,
> Aleksandar
>
>
>
> > Cheers,
> > Libo
> >
> >
> >
> >
> > ------------------ Original message ------------------
> > *From:* "Aleksandar Markovic";
> > *Sendtime:* Thursday, Aug 22, 2019 6:53 PM
> > *To:* "Libo Zhou";
> > *Cc:* "qemu-devel";
> > *Subject:* Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> >
> > On Thu, Aug 22, 2019 at 12:24 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:
> >
> > > Hi Aleksandar,
> > >
> > > Thank you very much for your patient explanation in the previous post=
.
> > And
> > > thank you for checking.
> > > Your and Peter's replies in the previous post certainly helped a lot.
I
> > am
> > > now looking at a git commit 7 years ago (
> > > bd277fa1966bc400f1b411f868f39125cda0c403), it was a Loongson
Multimedia
> > > Instruction implementation done my Richard Henderson.
> > >
> >
> > Cool, that commit is a very good staring point - it is definitely not
too
> > simple, and it is not too complex either. And you can discover several
> > different concepts in the process of exploring the change.
> >
> > Documentation on instruction set extension related to the commit (found
by
> > Google):
> > https://files.somniafabularum.com/loongson/docs/Loongson2FUserGuide.pdf
> >
> > Be persistent, take your time, study the details and handling of
individual
> > instructions, and, of course, let us know if you encounter some major
> > obstacles or thorny dilemmas.
> >
> > Yours,
> > Aleksandar
> >
> >
> > > I think what he did is exactly what I want to do now. I got a vague
view
> > > of the big picture, but I need more time to figure out the details. I
> > will
> > > certainly ask more questions about this later, but before that I need
to
> > > look at some other parts of the source code:) Again thank you for
> > checking!
> > >
> > > Cheers,
> > > Libo
> > >
> > >
> > > ------------------ Original message ------------------
> > > *From:* "Aleksandar Markovic";
> > > *Sendtime:* Thursday, Aug 22, 2019 4:23 PM
> > > *To:* "=E7=AB=8B";
> > > *Cc:* "qemu-devel";
> > > *Subject:* Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> > >
> > > On Tue, Aug 20, 2019 at 12:12 PM =E7=AB=8B <zhlb29@foxmail.com> wrote=
:
> > >
> > > > I am working on a project that requires me to modify the ISA of the
> > MIPS
> > > > target.
> > >
> > >
> > > L.,
> > >
> > > How is it going?
> > >
> > > Aleksandar
> > >
> > >
> > >
> > > > I have been staring at the source code for about a week, but found
it
> > > > really difficult due to me being a young rookie and the sparse
> > comments.
> > > > Specifically, I need to extend MIPS, by adding some new instruction=
s
> > and
> > > > new CPU registers to the current architecture, and that sounds
really
> > > easy.
> > > > I think the place for me to look at should be at the directory
> > > > ${qemu_root}/target/mips/. With a MIPS Instruction Set Manual
Release 6
> > > > handy, I have difficulty finding the source code where the ISA
resides.
> > > Is
> > > > it in op_helper.c? Or translate.c? Any guidance would be really
> > > > appreciated. Thank you very much in advance.
> > > >
> > > >
> > > > Cheers,
> > > > L.
> > >
> >
