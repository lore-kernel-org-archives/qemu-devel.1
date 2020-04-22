Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03ADC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7956A20776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1bNQD1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956A20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ39-0004JC-Kb
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJ1i-0003AK-Ge
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRJ1h-00078c-TP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:19:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRJ1h-00077a-G2
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:19:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id r26so3370638wmh.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0XkqcUDwg+MMEHdNHb35JIm7+KgpsQO567biYIBqyUo=;
 b=Q1bNQD1t3G5da1EdzzJwBYuT3CY6IDSoCfjwBmB4qyxArS81tQrBwuxGeseriUFwas
 BO/kzV5otPjE147I+YOliEecJkph4jDaoTQfR1kmHj4SRGGRI18+KCCQfrwmfiE9rvY3
 G739Ovwakm73FdNp3S60VTMjxIuXCSnsBg2nH6Pxe0z59GT1Qlwzl1qECBp+i5fgXoZ9
 FAHU0kRcvGW/QdRL8tZUtbqu6OXMfafO11m1kEIVvxIotlwYD/E9f3Q57m1SlIA9NRwd
 aeqqiLQ5hRhmKy5+E8Hi8MRTyZjvmxK4RQOTIhUohzo6vufstT202WnsuTlJ8FM5KuMy
 oYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0XkqcUDwg+MMEHdNHb35JIm7+KgpsQO567biYIBqyUo=;
 b=cdGqKbqpykQxTxBudW+19801UQxs6T1MJrq/9wk6ERH1spAZ5OdynZnAvNlAWjRBee
 3fgfl+kYuGLqgm4CzmLhLJxbfov5eKmHHV6di4dkC+xSHLUCA3g6OfidNjScFNrRKyHH
 Fqh3QMTCtR4rwOKoKDYni+qY98imV9xxnTGxIA7f94ExZvdbqYEvqDc6ZPaDRS3RVcSy
 UknPr7WivNLG7yCzfS24tMV8ynPLYfstQ9SyLJtu0mSQbzVO4fXrj4G/tEFU+PWnVfC2
 dNHTdYG0EXsRiXp+GRddogog06GeTbZ1tuYE+7Qm9BzKCkocshWgDYBp53QRkLIIL/sq
 CV0A==
X-Gm-Message-State: AGi0PuaGa2Ojbhges1YEW+aEJwxzKLcxyuPNB/DiTegqtZ+LLWTZ5hl4
 4Yi2jYBG1n38iylQ+IfwuEx9mw==
X-Google-Smtp-Source: APiQypKdxaZ74jKUu1INoir3xTTzObXNXUtK9I0uElL14/CzWtWvznWRMb37onADIqVrQSpPtFPnVA==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr12134600wma.38.1587575947938; 
 Wed, 22 Apr 2020 10:19:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 145sm9155513wma.1.2020.04.22.10.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 10:19:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 398771FF7E;
 Wed, 22 Apr 2020 18:19:06 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-17-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 16/36] tcg: Rename struct tcg_temp_info to TempOptInfo
