Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2020C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26F5205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYzdmrQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26F5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Z2l-0004WJ-Ub
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Yzu-0002m0-Ly
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Yzt-00025p-GO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:46:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Yzt-00025W-AJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:46:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id r20so18196078ota.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fMdFblafD94Pg7EdUX7Bt3ViF3OCQnoMFCqUfT0Ylhc=;
 b=OYzdmrQ7NUlZI5AHNhnQeSe/nXlwYW7SgwRsA3b4L3D4bw/w+K2BVF3cPycscudlKe
 GhDWhkO4j2ZHqXOKB7/2/WQKWA01ljQ1bX14B36OvJiuRfL3kF7S2R4Tn2RHdtN3yyJ0
 nsUGlQ7F/hUWGIK2GQAQ+NdtrsQTESXKUmZQB1BGfB3/a5brBesXKgsJxKK5LDKBVxce
 e7I7SWNNu2NXn7hDYWAI/IznuRR3XVEpLZ7Z4FDTVFnqaiFnFMun72vRstwJ49MJvN+g
 ij0DnBFyy5WO7hEQwmNnUvEEp6g2+rLIbV/KUIfCST9sJa4ajKzHEYzzcjUcSLE8nXv1
 60Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fMdFblafD94Pg7EdUX7Bt3ViF3OCQnoMFCqUfT0Ylhc=;
 b=DyiBRd8i21A3MsBPx60MAzFaL4DveqlutHLwbFXP60R7XM6+EhWaq5w4eFoWDIJSqA
 Bjr1jkG9M+EbKNWneuJLbVcpgjO8eH5KARANRia1DXe+t1AqwU38bD43145KOKMLkbFk
 9tLyNqdQwGEs4D5cFpRH5sVd+uUmWT/EQsl68ZriMSGTuP6DJYiNKVnl9LROPGg602/T
 S+KOxUrrZSY/7fVRk3hCiECf2D/8xqZ47PHiYnz8/PmFLt98c/PharfYZmrG08ndaR/2
 aydYbZ+TKX5nzvo+E2Y/gMnjZnPzV9tCuQGjiPh2OXCgd+fFLT6llMjGG2ibw0yhyuWi
 jbtg==
X-Gm-Message-State: APjAAAWDxZ9+7C/T1uhJB7LWa9g1/HefvM8vYsn7W+hqR9eTugOG4MwG
 LUi64xlF2NQd7CkaITgdlo1lUpoRiqX/rcr669g1SA==
X-Google-Smtp-Source: APXvYqz+qr6DbHrCGeKO5sjiN6LXB+EVCMhdO0GKn3itELiX0QcqmzRdd+Lr8HFEZ5rPidZsJyQKwYJJ99++ILl2Exc=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr1098975otf.97.1566902804446; 
 Tue, 27 Aug 2019 03:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-22-richard.henderson@linaro.org>
 <CAFEAcA8saD6zkOA7-6nF5jQBMgKPLv0L3WXV2m0Y4WtHwVqWgw@mail.gmail.com>
In-Reply-To: <CAFEAcA8saD6zkOA7-6nF5jQBMgKPLv0L3WXV2m0Y4WtHwVqWgw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 11:46:33 +0100
Message-ID: <CAFEAcA-PG1Jd2F-DLp7yKQest3aWqb3pv4FjUB9movDf4VgWgA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 21/68] target/arm: Convert
 Synchronization primitives
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 11:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/translate.c | 560 ++++++++++++++++++++++-------------------
> >  target/arm/a32.decode  |  48 ++++
> >  target/arm/t32.decode  |  46 ++++
> >  3 files changed, 396 insertions(+), 258 deletions(-)
>
> > +static bool trans_STREXD_a32(DisasContext *s, arg_STREX *a)
> > +{
> > +    if (!ENABLE_ARCH_6K || (a->rt & 1)) {
> > +        return false;
> > +    }
> > +    a->rt2 = a->rt + 1;
> > +    return op_strex(s, a, MO_64, false);
> > +}
>
> I've just noticed that there's a bug in these checks -- the
> M-profile CPUs don't have the V6K feature, but they should
> still have STREXB/STREXH/STREXD, and with this test they'll
> incorrectly UNDEF them.

...OK, not this specific function, as I just noticed it's the _a32
one, but trans_STREXB(), trans_STREXH(), etc are wrong.

thanks
-- PMM

