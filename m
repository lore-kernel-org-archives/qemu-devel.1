Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB4C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB5820838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfcPVa3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB5820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Hqu-0005z4-NF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Hq3-00057Y-UW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Hq2-00058J-Md
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:48:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Hq2-000587-EO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582566493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEo8Owo3dxAt8duIBP68fE93UzuHq/vpdKVFc2vfq40=;
 b=GfcPVa3cCNiExh7kGgRmrLP3oknUSaNT0A3pAhFXwBC2AqsNk95XeFvgoBUA/TcLkk/yrh
 TSfMqWwqzc4OmwfjP9LyG8qR60Cjcd1uNQd0IcKvK6gyGJuz2UfqjuFVnquzyMT5JVCMUl
 Fu7++oo73M5Nb8yvvbmr3fxQ4MjogBI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-eS0kp3AxMXyGJEo_hdjLqQ-1; Mon, 24 Feb 2020 12:48:11 -0500
X-MC-Unique: eS0kp3AxMXyGJEo_hdjLqQ-1
Received: by mail-wm1-f71.google.com with SMTP id b205so68669wmh.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CYthtwoHtlW7P8CCYCmGqIORp+qZPl+s7XsdJtf+IA4=;
 b=TAyLTIR3UfNgR2kMVJy6DF4QznzJKGxHSL2NY4Rfs+vNBLSz57Eoi2m4oAURGI+ttJ
 KbvS3l/IT5Vg6ACd9mmx6rpYY3UNfci6aHZkjzMN3MqTdatnakLkeTq8v8zJ4d+hhDcG
 le1CTTtF44fFzjULd1pycrFv588DY8/97E15R2oCM+X0Um+KIx0drqziGr0mKy0oltJS
 tjMy8ZJ4lbXErID6n4//K/iSgvBM0Mzez8M4Wfk2/pkmMkHiwIBov+mybmqazetV0WYF
 Ms9KGmffWUTgIqbRiohpDqTcnOeEnm+jawuQCDTEOqhlJeWI1B6+1R/7jkQ+rqwdFrhk
 GdEQ==
X-Gm-Message-State: APjAAAVYlpLNVB78pZmp4mXPcT6xLLe+ezO7Id7qAZ9CTUMtUjMlt5d2
 WZOoX7lci4QgcSkiKBt6zCIt6aFquJPNjqSMt/XCR2RKqh2rASqYSMCAnmp+1rkQoAoWngpuYDR
 Ru4luczdDc0ChCEo=
X-Received: by 2002:adf:ea88:: with SMTP id s8mr67768797wrm.293.1582566490285; 
 Mon, 24 Feb 2020 09:48:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDv01H1OnfDqzUgvZiTA2xXYq7G6eSgy5BW5UKBoQYxU3GtEuq9So5jkEPLowMssuB4i5k7g==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr67768780wrm.293.1582566490105; 
 Mon, 24 Feb 2020 09:48:10 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z6sm20307343wrs.96.2020.02.24.09.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 09:48:09 -0800 (PST)
Subject: Re: [PATCH 1/3] target/arm: Fix wrong use of FIELD_EX32 on ID_AA64DFR0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200224172846.13053-1-peter.maydell@linaro.org>
 <20200224172846.13053-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ce87bfc-a6bc-7d8a-d968-dbb205235e48@redhat.com>
Date: Mon, 24 Feb 2020 18:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224172846.13053-2-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 6:28 PM, Peter Maydell wrote:
> We missed an instance of using FIELD_EX32 on a 64-bit ID
> register, in isar_feature_aa64_pmu_8_4(). Fix it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 65171cb30ee..b647d8df916 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3723,8 +3723,8 @@ static inline bool isar_feature_aa64_pmu_8_1(const =
ARMISARegisters *id)
>  =20
>   static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
>   {
> -    return FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >=3D 5 &&
> -        FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) !=3D 0xf;
> +    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >=3D 5 &&
> +        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) !=3D 0xf;
>   }
>  =20
>   /*
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


