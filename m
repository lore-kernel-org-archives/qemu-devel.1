Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC96C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2112220692
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdgW06jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2112220692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iowYg-0005XD-9G
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 16:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iowY0-00050B-Gg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iowXz-0007rG-7W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:37:56 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iowXz-0007qE-1A
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:37:55 -0500
Received: by mail-io1-xd41.google.com with SMTP id z193so983327iof.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qRpNJIt+CAndQFmPpKh8U4lC5A1EfPHkDTbFLIWjsAc=;
 b=EdgW06jqsnL9nc9Hp+LW2X7g5NfcAM5m2NZ7ZmjiOn3Z4oKKbjtaf4aco9DQHuaG3q
 xLwXbkoUx/lBLxE3jW8wUb97gP/dyS+iPo44OVCur7us6HD6LFQVgx+fihT6BPfzWPxX
 yEjzTEYq/nLX/qCNBu/DYNSsKiGRbq7l5GR4iejRz7qluzdhRqU+2Vr5mvMWyfU4Ca7v
 yUGX0XRenbBbIN2cVEqaPIOEi4CWOHHX4ZacfVCGpBc2zGDJtFthd4YajmjqjSi282ql
 ovL+sG18MutNr5G5sAYTn7tqdkEzlIxQsyYeiAMyUTIVtwfiUyw88iZ+ygqWjjOP7an/
 HiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qRpNJIt+CAndQFmPpKh8U4lC5A1EfPHkDTbFLIWjsAc=;
 b=aIH9/nnGXTBK+Fj6+jZcbZprn24EXes1BbjDctBC1yx/uSMxOAoyDs1YwZQVDvW0N7
 BvRtiowXxB4YSl/Luef2EUnHPrlZahJ3A1foncezau2pgucfuSIJSscqg0zpwuctFK6c
 5wyEPLXZnNkW/D59q2OSE+YJMTWokG6vUQzGtKph7BQm90BcLUNS2nuJa4asAk5F1dd6
 LxkvuCb0yaYLLoqk6cVdiYNHI8wJKq7bVb2UBokttqM8D2F67WKwPoH0lLDCML1yrBVv
 k501doLS+Wc7+0a7AXJyKQle7biq7n2L7kGg+zdkDEKnBv20xiog1ke896cNxViR0I1r
 oLfQ==
X-Gm-Message-State: APjAAAUmLi5Yox6fJzSFXBxt6uJC/OhhXqvUwcFRnggjsMa8bTIZCBHH
 ysWeBoP83zPGuJNK++Hftq4d/tJ/ov6rtPpmFg3pTA==
X-Google-Smtp-Source: APXvYqxhFGcd2wq8eesIcEguBnhQqFUiawiB4Tj3pKbC8iHAA+vQA6wvXBLVuZpLphEowlTWXnkByNXSLBsimQQFlAw=
X-Received: by 2002:a05:6638:76f:: with SMTP id
 y15mr1476560jad.5.1578433074064; 
 Tue, 07 Jan 2020 13:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20191220202707.30641-1-beata.michalska@linaro.org>
 <20191220202707.30641-2-beata.michalska@linaro.org>
 <CAFEAcA-M=P=-6t5RX0bdO-8fbcd-_Ar_aBNskzs49aspvZ0+7Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-M=P=-6t5RX0bdO-8fbcd-_Ar_aBNskzs49aspvZ0+7Q@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 7 Jan 2020 21:37:43 +0000
Message-ID: <CADSWDzu3jVj7kmcmLwY7D_j2ErN4S2G82ZKMzTsScqanHV=MzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] target/arm: kvm: Handle DABT with no valid ISS
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 at 14:28, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Fri, 20 Dec 2019 at 20:27, Beata Michalska
> <beata.michalska@linaro.org> wrote:
> >
> > On ARMv7 & ARMv8 some load/store instructions might trigger a data abor=
t
> > exception with no valid ISS info to be decoded. The lack of decode info
> > makes it at least tricky to emulate those instruction which is one of t=
he
> > (many) reasons why KVM will not even try to do so.
> >
> > Add suport for handling those by requesting KVM to inject external
> > dabt into the quest.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> > +        /*
> > +         * Get current PC before it will get updated to except vector =
entry
> > +         */
> > +        target_ulong ins_addr =3D is_a64(env) ? env->pc
> > +                                /* AArch32 mode vs T32 aka Thumb mode =
*/
> > +                                : env->regs[15] - (env->thumb ? 4 : 8)=
;
>
> Another thing that occurred to me last night -- why do we need
> to do this adjustment of the PC/r15 ? If this is the kernel
> handing control to userspace to say "this is not an instruction
> I can handle, maybe you'd like to try" then surely it should
> do so with the PC pointing at the offending instruction?
> Similarly, if we ask the kernel to inject a data abort I
> would expect that the kernel would do the work of adjusting
> the PC forwards as the architecture requires when taking
> the exception.
>

The code here is just for easing debugging from Qemu perspective
and that is the only reason why we even try to read the value of PC
- it is not in any way needed by kernel to inject the abort.
One can use the monitor to decode the instruction, provided it is still
available at the memory location pointed by PC (handy monitor_disas)
- that is why logging the address with decoded instruction,
as it is the only thing that is being done here. Still the address of actua=
lly
executed instruction for ARM would be PC=E2=80=938 (PC=E2=80=934 for Thumb)
that's why the adjustment.

BR
Beata


> thanks
> -- PMM