In-reply-to: <20200422011722.13287-17-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 18:19:06 +0100
Message-ID: <87blnjcub9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Fix this name vs our coding style.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/optimize.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index effb47eefd..b86bf3d707 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -35,20 +35,20 @@
>          glue(glue(case INDEX_op_, x), _i64):    \
>          glue(glue(case INDEX_op_, x), _vec)
>=20=20
> -struct tcg_temp_info {
> +typedef struct TempOptInfo {
>      bool is_const;
>      TCGTemp *prev_copy;
>      TCGTemp *next_copy;
>      tcg_target_ulong val;
>      tcg_target_ulong mask;
> -};
> +} TempOptInfo;
>=20=20
> -static inline struct tcg_temp_info *ts_info(TCGTemp *ts)
> +static inline TempOptInfo *ts_info(TCGTemp *ts)
>  {
>      return ts->state_ptr;
>  }
>=20=20
> -static inline struct tcg_temp_info *arg_info(TCGArg arg)
> +static inline TempOptInfo *arg_info(TCGArg arg)
>  {
>      return ts_info(arg_temp(arg));
>  }
> @@ -71,9 +71,9 @@ static inline bool ts_is_copy(TCGTemp *ts)
>  /* Reset TEMP's state, possibly removing the temp for the list of copies=
.  */
>  static void reset_ts(TCGTemp *ts)
>  {
> -    struct tcg_temp_info *ti =3D ts_info(ts);
> -    struct tcg_temp_info *pi =3D ts_info(ti->prev_copy);
> -    struct tcg_temp_info *ni =3D ts_info(ti->next_copy);
> +    TempOptInfo *ti =3D ts_info(ts);
> +    TempOptInfo *pi =3D ts_info(ti->prev_copy);
> +    TempOptInfo *ni =3D ts_info(ti->next_copy);
>=20=20
>      ni->prev_copy =3D ti->prev_copy;
>      pi->next_copy =3D ti->next_copy;
> @@ -89,12 +89,12 @@ static void reset_temp(TCGArg arg)
>  }
>=20=20
>  /* Initialize and activate a temporary.  */
> -static void init_ts_info(struct tcg_temp_info *infos,
> +static void init_ts_info(TempOptInfo *infos,
>                           TCGTempSet *temps_used, TCGTemp *ts)
>  {
>      size_t idx =3D temp_idx(ts);
>      if (!test_bit(idx, temps_used->l)) {
> -        struct tcg_temp_info *ti =3D &infos[idx];
> +        TempOptInfo *ti =3D &infos[idx];
>=20=20
>          ts->state_ptr =3D ti;
>          ti->next_copy =3D ts;
> @@ -114,7 +114,7 @@ static void init_ts_info(struct tcg_temp_info *infos,
>      }
>  }
>=20=20
> -static void init_arg_info(struct tcg_temp_info *infos,
> +static void init_arg_info(TempOptInfo *infos,
>                            TCGTempSet *temps_used, TCGArg arg)
>  {
>      init_ts_info(infos, temps_used, arg_temp(arg));
> @@ -177,7 +177,7 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op=
, TCGArg dst, TCGArg val)
>      const TCGOpDef *def;
>      TCGOpcode new_op;
>      tcg_target_ulong mask;
> -    struct tcg_temp_info *di =3D arg_info(dst);
> +    TempOptInfo *di =3D arg_info(dst);
>=20=20
>      def =3D &tcg_op_defs[op->opc];
>      if (def->flags & TCG_OPF_VECTOR) {
> @@ -208,8 +208,8 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op,=
 TCGArg dst, TCGArg src)
>      TCGTemp *dst_ts =3D arg_temp(dst);
>      TCGTemp *src_ts =3D arg_temp(src);
>      const TCGOpDef *def;
> -    struct tcg_temp_info *di;
> -    struct tcg_temp_info *si;
> +    TempOptInfo *di;
> +    TempOptInfo *si;
>      tcg_target_ulong mask;
>      TCGOpcode new_op;
>=20=20
> @@ -242,7 +242,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op,=
 TCGArg dst, TCGArg src)
>      di->mask =3D mask;
>=20=20
>      if (src_ts->type =3D=3D dst_ts->type) {
> -        struct tcg_temp_info *ni =3D ts_info(si->next_copy);
> +        TempOptInfo *ni =3D ts_info(si->next_copy);
>=20=20
>          di->next_copy =3D si->next_copy;
>          di->prev_copy =3D src_ts;
> @@ -605,7 +605,7 @@ void tcg_optimize(TCGContext *s)
>  {
>      int nb_temps, nb_globals;
>      TCGOp *op, *op_next, *prev_mb =3D NULL;
> -    struct tcg_temp_info *infos;
> +    TempOptInfo *infos;
>      TCGTempSet temps_used;
>=20=20
>      /* Array VALS has an element for each temp.
> @@ -616,7 +616,7 @@ void tcg_optimize(TCGContext *s)
>      nb_temps =3D s->nb_temps;
>      nb_globals =3D s->nb_globals;
>      bitmap_zero(temps_used.l, nb_temps);
> -    infos =3D tcg_malloc(sizeof(struct tcg_temp_info) * nb_temps);
> +    infos =3D tcg_malloc(sizeof(TempOptInfo) * nb_temps);
>=20=20
>      QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
>          tcg_target_ulong mask, partmask, affected;


--=20
Alex Benn=C3=A9e

