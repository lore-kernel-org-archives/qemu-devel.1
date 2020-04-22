Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E655C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10852075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edA1MqOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10852075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJZw-0005gK-0C
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJYv-0004ME-RW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJYu-0002sL-Ky
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:53:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRJYu-0002nX-76
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:53:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id d17so3506269wrg.11
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lL23JNais+S1Wv4htiWPpsaEuqFsq39lDCTDj5GHckA=;
 b=edA1MqOQZMedMcqC5NqYMdIu2uJ853NKsBHNkUQu2Gxz0IkEWmDq2SjKNf36DTVyQQ
 dp2wj4XX2F03fULidtOcXJom7JbPyJ2JpyW7L+mM41wQYUUqVEvEGj5ZlnTF4C10UH5R
 340n/MhT89NJXZ34nTPGbF42214TnF1ffXgzij4vIwhzZzc4yQJmjzj8juWqcukhFEVQ
 TAPLJ1h6UipzNRsDfIOCH7kMkL8U1dnS0u5YgH+0NrXZM5k/gpLR02jByQOfnbRjzXET
 T5friyR3BERYAgkQi1Lqy2EuM8Iog3c4FT0+G8D+anyr9z0W7WMnpo5aQDCSicQ17Trj
 btrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lL23JNais+S1Wv4htiWPpsaEuqFsq39lDCTDj5GHckA=;
 b=VMqDFpGtm0UArBvwoCPuN0P9U8pWx3N9wVOQtsHWPd303GwwWY7NVj0Uot+ykoW15a
 6wAU9c6Mur2HE6f9ngqtF7NDsoMSJyHvRWoItl/4egHrqY8Q9x5QnaCKHYIttPqf1O0t
 XRzjm6dt+GKaGZG5cEao6r82wbMuTbEZIyqmkosVq4tFK9pSI0rSLbpgY3VJdCeqWGzA
 f72nXDzH78HEPTgVGqlsRTCEntJssbADfZAAfattr9A07m9wfA+JAEaJtX9tEcgA0E1p
 n28YPNorN4gSaNKN/LZ9BR5BIFT36Y2K0lAaF+o/JG0Oxw+Ui1G3vM89jfUTpt8Z09Pn
 OlcQ==
X-Gm-Message-State: AGi0PubkDSL1R5+rvFH87qLixxHqrODUhi33rEkrSzBdikbqZisN61lK
 NnehEbJh1Y6GP5cyt0VLb80zDQ==
X-Google-Smtp-Source: APiQypJIzDNv4P9V9/EgbHsbcAYG5M8Kg19XlHTSGN8lWc1+wTGWsYNny+XXEMhtKbf/QkX/RhY1tQ==
X-Received: by 2002:a05:6000:1044:: with SMTP id
 c4mr228588wrx.57.1587578005637; 
 Wed, 22 Apr 2020 10:53:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 145sm71292wma.1.2020.04.22.10.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 10:53:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FAAD1FF7E;
 Wed, 22 Apr 2020 18:53:23 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-18-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 17/36] tcg/optimize: Adjust TempOptInfo allocation
