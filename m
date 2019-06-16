Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F0C46477
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B7520870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B7520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcaVC-0006ir-KS
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 15:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcaUP-0006HR-0J
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcaUN-0006Yy-G8
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcaUM-0006Xe-Tz
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9444B3086218;
 Sun, 16 Jun 2019 19:06:49 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CE10100034B;
 Sun, 16 Jun 2019 19:06:46 +0000 (UTC)
Date: Sun, 16 Jun 2019 21:06:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190616210641.347f276f@redhat.com>
In-Reply-To: <20190616142836.10614-22-ysato@users.sourceforge.jp>
References: <20190616142836.10614-1-ysato@users.sourceforge.jp>
 <20190616142836.10614-22-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Sun, 16 Jun 2019 19:06:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v20 21/24] hw/registerfields.h: Add 8bit
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Jun 2019 23:28:33 +0900
Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.

probably should go before 13/24 (i.e. before actual users start using it)

this patch causes checkpatch errors but it uses macro magic style
common to registerfields.h.
we probably don't wish to fix existing code style at the moment.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190607091116.49044-11-ysato@users.sourceforge.jp>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/registerfields.h | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 2659a58737..a0bb0654d6 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -22,6 +22,14 @@
>      enum { A_ ## reg =3D (addr) };                                      =
    \
>      enum { R_ ## reg =3D (addr) / 4 };
> =20
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
> =20
>  /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_=
LENGTH
> @@ -34,6 +42,12 @@
>                                          MAKE_64BIT_MASK(shift, length)};
> =20
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
> +#define FIELD_DP64(storage, reg, field, val) ({                         \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
>      } v =3D { .v =3D val };                                             =
      \


