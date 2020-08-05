Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA3C22CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO/mKelE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA3C22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Mf1-0002I4-8z
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3MeM-0001lS-6Y
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:52:22 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36]:40963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3MeJ-0004nh-SU
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:52:21 -0400
Received: by mail-oo1-xc36.google.com with SMTP id x6so2207125ooe.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wQZEdO6IRmBkW9gAD+QQA+Rxogg7RwJiDbXkcomON+A=;
 b=PO/mKelEWXE/0m6tUMD1Nx0Qucvx9Rd/0E7vI9ZylOlCcAl0OS9fm2Qowph1/UQ23C
 G/hPoaqPzVLiHl2fAtw5kA/ycdVunMy7UqrmpbGGNbuPcHVW6QFAMXF3MJW43NgKMCpx
 nr08TVfOB4TI4Nc/HptDG7Am2G1TiOJnV/3Vz2286eNwX213Ru2bx4MbToKm2UFcAVHJ
 i53P7BPjvNnHjI0fmrrWLEoKuQ9rYHSLi/gcmTz/sI4SoERw4tWpZKKLO6qn2RZCEcch
 6l1NCDsU7+hiP5rx6ZnzaJHrxVmNigBkvs8vHfy2hCvHBMPn+/kjQbXZq2GpsV0NyGqv
 KPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wQZEdO6IRmBkW9gAD+QQA+Rxogg7RwJiDbXkcomON+A=;
 b=B1E+htCvchynNQMwa2Oza1o5wAjW/pcnYcPmPnaR/ngvysv4N4/HQbkp7yxcE4qPF3
 ZZ9gqzUlPf5i59/Eg+d2LdQ2cANyewqSUdzcteJEQJjiGXozy39ZOgtCPVze2YSJ9Eh5
 1MaHoGwsnjfm1HAdd3sQKm01J3jQRPJ8RdIpcG6IKxn5J+4gbzwu2VuCqs9vMwJSx2LA
 FlBws13e1vPoYu6EcYtj5otpLovBFPvmR2ADkGKxYhfRA2mdbf+anqFEBjw0wGfJSR5m
 o/6+J4F/so/vWWpMUXIfV+IqzJWVP+U725d/vXos0db6O+S+MDUcDh9c5lMw2Kk4RJsr
 ATdg==
X-Gm-Message-State: AOAM532Lwo/bxyfvAzQUZ1W3NcO1NWzNiSvaYrInfSls6wlRgx9ZTqvf
 LaoRU8SgAhjeE0qMx3wzEMmt1y5dlFH91HWmj34b9A==
X-Google-Smtp-Source: ABdhPJzYcgspKiWF/vBeQhRU+5YCSCJ60GUsn6XpwXQJTOfPrVjsOpsKR5V3OvO9ynMOJ8XbAAjPELz5wrD9deUk6mM=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr3728104ool.69.1596646338406;
 Wed, 05 Aug 2020 09:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
 <2c5ed9d8-6d79-1b53-5588-8fb9efebf0fa@linaro.org> <87tuxhkpo2.fsf@linaro.org>
In-Reply-To: <87tuxhkpo2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 17:52:07 +0100
Message-ID: <CAFEAcA8+acTg6KoBDW5-7FvnrW=vDMXohWfTAXtTFv6BDqyuRQ@mail.gmail.com>
Subject: Re: v8.1M cpu emulation and target-arm feature-identification strategy
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc36.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 17:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> I wouldn't test other feature bits but what stopping us adding:
>
>     struct ARMISARegisters {
>         uint32_t id_isar0;
>         ...
>         uint64_t id_aa64dfr1;
>         /*
>          * The following are synthetic flags for features not exposed to
>          * the directly exposed to the guest but needed by QEMU's
>          * feature detection.
>          */
>         bool v81m_lob;
>     } isar;

Nothing, except we already have a set of synthetic flags, that's
what the ARM_FEATURE_* are...

> That said we still seem to have a number of ARM_FEATURE flags, are we
> hoping they all go away eventually?

I think that they're a mixed bag. Some represent cleanups we
haven't got round to doing yet (eg ARM_FEATURE_NEON, which would
be a fair chunk of work, or ARM_FEATURE_PXN which would be pretty
trivial to change to looking at ID_MMFR0.VMSA >=3D4). Some are
features that pre-date the ID feature bit scheme and so might
be awkward to convert (eg ARM_FEATURE_XSCALE). One or two
we've already converted and just forgot to take out of the
enum (eg ARM_FEATURE_CRC)...

thanks
-- PMM

