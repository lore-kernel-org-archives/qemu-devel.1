Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A46DC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 02:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EED20B7C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 02:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivjwWNzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EED20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwGkk-0008No-BP
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 22:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwGjH-0005hk-1b
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 22:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwGjF-0005Uh-Mv
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 22:03:34 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwGjF-0005UM-E9; Fri, 09 Aug 2019 22:03:33 -0400
Received: by mail-lf1-x142.google.com with SMTP id c19so70820110lfm.10;
 Fri, 09 Aug 2019 19:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G+duk7zj6MtgC/aAwGWmgTHU09nMOBNrTdfA+ShMYzQ=;
 b=ivjwWNzk8ipDxC3VQYTvmMt+zfdmN0iS+KPv8c9iEJ2HTt6ck7wYgnFelZwwqH+u/e
 TbFLrONgrU+pKmcTgT+ipVp6Oq8sXKZIRAs7n4N2HXi7yABvBcoZApzvHE4LXBQ3mkp8
 TuhJoczaH5cxEyFMavgSr4MEl3bxpEG0dKk9KZ5Gw77lmjTevD+ts8XODOlhgxbuZVea
 04R2AlZkU2a0RPfiz3e9KGo1MLQXE2SdxrRlrGhV5LpsgLMEwGxIz5jkw0/v/rrR+ZNO
 Rr11DEAGuW0kbnMY5ydq/lb6xN103BncbyeL2OObkJukycpmWf8fNEjYs4J3Y8kQ+OYv
 sERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+duk7zj6MtgC/aAwGWmgTHU09nMOBNrTdfA+ShMYzQ=;
 b=lJ+EiJPq955CBnzX0pq/0JkmGCoOx/sFSOa0+D2QD9X6pVOxBvmzE236CxHu8hLYCk
 zZm2Zqh3EUBv1XhHskCkaSz0ydvhgDpb7CrGFCmbCOQk+XOVLd13D8BqyUlP7qTrDEf9
 i1HJhmTAKS7++8dTXosJG/mQzbYL0BTpixoQO9e0srxxobut/W14I7Yq9ziqYnLQbBcp
 aI1QdTPoL/oGBq+dinA3s2Y1nN3n1HjQuCbwl3nQ1uhx1f8fguJScYwBFZRtjTPl9llI
 hVz9hYSw6T7brfL/hkSmFtT7MKsc8ppuWFaKJcdOfSWREsQRA+WW0z9hp6NBpWN+nRqL
 qXmg==
X-Gm-Message-State: APjAAAVddYoYPgh92dO5+e5EH3fHchtF/rHF3yNv7LxomRhkYO14GnIM
 QJi/Ap83uD9XwOJlSoBMCRxxuz1k0CwLm3Qbad4=
X-Google-Smtp-Source: APXvYqwUwkCFR7rn2MrJep/jDgUee/9YvPQqqzQgkbdFaaeP5JVwoTRUKv0+kLcjHhh6FRD9z+i9luwfLC5lOslNbNQ=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr14331811lfy.141.1565402612044; 
 Fri, 09 Aug 2019 19:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190809154153.31763-1-richard.henderson@linaro.org>
 <20190809154153.31763-4-richard.henderson@linaro.org>
In-Reply-To: <20190809154153.31763-4-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Aug 2019 19:03:05 -0700
Message-ID: <CAKmqyKP7DU0ZAB9ruOxVQxCLevw0XO8378oZc+diQAxpmqifWg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH 3/3] target/riscv: Remove redundant
 declaration pragmas
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 8:43 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are now generated by decodetree itself.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 8d6ab73258..adeddb85f6 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -708,26 +708,9 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rvd.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
> -/*
> - * Auto-generated decoder.
> - * Note that the 16-bit decoder reuses some of the trans_* functions
> - * initially declared by the 32-bit decoder, which results in duplicate
> - * declaration warnings.  Suppress them.
> - */
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> -# pragma GCC diagnostic push
> -# pragma GCC diagnostic ignored "-Wredundant-decls"
> -# ifdef __clang__
> -#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> -# endif
> -#endif
> -
> +/* Include the auto-generated decoder for 16 bit insn */
>  #include "decode_insn16.inc.c"
>
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> -# pragma GCC diagnostic pop
> -#endif
> -
>  static void decode_opc(DisasContext *ctx)
>  {
>      /* check for compressed insn */
> --
> 2.17.1
>
>

