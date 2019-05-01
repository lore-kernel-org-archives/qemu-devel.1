Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1455EC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF38208C4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flmkOl5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF38208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLtC9-0005f4-3l
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:39:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLtAp-0004lp-Vt
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLtAo-0005NW-Nf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:37:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLtAo-0005MC-HW
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:37:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so25341697wrs.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=ca8k9DmO9DRfeSA2ahMAlcCr221iG0TjupF1hE0uinE=;
	b=flmkOl5b9OeqOeqlG7AppEz34i7kmgYdO5hniOglTXKsolfA5VFM4ekw5rOBPdk6ta
	g5e9ke+RuwHB9P2DJOHfq7hqiTMmn6mCCS7n6Q65JzpkzAlt0Zvgf8IZA8HoCXhWv8gD
	g9nOiR9xTylxJRupOjPeGcQTUH3Vd3IZ7kaRGqHr5w8sPi4tg+XEGepFk/B5+kE+2KM9
	2sgo9VU4fnFH/erY9CadnvA97t0XWYFPBjZy9ms5pThNaNKk64Q92DA7zrFL5oo+L6ww
	Be1a2mtKWkQtiqc7hHm/Ux/F9ateqhBLapKgaoV/3KC283Qq+E8mlkaooJUXoQeSeMHp
	k34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ca8k9DmO9DRfeSA2ahMAlcCr221iG0TjupF1hE0uinE=;
	b=Q2CemAiX/2m9lXpdah97rpCt0nHLdoODKv3ZzRyBBdr7HV59v8sUDoRDi1/gXVPQXL
	yM7yCm2OaEFqr9GPNn4ScpIdwwmZ40hflrp6Nxe3z8ussKcGi2Jk2abtk4CfM5eqm3oW
	SmX8gvOTqFwDPVmooeH/m1g+hhT2oGvEFuE6bAqKyZ/UX/L9smUlaXA0ie/OhqegBO7r
	ZUH+cwXfdv7nQj7BQ2ND22pfpcZQlATdfFoQgVrat+kZ3H7Mg2BeWXNlH9BxNQigdt+i
	A8q9nB8QJpbJ0IDSXbiktYXM6MphyHSzBwkhndz4VUq/BLTYvm+j4j/tvpxYULEL99B/
	E4sw==
X-Gm-Message-State: APjAAAX1Fcz2ebntTQUNUut3VTFdYHSB/WmCfMMEbrnPWIO64A11TAWN
	4Pld49E/TfZ+hLOAijlVw7ARX+sORqs=
X-Google-Smtp-Source: APXvYqzKbEIcAQhWoaVdJ7lS9iloUR8ctTlWy7qhWAHSVVxHQuYjNiPsDdFa2zKRANyAGLROZuSktA==
X-Received: by 2002:adf:8b0b:: with SMTP id n11mr11787223wra.149.1556732256809;
	Wed, 01 May 2019 10:37:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	e10sm31553607wra.52.2019.05.01.10.37.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:37:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1D0FE1FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 18:37:35 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-9-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-9-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 18:37:35 +0100
Message-ID: <87lfzq5b4w.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 08/29] tcg: Promote tcg_out_{dup,
 dupi}_vec to backend interface
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
Message-ID: <20190501173735.fT28q1oaGF8zP1_j0H4uzdC1LTvTLAEb86rMekMvlsA@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> The i386 backend already has these functions, and the aarch64
> backend could easily split out one.  Nothing is done with these
> functions yet, but this will aid register allocation of
> INDEX_op_dup_vec in a later patch.

  "Also use correct type for tcg_out_dupi_vec"?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 12 ++++++++++--
>  tcg/i386/tcg-target.inc.c    |  3 ++-
>  tcg/tcg.c                    | 14 ++++++++++++++
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index ee89734318..e443b5df23 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -799,7 +799,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64In=
sn insn, TCGType ext,
>  }
>
>  static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> -                             TCGReg rd, uint64_t v64)
> +                             TCGReg rd, tcg_target_long v64)
>  {
>      int op, cmode, imm8;
>
> @@ -814,6 +814,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType =
type,
>      }
>  }
>
> +static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
> +                            TCGReg rd, TCGReg rs)
> +{
> +    int is_q =3D type - TCG_TYPE_V64;
> +    tcg_out_insn(s, 3605, DUP, is_q, rd, rs, 1 << vece, 0);
> +    return true;
> +}
> +
>  static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
>                           tcg_target_long value)
>  {
> @@ -2201,7 +2209,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode=
 opc,
>          tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
>          break;
>      case INDEX_op_dup_vec:
> -        tcg_out_insn(s, 3605, DUP, is_q, a0, a1, 1 << vece, 0);
> +        tcg_out_dup_vec(s, type, vece, a0, a1);
>          break;
>      case INDEX_op_shli_vec:
>          tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 1198c76392..0d621670c7 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -855,7 +855,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, =
TCGReg ret, TCGReg arg)
>      return true;
>  }
>
> -static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
> +static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
>                              TCGReg r, TCGReg a)
>  {
>      if (have_avx2) {
> @@ -888,6 +888,7 @@ static void tcg_out_dup_vec(TCGContext *s, TCGType ty=
pe, unsigned vece,
>              g_assert_not_reached();
>          }
>      }
> +    return true;
>  }
>
>  static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 68d86361e2..3ef4d3478d 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -109,10 +109,24 @@ static void tcg_out_movi(TCGContext *s, TCGType typ=
e,
>  static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
>                         const int *const_args);
>  #if TCG_TARGET_MAYBE_vec
> +static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
> +                            TCGReg dst, TCGReg src);
> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> +                             TCGReg dst, tcg_target_long arg);
>  static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
>                             unsigned vece, const TCGArg *args,
>                             const int *const_args);
>  #else
> +static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned=
 vece,
> +                                   TCGReg dst, TCGReg src)
> +{
> +    g_assert_not_reached();
> +}
> +static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
> +                                    TCGReg dst, tcg_target_long arg)
> +{
> +    g_assert_not_reached();
> +}
>  static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned=
 vecl,
>                                    unsigned vece, const TCGArg *args,
>                                    const int *const_args)


--
Alex Benn=C3=A9e

