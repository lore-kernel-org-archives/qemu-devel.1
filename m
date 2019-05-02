Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ABC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585DB20449
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO165QBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585DB20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDbi-00081s-Li
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:26:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDaa-0006zx-0x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDaY-0001TV-9k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:25:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDaW-0001Ir-Fx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:25:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id h11so3149281wmb.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=U7DsVjgrtKC8/0nAUR6e3ok0/6AAH5MALF+j6ENbECU=;
	b=aO165QBLU1ArO6yiuXI6TO47TJka93FbQHSPMzE8F2alLV284EWeo5xMW3KvKAT6u/
	nIm3trg4hYcZ5U+sljOgEVZGrTSvdCtEicZB5825vd0tSIHJuGjiUlkytVsSz50EfXkT
	JiQIdgUI0V8wpqpH2bznL7ke5yu8GwoApuLjA0vnf/5M+P7SzNjl4H1kSX0Z5QCORHWT
	8vn/HKoSKmFEpNtAgfphfKC1CYc9O5Q6Rsn0f/Tf7/7LqrGRpn4QWbKE3EkCbk6DvipB
	IUgye6jHW9yyk55FjqhyzKz+edKErJ8naZPhhc8zRWelnROBhGVJJzWIW0uX+RNiYDci
	I54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=U7DsVjgrtKC8/0nAUR6e3ok0/6AAH5MALF+j6ENbECU=;
	b=gJ4yoNkNG/odiiBcf2zz9CSSkJDdyToHAlM/ywXuraZ5eHlxsRAjaUDgfzFfOqjI4R
	reuXJPVTYPqHuGpStL9c4RpgKmx0YW0kFWIbj8O80yW72UtDLEE5Rfb8vmmix3uZmytk
	8OKF9oO90zRx4fmRpJzAaehzknh+IjiOFJMkZ4wswlKZ7gZj/83BkLjGEDZXwoqN2Fsp
	nXph4X8uFems2fwUjBvBSqEJUaR+7PY3IFYSU8pIi6V5k0fyDt3hBvLmioI1cbSZ5soC
	+V7XfFCUzHLLKbKgJD8hX8KkmHUdS9l8AfsigNa44KQNG3rkHPmLwDNo8fTs9VXVhjEJ
	GnZA==
X-Gm-Message-State: APjAAAV4GNWuR78gc3BZS+w3bI4J3CaosCXu0qMCvi57KQwXVay1PS6d
	BEYPQ4PXQBBC/r7SQc2Oou1jsK19CQw=
X-Google-Smtp-Source: APXvYqyL6rE7smj26tpahU1GBXALSJ7rQokYSDzuMBxjAH8mVu6TxJHyCBwCVcSaCFcnoRAIhvhJnA==
X-Received: by 2002:a7b:cd05:: with SMTP id f5mr2757590wmj.98.1556810729923;
	Thu, 02 May 2019 08:25:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s145sm18802137wme.38.2019.05.02.08.25.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 08:25:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id F109C1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 16:25:28 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-20-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-20-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 16:25:28 +0100
Message-ID: <874l6c6fpz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 19/29] tcg: Add support for integer
 absolute value
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502152528.yKeC-dnzQM3liBRHjnEND150StYEv-7eFxWT8SzEXTk@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> Remove a function of the same name from target/arm/.
> Use a branchless implementation of abs gleaned from gcc.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op.h           |  5 +++++
>  target/arm/translate.c | 10 ----------
>  tcg/tcg-op.c           | 20 ++++++++++++++++++++
>  3 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 472b73cb38..660fe205d0 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i=
32 arg2);
>  void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
> +void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
>
>  static inline void tcg_gen_discard_i32(TCGv_i32 arg)
>  {
> @@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i=
64 arg2);
>  void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
> +void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
>
>  #if TCG_TARGET_REG_BITS =3D=3D 64
>  static inline void tcg_gen_discard_i64(TCGv_i64 arg)
> @@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_=
vec a, TCGv_vec b);
>  void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b=
);
>  void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b=
);
>  void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b=
);
> @@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCG=
Arg offset, TCGType t);
>  #define tcg_gen_addi_tl tcg_gen_addi_i64
>  #define tcg_gen_sub_tl tcg_gen_sub_i64
>  #define tcg_gen_neg_tl tcg_gen_neg_i64
> +#define tcg_gen_abs_tl tcg_gen_abs_i64
>  #define tcg_gen_subfi_tl tcg_gen_subfi_i64
>  #define tcg_gen_subi_tl tcg_gen_subi_i64
>  #define tcg_gen_and_tl tcg_gen_and_i64
> @@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCG=
Arg offset, TCGType t);
>  #define tcg_gen_addi_tl tcg_gen_addi_i32
>  #define tcg_gen_sub_tl tcg_gen_sub_i32
>  #define tcg_gen_neg_tl tcg_gen_neg_i32
> +#define tcg_gen_abs_tl tcg_gen_abs_i32
>  #define tcg_gen_subfi_tl tcg_gen_subfi_i32
>  #define tcg_gen_subi_tl tcg_gen_subi_i32
>  #define tcg_gen_and_tl tcg_gen_and_i32
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 35bd426a3d..b25781554f 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -604,16 +604,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv=
_i32 t1)
>      tcg_temp_free_i32(tmp1);
>  }
>
> -static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
> -{
> -    TCGv_i32 c0 =3D tcg_const_i32(0);
> -    TCGv_i32 tmp =3D tcg_temp_new_i32();
> -    tcg_gen_neg_i32(tmp, src);
> -    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
> -    tcg_temp_free_i32(c0);
> -    tcg_temp_free_i32(tmp);
> -}
> -
>  static void shifter_out_im(TCGv_i32 var, int shift)
>  {
>      if (shift =3D=3D 0) {
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index a00d1df37e..0ac291f1c4 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TC=
Gv_i32 b)
>      tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
>  }
>
> +void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
> +{
> +    TCGv_i32 t =3D tcg_temp_new_i32();
> +
> +    tcg_gen_sari_i32(t, a, 31);
> +    tcg_gen_xor_i32(ret, a, t);
> +    tcg_gen_sub_i32(ret, ret, t);
> +    tcg_temp_free_i32(t);
> +}
> +
>  /* 64-bit ops */
>
>  #if TCG_TARGET_REG_BITS =3D=3D 32
> @@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TC=
Gv_i64 b)
>      tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
>  }
>
> +void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
> +{
> +    TCGv_i64 t =3D tcg_temp_new_i64();
> +
> +    tcg_gen_sari_i64(t, a, 63);
> +    tcg_gen_xor_i64(ret, a, t);
> +    tcg_gen_sub_i64(ret, ret, t);
> +    tcg_temp_free_i64(t);
> +}
> +
>  /* Size changing operations.  */
>
>  void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)


--
Alex Benn=C3=A9e

