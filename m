Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F8AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37221206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37221206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoab-0005gC-9A
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHoXS-0003v2-PH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHoXQ-0007bL-Ht
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:24:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHoXQ-0007ZF-9B
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:24:24 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 279107F770
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 12:24:23 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id y18so6916924wrw.8
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=59TrlkxKwO9lNdvX42OmTnxEw2K/WUWq6vheBRPQwu4=;
 b=C35V4l03erHY7LTIe94TYp24RyYYa4Ojs3k00nAGLPmd/sgp/pxxRMF1PDE0u0Ghuq
 +GnX2uJNsPdzhgrRAMTg1TjA5NBmhPHI+jwkwDVUBQMk1GBMBfuAZeBL4K5K4cNR6IYs
 7E/f89wVongK1x5Iqo21GvrL4W9nh3Xyam9fOwN6X9HSmSkNqwKj3aCosEk4g+EFBTaT
 fdsEnIpLJO2E9g23MzQHw66PipEwNq+j0XSEKP9SskbLq3fB8vIyAQgzD4w5S8L5b7TI
 tc31IciTqzEYUjXhrdX6DWJ9AP8zTqX2TDIvkOtJqfDT1m5UoH50q3DxSUahiaPHNB1l
 TkKA==
X-Gm-Message-State: APjAAAUTapEGJZJTz04HZ0SBIyfeq4sFowBlGI9Y8x2U0NaaqKnVty1Z
 d7qj24hRe6LgTp4FFPbgaXgG6B1oYRAJSOhIAO2hKbb2FGGKiSjj8pvgsXl8nnVw4BcrR7T31O8
 W1GogEFoq+buMGnk=
X-Received: by 2002:a5d:6411:: with SMTP id z17mr4327619wru.274.1570537461947; 
 Tue, 08 Oct 2019 05:24:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRtTqtsELyGuiNK81oTjxxq5sNy5J6EfBFFcewDXyIv69VIVGuYP3ZkhpdIMvvJZcqX6YztA==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr4327599wru.274.1570537461665; 
 Tue, 08 Oct 2019 05:24:21 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id m18sm38076383wrg.97.2019.10.08.05.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 05:24:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-3-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a6951b6-e8d6-90ff-727a-62c2a188660b@redhat.com>
Date: Tue, 8 Oct 2019 14:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008113318.7012-3-imammedo@redhat.com>
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
 hpoussin@reactos.org, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:33 PM, Igor Mammedov wrote:
> rs6000mc_realize() violates memory_region_allocate_system_memory() cont=
ract
> by calling it multiple times which could break -mem-path. Replace it wi=
th
> plain memory_region_init_ram() instead.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/ppc/rs6000_mc.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
> index df7c0006fc..66b14db5fa 100644
> --- a/hw/ppc/rs6000_mc.c
> +++ b/hw/ppc/rs6000_mc.c
> @@ -144,6 +144,7 @@ static void rs6000mc_realize(DeviceState *dev, Erro=
r **errp)
>       RS6000MCState *s =3D RS6000MC_DEVICE(dev);
>       int socket =3D 0;
>       unsigned int ram_size =3D s->ram_size / MiB;
> +    Error *local_err =3D NULL;
>  =20
>       while (socket < 6) {
>           if (ram_size >=3D 64) {
> @@ -165,19 +166,21 @@ static void rs6000mc_realize(DeviceState *dev, Er=
ror **errp)
>           if (s->simm_size[socket]) {
>               char name[] =3D "simm.?";
>               name[5] =3D socket + '0';
> -            memory_region_allocate_system_memory(&s->simm[socket], OBJ=
ECT(dev),
> -                                                 name,
> -                                                 s->simm_size[socket] =
* MiB);
> +            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name=
,
> +                                   s->simm_size[socket] * MiB, &local_=
err);
> +            if (local_err) {
> +                goto out;
> +            }
>               memory_region_add_subregion_overlap(get_system_memory(), =
0,
>                                                   &s->simm[socket], soc=
ket);
>           }
>       }
>       if (ram_size) {
>           /* unable to push all requested RAM in SIMMs */
> -        error_setg(errp, "RAM size incompatible with this board. "
> +        error_setg(&local_err, "RAM size incompatible with this board.=
 "
>                      "Try again with something else, like %" PRId64 " M=
B",
>                      s->ram_size / MiB - ram_size);
> -        return;
> +        goto out;
>       }
>  =20
>       if (s->autoconfigure) {
> @@ -193,6 +196,8 @@ static void rs6000mc_realize(DeviceState *dev, Erro=
r **errp)
>  =20
>       isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
>                                rs6000mc_port_list, s, "rs6000mc");
> +out:
> +    error_propagate(errp, local_err);
>   }
>  =20
>   static const VMStateDescription vmstate_rs6000mc =3D {
>=20

