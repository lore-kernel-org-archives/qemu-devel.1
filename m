Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF1C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F976206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE5NrWVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F976206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mF1-0004q8-FV
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1mE4-0003rL-TF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1mE3-0004Nz-38
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:14:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1mE2-0004NY-Nz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581491662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aT5UiNf8gz7EGwt9+XmRFIld/RnBLY/7qtRI4rhcrME=;
 b=FE5NrWVYmvsvFtFENS/DG4EM1gHsE6nEKPRe2O8kwIkDLaskRsb2m3oW282D3GuKosFDLG
 hJuUxU8t77LuTjNqN/Vju3nH3uFBqhMeAXCa+3mTGy4FQw7GcDDj7YxH/sZdAozKZe1aOk
 FT0DJy1S2a6zJqR3BXsBOw7KU30Px/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-PyeRKo5dMuKCM8ChjUbgfA-1; Wed, 12 Feb 2020 02:14:19 -0500
Received: by mail-wm1-f72.google.com with SMTP id t17so348022wmi.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u3tnGTnKXIZFszcgkY4p1KSu60g0NmpIXqQvcc6mDgw=;
 b=R34COIXqsppNANaGWkcVHEtkVCQTNLIvy/lDhmB1UHFzrMwUZRLTIAuNKy70P28sQH
 PwXgMPeAP60EJ73CvQX0yKPhBaZ/zI4AbUyfe6ruUgV4N31Wj9QiZtl3auaGRW7qck/u
 aT5ErMF2pW6FEpFaM+iT/NaUCH3c3puZ41XdL+uHDKaEGF30sItjQWAVEpIlXAl94CPq
 eugomTCCklkd8z23Dqe3iOviUJ7PD/DDcQg2zYhiZ4f7LUqLnCC477l1My+tx5lCoIgz
 niIWbBpkr54l1OJrydYyjIHlWi8D/887Z7/9+i4pHMFOPHDlTlE3V7QBrKLyx0yy5Xl8
 NSnQ==
X-Gm-Message-State: APjAAAUSlSQ/8rQ7ssCrGxxCQhjSLi3X1YRZaBWRTEE6g2+WpmeHwK9v
 rXJsTrPCeMvScgTxQagF8n9c2ILmTQ/7lEouTK9SMGs27phPnpwImBKs4GheHLXjd+b/xGcSCtZ
 mYtOLRo0xtluMIsI=
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr13317778wrm.24.1581491658739; 
 Tue, 11 Feb 2020 23:14:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuH0wWLtSVjrGN5rXX6zXAGIiDIt6OWW5TgbpXQ3GGBIsalhml1IpzTc/GlrfwSx/NiQcCRw==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr13317746wrm.24.1581491658438; 
 Tue, 11 Feb 2020 23:14:18 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f8sm8471536wru.12.2020.02.11.23.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 23:14:17 -0800 (PST)
Subject: Re: [PATCH 13/13] target/arm: Correct handling of PMCR_EL0.LC bit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9e33251-9f9d-dc6a-efd9-6f4fcba1a124@redhat.com>
Date: Wed, 12 Feb 2020 08:14:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-14-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: PyeRKo5dMuKCM8ChjUbgfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 6:37 PM, Peter Maydell wrote:
> The LC bit in the PMCR_EL0 register is supposed to be:
>   * read/write
>   * RES1 on an AArch64-only implementation
>   * an architecturally UNKNOWN value on reset
> (and use of LC=3D=3D0 by software is deprecated).
>=20
> We were implementing it incorrectly as read-only always zero,
> though we do have all the code needed to test it and behave
> accordingly.
>=20
> Instead make it a read-write bit which resets to 1 always, which
> satisfies all the architectural requirements above.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c6758bfbeb5..1d8eafceda8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1023,6 +1023,11 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
>   #define PMCRC   0x4
>   #define PMCRP   0x2
>   #define PMCRE   0x1
> +/*
> + * Mask of PMCR bits writeable by guest (not including WO bits like C, P=
,
> + * which can be written as 1 to trigger behaviour but which stay RAZ).
> + */
> +#define PMCR_WRITEABLE_MASK (PMCRLC | PMCRDP | PMCRX | PMCRD | PMCRE)
>  =20
>   #define PMXEVTYPER_P          0x80000000
>   #define PMXEVTYPER_U          0x40000000
> @@ -1577,9 +1582,8 @@ static void pmcr_write(CPUARMState *env, const ARMC=
PRegInfo *ri,
>           }
>       }
>  =20
> -    /* only the DP, X, D and E bits are writable */
> -    env->cp15.c9_pmcr &=3D ~0x39;
> -    env->cp15.c9_pmcr |=3D (value & 0x39);

Ah this was missing PMCRLC indeed.

I was tempted to use 'Fixes: 74594c9d813' but the PMCRLC is "Reserved,=20
UNK/SBZP" in the ARMv7 reference manual.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    env->cp15.c9_pmcr &=3D ~PMCR_WRITEABLE_MASK;
> +    env->cp15.c9_pmcr |=3D (value & PMCR_WRITEABLE_MASK);
>  =20
>       pmu_op_finish(env);
>   }
> @@ -5886,7 +5890,8 @@ static void define_pmu_regs(ARMCPU *cpu)
>           .access =3D PL0_RW, .accessfn =3D pmreg_access,
>           .type =3D ARM_CP_IO,
>           .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmcr),
> -        .resetvalue =3D (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT=
),
> +        .resetvalue =3D (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT=
) |
> +                      PMCRLC,
>           .writefn =3D pmcr_write, .raw_writefn =3D raw_write,
>       };
>       define_one_arm_cp_reg(cpu, &pmcr);
>=20


