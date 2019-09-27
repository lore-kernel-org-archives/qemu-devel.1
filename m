Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA0A21655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7fJFqfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA0A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDyDA-0002hV-OZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDyAX-0000fV-BF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDyAW-0001gT-CL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:52:53 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDyAS-0001dF-NG; Fri, 27 Sep 2019 17:52:48 -0400
Received: by mail-lf1-x142.google.com with SMTP id q11so2960649lfc.11;
 Fri, 27 Sep 2019 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lJcKZk8/IoSvhj7jWvlyxigM7z8UqdXfxfgYKDykwLY=;
 b=S7fJFqfJ/NjODtXLl85taQuTnuSx+f4bJxlaLKaRWJM1dD7KxFiyMaWKxCq6Q65SU9
 Bh7alMry3k1bBejOZgBUC0ZPR/jzWrjPa3bqh+Fjkcrtzz4nOvkPMY0TutAnZo8y36+v
 2Znu7TydSOllLIaYeWeI2PD0wio8AxJT1QMxgFTuVgdKoprkVnq3T7q6VUBNCPu//owV
 xnltIoZ/zJ/xgwfBlorrniHoO7ywLo4+3qFKhVxGLbTE6nsdvtQgkg0rOpxy+vgDcL+J
 BOenb7cgxKrwc6W6hBNQJHlnl0unyGlXkV/yQW/PVDYL2ejHLguDOEL3s/Y7LJ0oTAmr
 mqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lJcKZk8/IoSvhj7jWvlyxigM7z8UqdXfxfgYKDykwLY=;
 b=Iyd3+V6NZ2+0qyhMpTZr7qwoflIhY5XObyXG6mkcb7a3QVQij7wazJmivpk40YKMNO
 hyj9oKyVSFCcXTWeRleApsjVmnuSHEqMkf0/sVToZG1WT6Ry8XOECKVuKjP1aOuloSq8
 ZdEUmAhgKMkcg4lhf87HjNCp4rEAUF6iL0/yCLUTbbrwgBeM9xs/mCUhFzLRJsSSD6ez
 7LYSc1FK0r9UcYuL+axvNFMAyHZp/VSi9YFAL10SBCVWt+jMgP9f02PaPu3v6iDSxO8E
 5EgCheeknzo7IpWbuvvnJnQLrCDJbKw2qwj//U1FioKvbuniFR19i77/bsRi0eOzZBLA
 0B4A==
X-Gm-Message-State: APjAAAVV9bRJhZ4VoBciGS5NX5dcthnwKSkvBOxlQuEgYe/T0QYtYtsq
 wdb7+Jbst8Z5t7mzMY46HmlKTYxKlFhFrrZTtMQ=
X-Google-Smtp-Source: APXvYqyonzFrGrNnWzXCasu1TtEIUoV7KvsVKuw+9Q7BomhBeH+NioUYddlfqusODWnnx5LOQ/Dc1DeWIHNVqJPpmMU=
X-Received: by 2002:ac2:484a:: with SMTP id 10mr4209412lfy.135.1569621166581; 
 Fri, 27 Sep 2019 14:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <98e88256-7a88-b505-9bde-0836cf21c654@linaro.org>
 <mhng-a709557f-be85-4a1e-9f95-d708e95c540e@palmer-si-x1e>
In-Reply-To: <mhng-a709557f-be85-4a1e-9f95-d708e95c540e@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:47:59 -0700
Message-ID: <CAKmqyKNp=-CezYO0OMKwmM0a0p7VKUhv7K3dDr1OUbyY+JVyAw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 33/50] target/riscv: fetch code with
 translator_ld
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Emilio G. Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 3:50 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 17 Jun 2019 15:38:45 PDT (-0700), richard.henderson@linaro.org wr=
ote:
> > On 6/14/19 10:11 AM, Alex Benn=C3=A9e wrote:
> >> +++ b/target/riscv/translate.c
> >> @@ -793,7 +793,7 @@ static void riscv_tr_translate_insn(DisasContextBa=
se *dcbase, CPUState *cpu)
> >>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> >>      CPURISCVState *env =3D cpu->env_ptr;
> >>
> >> -    ctx->opcode =3D cpu_ldl_code(env, ctx->base.pc_next);
> >> +    ctx->opcode =3D translator_ldl(env, ctx->base.pc_next);
> >
> > I'll note for the riscv folks that this is an existing bug, reading too=
 much in
> > the case of an RVC instruction.  This could well matter for the last 2-=
byte
> > instruction at the end of a page.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Thanks for pointing this out.  I'm checking the ISA semantics with Andrew=
 to
> make sure I've got it right, as there's some implicit wording in the docu=
ment
> that doesn't quite do what I'd expect it to.

Did we figure out what to do here?

Alistair

>

