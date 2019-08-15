Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F709C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AB920656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r11EJ5FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AB920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyH4e-0001Of-BZ
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyH3M-0000bn-Mt
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyH3J-0007pL-2k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:48:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyH3I-0007ot-RP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:48:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id u15so2311330oiv.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=WN5IKN5DloNomZ2mLa8vS5cnHjb2JFd5ccO6E1V1l4o=;
 b=r11EJ5FNjTzlN9Hd4hFm1gHL+Loya8rwgqD6rAJjGVTQzdVA+/hDVG91OvHsXHqV68
 Yo6ymu3x7XsiJUGx56TZdWbADvz0EetMc92TU+L1RkxpHDpELPmlUMTSTjlQ+ZkStF3L
 5sKtD3NwXvRd5Fm0SrYNnja1ka0NkCBQb31qFkNO4If2rOSthdrQSOAvhzl2P0Ovasss
 H5AhgFVB7Q2KII5vNRb4ecKgd2NSZ3aDeawXODHQjtcybxoatre/x1avDisZHl0jSMW6
 pyGhkhrs8u37jWclR4Fl1+cJN2U882jlKDu2r1BG4r3hfmMK3wcptqKztWwqekd3w80r
 MfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=WN5IKN5DloNomZ2mLa8vS5cnHjb2JFd5ccO6E1V1l4o=;
 b=Z4LWeI9DsGuFb6UAHR1DF8DsXbXkBHOz4Yh5Iba7ouksH598IRLA/pbmWWjlKtwFoe
 BV5WMeWJ+mUno9o8eIR3zfxYWwp2gR+10peMm29HL9IzVrc3NhdYWJqoqzFHVWTlTzjQ
 dp3Wclz4MT6IAE+CNKv2QBdbudmz1i43BTfs1uip7/zS8Ye02OQxsWtMsLdFmbuSzwuI
 DgEDMjGgYbPSE7iHz6G7nL8Dz2x0dOHytK37//kJkRW49rRQWOqDZzOeO6Lxgq1o7Z4u
 7VLeXvYesveS+1ps+m8KHVY9fBpoFW+z3U1FBsRjXIHgCO762l3EviMizTXp+0GsK6mn
 +fNw==
X-Gm-Message-State: APjAAAWxaFiekHdk6h2cabeoBiFdCCi8lxtl+CpuY0qAO8W5QH+/4Hhl
 BdcDH9pZ2njd8s+In8rKKpEluTWt9JILmQF+O8c=
X-Google-Smtp-Source: APXvYqzKa3r67BWYtv772veJo4RDIdEPDWgJFZ8cLWtcar7M9q1dufj8q5N5M6oSWbmXT5V9NDLX7eFok6PD+I6n9kc=
X-Received: by 2002:a05:6808:8cd:: with SMTP id
 k13mr1899474oij.136.1565880511908; 
 Thu, 15 Aug 2019 07:48:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 07:48:31
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 07:48:31
 -0700 (PDT)
In-Reply-To: <20190813124946.25322-5-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-5-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 16:48:31 +0200
Message-ID: <CAL1e-=g4Cxd74r3NyShEPpFEqx2JoT2x75zLeUXejgVgtVjSHA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 04/13] fpu: use min/max values from
 stdint.h for integral overflow
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.08.2019. 14.52, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> =D1=98=D0=B5=
 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Remove some more use of LIT64 while making the meaning more clear. We
