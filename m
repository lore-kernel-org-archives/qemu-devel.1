Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1134FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA6E2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3sHJx6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA6E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDxuB-0006wj-SL
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDxsA-0005gL-M7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDxs9-0004p7-F9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:33:54 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDxs8-0004mL-M0; Fri, 27 Sep 2019 17:33:53 -0400
Received: by mail-lj1-x244.google.com with SMTP id a22so3890360ljd.0;
 Fri, 27 Sep 2019 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=52Nl/hnrTdintPo+v2dNLw5Df8YagLSXj5rzf3GKQ0w=;
 b=u3sHJx6f1V3AhrD+T/KiXT3CGZRv/MvIm0mN7j8Ody9rmqVsBaJ23x6aEqhwi6qIYm
 GbCJ4snKAjgjHDhpAv20tSyTe/j5rNdIedIrhhzERm7j0jUx+1uu6GyXrN5dYUVdmnL/
 jd6yh5pTx1W3iIro6000p2TErMXuhsAKVlh1yH3mohvVMpq+saMM5CoxDQMErTpCgo0F
 JZFcSMyDVvForCfMS507LlUy2muhWaywCJKwNhmieaEUhbm2r8FKoqqnzQXQPDs1NhRe
 sy37BF3CZeV0izoBfS/c9E+0g0X4W2xTNoizwAnKJSudegNoprtLEEkriXoaLzDBIAai
 mRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=52Nl/hnrTdintPo+v2dNLw5Df8YagLSXj5rzf3GKQ0w=;
 b=J4HQHj33KTzZa7TsyIhVD1668bCdDOSemtYekR2wAcVhQO1icvsyXX5Vlvep/3UXgZ
 Dz7e0/60IFSD2xYqkkJeYntXvIbJP0fGJkDP32NmDdx0j2wULRwln2aoXQPQEZzHhFrz
 3a/V1xgo13fbY8pmZxdICYUZ/3JvE+YUa5LIXzPeajBUhLk7cUzC6zUey54qZBEo6D6s
 BN8oKLUO0si0AvpR+xX3NeCojaQwZUAYpwi5OjVg9oRn5OUf2LTQHrvu6oB+MrSszYFL
 HPRqz0pKi533ZXRh66hKZs3BNHg1nzsJNyAnAIs+rJTuJ1oAIDOCsu15Hwsis2LHYnPG
 s5Rw==
X-Gm-Message-State: APjAAAWzCEotzEbqF0II0oSkpSGCgOkZ2h+MhpilSs25nf+cuBhfuOhO
 YhxjnQD0RMSCMTAsISzXe3bTLwidEzboYvWfryY=
X-Google-Smtp-Source: APXvYqxMvt19AaHC82+q9Kv371N3TsPow5Kan4vED/+LgKS2XFIkMUucQDOtHkwjCzsZ+RjfQzBkiUMZ1J/oIT+kFnM=
X-Received: by 2002:a2e:3902:: with SMTP id g2mr4430722lja.196.1569620027988; 
 Fri, 27 Sep 2019 14:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
 <960d9622-8241-efe7-cee6-1d4a1307fbc0@linaro.org>
 <CAKmqyKP90UDcS4moAYvLVN2q+aZ_cqGwY2fEgfX8dCjsHW1Tfg@mail.gmail.com>
 <8248daee-d5d0-0576-ee89-bd1400ddf947@linaro.org>
In-Reply-To: <8248daee-d5d0-0576-ee89-bd1400ddf947@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:29:01 -0700
Message-ID: <CAKmqyKP86E9aJBKjrGzG7=A7dLDsfhFBdnDjc6pZjtECpticAg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 10:53 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/27/19 10:23 AM, Alistair Francis wrote:
> >> I'm curious about the motivation here.
> >>
> >> In particular, what difference does it make what cpu the TB is generated for?
> >> It would seem like the more relevant place to look for this is with -d cpu or
> >> -d exec where the TB is actually executed, which could well be multiple cpus.
> >
> > The main reason is that the sifive_u machine now has two RISC-V
> > clusters so it's useful to see what is happening on each CPU. -d cpu
> > and -d exec are much more difficult to comprehend so aren't always as
> > useful.
>
> Hmm.  I wonder if it might be time to find a way to be able to optionally split
> the qemu_log output on a per-cpu basis.  It wouldn't necessarily always be
> helpful, because we'd still have the case of a given TB being translated by one
> cpu and executed on another, but it could make some things easier to follow.

A per cpu-cluster basis would be useful.

Until then though this patch helps.

Alistair

>
>
> r~

