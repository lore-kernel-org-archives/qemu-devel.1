Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73079C5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D5E2075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cH/2/vGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D5E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJPz-0003TB-F5
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRJNr-0001nC-2y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRJNq-0004RW-Ai
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:42:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRJNp-0004Nr-TW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587577320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xR/a9qaruUfJuiiFbCuVugQkA7BqOfxP5EkzMf4OK7g=;
 b=cH/2/vGtrN/pWRjAYm0VH1It2CUsgTkePfvKN+z46T4zeu+oBYL3cH3kpsStzMiolH4dn4
 IujgM2gUwyXZHn/n+ZbsBXMdSDfU3c0tID/FwQbmvJnSjXwJe4oE99wSmroofgYxdfdofa
 lr3/8qomWPIxe9VSN2VmTgggNkKsZBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-5cmtrMfCNnmAQQCgS78qog-1; Wed, 22 Apr 2020 13:41:59 -0400
X-MC-Unique: 5cmtrMfCNnmAQQCgS78qog-1
Received: by mail-wm1-f71.google.com with SMTP id n17so1165918wmi.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MLyp6M4wXApkbzk5EE/B0GR90m25YAmskER309AY+Es=;
 b=mCZNYSZRhyNY/8tNFcaB/TEZZ7wVO1iX6pdyoBU+Pxl44TI2WlYH4RFHYveJrwN0VC
 OFFIeyqhELel9Nwn9S4Qj1GQ/EDYYCY94mRfawTxCGFQU1n1DuttvegW4pFS+MV4GBD+
 UaqxzSzc92SCMPugw1Qvvk6j24aK3ZXied3SqCFcMteb+/LWdANO/MGd8la8IIrjazPw
 jUxwmI+ZCwog88gCCCkf5YLIwEPBVAEegqcpg5ut++/jIlR1MNAOGJMTfNY4L5NAxa3G
 ifbEuoE4T2NMBZemcdaAPXseZ1I9U4RNLO3vdBAZPZXJL+1UpT2NhlJMMXSLtX+R/Sz4
 kG5Q==
X-Gm-Message-State: AGi0PuZJ0AyHDwcI3N0RwYMHTQ7B5gYpXjbY2cUq8w9ZbxqCtW1gQWOz
 giila6irwAfyPlW/9qNIxG3fOpveviOioU/Za/kepbQ/EUNTh3iHOWlJ/fkIKXvv5R3t/K4hJ+2
 wD+VfJuNTezMaCNs=
X-Received: by 2002:a7b:c759:: with SMTP id w25mr12807797wmk.68.1587577317884; 
 Wed, 22 Apr 2020 10:41:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcYMkmlshHBs2Nc0J4H2j7rzEh+ibM9T1wNKLjC7qLvCWZhKqDbn6yQhYEPvcjWnZBWev8IQ==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr12807777wmk.68.1587577317663; 
 Wed, 22 Apr 2020 10:41:57 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j68sm9165649wrj.32.2020.04.22.10.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 10:41:57 -0700 (PDT)
Subject: Re: [PATCH for-5.0?] target/arm: Fix ID_MMFR4 value on AArch64 'max'
 CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200422124501.28015-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b6dd8d4a-ec38-84c5-eb94-cf25bfa4cf4a@redhat.com>
Date: Wed, 22 Apr 2020 19:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422124501.28015-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 2:45 PM, Peter Maydell wrote:
> In commit 41a4bf1feab098da4cd the added code to set the CNP
> field in ID_MMFR4 for the AArch64 'max' CPU had a typo
> where it used the wrong variable name, resulting in ID_MMFR4
> fields AC2, XNX and LSM being wrong. Fix the typo.
>=20
> Fixes: 41a4bf1feab098da4cd
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Nice testing/catch Laurent!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> maybe 5.0 just because it's so trivial. I dunno...
>=20
> There's also an error where we use the uint32_t u variable
> to update the 64-bit ID_AA64DFR0 register, but that's harmless
> because as it happens the top 32 bits of that register are
> all zeroes anyway, so we can just fix that in 5.1.
>=20
>   target/arm/cpu64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 62d36f9e8d3..95d0c8c101a 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -705,7 +705,7 @@ static void aarch64_max_initfn(Object *obj)
>           u =3D cpu->isar.id_mmfr4;
>           u =3D FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
>           u =3D FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> -        u =3D FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
> +        u =3D FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
>           cpu->isar.id_mmfr4 =3D u;
>  =20
>           u =3D cpu->isar.id_aa64dfr0;
>=20


