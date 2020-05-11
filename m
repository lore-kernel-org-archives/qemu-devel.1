Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A689C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44438206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWFaFqet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44438206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBcE-0003VE-CT
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jYBb5-0002yA-Na; Mon, 11 May 2020 12:48:07 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jYBb4-0004MH-US; Mon, 11 May 2020 12:48:07 -0400
Received: by mail-io1-xd44.google.com with SMTP id i19so10479143ioh.12;
 Mon, 11 May 2020 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MWJveCUZ0uKJCkmQvcC9nArilKrXkegojoXCehmFwXU=;
 b=PWFaFqethFsYKZnML2XRm8so5ovmyRmFyM66KNaz1DDxFdr/g+qEDO4UrDQ9IOgFPa
 vgxawWUY005MnGITIcEgV/T/DHBgZyHfteavbMw34RpNrdRUtgEXNw2GDkR2p9PGjDSm
 /s1Ps5QetiulQuBVBFCpSRIX4KF4LM6KdffooVimvxKaTXd741b4bIb5el2QilTedZ1E
 vuQnt+av0gD8s0i46X1FqCjYPH1brN3Kmde6pJBSdlTGaodH5KWPqWkc8lbf3JCaWaNM
 Gw5FMxcud+N9Ovd3HDQrnQKa1TN88YNlzxcwvMh3F3y4tUOgj0vBSxH/RhfYmOO4q4ED
 uQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MWJveCUZ0uKJCkmQvcC9nArilKrXkegojoXCehmFwXU=;
 b=uS8xIoiIYd9ZGN8mFXOc8QEeAq+sjiRHWjqix1jSISJWA7qLLuMEs/W/JqgCdxFcv0
 OD5M2MKbox7/pvTtpIlamopt4ExFfAIbL4aBq93YqgSfyd2UUSqlcZcJFwvZX3ODBYmT
 FFx3D1VYPXfEcoqKfmpcKuJdQQZ49bky7BQgPkyFRbBijZnJdRqPpIxLawg+2J9K0T7Y
 DEkHubnFLowTIThitE34bRTe/cficwztJkPbZzT0boPBoed2GmbjHiOR+eChajdohC4A
 MJTrQrbcgKo+qui073ubWQzOyPRSodOQ40LWQkfq8aXHVpBxp5FLTfAz8bS9SHedOA6e
 nWCQ==
X-Gm-Message-State: AGi0PuYNqO3cBcmWkUViOqssoVqitrSputOehY2l4sZjMbxct33OM1Pc
 Rb4/43u24FJ/ZuSEeNYdj+r2dCgDVQwup3qGQ+w=
X-Google-Smtp-Source: APiQypJSnv9kSKwP3NVeY/64oV539Ei1/cJfUrCklLvyQluUracFRfIA/gDvhlayI56c9+tS0rh1VcW5kWzyMJesiTQ=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr16379108ioj.42.1589215684749; 
 Mon, 11 May 2020 09:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200510203457.10546-1-f4bug@amsat.org>
In-Reply-To: <20200510203457.10546-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 May 2020 09:39:18 -0700
Message-ID: <CAKmqyKO0FToRt-nHP7OKgbYf_2V8XLBV3FYhtz+c+n02u=kD3g@mail.gmail.com>
Subject: Re: [PATCH] hw/registerfields: Prefix local variables with underscore
 in macros
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 10, 2020 at 1:35 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> One can name a local variable holding a value as 'v', but it
> currently clashes with the registerfields macros. To save others
> to debug the same mistake, prefix the macro's local variables
> with an underscore.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/registerfields.h | 40 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 0407edb7ec..93fa4a84c2 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -66,35 +66,35 @@
>  #define FIELD_DP8(storage, reg, field, val) ({                          =
  \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> -    } v =3D { .v =3D val };                                             =
      \
> -    uint8_t d;                                                          =
  \
> -    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> -    d; })
> +    } _v =3D { .v =3D val };                                            =
      \
> +    uint8_t _d;                                                         =
  \
> +    _d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,      =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);            =
  \
> +    _d; })
>  #define FIELD_DP16(storage, reg, field, val) ({                         =
  \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> -    } v =3D { .v =3D val };                                             =
      \
> -    uint16_t d;                                                         =
  \
> -    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> -    d; })
> +    } _v =3D { .v =3D val };                                            =
      \
> +    uint16_t _d;                                                        =
  \
> +    _d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,      =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);            =
  \
> +    _d; })
>  #define FIELD_DP32(storage, reg, field, val) ({                         =
  \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> -    } v =3D { .v =3D val };                                             =
      \
> -    uint32_t d;                                                         =
  \
> -    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> -    d; })
> +    } _v =3D { .v =3D val };                                            =
      \
> +    uint32_t _d;                                                        =
  \
> +    _d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,      =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);            =
  \
> +    _d; })
>  #define FIELD_DP64(storage, reg, field, val) ({                         =
  \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> -    } v =3D { .v =3D val };                                             =
      \
> -    uint64_t d;                                                         =
  \
> -    d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> -    d; })
> +    } _v =3D { .v =3D val };                                            =
      \
> +    uint64_t _d;                                                        =
  \
> +    _d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,      =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);            =
  \
> +    _d; })
>
>  /* Deposit a field to array of registers.  */
>  #define ARRAY_FIELD_DP32(regs, reg, field, val)                         =
  \
> --
> 2.21.3
>
>

