Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E3C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD22208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv/frVVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD22208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZLyE-00007u-3o
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 17:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hZLwu-00087q-AZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 16:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hZLwq-0003u1-RF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 16:58:54 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hZLwo-0003kD-HI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 16:58:50 -0400
Received: by mail-lj1-x242.google.com with SMTP id 16so2875798ljv.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RWw+DiyTsh8tpxKHBdSjiku1+848/buEmu+oGsXfG18=;
 b=Dv/frVVeapAiHko7AWeW/LzYAXk5bFTeAJ6SU8QVEy4v5VpWXZBb5M2kwvnHGuuEAW
 Sci8VvWz7mJmLbPgpKtWk/6fYi85dnIaZs7jm3bMeMiiKGGgX79OelbN8PjBpPQPmRuC
 hlwOilj0k+B3UjZu475dbNZ23BMQYQ9NYQ94kcq4zz01hZV6amtZw31TIn2iXOt6adOc
 8UvUVnlF2RSf57z0KaVYsUpiIGqyOjCOGeCBspzPAcxXa30s23GhPMoYXXhcu90lLO+a
 ShYc4rKQiurOXpq8t+wn7M8E7p/k3k3cZrc9UoZ9v85EWzUF5a16hZX3ea5oO00Mm8qh
 7e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RWw+DiyTsh8tpxKHBdSjiku1+848/buEmu+oGsXfG18=;
 b=aMibGb1vppTULQ5TmWwmBI42bBMPFSOXLUOlz8rR0dlvEujq8kzrv9tv9FrFTRS9jT
 J1Ho5ZZW2PpsKvLsBOXRy67w7dWBsHdycr3yecpspcxJo27rCDwUdKh1jUsz8JBMbZK+
 a5Pts2PjBRkIn9yDD+PiEwwaslgfH3vDnGgxS5m+FzEzseHWkdZbOyKcdm+Gm2feBuLl
 DetWBxkQqXMzshBoHdPkYWSMwAmVzeZNtj33Pl3aO0vYQsVNMiG6P1jIv+jLB3nd50YU
 axXscmw0NqSXIT+ytgvj0IycgemM6QThpd9nSP7JFfHZA6oAfrPI8UCBaL2cAtTSBR/1
 o+hQ==
X-Gm-Message-State: APjAAAWcZGgBvDwrNQDdTuf3e3IWX8yp0xjh6GOzM+1R0ju12NqQlDzR
 jn7bb+GIVWOnuIZHCYlzSr67KLNYvFYiZTBjoLM=
X-Google-Smtp-Source: APXvYqzxhF2l3JKb6caMLiCHH8gCD/av7uJAQaE/7LQ+2GEea2/b4BVO4fyeUUZwQgsjwF2CRwbJrDO9YsuIQdR5S3Q=
X-Received: by 2002:a2e:29c4:: with SMTP id p65mr306297ljp.141.1559941125578; 
 Fri, 07 Jun 2019 13:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190607153725.18055-1-philmd@redhat.com>
 <20190607153725.18055-14-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-14-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Jun 2019 13:56:09 -0700
Message-ID: <CAKmqyKOZK9xCb2HNj5UMAUcKSyONev+KpZDONw_N_4_27GpXZA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v18 13/29] hw/registerfields.h: Add 8bit
 and 16bit register macros
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 7, 2019 at 9:57 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190607091116.49044-11-ysato@users.sourceforge.jp>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/registerfields.h | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 2659a58737..a0bb0654d6 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -22,6 +22,14 @@
>      enum { A_ ## reg =3D (addr) };                                      =
    \
>      enum { R_ ## reg =3D (addr) / 4 };
>
> +#define REG8(reg, addr)                                                 =
 \
> +    enum { A_ ## reg =3D (addr) };                                      =
    \
> +    enum { R_ ## reg =3D (addr) };
> +
> +#define REG16(reg, addr)                                                =
  \
> +    enum { A_ ## reg =3D (addr) };                                      =
    \
> +    enum { R_ ## reg =3D (addr) / 2 };
> +
>  /* Define SHIFT, LENGTH and MASK constants for a field within a register=
 */
>
>  /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_=
LENGTH
> @@ -34,6 +42,12 @@
>                                          MAKE_64BIT_MASK(shift, length)};
>
>  /* Extract a field from a register */
> +#define FIELD_EX8(storage, reg, field)                                  =
  \
> +    extract8((storage), R_ ## reg ## _ ## field ## _SHIFT,              =
  \
> +              R_ ## reg ## _ ## field ## _LENGTH)
> +#define FIELD_EX16(storage, reg, field)                                 =
  \
> +    extract16((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
> +              R_ ## reg ## _ ## field ## _LENGTH)
>  #define FIELD_EX32(storage, reg, field)                                 =
  \
>      extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
>                R_ ## reg ## _ ## field ## _LENGTH)
> @@ -49,6 +63,22 @@
>   * Assigning values larger then the target field will result in
>   * compilation warnings.
>   */
> +#define FIELD_DP8(storage, reg, field, val) ({                          =
  \
> +    struct {                                                            =
  \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> +    } v =3D { .v =3D val };                                             =
      \
> +    uint8_t d;                                                          =
  \
> +    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> +    d; })
> +#define FIELD_DP16(storage, reg, field, val) ({                         =
  \
> +    struct {                                                            =
  \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> +    } v =3D { .v =3D val };                                             =
      \
> +    uint16_t d;                                                         =
  \
> +    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> +    d; })
>  #define FIELD_DP32(storage, reg, field, val) ({                         =
  \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> @@ -57,7 +87,7 @@
>      d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
>                    R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
>      d; })
> -#define FIELD_DP64(storage, reg, field, val) ({                         =
  \
> +#define FIELD_DP64(storage, reg, field, val) ({                         =
\
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
>      } v =3D { .v =3D val };                                             =
      \
> --
> 2.20.1
>
>

