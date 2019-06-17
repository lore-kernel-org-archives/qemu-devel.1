Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40FEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C532A2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O61tMpNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C532A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvYs-0005Ns-49
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hcv7O-0005aY-AJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hcv7N-0000Bp-6f
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:08:30 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hcv7M-00008D-Sv; Mon, 17 Jun 2019 13:08:29 -0400
Received: by mail-lj1-x243.google.com with SMTP id v18so10042100ljh.6;
 Mon, 17 Jun 2019 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0hrRRgMO2XtUkfzFyfRARDAR6X0+SctDDT9Im4dP8Vs=;
 b=O61tMpNTiqCuqJvEfhU0RpY5m+EgOAhk1sdhUpYhNkZWbCfbazN5cCPxNcQRVaWMF6
 P2s8VrNhj3+nQRgugfpFrdpATxsj4ZcPHRVN4vjxvrl3BVVkv6wfoLg81zY4bPtxADsw
 G/rUCzf/ryMKdKxVb4v9FNCPMnU8bk0yUw0nV3MT32pRLNUxu1hYHH4z+grPYnhmij0p
 nYnay7EVd003vmY0wnM0CnC4SWYffsToW1AtFJCcM3y8dMyOtXPvxpUHYmbVrIHtnNDM
 1qoVa63wInP4H+gXAnxGFvKSowCDG1K5OZN0uvOP1I9BWhDestgk05XWg/+HUT0FHrJ7
 Vgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0hrRRgMO2XtUkfzFyfRARDAR6X0+SctDDT9Im4dP8Vs=;
 b=L2HuH0elz20aT6HHFkcQxl/ffSPgW+X7EpF4D6hJAc5DZlEBorCl2rsSnMuH9LGrGd
 WhRTkfh2Iz7C6NZnnbFTP+qSN121ewF9zSIfpqDxygP4gK/tnOR1GICQnitoNWskPhNT
 VevsRyVMQt776CCgxKGMFMUXzqjG8xndj9aebLJ0RGeixfo4Za5JKe0AcntcAlQgRnCE
 okEb2i7hSDuTPQZanHdfnXXcBDG0zsP6X0YyL978oUz7U4NPzMoghhRYKYJSiTJja4Wn
 dO/TSskl1cv4xR/vF6n6trxh3ZoMzefWy6mswByTDRxWkILgOMD0ZkewDxkLsykjs4VT
 J9OQ==
X-Gm-Message-State: APjAAAU4+LPFcOHAVUgMnlAaZBG/3w1RUjNrUm10iy3mAbNwEngdeQeo
 xg+lqaRA/a4ARsVVlZ8cX3ukotDTWFEckrb6cB4=
X-Google-Smtp-Source: APXvYqyP7APFa0lOxtv7oP+QeA+1h/YjUDHpPlP4U3tcUB3+Hbu0VL2lIx9mJXbhvz5bdHq7X4yJDc8jC0rvC1nRsLg=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr323422ljg.33.1560791306223;
 Mon, 17 Jun 2019 10:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <d4664adffe008df43f2a0760dd4e2b9cb834b652.1558131003.git.alistair.francis@wdc.com>
 <mhng-bd7fc2fb-94f7-4afa-b03c-4f8674d5ade4@palmer-si-x1e>
In-Reply-To: <mhng-bd7fc2fb-94f7-4afa-b03c-4f8674d5ade4@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Jun 2019 10:05:39 -0700
Message-ID: <CAKmqyKNV8PY1hgXq7QO9SxwdXCWxCBGw5pvgSgBpPy4pVvB7Dw@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v1 3/4] disas/riscv: Fix `rdinstreth`
 constraint
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 2:41 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 17 May 2019 15:11:04 PDT (-0700), Alistair Francis wrote:
> > From: Michael Clark <mjc@sifive.com>
> >
> > The constraint for `rdinstreth` was comparing the csr number to 0xc80,
> > which is `cycleh` instead. Fix this.
> >
> > Author: Wladimir J. van der Laan <laanwj@gmail.com>
>
> I'm not sure what this tag is supposed to mean.  If this is the actual author
> of the patch, then shouldn't it also have a SOB?

I'm not sure either, that is the line that the patch had and I didn't
want to change it. I'm not sure what usually happens in cases like
this.

Alistair

>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  disas/riscv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/disas/riscv.c b/disas/riscv.c
> > index 3ab4586f0a..c2578a3c4b 100644
> > --- a/disas/riscv.c
> > +++ b/disas/riscv.c
> > @@ -614,7 +614,7 @@ static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01, r
> >  static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc02, rvc_end };
> >  static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
> >  static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81, rvc_end };
> > -static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
> > +static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc82, rvc_end };
> >  static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003, rvc_end };
> >  static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002, rvc_end };
> >  static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001, rvc_end };

