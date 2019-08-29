Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01788C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 14:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5F1208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdfbRmGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5F1208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3LKi-00010P-Oz
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 10:23:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3LJp-0000ap-WD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3LJo-0007kN-2C
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:22:33 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:34914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i3LJn-0007ja-SO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:22:32 -0400
Received: by mail-oi1-x234.google.com with SMTP id a127so2686483oii.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oGhlzJloVlK6+u0vtE+IMMlwRc0YoqOxyFplJxyIQ8w=;
 b=KdfbRmGbiGgAztQ4pcdiii0axRC4FDlFnGooHvfJl01DNtlwCFejMMWBjXryEIw5FX
 +P7dpwCERVwosJ6tt1HTIzLCcU0eAIvKPddz4xj6xfqOBTpAcXqncoTDwV7snpn8XWIR
 zYosp58LxxOm3mjJfOlC+DM+bHBmAx/aNIklTyfHAqLKX5CtiweABCJx1AFRqAy8iCsy
 xuqsYABgmffEQlgBbQQ8MLj6jTpQstv0KWxhhMQNL8WZu5YeLOtciKJw3Y97yjGTKbJX
 NdSRz9U5mq/hhKjiHvGRMmrk5pVaAOBTtBbWlRaB03Pa/KdlsvBmr07anuKLml0AOOPA
 ym5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oGhlzJloVlK6+u0vtE+IMMlwRc0YoqOxyFplJxyIQ8w=;
 b=MjWSg/LX9bUYjpVVbsIrWv05BCUywzTMbzG2KesfRJiKKx5wmC8PhFAJdgjdr5LnzJ
 x9pqbayFZ+zWPhl3e2l2cXQaoL96L17b+0OXZRFuad0vZ6LTKr31p4potc7ptXDt4nDo
 pdpwpgAMwdJB2djzV9Olkfxog8n2YoRmiwJh0JlcGNjufRpW3oAlU3Cgvm7OaBF/6lIA
 qr+CBeVdsOAljCLJNNdPbIU8dB7NJSv+PSg19qX/f7A30zaMttBR9BGPMSrEy6th+qv7
 9kXFguJ+0z8iwIoXeKjE6CT9RoilQXcViCnmXCCZxqi7kdxvv9S71/ZSNNU19cPwAsAK
 4ThQ==
X-Gm-Message-State: APjAAAUecSbItU4lCiImWw7/dm+b6HgcO9+tdmRKUI5Q79hFnfLHBXcO
 QyfdZzKRb++NxbjKCkKkpuuxWHsvnqwBtn9caEQ=
X-Google-Smtp-Source: APXvYqxpm/3Ek3U2p6GqBYPjDohFZXItZpk98Hc0oDlCqvHD5J+upWVJaP98INjRzo7sUGJjd9zbx+Bl/fh4i6JsVWg=
X-Received: by 2002:aca:ad57:: with SMTP id w84mr6341830oie.106.1567088550885; 
 Thu, 29 Aug 2019 07:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
 <CAL1e-=jUNzu19BBhFq0M_hjxi6BSgfmZUgQMygszTTonORVNmg@mail.gmail.com>
 <tencent_6386EC2F24D7A13D2B753FCF@qq.com>
 <CAL1e-=gtL6AxsRYPTO5bztH_F-gJDXixEEif3QRKQYo7d4XcUA@mail.gmail.com>
 <tencent_1D2ACC9711B86DEA5633A4F0@qq.com>
In-Reply-To: <tencent_1D2ACC9711B86DEA5633A4F0@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 29 Aug 2019 16:22:19 +0200
Message-ID: <CAL1e-=jrZPuAhDP2TUxrmHzf8ts81i3SPAq89cmMfREx4ATN-A@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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

On Wed, Aug 28, 2019 at 5:54 AM Libo Zhou <zhlb29@foxmail.com> wrote:

