Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0597DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87622064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87622064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVj3-00080Y-0Q
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLVfc-0005df-SA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLVfb-0007nJ-DT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLVfb-0007ml-5Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:04:07 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 227A5C049E12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 17:04:06 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id o188so3001229wmo.5
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=20VL07eZ6pVWeEvn8kJv/AgmnvUHrvm1zFQD1xroqRA=;
 b=Kh1Un8BoLqzpEDZZaJu3sIEi7lXAB6KFAT7cuRJ/0rMxxxOwclhbQ+XcdZVsptHiM1
 PU3UkY0BtM2LxHjUJrIJhsNWFPQChEqO99BNkf4ZKZZ8bR1dr9Hyre/QEPxmf9PHkrvL
 rZYQnxec4garKcyV1UGFgRL0AjSSS3/JHYqmnugWvRB/Pdj82N5vrKYAUbVMsTzk40zR
 DvmflHPqe2vdBJuw7aqIWm677hV8BfUQdQEvn50/l7PZXVR2LqqraxR7+OZalznovyen
 7gcRLaM2UOsGb6810/CqtLE+gV6o4qPWneZxYnO7LqPFmn42Tv/L746qkl0rxDrWivhu
 FcoA==
X-Gm-Message-State: APjAAAW6IYt13e4VEODozVxgeAH1uhue79jSteg6OfTcltLovZxO+dm4
 DfXPPvA52fPLUTQ32cIEix9Swp3OSH2WX3jqx6uHDXBgx+curIzp5Er2FbSlA0719ofIsUgDvtQ
 DlC299M+ec52xUVc=
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr8657942wrn.29.1571418244763;
 Fri, 18 Oct 2019 10:04:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFcHxiedG1B5NB4Az+XyB9urxjLFgVPZvCib1nv+lgs7UKaKH+R/BqDJbfHY8LZ2lnBi4rAg==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr8657901wrn.29.1571418244445;
 Fri, 18 Oct 2019 10:04:04 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id s9sm6805467wme.36.2019.10.18.10.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 10:04:03 -0700 (PDT)
Subject: Re: [PATCH 07/14] RFC: mips/cps: fix setting saar property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-8-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e13cbf70-e7a3-904c-f230-c42f75d5adbc@redhat.com>
Date: Fri, 18 Oct 2019 19:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018154212.13458-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 5:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> There is no "saar" property. Note: I haven't been able to test this
> code. Help welcome. >
> May fix commit 043715d1e0fbb3e3411be3f898c5b77b7f90327a ("target/mips:
> Update ITU to utilize SAARI and SAAR CP0 registers")

This seems a MIPS feature that is not fully mainstreamed, I suppose we=20
miss the DSPRAM patches, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg638373.html

This code is currently not reachable:

$ git grep saarp
hw/mips/cps.c:98:    saar_present =3D (bool)env->saarp;
target/mips/cpu.h:1103:    int saarp;

Unfortunately the author email is bouncing:

host mips-com.mail.protection.outlook.com[104.47.46.36] said:
550 5.4.1 [yongbok.kim@mips.com]: Recipient address rejected:
Access denied [BN3NAM04FT027.eop-NAM04.prod.protection.outlook.com]
(in reply to RCPT TO command)

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/mips/cps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 1660f86908..c49868d5da 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Erro=
r **errp)
>           object_property_set_bool(OBJECT(&s->itu), saar_present, "saar=
-present",
>                                    &err);
>           if (saar_present) {
> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->C=
P0_SAAR);
> +            s->itu.saar =3D &env->CP0_SAAR;
>           }
>           object_property_set_bool(OBJECT(&s->itu), true, "realized", &=
err);
>           if (err !=3D NULL) {
>=20

