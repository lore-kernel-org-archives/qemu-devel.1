Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A8F21726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKm5F/wE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A8F21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BpL-0000z1-6E
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1BnI-00083S-4v
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1BnH-0005Lz-8y
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:48:04 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1BnH-0005L8-1l; Fri, 23 Aug 2019 11:48:03 -0400
Received: by mail-lj1-x242.google.com with SMTP id e24so9284288ljg.11;
 Fri, 23 Aug 2019 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h8BKNZUfrDowpntTpQTXLqsa0BM3N7JYQ28TeZBCjeI=;
 b=QKm5F/wEQXnM7pkzKpFzYOPF0HSJaGP0JBUGwrk3ZZTOcVM00QM7CCyqgXwIRYlFIl
 cVHIc83jAn/6fWS/ooALZVCYMYAj8qB59BfnoAPfgQ74+I2sJQl92Bq1Dkb4xHhNjWoK
 t8cSWHo9xl27BEWex8jiTX+zlT/WiBCRxoYuwuQOftdcB3+KJSJ/g3HjOfx+lWtUZThD
 IB7OdrIuPQTBdF745qgE7F4za13JSHTKsesye1m5953qcFoT79zSPt6rbx+qn7yrb/vv
 5qA3QWFPGIVrubyzw+wwC5LLHjf20qp4Pg6rPGP2II/MygO9qR4TyggsT614RXBDAVUI
 jR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h8BKNZUfrDowpntTpQTXLqsa0BM3N7JYQ28TeZBCjeI=;
 b=BO1R2MC4edxBPiRBpg/z89jhKYk9OFNOxDij1VwA6VpXA3QLPb3dRjyP+ci+9/JiKM
 MQQdk7K63A+vv45y7l41FarIZ19MvzoDSPkQCdxakRB4c1dBhQoHWoop8qqXBr2qVeAe
 xXZYu9FoGu522vqnqFWrQtaKKJOcMyvfV+IIgzeCUZn7BYHWLFxF5l4VvTF0ZRdpuno3
 9xAiN2QJfkMEXGKYTsnRXBu1rxKQ+1Jfbd4vvPwSutU9KkwgG30MVNYpgo3D3L2JAjun
 DPZJNrV5WQH8ilrzga7Qg4Bz5KzwS1VSszzC4/a5mirq1E0dJz3sA/EjdySoRu5XCpgl
 cLwg==
X-Gm-Message-State: APjAAAXsiTOD623GOMV3RUDWFA8LTdDub1yiS91d/XqUAN3p+RZOnRqX
 9lk5ELpuVBNePy21aLYFg1cvVC+zKInEcbtOxZM=
X-Google-Smtp-Source: APXvYqzrOg4Ei8bH8BwOhKKhofZpesonZpwB1PztffYihpILOaJSWXzFO14q+62fFaI8zGBG+pws8VsTTKe8XD1ux1Y=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr3401058ljc.85.1566575281417; 
 Fri, 23 Aug 2019 08:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566573576.git.alistair.francis@wdc.com>
 <066a2c520c38b0c175c052d6a3385d5661764833.1566573576.git.alistair.francis@wdc.com>
 <CAFEAcA8G8ufziwwLLWo6BQZtAHWjzt_3XMMveuMMxknKSgChNA@mail.gmail.com>
In-Reply-To: <CAFEAcA8G8ufziwwLLWo6BQZtAHWjzt_3XMMveuMMxknKSgChNA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 08:43:55 -0700
Message-ID: <CAKmqyKN__eTBhJs-5fqB1zL0ZZaS017tJ3Khc8Afoej9aFCSqA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v4 7/7] target/riscv: Use
 TB_FLAGS_MSTATUS_FS for floating point
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
 QEMU Developers <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 8:44 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 23 Aug 2019 at 16:37, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > Use the TB_FLAGS_MSTATUS_FS macro when enabling floating point in the tb
> > flags.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index eb7b5b0af3..0347be453b 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -301,7 +301,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
> >  #else
> >      *flags = cpu_mmu_index(env, 0);
> >      if (riscv_cpu_fp_enabled(env)) {
> > -        *flags |= env->mstatus & MSTATUS_FS;
> > +        *flags |= TB_FLAGS_MSTATUS_FS;
> >      }
> >  #endif
>
> The old code was setting the bit in flags only if
> it was also set in env->mstatus; the new code sets
> the bit unconditionally -- deliberate change ?

Yes it is deliberate as the riscv_cpu_fp_enabled() function already
does the check. The function contains the exact same & operation
inside of it.

Alistair

>
> thanks
> -- PMM

