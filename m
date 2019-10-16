Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1FBECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C8820872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNMmTUrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C8820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKqRX-00052p-2M
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 17:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iKqQ2-0004A4-7B
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iKqQ0-0007M0-U7
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:01:18 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iKqQ0-0007JJ-Ka; Wed, 16 Oct 2019 17:01:16 -0400
Received: by mail-lj1-x244.google.com with SMTP id m13so155468ljj.11;
 Wed, 16 Oct 2019 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZgU+CS0nFS1d6H6euIDyJtA+7V3NZ/G1q7nqIQcmhQU=;
 b=WNMmTUrcWtZTH28bykLrng0AMGYm15kBq8yhX8Tw8yyiBPS8YiXb6sZ1KU502AwymG
 zopQjCz5reegDdg3w5bhWSFSOK+g/pk7CkF/u9DNq6ld2FS2fC1XA5TekeE5l0a9P73z
 VfU/hySQWlugGbhNJK/CQ+Fe4eB7RnP+u5JtpRrnc4DgwCwDe9c99Ps+SL8bFApAk6Ub
 Oq/LxKdiaRxoSqKmuYIZCN8TSoUGxkRrqD9TUhuTpVN4bUbwwE9vTWjs3lmmTMUsG/qO
 YOkK7aijqFxo0SttSiFV49TKtcIgd6Z6mFpK5BfPbLbfpCjME2SnqpyYk0ZtQ1/mW02Q
 eK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZgU+CS0nFS1d6H6euIDyJtA+7V3NZ/G1q7nqIQcmhQU=;
 b=rwBenOCIkUuPUHPpnYAyDQ2qzLQ5N43hsmG4A7ZV7+e5Ba6sBBdD0Ub7fKkMnYXiVE
 RKKs8mSjDdqrbqhC57+e8v0rL88vekMvwmgM6uoFgMdUp9u725NI8GVPOYihPfV11u2j
 BrGzLmz1fA9T04KyPpmbyOEB55wzRY3B1Mg/3mBSfzgSv4xVfaCe57hXyzMp027Ms6CE
 yOnPqap4C94w9W7j9ERvimn427MNQfrCzHpdtZ7ymbI5y5RqWL29qByGAUOM5VmGuGYM
 OirY7PYmMhtaSoM4muP05NikyILJqaV7u8nA99+JkieYGt3aD1fL9oevf32BHbqDmXdx
 uh8g==
X-Gm-Message-State: APjAAAV7MoitDiDgPZYMSuWzXUWy2UcBPkWWWLSAsD44iBabW3zksx9C
 MQCNyekUucq9jUFsE5mZLn1uuVk+A+gEOGqR4l0=
X-Google-Smtp-Source: APXvYqxHj873CSI4EMCmF1u85bevrHwiaEyLj4rsEGgUgfL47SkQvwkyBxkuFNHbe/wYuUG/BpF8qwP6wjGd2WlCa4I=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr113641ljj.4.1571259674714;
 Wed, 16 Oct 2019 14:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <a090bc437bf412c279b1254d05eae5c2d67225db.1566603412.git.alistair.francis@wdc.com>
 <mhng-afa69c9b-17b7-4043-b204-512c92cf618a@palmer-si-x1e>
In-Reply-To: <mhng-afa69c9b-17b7-4043-b204-512c92cf618a@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Oct 2019 13:56:04 -0700
Message-ID: <CAKmqyKMf1bPSpM7RP1ULmOK7sKcUFA5Rbb_TkD7f0vTtu5fa1Q@mail.gmail.com>
Subject: Re: [PATCH v1 04/28] target/riscv: Fix CSR perm checking for HS mode
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 7:48 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 23 Aug 2019 16:38:00 PDT (-0700), Alistair Francis wrote:
> > Update the CSR permission checking to work correctly when we are in
> > HS-mode.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/csr.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index f767ad24be..471f23a1d0 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -799,9 +799,15 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
> >
> >      /* check privileges and return -1 if check fails */
> >  #if !defined(CONFIG_USER_ONLY)
> > -    int csr_priv = get_field(csrno, 0x300);
> > +    int csr_priv = env->priv;
>
> This isn't really "csr_priv" (ie, the priv needed to access the CSR) any more,
> it's really the effective priv of the machine.  Leaving the variable with the
> same name makes this hard to read, but I think it is correct.

I changed the name to effective_priv.

>
> >      int read_only = get_field(csrno, 0xC00) == 3;
> > -    if ((write_mask && read_only) || (env->priv < csr_priv)) {
> > +
> > +    if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
> > +        /* Plus 1 as we are in HS mode */
>
> The comment is useless, it doesn't say why we increment it.  Also, I don't
> think this is correct: doesn't it allow U mode to access S CSRs when H is
> present and V is disabled?

Yes, you are correct. I have changed it to check that we are in S mode.

>
> Something like
>
>     riscv_effective_priv(CPURISCVState *env)
>     {
>         if (riscv_has_ext(env, RVH) && env->priv == PRIV_S && !riscv_cpu_virt_enabled(env)) {
>             return PRIV_HS;

I don't like this as there is no PRIV_HS. It seems like a bad idea to
start using a reserved privilege level, if it is ever used we will
then be stuck updating this. I also don't think this is used anywhere
else. I have just fixed up the if statement and comment.

Alistair

>         }
>
>         return env->priv;
>     }
>
> would probably be used in a handful of places, and would be a drop in for
> env->priv here.
>
> > +        csr_priv++;
> > +    }
> > +
> > +    if ((write_mask && read_only) || (csr_priv < get_field(csrno, 0x300))) {
> >          return -1;
> >      }
> >  #endif

