Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99844C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAB72082C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bo7kf47F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAB72082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5sDH-0002eR-KZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5sCE-0001dW-9a
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5sCC-0007rh-DY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:53:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5sCC-0007rC-15
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:53:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id g207so2894438wmg.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jvQSQWirlVyujTR96qV2+Mq0FBny+ywIzibWcHE3Tok=;
 b=bo7kf47FCELKXH0g+aJEqHRT6yuBRxcWo0iybT7mU9BAbWn4ndpX2nguJD5yEPnk+w
 iW9kh7V/puccrU8oXi7HZ26cdYCtGe9GQ2jlRTDQDfcKv45kjHDsIbITBlUxZi/Eyi3V
 UbgCxAx8KXwRAK7x5mTYpnlRUjsYZAU1lLNo65Hr6A+0+AQmqj3woHj7T2ufoqu9yfdc
 K+6GMYFIC+weUQvEan+iStJqC87IELw6DNantdfKlVYxQALBfXq+JZI/Fbb5q3n8el4+
 BPizBw0tSV+E1jhTopmVEw11O+QEsGiPv6S6rSf80vpr6KfAUbo914R+WFPqSbVptD+V
 PR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jvQSQWirlVyujTR96qV2+Mq0FBny+ywIzibWcHE3Tok=;
 b=r2cvRFBE9ZmtfzGJ9V65uIOPOeEWaxgQbhZuy4yJiIDQMc2B8ccSfhpIyJOS5P8v+H
 Df6xoRYDK+IHXITvCh1GULWVSmtIOQP32X+yeC+qb4UIlcyuhTCVQFgnEyxS6u0OEEeQ
 YyEz9LcuVQLejYe0H3YaaJsr6olZNxB7++XHWcQLxGntZwK9PYoKB43mn9dJCJhDl8rs
 C5JFbC/b364B+siN5soGiR4TgECy0dIBcP65arrGIRp9nK3OgpmdfNFnRDZ7PyVn39U4
 K++McY2ByGXbvnVteYqWI7Trm9MnI4AkjBCCwiblnsskBojTjivDgD23w9KJt+GaFDWU
 1Jwg==
X-Gm-Message-State: APjAAAUGAIJbAgpbu1ntfd6apczONbcZY7YfzBu2Q/tTprPqJSgConTD
 Jsek4kueQIgvqLGLTf8OF/O+gQ==
X-Google-Smtp-Source: APXvYqyEmSgW8JcbeVkh2PqhkG4QxWtP8oLHUE9bOJCEv2gmAg/i6XBI2igV4u8L1ON0nfRgo7cbTw==
X-Received: by 2002:a1c:f20a:: with SMTP id s10mr3208294wmc.145.1567691586726; 
 Thu, 05 Sep 2019 06:53:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t25sm1710845wmj.29.2019.09.05.06.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 06:53:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 595631FF87;
 Thu,  5 Sep 2019 14:53:05 +0100 (BST)
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-17-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190820210720.18976-17-richard.henderson@linaro.org>
Date: Thu, 05 Sep 2019 14:53:05 +0100
Message-ID: <87a7bi97em.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v5 16/17] target/arm: Rebuild hflags at EL
 changes and MSR writes
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Now setting, but not relying upon, env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c       |  1 +
>  target/arm/cpu.c           |  1 +
>  target/arm/helper-a64.c    |  3 +++
>  target/arm/helper.c        |  2 ++
>  target/arm/machine.c       |  1 +
>  target/arm/op_helper.c     |  1 +
>  target/arm/translate-a64.c |  6 +++++-
>  target/arm/translate.c     | 18 ++++++++++++++++--
>  8 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8b41a03901..be01c33759 100644
<snip>

I had to manually fix these up due to the patch failing to apply. I
think because 9e9b10c64911 removes the gen_io_end() calls.

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index fc3e5f5c38..4412c60383 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1777,11 +1777,15 @@ static void handle_sys(DisasContext *s, uint32_t =
insn, bool isread,
>          /* I/O operations must end the TB here (whether read or write) */
>          gen_io_end();
>          s->base.is_jmp =3D DISAS_UPDATE;
> -    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +    }
> +    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>          /* We default to ending the TB on a coprocessor register write,
>           * but allow this to be suppressed by the register definition
>           * (usually only necessary to work around guest bugs).
>           */
> +        TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
> +        tcg_temp_free_i32(tcg_el);
>          s->base.is_jmp =3D DISAS_UPDATE;
>      }
>  }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d948757131..2f7beca065 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7130,6 +7130,8 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
>      ri =3D get_arm_cp_reginfo(s->cp_regs,
>              ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
>      if (ri) {
> +        bool need_exit_tb;
> +
>          /* Check access permissions */
>          if (!cp_access_ok(s->current_el, ri, isread)) {
>              return 1;
> @@ -7301,15 +7303,27 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
>              }
>          }
>
> +        need_exit_tb =3D false;
>          if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_C=
P_IO)) {
>              /* I/O operations must end the TB here (whether read or writ=
e) */
>              gen_io_end();
> -            gen_lookup_tb(s);
> -        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +            need_exit_tb =3D true;
> +        }
> +        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>              /* We default to ending the TB on a coprocessor register wri=
te,
>               * but allow this to be suppressed by the register definition
>               * (usually only necessary to work around guest bugs).
>               */
> +            TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +            if (arm_dc_feature(s, ARM_FEATURE_M)) {
> +                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
> +            } else {
> +                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +            }
> +            tcg_temp_free_i32(tcg_el);
> +            need_exit_tb =3D true;
> +        }
> +        if (need_exit_tb) {
>              gen_lookup_tb(s);
>          }


--
Alex Benn=C3=A9e

