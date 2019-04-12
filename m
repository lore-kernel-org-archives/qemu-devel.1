Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12DC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3712171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd6O+qMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3712171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42805 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3X1-0007to-77
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:16:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hF3W3-0007OU-Gf
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hF3Vw-0001eC-Is
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:15:14 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hF3Vu-0001cI-9Z; Fri, 12 Apr 2019 17:15:10 -0400
Received: by mail-lf1-x144.google.com with SMTP id u17so8540884lfi.3;
	Fri, 12 Apr 2019 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MfyNgsgC4DlTdcjLD+NXILuSu1rvA1GabN0BxqymjlE=;
	b=Dd6O+qMn29ykF9RgdxoZLjFwEklNBSyHs2w8qkEbjS64i2E8cweCU594HmHDvRbVu0
	gv3WcPifTDmY8z0h/Xt1vdUjdRoA2C2fYlTzphXJKQCy9KKGb3LNBfF7C4WiPrK1S2eL
	qDgNtUo4aEDMohWzqoKDtJ5vjU1yxohRmc6NaCJKPl4+Lh4tqRTBJhIU9aaUHJlPZ1xw
	SswdAujUILRke9EyCqkVOUL0shRO8Bp6zjdsh69xjNgScBRpn+N1NlwvbaG1kWyX007c
	z6W6OblYVgKcbPTenYgyBRofg8V7u+ENXiMc/RMGOd/GHfDEuZGTswFc7YU1n9g+wZBF
	e/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MfyNgsgC4DlTdcjLD+NXILuSu1rvA1GabN0BxqymjlE=;
	b=k3EZVyb84m8QWLYKLEYL3SQUK9GhtfL9DHDsV+2+TSIT+fqA7W0g6X7p0eVv0EKrIR
	sfRKb/3Nu1kwbQ/KPtIRyLQyPrDuVPxmzojzMK7vUBEnIK28N7xspGXf68R7GU4erVuv
	6RfsKzzOCr63I0hDxsI0soiCkBamLkSXRSkkbMjpK5lAsb1ZlSwv8HFZJJXigbj7DD2J
	Gha/i5Umg9xLrmojrFcISpsLAZVxul2RDOmpyflFvNcYUMdOvJhTtZFa3jVdcnPANQ77
	WN6tB0/N3x2d7rJVYv4kWw0gv8o1NQ1nkydkMdqXJhP0BHVCjSO2cEwICAa2eBf26lED
	se6w==
X-Gm-Message-State: APjAAAVI/cebVHR7XWWCXXE/ILU2HSie6VAgZmR66V+HRy2tz6erlJul
	xZk1Gf2sQmHzf11I5BsUpFq63jA7PKdh/8HCK10=
X-Google-Smtp-Source: APXvYqwsVJSb5yC1aQjQmEfi/t19RPQYYJpGuEbK+iLf/U7mkxKebrpkCmjB7QcOc5WscwBpD5BpCnwJhp7upZdwS6I=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr5827018lfy.128.1555103707107; 
	Fri, 12 Apr 2019 14:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
	<CAKmqyKNVno+jR_PYxgnyqQOSQFCn_ai7GH+hYPgaO=fkqHDa6A@mail.gmail.com>
In-Reply-To: <CAKmqyKNVno+jR_PYxgnyqQOSQFCn_ai7GH+hYPgaO=fkqHDa6A@mail.gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Fri, 12 Apr 2019 17:14:40 -0400
Message-ID:
 <CANnJOVHprai3DLd=PunsVDGUwaGvvA4ynou5_LhyGVztTf-tNQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Do not allow sfence.vma from
 user mode
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412211440.n7-hMZflZo4yFyg_FQd53QkMwYjyURQ0X83q7GaKVyM@z>

Just to double check, nothing further on this is need from me, right? It is
set to be merged onto the master branch once the 4.0 release is out?

Jonathan

On Wed, Apr 3, 2019 at 7:11 PM Alistair Francis <alistair23@gmail.com>
wrote:

> On Mon, Apr 1, 2019 at 1:39 PM Jonathan Behrens <fintelia@gmail.com>
> wrote:
> >
> > The 'sfence.vma' instruction is privileged, and should only ever be
> allowed
> > when executing in supervisor mode or higher.
> >
> > Jonathan
> >
> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> >  target/riscv/op_helper.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index b7dc18a41e..644d0fb35f 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
> >  {
> >      RISCVCPU *cpu = riscv_env_get_cpu(env);
> >      CPUState *cs = CPU(cpu);
> > -    if (env->priv == PRV_S &&
> > -        env->priv_ver >= PRIV_VERSION_1_10_0 &&
> > -        get_field(env->mstatus, MSTATUS_TVM)) {
> > +    if (!(env->priv >= PRV_S) ||
> > +        (env->priv == PRV_S &&
> > +         env->priv_ver >= PRIV_VERSION_1_10_0 &&
> > +         get_field(env->mstatus, MSTATUS_TVM))) {
> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> >      } else {
> >          tlb_flush(cs);
> > --
> > 2.20.1
>
