Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F217C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4B22171F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCQZkC8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4B22171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwwW-0002Ba-DA
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwwH-0001gY-PB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwwA-0006O1-Ex
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:54:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqwwA-0005vn-7B
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:54:54 -0400
Received: by mail-ot1-x344.google.com with SMTP id l15so54748124otn.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aKhk4erY9ZehA+G4HHOTM66gQZJGI/LlLhKy6+qIZ6o=;
 b=cCQZkC8EZfhw3i4wc4kvU/iNlPr9n7AHtibh53G2DUeo8Mtx9JTa+OxXLA+TpESAWO
 Hu87v1/DVUYeM+/mmiMV77H+IHNb0+R9GZ9EF/5NMzcuPgExEdkWaS55gaOe7qhNvWpq
 nRc4EFapGFeGHI6i0EdAPZ17ye+gSv5tVjkwYk5TuE8+BrmHLsb8eL5NiibCpDdfESw0
 uxfyiomVAz99hBBLD0rO2DyuXgVA+YBY9rw38ZHA3c5EcC6jBq1gWDnJm9ziYV4WSzj1
 AVNJWNO5hCRiXKcle6UV/vmTmW9oYzmirkHCOQHQ8y2v7BdsyTlOalWooaPxF95LrrTT
 RmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aKhk4erY9ZehA+G4HHOTM66gQZJGI/LlLhKy6+qIZ6o=;
 b=DKrFCSd1to0wOI4qr68mX29RnjVhfbzFKF3mroLhdN3TUKLG9bZmsdSaO99bfI5HZ3
 ir3rk8d5y7UXq6kZL/kSdz1n5Y8YJMqoTK2BJ4p3ZukCctNq+6WtTB3V4HNTFolko1DJ
 JX+eNTm8EaIk/I5ijDcPlRmv8DAMHcWYAvN12VFDaDI12m/O/T9m6eZ+ArMplQ/rdSDk
 TuCv9KhOpLscP23avKZCvbYvK3eSzVlQwhsSy5opGxkC34kx2d3TxV7fAHHfzFVy/juQ
 D3hSauZ6/HSwdO7DPgBi4CK/JnssX879DSktIM3NhaA01GDHdkBXjnO/SxaW03LtEMe/
 VWPQ==
X-Gm-Message-State: APjAAAUpandhFVMBpHHulqd0hlJj6p+7FfX7YPFyvtnYVtMeH55XrK9V
 bEGmgJqJSgVInE+muQEyiQ0aW7yYfOhNZTz+ENLLGA==
X-Google-Smtp-Source: APXvYqz0D+R1n4qaO5wNZ3Kknmxr9TTLH6t37Ndva5LSbwJM1SzAPESYMn0iMTPsaVCG64Hk2xtCm+avxEn1AbaXUcE=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr10686844oti.91.1564134886035; 
 Fri, 26 Jul 2019 02:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190726094757.17779-1-alex.bennee@linaro.org>
In-Reply-To: <20190726094757.17779-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 10:54:35 +0100
Message-ID: <CAFEAcA9hZm3yDxjAceR5EB3-sS5b2qpRRj2x8gT=j-HhJDEHhA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3] target/arm: generate a custom MIDR for
 -cpu max
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

On Fri, 26 Jul 2019 at 10:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While most features are now detected by probing the ID_* registers
> kernels can (and do) use MIDR_EL1 for working out of they have to
> apply errata. This can trip up warnings in the kernel as it tries to
> work out if it should apply workarounds to features that don't
> actually exist in the reported CPU type.
>
> Avoid this problem by synthesising our own MIDR value.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - don't leak QEMU version into ID reg
> v3
>   - move comment into one block
>   - explicit setting of more fields
> ---
>  target/arm/cpu.h   |  6 ++++++
>  target/arm/cpu64.c | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 94c990cddbd..67f2af0e169 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1611,6 +1611,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
>  /*
>   * System register ID fields.
>   */
> +FIELD(MIDR_EL1, REVISION, 0, 4)
> +FIELD(MIDR_EL1, PARTNUM, 4, 12)
> +FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
> +FIELD(MIDR_EL1, VARIANT, 20, 4)
> +FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
> +
>  FIELD(ID_ISAR0, SWAP, 0, 4)
>  FIELD(ID_ISAR0, BITCOUNT, 4, 4)
>  FIELD(ID_ISAR0, BITFIELD, 8, 4)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 1901997a064..f99008d7da1 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -296,6 +296,23 @@ static void aarch64_max_initfn(Object *obj)
>          uint32_t u;
>          aarch64_a57_initfn(obj);
>
> +        /*
> +         * Reset MIDR so the guest doesn't mistake our 'max' CPU type fo=
r a real
> +         * one and try to apply errata workarounds or use impdef feature=
s we
> +         * don't provide.
> +         * An IMPLEMENTER field of 0 means "reserved for software use";
> +         * ARCHITECTURE must be 0xf indicating "v7 or later, check ID re=
gisters
> +         * to see which features are present";
> +         * the VARIANT, PARTNUM and REVISION fields are all implementati=
on
> +         * defined and we choose to set VARIANT and leave the versions a=
t zero.
> +         */
> +        t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
> +        t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
> +        t =3D FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
> +        t =3D FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
> +        t =3D FIELD_DP64(t, MIDR_EL1, REVISION, 0);

Comment says we set VARIANT and leave the "versions" (what are they?)
at 0, but the code says we set PARTNUM...

With the comment text fixed to match the code,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

