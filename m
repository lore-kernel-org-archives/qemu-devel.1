Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9BDC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEE42184E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="po6VEKvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEE42184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxVc-0008QW-5W
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqxVN-0007uo-Bl
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqxVM-0001cc-9Z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:31:17 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqxVL-0001Hk-W1
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:31:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id a127so39892590oii.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Js57P2GxEMkXfeB66CfbhBeEc4bvSPCyOyQZRR3vLy4=;
 b=po6VEKvIy26QR07pGgN1flfJ8l9sLtMJ3vo7gMJlfRZkcfw16HbFQ+g/hconvcsO4L
 RYVNdWp8/hM0BA99+LWqVPSvOqa0u4umow1hcn9b8LrlAzKzdaeD0Woc4sxq/gnQZ8R1
 ohfvgISzVcomizMSSlWDbOuQudFGwJfpQJZOUNFCdU+hfiG2ukQ1Ehwa8xEjcePzBCII
 WE6WIFyoZ81nPJT9KQIJBkfUeZ3qDL5+8qNwFN+R0riDYEHvXa08Xx1LC9pVnIe+aUji
 FYqDL384gIe9mnudwS7psZ0lY9BIsXIa6QBOirKqCw+Fwco6IuupIZNs1cIINRQsZ6s+
 sVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Js57P2GxEMkXfeB66CfbhBeEc4bvSPCyOyQZRR3vLy4=;
 b=Z8YUs/tqCgU55V6ofzimjFNMN7dmlKy8GjzssYQo1wKahfPnsGGiflQMMdaH9WInTJ
 5g8pouJS+uKkBMGtGPN0aRPNLKLjwubY5ZuFkOlkg/ZT66/jG24M5LZueuccuzbKWO0q
 ZLnfXoqoWfvaw/RjQcfURuFoUN6ogh41A66r8H2C7fvypqJqOkOhUmCJpYDJWa381Lvt
 pSjtnulM34XW/UX5QlwrGlXzZbPj2k25X53hfN604SO67uPjvVrCFl79uDjaD/p0kB7g
 EKK+2jDEMRSmT0fRaOVCNvSY2Y2d9ehwo4OhoqUI4nbiWSP5v0q2M+dk5cj6H1YNCgL0
 1Nxw==
X-Gm-Message-State: APjAAAVfVbgWKDIwn9iHV/4tHqS8XeoOUL1/mnmoWR12XYUKZNyo7Gms
 gOcO80On/GClfgpsfDcBtAZKUUEAwEhWuj6lXoRKBA==
X-Google-Smtp-Source: APXvYqz6/MwwkpRocL7QGNHFowlWkbxA6h04m6MXYMJk0xb6B1MlhmyGJST6pPXPJJYz/BhMXyLv3RPsu9vghIasVkU=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr47521352oib.163.1564137070904; 
 Fri, 26 Jul 2019 03:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190726103010.31741-1-alex.bennee@linaro.org>
In-Reply-To: <20190726103010.31741-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 11:30:59 +0100
Message-ID: <CAFEAcA9ioE_XcSuU_MXZAW=v-7Me6Nq_z9A830i+RswfNxGjcA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v4] target/arm: generate a custom MIDR for
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

On Fri, 26 Jul 2019 at 11:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
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
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

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
> +         * defined and we choose to define VARIANT and set the others to=
 zero.
> +         */
> +        t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
> +        t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
> +        t =3D FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
> +        t =3D FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
> +        t =3D FIELD_DP64(t, MIDR_EL1, REVISION, 0);

Comment still says we set VARIANT but code says we set PARTNUM...

thanks
-- PMM

