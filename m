Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED75C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2266C206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFo13IoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2266C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPOt-0007Uh-As
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKPOE-00073w-TQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKPOD-00087R-Ao
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:41:54 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:33410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKPOC-00086u-TV
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:41:53 -0400
Received: by mail-ot1-x332.google.com with SMTP id 22so7970232otf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RcOjAfcVergWCiWxhHnDkoJAu3Ubwt1fQDAJzV58IeA=;
 b=xFo13IoFR4UKYmCRpM0iYI7DW3WWKEDPb257ILbmfMa9VjB89svIMnSI3IV08LGyQb
 cZ6Wv62RPb1nEDaH04zHjh9um0b+4QEQpH5D+4YAmA+/Cbz5Nu9eZXSOdQk2CYD9Yt4P
 MFjjQpPmqKhKO3o+C2oU5CjtuFNoM35GzlYapS3m0FItdL/fEso+dXcvqr37P0jY2JhT
 NwST4lJvgIyLSbQpXtegH6WMqjQvdb2ZyXuwdu+nMVy1luHTNt1v4QWCtXfsrZ4RH2+1
 UKcls01/L0b9cLyXnG4xz8lGktB3Z3UrD8+JYopGg8yF0TcTSpMYCvo6VdSc9Wyoea86
 nENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RcOjAfcVergWCiWxhHnDkoJAu3Ubwt1fQDAJzV58IeA=;
 b=ZVlsZfeqUKr2jqh+7ovp7XU7pwImwe0Om52fIiJbXXj5yAeagVejPF1X1/aNH6Y/qp
 96+UtErBW+g6qElxhgZTYcx7zNX0M66My6sglT2TGH7TGBObvGGFfqQxriasCFElX3yq
 7qNuZDZ5vUPaTDegHHkpFGVA3PL/5gN1I0ka+MSJjqjl59Ek+BE6fyCxT+s/TasTtSEF
 JbzoMvm0pVK186jhnzuDtQNNRju9R8yzzVdINdBZ2nO9Og/UfxTNVid//1uqEpfBKukG
 JVhtz5MjkDck1xoynczToYNnSqrXCeYgcV/6hnRXIeT1vEvwAVizIJH7rvj7dZAhPOG3
 KyIQ==
X-Gm-Message-State: AGi0PubsOQrng4qDL8h9l5eKFxUWFh9xvbO4BD/A4rgbD1LnqyDYh52m
 T01hVi5/HQgmmJrtQuF3EIFa6FUoNLNcxhe6X3zhYw==
X-Google-Smtp-Source: APiQypLxR58Putt8PG0iosKDLb7HQUsm3QgssASSenikGKQkySlZE+lH/AJPnts4fUiZA+X0W6wNDnd96TfZncWz9j8=
X-Received: by 2002:a4a:2a09:: with SMTP id k9mr7383152oof.64.1585932111697;
 Fri, 03 Apr 2020 09:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200317163616.30027-1-f4bug@amsat.org>
 <20200317163616.30027-4-f4bug@amsat.org>
In-Reply-To: <20200317163616.30027-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 17:41:39 +0100
Message-ID: <CAFEAcA_zu+TXPyGiv9aeszY2s4uhxb=9HisKD1TipM4yj=e_Sw@mail.gmail.com>
Subject: Re: [PULL 03/13] target/rx: TCG translation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 16:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> This part only supported RXv1 instructions.
>
> Instruction manual:
>   https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01us00=
32ej0120_rxsm.pdf

Hi; Coverity points out a possible missing 'break' here
(CID 1422222):

> +static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
> +{
> +    DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> +
> +    switch (ctx->base.is_jmp) {
> +    case DISAS_NEXT:
> +    case DISAS_TOO_MANY:
> +        gen_goto_tb(ctx, 0, dcbase->pc_next);
> +        break;
> +    case DISAS_JUMP:
> +        if (ctx->base.singlestep_enabled) {
> +            gen_helper_debug(cpu_env);
> +        } else {
> +            tcg_gen_lookup_and_goto_ptr();
> +        }
> +        break;
> +    case DISAS_UPDATE:
> +        tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);

Should this have a "break" or a "/* fall through */" comment ?

> +    case DISAS_EXIT:
> +        tcg_gen_exit_tb(NULL, 0);
> +        break;
> +    case DISAS_NORETURN:
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

thanks
-- PMM

