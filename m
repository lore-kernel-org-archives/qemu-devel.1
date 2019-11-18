Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A649C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EDF222DD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lfg/nDRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EDF222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoWk-0003MP-To
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWoTW-00080S-Sw
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWoTU-0001nQ-UV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:22:22 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWoTT-0001mO-1F
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:22:20 -0500
Received: by mail-oi1-x242.google.com with SMTP id a14so16764399oid.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jRDi7HYnf8c4TF3RQNVQKw+I2dKGd0rVFRaPLUds7no=;
 b=Lfg/nDReTI+tpyP7sixHXhbL9lQAxCgx0jA+8oUGK9/zUO/tuaxZhAnkavQvbohn24
 n6EgBDjblqU7n8Cp4wKA0uMHv+SDQqfMiaSZ7/RxOZy/f6RzBRsBuRFK8qqbnWgdDbeA
 JWlylXIp2cwETXyChmDYLPihCx8hwqNh7TaTIcDWXaXbrbCRb4FIrgrAsFGTVuzKyZZF
 HgS2eZyskUDnrIl8hskmqNT/dnihK9/rD5QVaf01fufjhOi+VHsvNulVLNsml1Pw+eNz
 Lwz+14ao2+Z5CHlJvS+Cy+W54XZpxlAQlh9fsUBDougu2++JmLMx/cXJJXt1RvUmbyzQ
 DC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jRDi7HYnf8c4TF3RQNVQKw+I2dKGd0rVFRaPLUds7no=;
 b=WnYutsQaxzZwqc1wyQ4knOSRVQSOcasRiZoP3mJzqpymIBykUnAhJ4NP2MueZPnGd1
 Dc7IyM0MDnPN3P05k8MlGsEPk2RYoAN5NIE83lE/T92NdieeHMm84d9zVcjOjqF89E0B
 q710h6TmfZGjqRNjicFerIrIP0Svo4XwknzmkIRiyobekriUcABIxFtyixPHyCepkVki
 vCQY9m2dfMM1O/4hqV0Ib0qdNFYYieRQ6LMH64ErKeu/YzguacanJnBpHiMGvLfhpyPp
 lTVa1+WhrftrohelNvA37iGh0sA0ii3yPtwNMiufKXO/3VkbAMdbnx8VG4D4om0OWjQ0
 dOTQ==
X-Gm-Message-State: APjAAAWTFtM9FN/30912Gwmx6cjfOb6toOM7071FcSW/bFde++B8qdn/
 UCif7MVaO+WEO0mGVNgGi3a7zHbj3QrF91xQtFqK3A==
X-Google-Smtp-Source: APXvYqziMH9C1DI+STIDdxTRJhSXecI4wF6Z04VvjRtwyAbYAygNSUT2d/g+cYRqP/xLgKitHoNhpJM7FSK5IFpXyNc=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr911291oij.163.1574112138024; 
 Mon, 18 Nov 2019 13:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20191117090621.32425-1-richard.henderson@linaro.org>
 <20191117090621.32425-3-richard.henderson@linaro.org>
 <CAFEAcA8FdT8R4_nwUQ1QLBMBST_K0xuHABER3f8kt6JY1vYojw@mail.gmail.com>
 <f8071794-cb5f-d987-0e7d-11a70ba4d2bc@linaro.org>
 <CAFEAcA_qF6e_4_7syRVomag31pMgX02=R7JJ7a5pW_r+MU-aaQ@mail.gmail.com>
 <59a944f9-45f0-b78f-6ec3-5e96fe804767@linaro.org>
In-Reply-To: <59a944f9-45f0-b78f-6ec3-5e96fe804767@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 21:22:10 +0000
Message-ID: <CAFEAcA_f9bqh-d3=kZem_=SCokGgr-ZDeJnGkirBojYy58xExw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Relax r13 restriction for ldrex/strex for
 v8.0
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 20:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/18/19 6:53 PM, Peter Maydell wrote:
> > On Mon, 18 Nov 2019 at 13:16, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 11/18/19 2:10 PM, Peter Maydell wrote:
> >>>>      /* We UNDEF for these UNPREDICTABLE cases.  */
> >>>>      if (a->rn == 15 || a->rt == 15
> >>>> -        || (s->thumb && a->rt == 13)
> >>>> +        || (!ENABLE_ARCH_8 && s->thumb && a->rt == 13)
> >>>>          || (mop == MO_64
> >>>>              && (a->rt2 == 15 || a->rt == a->rt2
> >>>> -                || (s->thumb && a->rt2 == 13)))) {
> >>>> +                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
> >>>>          unallocated_encoding(s);
> >>>>          return true;
> >>>>      }
> >>>
> >>> These cases for r13 are indeed no longer UNPREDICTABLE in
> >>> v8A, but they are still marked as UNPREDICTABLE for v8M...
> >>
> >> Ho hum.  I knew I should have looked at that doc as well...
> >
> > I would like to get this in for rc2 tomorrow, so I propose
> > to squash in changes to give the following result (basically
> > turning the ENABLE_ARCH_8 checks into checks on a new bool 'v8a'):
> >
> >
> > diff --git a/target/arm/translate.c b/target/arm/translate.c
> > index b285b23858e..4d5d4bd8886 100644
> > --- a/target/arm/translate.c
> > +++ b/target/arm/translate.c
> > @@ -8927,15 +8927,17 @@ static bool trans_SWPB(DisasContext *s, arg_SWP *a)
> >  static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
> >  {
> >      TCGv_i32 addr;
> > +    /* Some cases stopped being UNPREDICTABLE in v8A (but not v8M) */
> > +    bool v8a = ENABLE_ARCH_8 && !arm_dc_feature(s, ARM_FEATURE_M);
>
> Sorry, I wrote the patch but got distracted with other bugs without getting
> around to posting.  I had solved this with a new ENABLE_ARCH_8A, but this
> version works for me as well.

At some point we should decide whether we prefer these ENABLE
macros or just to open-code arm_dc_feature() calls, because the
current mix is a bit odd... (for code I've written I've tended to the
arm_dc_feature() approach).

thanks
-- PMM

