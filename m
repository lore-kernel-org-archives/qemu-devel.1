Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6B920644
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7t5bgJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6B920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzpo-00071o-KZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1iAzmT-00058U-VC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1iAzmS-0006OO-Tt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:59:45 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1iAzmQ-0006LK-85; Thu, 19 Sep 2019 12:59:42 -0400
Received: by mail-lj1-x244.google.com with SMTP id e17so4281258ljf.13;
 Thu, 19 Sep 2019 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fXq/CJAkjIlUrA7ulzeCY/7Lh2+aL00qHpfQzFW/RSA=;
 b=P7t5bgJAAhwzyF4RhvG411jOvFZ7EMd6XMk2PHwFl/EWyS0d2rqHUUN3wGNVHoznHE
 vChbPsnXfTynKg6gUgutf5icXKS3/6PFAEv941YQHAmkaaN/obQeD9uKStQw+R0e45nx
 q1sn+6AYEGdpfqhCMu9H4Lybq065uIDtZLwhZxUwAXZsYbxa/JhpGpYK0I8X+5t+tQCx
 R3WVY5HzQRjSHOF81M/8LoLBthlN8zeB2KDbXluR8bwkuIS3b+x6Dhh72gXrGnqZPiGM
 InA8s8ZWsDD2L816NCUTjxoSTHTKuDrbH8XHS4c+dWO5Fx5yHp8CC+iSRuWtB2UmFKUC
 CHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fXq/CJAkjIlUrA7ulzeCY/7Lh2+aL00qHpfQzFW/RSA=;
 b=E/pWbKeflmQPrboi5o+Uk5XH2Q2BEGIkr17T3ubUeaE1/IJoW2KJ6a0d0BukMfYWyx
 Bfo44XEUSQNgrW0TLSRTRaIf6kXD6NWl0r867Uu033hfX8SdqDveGW2L+0VrikpjcXfO
 ph6pQaRQr/LUyTcuh8qKrjq/YFhYVl/iyANqFP2+iKdNOHItQAyvAZS7a+Pice+Ex9qr
 Cjd5YLWOavnv7A0jgcHay2yedV4zDdwnK/Psm1AukKr7rkNmhNVxeKmpO7xIj2QbSesj
 EU80QYfX3GT6zLR4NeoMzA7iBBeJHr7yEmJY0BBN/UQX9ypHOC5TaJBC7gcB3QmQscIa
 5Nrg==
X-Gm-Message-State: APjAAAXQYGpbDp1ifNEZdkKePAWrwHfU7LxC8NzerqQZ34NVuSswWD6U
 Kb2yYEGeyZPErvr80n7kK4pYoe6r1+yJ349IAjY=
X-Google-Smtp-Source: APXvYqygCVfYIMMKo6iG2cltIZIYVjrycZSGE0Izyk3ZJSI3Wv6T2QiuaALARmw4u9YcLIXkSYoITxW9Up/Xp3icivg=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr5947753lja.161.1568912379933; 
 Thu, 19 Sep 2019 09:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <850360df8fc15a3671bf2237f972ebaf09110015.1566603412.git.alistair.francis@wdc.com>
 <mhng-b813f03d-c23e-405a-8213-c4c9b22a6831@palmer-si-x1e>
 <CANnJOVFNqXEg9KkJC4CHkt0KTt2_6HjyhU2CvMROW+e79mDncA@mail.gmail.com>
 <CAKmqyKMfODSjbBm5ZgmHYYzzrf3B_4WEbANeKXo6rSO6V5Pzeg@mail.gmail.com>
 <CANnJOVGPW1ppNdx+=KAvgNhgGQPvJxjyGY=rxunicu=f++xhiQ@mail.gmail.com>
 <CAKmqyKPQPrPKdkaRjZ7P75jamuqEq6BABir56VrYGm=ZSFpAww@mail.gmail.com>
 <18b87754-d5b2-e4f1-bdc5-92ad26b97379@linaro.org>
In-Reply-To: <18b87754-d5b2-e4f1-bdc5-92ad26b97379@linaro.org>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Thu, 19 Sep 2019 12:58:40 -0400
Message-ID: <CANnJOVEsF57FBbNxJ_WvL3O7iJ_mZijYikC_aNhxKcP856qTzw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 10/28] target/riscv: Convert
 mie and mstatus to pointers
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 10:50 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/18/19 4:47 PM, Alistair Francis wrote:
> > I'm not a fan of the pointer method that I'm using, but to me it seems
> > the least worst in terms of handling future code, keeping everythign
> > consistnent and avoiding complex access rules.
>
> FWIW, I prefer the "banked" register method used by ARM.
>
> enum {
>     M_REG_NS = 0,    /* non-secure mode */
>     M_REG_S = 1,     /* secure mode */
>     M_REG_NUM_BANKS = 2,
> };
>
> ...
>
>         uint32_t vecbase[M_REG_NUM_BANKS];
>         uint32_t basepri[M_REG_NUM_BANKS];
>         uint32_t control[M_REG_NUM_BANKS];
>
> The major difference that I see is that a pointer can only represent a single
> state at a single time.  With an index, different parts of the code can ask
> different questions that may have different states.  E.g. "are we currently in
> secure mode" vs "will the exception return to secure mode".

This makes a lot of sense to me. It means that any individual control register
has an unambiguous name that doesn't change based on context. They aren't quite
the same names as used in the architecture specification (mie & vsie
vs. mie[NOVIRT] & mie[VIRT]), but they are reasonably close. It also means other
parts of the code can't ignore that there are two different versions of the
registers in play. Perhaps the biggest benefit though is that you can sidestep
swapping on mode changes *and* avoid needing any super fancy logic in the access
functions:

int read_mstatus(...) {
    target_ulong novirt_mask = ...;
    *val = env->mstatus[NOVIRT] & novirt_mask | env->mstatus[virt_mode()];
}

int read_vsstatus(...) {
    *val = env->mstatus[VIRT];
}

int write_mstatus(...) {
    ...
    target_ulong novirt_mask = ...;
    env->mstatus[NOVIRT] = (env->mstatus[NOVIRT] & ~novirt_mask) |
                           (newval & novirt_mask);
    env->mstatus[virt_mode()] = (env->mstatus[virt_mode()] & novirt_mask) |
                                (newval & ~novirt_mask);
}

