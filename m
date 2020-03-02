Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94436C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595E0217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5THGtS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595E0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ur1-0006CP-Hb
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8uq8-0005C9-On
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8uq7-00017a-Na
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:51:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50829
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8uq7-00017T-Ju
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583193071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuPz6n+BeBVA7+PsSxRCyYsGG4BT486cTX3EaSuJfTU=;
 b=H5THGtS4lTZaKYkwrCe7VUqaXV7SksbCOwpO2zfi+BRGtFDuRJJj1IUdiREoQjd85xD6CW
 yWxXOtNyTnMlDAgoBu3lCvWofMAu1i/Jh/i3I92p0GLM0vSPZ3xGvmspwqQ3/1CcgS0CzM
 ELYANEPc9SpDPIAVEyS24SUDpL+48o4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-XNzxF-gmMhuSYVTdkEoYVA-1; Mon, 02 Mar 2020 18:51:09 -0500
X-MC-Unique: XNzxF-gmMhuSYVTdkEoYVA-1
Received: by mail-wm1-f70.google.com with SMTP id c5so331896wmd.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n36ZH3tfqOtKU4lEeXMPPAyLS3rveIOnCwDlc1J1iLM=;
 b=hzJsnABjf92FBQ2qS0zeTxII02/s410e93B3iG++PHZobJesQjjVZYZWtNuAN6Mzq6
 3rIQMlsNe8hf5phWERhNIqMdy2N08GnQtJdcjgwVb8q7kSGI/sB622tmZxvYWCKPbSlE
 zht8fQPQS7FU13/QE4570GR1BqSTxjrPLOjcPp9xQMO0nGaVOWbj8jLXjfYUT4jNXVP9
 5HJKKu1GGu9fWRLIaZ7s1dpdWW2DGM06RmPR/M0d15zZc4erhBAq/dYmtBttxe6H36Ho
 fkeXYAnyH8UJgNO97vuAQZjaMRYHC/NtQD83xtPKji4B9ClnSYoiG479jtQHOU5dRwgJ
 b9sw==
X-Gm-Message-State: ANhLgQ0AcrLSQN+RYXMnPQ+/PXtT38aun3KkqnjRkLiKZn/wzLck+7Px
 WTmsy77MWtb6vKKE4fPWly5nnJAG8R3VMl93DNKi2lW+wegeE9PGMZD197KMzm5/I6GTkcierQZ
 1gwQBZz9lYBZ4ULQ=
X-Received: by 2002:a1c:5457:: with SMTP id p23mr771042wmi.45.1583193067496;
 Mon, 02 Mar 2020 15:51:07 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsI5VJnR8XcvTmOT9jrKw9X1fkrAKTJACUROr3u1r5nHjmcjbPmmsrsM4MEJgQpPYyUov3nOA==
X-Received: by 2002:a1c:5457:: with SMTP id p23mr770991wmi.45.1583193066708;
 Mon, 02 Mar 2020 15:51:06 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id j5sm30794631wrx.56.2020.03.02.15.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:51:06 -0800 (PST)
Subject: Re: [PATCH v2 1/9] target/arm: Replicate TBI/TBID bits for single
 range regimes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7cb1c45-6143-3301-1404-3145d6dcecdc@redhat.com>
Date: Tue, 3 Mar 2020 00:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302175829.2183-2-richard.henderson@linaro.org>
Content-Language: en-US
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 6:58 PM, Richard Henderson wrote:
> Replicate the single TBI bit from TCR_EL2 and TCR_EL3 so that
> we can unconditionally use pointer bit 55 to index into our
> composite TBI1:TBI0 field.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6be9ffa09e..37ffe06c05 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10316,7 +10316,8 @@ static int aa64_va_parameter_tbi(uint64_t tcr, AR=
MMMUIdx mmu_idx)
>       } else if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>           return 0; /* VTCR_EL2 */
>       } else {
> -        return extract32(tcr, 20, 1);
> +        /* Replicate the single TBI bit so we always have 2 bits.  */
> +        return extract32(tcr, 20, 1) * 3;
>       }
>   }
>  =20
> @@ -10327,7 +10328,8 @@ static int aa64_va_parameter_tbid(uint64_t tcr, A=
RMMMUIdx mmu_idx)
>       } else if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>           return 0; /* VTCR_EL2 */
>       } else {
> -        return extract32(tcr, 29, 1);
> +        /* Replicate the single TBID bit so we always have 2 bits.  */
> +        return extract32(tcr, 29, 1) * 3;
>       }
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


