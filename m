Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23848C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC00820830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC00820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jMI-00061i-Ot
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i8jKz-000588-99
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i8jKy-0005iI-CQ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i8jKy-0005hP-79
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:02:00 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 399504FCDA
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 11:01:59 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id f63so1187432wma.7
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 04:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U+/yDAIEQdjSUuPEqM/3Ahpv5JaD1YKojO1Ki8uJkGc=;
 b=F6ut5S5QafIHlgs672hu/P1S5NcGs484qkpAjRNwiXmsRn1aV5098JvNDUQ3kqCHY2
 wE6kUTgcmWbbASWn1DNYujdCeFasY1mdpu8c2COzKN4JyZj/4qGxclrlIUkx06vZENBq
 gSx6IZRiRn+O7SgEBO1b9/VSaMfYGiEn90f1E4whdQG5LUd+O+EbtofNYURxHARO0XWR
 MX/+pPnnKMR8qJiH/2/TksIkjA4uEyHGkMqr7Gj1JNMEZzIoLQjn3afm/bC2wsfvp+5U
 sojHHdVinc2JicCq//5sbqSOslPd5MUPeeWubVb6Q3zLkCaiMsuIA2VtXQD+0ceFTdcp
 o/wg==
X-Gm-Message-State: APjAAAUzzNR4bjZiU4GpylYIWfsXXElmTlYn3es7tNiwnVkYZ6olh0Xr
 9e7gYopQbvK0nwxriXRsimeCc/64Lbi0VU8NrPreYSrbGZGY/LDC7cONkPlTPLMCXs7ohiy070b
 Pz++PqhKbzZLNTlw=
X-Received: by 2002:adf:ee45:: with SMTP id w5mr37711611wro.246.1568372518024; 
 Fri, 13 Sep 2019 04:01:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkLVbJ6rAK4c6BdsFBvREDMN9HTH/X1oy9G2ain0xnhZ2N5pFDTyFwTAxM0t5ez5SwBV9/Jg==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr37711596wro.246.1568372517823; 
 Fri, 13 Sep 2019 04:01:57 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r28sm36374905wrr.94.2019.09.13.04.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 04:01:57 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190912183058.17947-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cdabfdcd-a7e2-fefb-3e35-a05c3b593dcf@redhat.com>
Date: Fri, 13 Sep 2019 13:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912183058.17947-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix sign-extension for SMLAL*
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 8:30 PM, Richard Henderson wrote:
> The 32-bit product should be sign-extended, not zero-extended.
>=20
> Fixes: ea96b374641b
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 34bb280e3d..fd2f0e3048 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8045,7 +8045,9 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr =
*a,
>      case 2:
>          tl =3D load_reg(s, a->ra);
>          th =3D load_reg(s, a->rd);
> -        t1 =3D tcg_const_i32(0);
> +        /* Sign-extend the 32-bit product to 64 bits.  */
> +        t1 =3D tcg_temp_new_i32();
> +        tcg_gen_sari_i32(t1, t0, 31);
>          tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
>          tcg_temp_free_i32(t0);
>          tcg_temp_free_i32(t1);
>=20

