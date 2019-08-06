Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F32C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642C020651
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGS0x2on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642C020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwC7-0008AW-OU
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 05:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huwBf-0007eR-RT
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huwBe-0005QU-PB
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:55:23 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huwBe-0005Nr-GZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:55:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so84986650otq.6
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bPXYZJMTNoLajk96h5a6B0Oeqlu3okr2ghnhZP4/sgo=;
 b=TGS0x2onOOLm9F82P2Dy2vI58pxs0x0+O1VabogPfM3WLV3QtGYMZSaNtRVs7+8zs2
 WueVyR7iwRGEKq83GKXgKxNtAenE7SlTtER8GLlNtY3vGFP5tuplGEZKrDMYC5HduK9l
 xiLrkl4+sBJHhtVExPe18N86K0PFgBWx7HKw4BJTxCGwrfg7psngllQUNiPr5ps67jWb
 di6aV7XoY62EqfnnMf12rU4LrmiYYnWRkNVD2wRVtgAN44X5dCRkfTdsFJr3OAfa1+wr
 TGAz1DCVd1i7UGF0ilt531RbMyWsFDpxAc8DqEpXcC1ZEQsIWQfvv6jgK7ywfvTXTzDZ
 +ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bPXYZJMTNoLajk96h5a6B0Oeqlu3okr2ghnhZP4/sgo=;
 b=cvna7Apf+EswbTWCIBCE09mU++RkILZ6xG8aSwPfWXkdM6/xWruCVpTxGX5lfIaSwd
 YxOM0V93P2aXPm6itiFPhpfuIPR76ZP5eLQ7M1ZupO9XSaIel9bIOJetygz9aYYPDvVr
 9Z7vfQB6wTfQJgIZK0rEI0lkrPJxJunXqJ0XAieJHO+xlE+n3Kh6oO375RK2KGEzPXUn
 jdRRLogVNcMDBGOFB6+INbhSTWhLmYsstRCX8XTGwXtLpYuVbYd9mmfROkEToA9CVkY5
 z6JMYQSKHv1EvIghzRDTCA/ebz/xxboGmI3QLAR3kzj2fYFGBqIEjSASVQNdxRU6T2V4
 K4dg==
X-Gm-Message-State: APjAAAU2ia5NhyuxHVEb1RP0XeBb6NxVV42KUL0dHD1yado/PSi4Y/Vm
 +5m2zhQz3kptbkenYJP+pzdZc4FnGdjIldhh/zy2QQ==
X-Google-Smtp-Source: APXvYqzWZa1qsZqm+JYfZ5jXQWKLp/g48frTeyVJ7+fafdVZM3hKs+Bvm2JND1PMykpXrX19zEJrGGHWnP441N5X6Yc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr2477235oti.91.1565085321445; 
 Tue, 06 Aug 2019 02:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-5-richard.henderson@linaro.org>
 <CAFEAcA-W7idBRdD-DHxrVqfnBsKmAOPZoQAJkaUVOcjnLnGugw@mail.gmail.com>
 <c7a3ef78-d541-aa0a-21a5-8b4f48db1fd7@linaro.org>
In-Reply-To: <c7a3ef78-d541-aa0a-21a5-8b4f48db1fd7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 10:55:10 +0100
Message-ID: <CAFEAcA-QzmZ8aaKU_qYbTtphgQNmNNTPH_C7YMF0-yJ0ZxeUiA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 04/67] target/arm: Remove offset argument
 to gen_exception_internal_insn
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 03:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/29/19 6:52 AM, Peter Maydell wrote:
> > I'm not so convinced about this one -- gen_exception_insn()
> > and gen_exception_internal_insn() shouldn't have the
> > same pattern of function prototype but different semantics
> > like this, it's confusing. It happens that both the cases
> > of wanting to generate an "internal" exception happen to want
> > it to be taken with the PC being for the following insn,
> > not the current one, but that seems more coincidence to
> > me than anything else.
>
> I don't like "offsets", because they don't work as expected between different
> modes.  Would you prefer the pc in full be passed in?  Would you prefer that
> the previous patches also pass in a pc, instead of implicitly using
> base.pc_next (you had rationale vs patch 2 for why it was ok as-is).
>
> Shall we shuffle these patches later, after the Great Renaming of Things Named
> PC, as discussed wrt patch 6 (pc_read and friends), so that the "offset"
> parameter immediately becomes the Right Sort of PC, rather than some
> intermediary confusion?

I think what we're really trying to distinguish here is two
orthogonal sets of possibilities:
 * take an exception, with the PC pointing to the following insn
 * take an exception, with the PC pointing to the current insn
and also
 * take an "internal" exception
 * take a guest-visible exception

(of which we happen to only want 2 of the 4 possible flavours at
the moment). I don't particularly mind what API we use as long
as the naming/parameter setup cleanly separates out the two
orthogonal concerns such that you could have all four without
having to rename anything. Possibilities:
 * have gen_exception{_internal,}_insn and
   gen_exception{_internal,}_next_insn
 * have the functions take a bool for "exception on this insn
   or on next insn?" (not ideal because 'bool' parameters are
   a bit opaque in meaning at the callsites)
 * pass in the specific PC to use

PS: the "_insn" part of the function name isn't sacrosanct:
it sort of makes sense I think but if better names occur that
don't include it that's fine.

thanks
-- PMM

