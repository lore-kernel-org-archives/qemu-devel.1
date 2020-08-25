Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F36C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700BE20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmuAGwva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700BE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZe1-0003uk-PC
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZdV-0003Tz-Kn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:09:17 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZdT-0001uH-W1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:09:17 -0400
Received: by mail-ej1-x642.google.com with SMTP id o18so16722459eje.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sk4ZsyIU63md/ZP55mGUpXUd53t8fEzxoXmffVvc3MQ=;
 b=QmuAGwva5pX/B1hSQEPCuNcah3etknMOOzXrSQV0KandJ4/oD7ATdPYg3FPIITYF+p
 3YSFECUdCQdBVemIbYOfBjMneJ6BMcGPII1aIbAuyAILn8qnp1ee3nfzd17IkdmU2Uwz
 iya6nt4duhihsfD4GrSRVIxK4ZlDCvjIPXBdY46IWORhrut8yQRuYI43BSZw0Yt8SnUD
 TmkC+rxsmti3PmDAk4TstUZdOIaaeRx88TRv/LoD2QNwaVj4+PvEs6xdaZS+8nloYdI6
 q8QBrELkaPOPYsBdnaoaTkzdubW4EFHjnmbohHB4h8U493aazajIRMjPxCV69irHmEO8
 mNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sk4ZsyIU63md/ZP55mGUpXUd53t8fEzxoXmffVvc3MQ=;
 b=a0b6QJXia6N3UwXNx6gXTSRjAgY/G4C7640HFVrX6LsR5ckwHMwYDoymPpcgTMFZQi
 v27Rn9cvX3/RbNGUOIJzVGXI2GkFi4xkB8uN8s47CcXVidtcr5MKNpb0ImHzHeK5ZPI+
 f/So7bKsr5A7lfhn2FCxZvKMj5u7KFXPi7e+o7/AEAcksTNpFbyT0kshoUkJTY+hnOtf
 N303t5Bmv1Sppw8SNDO2yb0In7S/AEUbcOn3jaDJkFfs96c0vat1MUAQi9HLVpb7xCg1
 Kvafsk3qwfBlTjY1FVNkZZy95NAXtafdhD+oCxkHMvb+JB+lgOqHAH2DsT4ucsXELR0Z
 CIgA==
X-Gm-Message-State: AOAM532EztjaWyhtIO1vu0ylnEomMpN3wuQLgDyHiVS2Qmtr4aGTED/i
 VBFvR6Gmx371IDkEuyDe2nPlWsJT5NzMDhbe0iFnfA==
X-Google-Smtp-Source: ABdhPJydHoHA/54c1mvlNnjlhl2yf8I+DagOYp8DlB9Lw6W9eHsbKYAQ/ibJ2VIIBr5Ou15BBe6u6mGhSntJYItwPz0=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr10333232ejb.382.1598364554341; 
 Tue, 25 Aug 2020 07:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-16-richard.henderson@linaro.org>
 <CAFEAcA9KPLqMkzT1ckdQPniJJ9y180YncJxfJ3W4TC_tvq9csg@mail.gmail.com>
 <e31f7e7b-bde8-c434-f692-a098eb4c086f@linaro.org>
In-Reply-To: <e31f7e7b-bde8-c434-f692-a098eb4c086f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 15:09:03 +0100
Message-ID: <CAFEAcA-bqAX1ExiCAhohYxBydV14w8xnC6Co95n371F29ksW2A@mail.gmail.com>
Subject: Re: [PATCH 15/20] target/arm: Fix sve_uzp_p vs odd vector lengths
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 15:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/25/20 6:43 AM, Peter Maydell wrote:
> > On Sat, 15 Aug 2020 at 02:32, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Missed out on compressing the second half of a predicate
> >> with length vl % 512 > 256.
> >>
> >> Adjust all of the x + (y << s) to x | (y << s) as a
> >> general style fix.
> >>
> >> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/sve_helper.c | 30 +++++++++++++++++++++---------
> >>  1 file changed, 21 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> >> index 4758d46f34..fcb46f150f 100644
> >> --- a/target/arm/sve_helper.c
> >> +++ b/target/arm/sve_helper.c
> >> @@ -1938,7 +1938,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
> >>      if (oprsz <= 8) {
> >>          l = compress_bits(n[0] >> odd, esz);
> >>          h = compress_bits(m[0] >> odd, esz);
> >> -        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
> >> +        d[0] = l | (h << (4 * oprsz));
> >
> > Why did we drop the extract64() here ? This doesn't seem
> > to correspond to either of the things the commit message
> > says we're doing.
>
> Indeed, the commit message could use expansion.
>
> > Also, if oprsz is < 8, don't we need to mask out the high
> > bits in l that would otherwise overlap with h << (4 * oprsz) ?
> > Are they guaranteed zeroes somehow?
>
> They are guaranteed zeros.  See aarch64_sve_narrow_vq.
>
> >>              for (i = 0; i < oprsz_16; i++) {
> >>                  l = m[2 * i + 0];
> >>                  h = m[2 * i + 1];
> >>                  l = compress_bits(l >> odd, esz);
> >>                  h = compress_bits(h >> odd, esz);
> >> -                tmp_m.p[i] = l + (h << 32);
> >> +                tmp_m.p[i] = l | (h << 32);
> >>              }
> >> -            tmp_m.p[i] = compress_bits(m[2 * i] >> odd, esz);
> >> +            l = m[2 * i + 0];
> >> +            h = m[2 * i + 1];
> >> +            l = compress_bits(l >> odd, esz);
> >> +            h = compress_bits(h >> odd, esz);
> >> +            tmp_m.p[i] = l | (h << final_shift);
> >>
> >>              swap_memmove(vd + oprsz / 2, &tmp_m, oprsz / 2);
> >
> > Aren't there cases where the 'n' part of the result doesn't
> > end up a whole number of bytes and we have to do a shift as
> > well as a byte copy?
>
> No, oprsz will always be a multiple of 2 for predicates.

Ah, I see, so final_shift is a multiple of 4, and (if it's
not also a multiple of 8) the last byte of the 'n' part of
the result is then 4 bits from n[2 * i] and 4 bits from
n[2 * i + 1] making up a complete byte.

thanks
-- PMM

