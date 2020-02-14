Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66115C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAC72168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXrG9FL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAC72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fjl-0005Ym-CZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2fis-0004nu-6A
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2fiq-0004Eh-V2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:29:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2fiq-0004EY-Rf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581704992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twXFr5g8UVsMoaBHDUrPXcNoRKmFFbhpPjxtOLR26ck=;
 b=QXrG9FL916zLak67eCZHx6mYWV/P73ougBbKkVUFzquKh+JgJAkjxRtcEnXB+26RECyAsJ
 Jv1QkUBE9h8p5tL73ujuRpsklPDfV1wjwLPYHlH+Vso1B1Yi7W+g26wINf5tUwV7skA7HK
 SieAWfCgwbu9UgH8EAUl4oBK+W6Smq0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-zw75TvMHOuS44eANu_TiMg-1; Fri, 14 Feb 2020 13:29:50 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so4433512wrs.22
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1LznbrlwQCMxGKxblQGKg620jVOO43W3gRISRt1o8tY=;
 b=uOp5s7WA3JQcblxCyaoRXz5cEIpOdm9KjOvDfdyHl9gRu3sr695NElzRw3mL9fSjWV
 +YVvAUTL9LKUzzVkIzBfc/FuTDcDEKWoBUujblGNxToavyFy6GtxurUw/Veutu90cwzD
 QAjNPfYjzU1bMxCrf4vRxPQCWL3ILV27tYFlrnWrMzkt7nlgB1Hn5E5+ZgNFXM9hYEIr
 hweALwmHalJ7VqBGB9PaNIoLD0BPMPrZVOZkzqavY1R+DumJtsbDcwh2sHIR3dQi6Aw8
 4CFxDl3fJrIu/JBcMJqfpw1y2IktFe20PvcJVjU+1sURKAzfgN1pguEJe+2Fl8yR5A8u
 iwZA==
X-Gm-Message-State: APjAAAXfjKzf6YytmzeYQLfNHwo6juFKJ8/eTheFwD2Dog13BfzawBMB
 hEaYsOiOdUPGkgwuuHE4nyrmC2EJSEb6rngqeFnMI5Kh6vA8kFtjWe6Y5NbBviErxASsZrqBiTg
 O5xvd6KvtRCoHTl8=
X-Received: by 2002:a5d:494f:: with SMTP id r15mr5427430wrs.143.1581704989463; 
 Fri, 14 Feb 2020 10:29:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDXBA12PKvEv4h83KzkB5DWfzKpZHf5JsX/RB2M/P5AP2NGCUcCmvEqRszhsgenosSwi/ehQ==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr5427409wrs.143.1581704989144; 
 Fri, 14 Feb 2020 10:29:49 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b17sm8497194wrp.49.2020.02.14.10.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:29:48 -0800 (PST)
Subject: Re: [PATCH 01/19] target/arm: Fix field extract from MVFR[0-2]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f511ebeb-228f-0e77-38be-32c19862569c@redhat.com>
Date: Fri, 14 Feb 2020 19:29:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214181547.21408-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: zw75TvMHOuS44eANu_TiMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 7:15 PM, Richard Henderson wrote:
> These registers are 32-bits wide.  Cut and paste used FIELD_EX64
> instead of the more proper FIELD_EX32.  In practice all this did
> was use an unnecessary 64-bit operation, producing correct results.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e943ffe8a9..28cb2be6fc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3415,18 +3415,18 @@ static inline bool isar_feature_aa32_fp16_arith(c=
onst ARMISARegisters *id)
>   static inline bool isar_feature_aa32_fp_d32(const ARMISARegisters *id)
>   {
>       /* Return true if D16-D31 are implemented */
> -    return FIELD_EX64(id->mvfr0, MVFR0, SIMDREG) >=3D 2;
> +    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >=3D 2;
>   }
>  =20
>   static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
>   {
> -    return FIELD_EX64(id->mvfr0, MVFR0, FPSHVEC) > 0;
> +    return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
>   }
>  =20
>   static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
>   {
>       /* Return true if CPU supports double precision floating point */
> -    return FIELD_EX64(id->mvfr0, MVFR0, FPDP) > 0;
> +    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
>   }
>  =20
>   /*
> @@ -3436,32 +3436,32 @@ static inline bool isar_feature_aa32_fpdp(const A=
RMISARegisters *id)
>    */
>   static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters =
*id)
>   {
> -    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 0;
> +    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 0;
>   }
>  =20
>   static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters =
*id)
>   {
> -    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 1;
> +    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
>   }
>  =20
>   static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
>   {
> -    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >=3D 1;
> +    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >=3D 1;
>   }
>  =20
>   static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
>   {
> -    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >=3D 2;
> +    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >=3D 2;
>   }
>  =20
>   static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
>   {
> -    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >=3D 3;
> +    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >=3D 3;
>   }
>  =20
>   static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *i=
d)
>   {
> -    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >=3D 4;
> +    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >=3D 4;
>   }
>  =20
>   static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


