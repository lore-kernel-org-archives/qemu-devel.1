Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DFBC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCA72076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEh0g948"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCA72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHUy-0000zO-QN
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRHUE-0000MY-73
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRHUC-0006f2-AS
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:40:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRHUA-0006VE-8O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:40:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id h2so2879547wmb.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VyeGp+GZB4z6ZDmQWpBpKc2/dzm7QYfBD8AdN8oeVMs=;
 b=ZEh0g948XmvJ9f/J2VPmGdI5w7CKBzgWryXh8O57wPTX0fkNuyDMMxyTE89oFOOSMA
 yDQZ7P7GNHjPHgK/ITU/8hKQ4Z8+ouiNHj8exttWyKut1j0o8saicV1vfkhFU+UasHtl
 560EDdgy+UkLowyuBhauj6PNyfdlT/dGyeFvoWhd6lwcHYize2WjNqbcpR/469NV6n3u
 W9MB8sHOMvTxhiexQLvTzEVoEjTd7RCFFmMhdETSncFnXB/1xLSFqSZKynVv9CNBoN+p
 a8MhCY9IxiWjpUvpYkT9ZejShUNVAVu1WTeBN6ojvtIT4y3irxRBPEI7oINotHgVgc9L
 krEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VyeGp+GZB4z6ZDmQWpBpKc2/dzm7QYfBD8AdN8oeVMs=;
 b=mfRuY+YMZKHErdHYE1ST7Bvi9BX89jI7E/GTYt7j1CFZH0zNf2LbKrjzELd1diK+GL
 AxnRPVhIp3BknNdOYI9dk8W3TTcbXoZntx2AsnNij6C6tBcIpaBlDNsHZ6huiuGjjWAM
 IPZKr125EK1VcyDludeKmPvOAs7cvvKt8to2CIJnErNc+aN0ONc0LLRhDbklGPvGZYqk
 bLpL9FTfmAZB3xEa8Pugq/QlMtx8+xrfKxC6XHr9GMToOKh0knS5JhaRLk4DT77Vm2on
 ILfj3zq/zWFLYyMTllHHlg/3G4+fL91ns8fKpGWGRRuzJCLdAH9TLEsLcFZ6D7Jf5u8y
 o7WA==
X-Gm-Message-State: AGi0Pual1qDHGU43n3MMVIXpab2if0544htpU8aziz833Jnb3JDH0Ryf
 AGaUSFstaJBa8fK6nHKNoeTy3g==
X-Google-Smtp-Source: APiQypKEht3f+vx4JncvOz1T+nlBV39Tdd8G/ioFbLTz2eMtWjm/jtE6DFKBAg1qw7OKI30XDeyrUg==
X-Received: by 2002:a1c:bd8b:: with SMTP id
 n133mr11833568wmf.175.1587570024065; 
 Wed, 22 Apr 2020 08:40:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u17sm10621749wra.63.2020.04.22.08.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 08:40:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 252D71FF7E;
 Wed, 22 Apr 2020 16:40:22 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-13-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 12/36] tcg: Use tcg_constant_i32 with icount expander
In-reply-to: <20200422011722.13287-13-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 16:40:22 +0100
Message-ID: <87mu73cyvt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

> We must do this before we adjust how tcg_out_movi_i32,
> lest the under-the-hood poking that we do be broken.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/gen-icount.h | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 822c43cfd3..404732518a 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -34,7 +34,7 @@ static inline void gen_io_end(void)
>=20=20
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
> -    TCGv_i32 count, imm;
> +    TCGv_i32 count;
>=20=20
>      tcg_ctx->exitreq_label =3D gen_new_label();
>      if (tb_cflags(tb) & CF_USE_ICOUNT) {
> @@ -48,15 +48,13 @@ static inline void gen_tb_start(TranslationBlock *tb)
>                     offsetof(ArchCPU, env));
>=20=20
>      if (tb_cflags(tb) & CF_USE_ICOUNT) {
> -        imm =3D tcg_temp_new_i32();
> -        /* We emit a movi with a dummy immediate argument. Keep the insn=
 index
> -         * of the movi so that we later (when we know the actual insn co=
unt)
> -         * can update the immediate argument with the actual insn count.=
  */
> -        tcg_gen_movi_i32(imm, 0xdeadbeef);
> +        /*
> +         * We emit a sub with a dummy immediate argument. Keep the insn =
index
> +         * of the sub so that we later (when we know the actual insn cou=
nt)
> +         * can update the argument with the actual insn count.
> +         */
> +        tcg_gen_sub_i32(count, count, tcg_constant_i32(0));
>          icount_start_insn =3D tcg_last_op();
> -
> -        tcg_gen_sub_i32(count, count, imm);
> -        tcg_temp_free_i32(imm);
>      }
>=20=20
>      tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
> @@ -74,9 +72,12 @@ static inline void gen_tb_start(TranslationBlock *tb)
>  static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
>  {
>      if (tb_cflags(tb) & CF_USE_ICOUNT) {
> -        /* Update the num_insn immediate parameter now that we know
> -         * the actual insn count.  */
> -        tcg_set_insn_param(icount_start_insn, 1, num_insns);
> +        /*
> +         * Update the num_insn immediate parameter now that we know
> +         * the actual insn count.
> +         */
> +        tcg_set_insn_param(icount_start_insn, 2,
> +                           tcgv_i32_arg(tcg_constant_i32(num_insns)));
>      }
>=20=20
>      gen_set_label(tcg_ctx->exitreq_label);


--=20
Alex Benn=C3=A9e