> Hi Aleksandar,
>
> Thank you for the link to Loongson2F documentation. It has been very
> useful:)
>
> I have spent several days immersing myself in the source code, now I thin=
k
> I have a more solid understanding about it. Just like Loongson Multimedia
> Instructions, I need to implement some sort of complex vector instruction=
s,
> and I need to write some helper functions (e.g. my_helper.c).
>
> The QEMU wiki website has very thorough explanation on TCG, but I haven't
> found any explanation on the port-specific helpers. Is there any
> documentation on how the helper functions are generated? I think now I
> *might* know how to write a working helper function, but I just don't kno=
w
> how it works.
>
>
Hello, Libo,

Prerequisite for writing a helper is that you have a clear definition of
new instruction functionality, in the sense, what operation is done on what
resources. "Resources" are registers - they could be general-purpose MIPS
registers, or some special additional registers. Did you use existing
registers, or did you define a new set or registers for your new
instructions? Registers are modeled as fields in a structure, and both
helpers and TCG implementations modify those fields while performing
instruction emulation.

In any case, you pass to the helper all information needed for the
instruction in question to perform. These are usually ordinal numbers of
involved register, derived from decoding the opcode. Alternatively, you can
pass pointers to the registers, rather than ordinal numbers. In turn, the
main part of functionality is implemented. At the end of helper, you may
want to update, let's say, a status register, if any (depending on your
design).

The declaration of helpers is a little contrived, and may still confuse
you. But this is not crucial to you. I advise you just to copy a solution
for a similar existing instruction.

Yours,
Aleksandar



> Cheers,
> Libo
>
>
>
>
> ------------------ Original message ------------------
> *From:* "Aleksandar Markovic";
> *Sendtime:* Thursday, Aug 22, 2019 6:53 PM
> *To:* "Libo Zhou";
> *Cc:* "qemu-devel";
> *Subject:* Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
> On Thu, Aug 22, 2019 at 12:24 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:
>
> > Hi Aleksandar,
> >
> > Thank you very much for your patient explanation in the previous post.
> And
> > thank you for checking.
> > Your and Peter's replies in the previous post certainly helped a lot. I
> am
> > now looking at a git commit 7 years ago (
> > bd277fa1966bc400f1b411f868f39125cda0c403), it was a Loongson Multimedia
> > Instruction implementation done my Richard Henderson.
> >
>
> Cool, that commit is a very good staring point - it is definitely not too
> simple, and it is not too complex either. And you can discover several
> different concepts in the process of exploring the change.
>
> Documentation on instruction set extension related to the commit (found b=
y
> Google):
> https://files.somniafabularum.com/loongson/docs/Loongson2FUserGuide.pdf
>
> Be persistent, take your time, study the details and handling of individu=
al
> instructions, and, of course, let us know if you encounter some major
> obstacles or thorny dilemmas.
>
> Yours,
> Aleksandar
>
>
> > I think what he did is exactly what I want to do now. I got a vague vie=
w
> > of the big picture, but I need more time to figure out the details. I
> will
> > certainly ask more questions about this later, but before that I need t=
o
> > look at some other parts of the source code:) Again thank you for
> checking!
> >
> > Cheers,
> > Libo
> >
> >
> > ------------------ Original message ------------------
> > *From:* "Aleksandar Markovic";
> > *Sendtime:* Thursday, Aug 22, 2019 4:23 PM
> > *To:* "=E7=AB=8B";
> > *Cc:* "qemu-devel";
> > *Subject:* Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> >
> > On Tue, Aug 20, 2019 at 12:12 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:
> >
> > > I am working on a project that requires me to modify the ISA of the
> MIPS
> > > target.
> >
> >
> > L.,
> >
> > How is it going?
> >
> > Aleksandar
> >
> >
> >
> > > I have been staring at the source code for about a week, but found it
> > > really difficult due to me being a young rookie and the sparse
> comments.
> > > Specifically, I need to extend MIPS, by adding some new instructions
> and
> > > new CPU registers to the current architecture, and that sounds really
> > easy.
> > > I think the place for me to look at should be at the directory
> > > ${qemu_root}/target/mips/. With a MIPS Instruction Set Manual Release=
 6
> > > handy, I have difficulty finding the source code where the ISA reside=
s.
> > Is
> > > it in op_helper.c? Or translate.c? Any guidance would be really
> > > appreciated. Thank you very much in advance.
> > >
> > >
> > > Cheers,
> > > L.
> >
>
