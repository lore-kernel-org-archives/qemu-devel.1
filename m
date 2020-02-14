Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A6AC3B19F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90191246C7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6vB1toV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90191246C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2diX-0001rO-PH
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2dhw-000107-J9
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2dhv-00041a-GA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:20:48 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2dhv-0003zl-AQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:20:47 -0500
Received: by mail-ot1-x344.google.com with SMTP id j20so9680565otq.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OUeacR2HSuiZ06xkS7nEFrztSocoM8juTLP1sGAzUys=;
 b=W6vB1toVxH2390oa63l7/zGQkRZJoLUl6Igs5FuYnDockDTRcmZtBYTymzfEIDpHx2
 RIcaqCCmEXHnpPD1a8IsTqUjpPDJBjFVxRMn3ZQrsvG6F9DQm7COwFc51/kpb6EqzqN5
 xShqvWsymbGtWQpzk73Zs9JYpaM9wB50rMWDp8BhD8qzeEH5XxhM/KuH9K1lINZdN+Oq
 LhxTtxBLNc1RG047oxXKdjUhcoG9WzzSCe7snZTdaj2waokwoTLKfRS7OS9CKo5VDrAv
 cq0wKaliQRfoQpxs0dlL2kjsFLp9wJT12mggMK4dTOun3lsWBO/U/2s3L/3DPnvGHo0N
 IFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OUeacR2HSuiZ06xkS7nEFrztSocoM8juTLP1sGAzUys=;
 b=ZNL5bVSQp/Efm/94XD8yoP9AfKRp2op+XAHZcZUDU8gHpzdPAbOCoZBk7srDbp6RwC
 b/QojtL8h08OxCVk3AzhzAHxbyxgqG9lUw8f09LIe0PuzRasgf8mD8cXL9hynAV6jvRb
 0XR2CWhXTQ+U5Qoud8y+fiCvBdSKRGwbpfnsiqO93XrVPMTLnfh4q5U3NOsUlP2bIkGv
 St/h/yLGy/dksYL2IfQ/hn9k1EANRlHmZvSgAjxG2TbsITit4OLG4CpLdybmgwDv9x9D
 5vGdMXdbAI+4uIgRrf4FvJTP17hosg3BqHItwljcE19u0OSYgEoAQarihB3uIKqP4Wk9
 CjeQ==
X-Gm-Message-State: APjAAAXnTqN0OU/aoip5BUR/UOIjddvKGb81fHPUeHTbFawZ/o7xRM2x
 cB2ysZIp04aDXdRzKBYqiuvgFMCNDhZjzpS16iz29w==
X-Google-Smtp-Source: APXvYqwKf8N4vzkR3moRsLNXWbTxO/g3ae6fcnUV1QAzducjRjZEkj8OImSZup2WpC+2COMI7ldnqdfXeL+mQuV46MQ=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2959095otd.91.1581697245624; 
 Fri, 14 Feb 2020 08:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20200208125816.14954-1-richard.henderson@linaro.org>
 <20200208125816.14954-4-richard.henderson@linaro.org>
 <CAFEAcA-ffaK7e2ACZvqXs3fcx22O3cyWHdKqoddmYu8z2ezJ1Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-ffaK7e2ACZvqXs3fcx22O3cyWHdKqoddmYu8z2ezJ1Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 16:20:34 +0000
Message-ID: <CAFEAcA81qC9UgMPJmLY0tZn5a81+JUb4EjDUP60CLhVrP5RRzw@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] target/arm: Add isar_feature tests for PAN +
 ATS1E1
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 11:28, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Sat, 8 Feb 2020 at 12:58, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Include definitions for all of the bits in ID_MMFR3.
> > We already have a definition for ID_AA64MMFR1.PAN.
> >
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> > @@ -3443,6 +3452,16 @@ static inline bool isar_feature_aa32_vminmaxnm(c=
onst ARMISARegisters *id)
> >      return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >=3D 4;
> >  }
> >
> > +static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
> > +{
> > +    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) !=3D 0;
> > +}
> > +
> > +static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
> > +{
> > +    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >=3D 2;
> > +}
>
> Didn't spot this before it hit master, but these feature
> test functions are looking at id->mvfr0, which is MVFR0, not
> MMFR3 !
>
> Also they're using FIELD_EX64 on a 32-bit register: is there
> a reason for that?

I've been fiddling with the ID register stuff anyway,
so I've written a patch that addresses these things.
Due out in v2 of my PMU patchset.

thanks
-- PMM

