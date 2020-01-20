Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A02C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8B120678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejBObqip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8B120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itKzh-0000v4-KD
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itKz6-0000KP-4i
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itKz4-0001XY-Ru
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:32:04 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itKz4-0001Wv-L4; Sun, 19 Jan 2020 19:32:02 -0500
Received: by mail-lj1-x243.google.com with SMTP id y4so31998236ljj.9;
 Sun, 19 Jan 2020 16:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RmMqJrBOHe/Q6dl3NvKH6ZqysU0tMXFP4wNB72lxUak=;
 b=ejBObqipHnJeBwVKO8A0Qxhj26xaDtSk5mllczuFxJ6bH8hy0n9z2CR0UGuO32RW8G
 cNR3Jrc/x3fgbkmgsq7LJuqUcrtdiGPkGT4Dk9ToVbNC/BSxa8TDKhhM0pjVUj/ttgEY
 WWEcl8ug6dspJl8aKC2Y6ppW2KELluqag+nayAW15Ywnk43iQixLZaRk2BlPf50+UmJP
 LIlsrTPBy77o1L/m772GTFufw6qeIt+4HWcWVLXjO/4Csk7bp3HWBZujyZQzd2xAWzmF
 46SaZzvvOe7JgPcYKdATSJXWmYCVbwXhsnId+pdyKP0YzeRuSwMj2yyQ/gxuYk4WwnFw
 3K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RmMqJrBOHe/Q6dl3NvKH6ZqysU0tMXFP4wNB72lxUak=;
 b=dQYc5nXXmFeHmscawf69k1kjkjW9MbohBq97/tQTPslr2d/bm43U8x7jkfcISn+Z5q
 JKumZ+rfiRp3DdHLJObiZ50DLlJIQeGGCTB/wDBwyvDDHQrWlJAhe6liJW2O6k+H5Hzb
 5ks9ydT6EOZ9w2MEV0FMpHdFMdtEY77FaRlsJQZts9oq3ytMP/PkI2TaOIV4mGKiSmHw
 5gqB0E5GGbqo9XNdJn3sa/2uEp8zar1u4PTMfpmEbd+bo7pHsE5CSr8FfgU1FWjs22xB
 YdOe8Qi80MSlke26xKV/bzIZrdEsD4T5xfjjFbnYc4jG00mwj915s22aXVnUolyzmNes
 Z03g==
X-Gm-Message-State: APjAAAWCm9Tm6KNNIDUZgxBDSQ1SpvFgkmk7Pv8AWsTuijWHiWfFDzFg
 tvbHUqs4M1kSvjsQzw4Z8JQB3NHQYjD9FC0wez0=
X-Google-Smtp-Source: APXvYqwdI2GF5LljLjWCzvIUotTwMq3HbLZBStbBeyL3q/4lLHDGeYTTRqUcKRgazawTEkJZWyOE7VBg4hTZ8T9nqW4=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr11762156lja.204.1579480320636; 
 Sun, 19 Jan 2020 16:32:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1566573576.git.alistair.francis@wdc.com>
 <5cc26abb98a9534720f09674b4b9caafb8f2cf0a.1566573576.git.alistair.francis@wdc.com>
 <20200105163640.GA1752551@aurel32.net> <20200105165916.GA1834646@aurel32.net>
In-Reply-To: <20200105165916.GA1834646@aurel32.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jan 2020 10:31:33 +1000
Message-ID: <CAKmqyKNd8ihSXTcdS9da_pGkinFVnJKAAsg4fR4LzBEUH8NZ2A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/7] target/riscv: Create function to test
 if FP is enabled
To: Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 6, 2020 at 2:59 AM Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> On 2020-01-05 17:36, Aurelien Jarno wrote:
> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > index e0d4586760..2789215b5e 100644
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> >
> > [ snip ]
> >
> > > @@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
> > >  {
> > >      target_ulong mstatus = env->mstatus;
> > >      target_ulong mask = 0;
> > > +    int dirty;
> > >
> > >      /* flush tlb on mstatus fields that affect VM */
> > >      if (env->priv_ver <= PRIV_VERSION_1_09_1) {
> > > @@ -340,8 +341,9 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
> > >
> > >      mstatus = (mstatus & ~mask) | (val & mask);
> > >
> > > -    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
> > > -                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
> > > +    dirty = (riscv_cpu_fp_enabled(env) &&
> > > +             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
> > > +            ((mstatus & MSTATUS_XS) == MSTATUS_XS);
> > >      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
> > >      env->mstatus = mstatus;
> >
> > This patch, and more precisely the above two hunks broke
> > qemu-system-riscv64. More precisely, when running a Debian sid system
> > inside QEMU, sshd hangs during key exchange.
>
> The problem is that at this stage, mstatus != env->status. Prior to that
> patch, dirty was computed exclusively on the new mstatus status, after
> the update by val. With this patch, riscv_cpu_fp_enabled() refers to the
> old value of mstatus. Therefore when FS is changed from "Off" (FS = 00)
> to "Dirty" (FS == 11), the SD bit is not set.

Thanks for reporting this!

Can you try this branch (it should be a PR to mainline QEMU soon) and
let me know if that fixes the issue?

https://github.com/palmer-dabbelt/qemu/commits/for-master

Alistair

>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net