In-reply-to: <20200422011722.13287-18-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 18:53:23 +0100
Message-ID: <878sincsq4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Do not allocate a large block for indexing.  Instead, allocate
> for each temporary as they are seen.
>
> In general, this will use less memory, if we consider that most
> TBs do not touch every target register.  This also allows us to
> allocate TempOptInfo for new temps created during optimization.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/optimize.c | 60 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index b86bf3d707..d36d7e1d7f 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -89,35 +89,41 @@ static void reset_temp(TCGArg arg)
>  }
>=20=20
>  /* Initialize and activate a temporary.  */
> -static void init_ts_info(TempOptInfo *infos,
> -                         TCGTempSet *temps_used, TCGTemp *ts)
> +static void init_ts_info(TCGTempSet *temps_used, TCGTemp *ts)
>  {
>      size_t idx =3D temp_idx(ts);
> -    if (!test_bit(idx, temps_used->l)) {
> -        TempOptInfo *ti =3D &infos[idx];
> +    TempOptInfo *ti;
>=20=20
> +    if (test_bit(idx, temps_used->l)) {
> +        return;
> +    }
> +    set_bit(idx, temps_used->l);
> +
> +    ti =3D ts->state_ptr;
> +    if (ti =3D=3D NULL) {
> +        ti =3D tcg_malloc(sizeof(TempOptInfo));
>          ts->state_ptr =3D ti;
> -        ti->next_copy =3D ts;
> -        ti->prev_copy =3D ts;
> -        if (ts->kind =3D=3D TEMP_CONST) {
> -            ti->is_const =3D true;
> -            ti->val =3D ti->mask =3D ts->val;
> -            if (TCG_TARGET_REG_BITS > 32 && ts->type =3D=3D TCG_TYPE_I32=
) {
> -                /* High bits of a 32-bit quantity are garbage.  */
> -                ti->mask |=3D ~0xffffffffull;
> -            }
> -        } else {
> -            ti->is_const =3D false;
> -            ti->mask =3D -1;
> +    }
> +
> +    ti->next_copy =3D ts;
> +    ti->prev_copy =3D ts;
> +    if (ts->kind =3D=3D TEMP_CONST) {
> +        ti->is_const =3D true;
> +        ti->val =3D ts->val;
> +        ti->mask =3D ts->val;
> +        if (TCG_TARGET_REG_BITS > 32 && ts->type =3D=3D TCG_TYPE_I32) {
> +            /* High bits of a 32-bit quantity are garbage.  */
> +            ti->mask |=3D ~0xffffffffull;
>          }
> -        set_bit(idx, temps_used->l);
> +    } else {
> +        ti->is_const =3D false;
> +        ti->mask =3D -1;
>      }
>  }
>=20=20
> -static void init_arg_info(TempOptInfo *infos,
> -                          TCGTempSet *temps_used, TCGArg arg)
> +static void init_arg_info(TCGTempSet *temps_used, TCGArg arg)
>  {
> -    init_ts_info(infos, temps_used, arg_temp(arg));
> +    init_ts_info(temps_used, arg_temp(arg));
>  }
>=20=20
>  static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
> @@ -603,9 +609,8 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
>  /* Propagate constants and copies, fold constant expressions. */
>  void tcg_optimize(TCGContext *s)
>  {
> -    int nb_temps, nb_globals;
> +    int nb_temps, nb_globals, i;
>      TCGOp *op, *op_next, *prev_mb =3D NULL;
> -    TempOptInfo *infos;
>      TCGTempSet temps_used;
>=20=20
>      /* Array VALS has an element for each temp.
> @@ -615,12 +620,15 @@ void tcg_optimize(TCGContext *s)
>=20=20
>      nb_temps =3D s->nb_temps;
>      nb_globals =3D s->nb_globals;
> +
>      bitmap_zero(temps_used.l, nb_temps);
> -    infos =3D tcg_malloc(sizeof(TempOptInfo) * nb_temps);
> +    for (i =3D 0; i < nb_temps; ++i) {
> +        s->temps[i].state_ptr =3D NULL;
> +    }
>=20=20
>      QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
>          tcg_target_ulong mask, partmask, affected;
> -        int nb_oargs, nb_iargs, i;
> +        int nb_oargs, nb_iargs;
>          TCGArg tmp;
>          TCGOpcode opc =3D op->opc;
>          const TCGOpDef *def =3D &tcg_op_defs[opc];
> @@ -633,14 +641,14 @@ void tcg_optimize(TCGContext *s)
>              for (i =3D 0; i < nb_oargs + nb_iargs; i++) {
>                  TCGTemp *ts =3D arg_temp(op->args[i]);
>                  if (ts) {
> -                    init_ts_info(infos, &temps_used, ts);
> +                    init_ts_info(&temps_used, ts);
>                  }
>              }
>          } else {
>              nb_oargs =3D def->nb_oargs;
>              nb_iargs =3D def->nb_iargs;
>              for (i =3D 0; i < nb_oargs + nb_iargs; i++) {
> -                init_arg_info(infos, &temps_used, op->args[i]);
> +                init_arg_info(&temps_used, op->args[i]);
>              }
>          }


--=20
Alex Benn=C3=A9e