> also avoid the need of casts as the results by definition fit into the
> return type.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 9e57b7b5933..a1e1e9a8559 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -3444,9 +3444,7 @@ static int64_t roundAndPackInt64(flag zSign,
uint64_t absZ0, uint64_t absZ1,
>      if ( z && ( ( z < 0 ) ^ zSign ) ) {
>   overflow:
>          float_raise(float_flag_invalid, status);
> -        return
> -              zSign ? (int64_t) LIT64( 0x8000000000000000 )
> -            : LIT64( 0x7FFFFFFFFFFFFFFF );
> +        return zSign ? INT64_MIN : INT64_MAX;
>      }

In function roundAndPavkInt32 tgere is a following segment:

    if ( ( absZ>>32 ) || ( z && ( ( z < 0 ) ^ zSign ) ) ) {
        float_raise(float_flag_invalid, status);
        return zSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
    }

Perhaps replace these constants with INT32_MIN, INT32_MAX, for similar
reasons, in the same or a separate patch?

Aleksandar


>      if (absZ1) {
>          status->float_exception_flags |=3D float_flag_inexact;
> @@ -3497,7 +3495,7 @@ static int64_t roundAndPackUint64(flag zSign,
uint64_t absZ0,
>          ++absZ0;
>          if (absZ0 =3D=3D 0) {
>              float_raise(float_flag_invalid, status);
> -            return LIT64(0xFFFFFFFFFFFFFFFF);
> +            return UINT64_MAX;
>          }
>          absZ0 &=3D ~(((uint64_t)(absZ1<<1) =3D=3D 0) & roundNearestEven)=
;
>      }
> @@ -5518,9 +5516,9 @@ int64_t floatx80_to_int64(floatx80 a, float_status
*status)
>          if ( shiftCount ) {
>              float_raise(float_flag_invalid, status);
>              if (!aSign || floatx80_is_any_nan(a)) {
> -                return LIT64( 0x7FFFFFFFFFFFFFFF );
> +                return INT64_MAX;
>              }
> -            return (int64_t) LIT64( 0x8000000000000000 );
> +            return INT64_MIN;
>          }
>          aSigExtra =3D 0;
>      }
> @@ -5561,10 +5559,10 @@ int64_t floatx80_to_int64_round_to_zero(floatx80
a, float_status *status)
>          if ( ( a.high !=3D 0xC03E ) || aSig ) {
>              float_raise(float_flag_invalid, status);
>              if ( ! aSign || ( ( aExp =3D=3D 0x7FFF ) && aSig ) ) {
> -                return LIT64( 0x7FFFFFFFFFFFFFFF );
> +                return INT64_MAX;
>              }
>          }
> -        return (int64_t) LIT64( 0x8000000000000000 );
> +        return INT64_MIN;
>      }
>      else if ( aExp < 0x3FFF ) {
>          if (aExp | aSig) {
> @@ -6623,7 +6621,7 @@ int32_t float128_to_int32_round_to_zero(float128 a,
float_status *status)
>      if ( ( z < 0 ) ^ aSign ) {
>   invalid:
>          float_raise(float_flag_invalid, status);
> -        return aSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
> +        return aSign ? INT32_MIN : INT32_MAX;
>      }
>      if ( ( aSig0<<shiftCount ) !=3D savedASig ) {
>          status->float_exception_flags |=3D float_flag_inexact;
> @@ -6662,9 +6660,9 @@ int64_t float128_to_int64(float128 a, float_status
*status)
>                        && ( aSig1 || ( aSig0 !=3D LIT64( 0x00010000000000=
00
) ) )
>                      )
>                 ) {
> -                return LIT64( 0x7FFFFFFFFFFFFFFF );
> +                return INT64_MAX;
>              }
> -            return (int64_t) LIT64( 0x8000000000000000 );
> +            return INT64_MIN;
>          }
>          shortShift128Left( aSig0, aSig1, - shiftCount, &aSig0, &aSig1 );
>      }
> @@ -6710,10 +6708,10 @@ int64_t float128_to_int64_round_to_zero(float128
a, float_status *status)
>              else {
>                  float_raise(float_flag_invalid, status);
>                  if ( ! aSign || ( ( aExp =3D=3D 0x7FFF ) && ( aSig0 | aS=
ig1
) ) ) {
> -                    return LIT64( 0x7FFFFFFFFFFFFFFF );
> +                    return INT64_MAX;
>                  }
>              }
> -            return (int64_t) LIT64( 0x8000000000000000 );
> +            return INT64_MIN;
>          }
>          z =3D ( aSig0<<shiftCount ) | ( aSig1>>( ( - shiftCount ) & 63 )=
 );
>          if ( (uint64_t) ( aSig1<<shiftCount ) ) {
> @@ -6764,19 +6762,19 @@ uint64_t float128_to_uint64(float128 a,
float_status *status)
>      if (aSign && (aExp > 0x3FFE)) {
>          float_raise(float_flag_invalid, status);
>          if (float128_is_any_nan(a)) {
> -            return LIT64(0xFFFFFFFFFFFFFFFF);
> +            return UINT64_MAX;
>          } else {
>              return 0;
>          }
>      }
>      if (aExp) {
> -        aSig0 |=3D LIT64(0x0001000000000000);
> +        aSig0 |=3D UINT64_C(0x0001000000000000);
>      }
>      shiftCount =3D 0x402F - aExp;
>      if (shiftCount <=3D 0) {
>          if (0x403E < aExp) {
>              float_raise(float_flag_invalid, status);
> -            return LIT64(0xFFFFFFFFFFFFFFFF);
> +            return UINT64_MAX;
>          }
>          shortShift128Left(aSig0, aSig1, -shiftCount, &aSig0, &aSig1);
>      } else {
> --
> 2.20.1
>
>
