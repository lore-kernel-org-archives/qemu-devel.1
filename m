Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD36C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAB9206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAB9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pKI-0002HQ-Eb
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5pJM-0001WL-K3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5pJK-0004Fc-Rf
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:48:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5pJK-0004BN-Hm
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:48:18 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CA20C055673
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:48:09 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b9so809933wrt.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YiJ7qMxZZrpWWgP5whvFQXJ+AM92m75a5pQYG7z5M2o=;
 b=bmkEmrZSSkKtfHAwH8H8jVL0zm1s7vQuerNErVJz2vV5z4XD0de28PcRXDMH5pIZfm
 Jda6VsFa3PSkU5yxOH36S2Pae1s+BNWF7TSOtx636kqAmiqlzW6tacpje5JsxKvxL3cj
 Wcd2WpHr0csDRJE9OiAXnTWgCppccX3VGpcPTtuxRBRyqHKUMbsrcx9+r397ApGHpvhH
 jKkPX89uPU1DudT6Iew2lEw+O812WmkgY1EAonS5NcNazZmmSBzTQdDNtZY6KGV19ZJd
 K1aXIUGHWkJxb5KZ//KEhnJSBKQSU8Vy5HrNn9zO28rA68PCR/r44+aLmWgxzTiGq7uC
 UlPQ==
X-Gm-Message-State: APjAAAVQWgumtGXYar2GUstpNGX6+pxPaY0xrLe3qbThKpxSrEw9ie+0
 fBdPsaxiRbvR91UaOR7u+rH5subCCHRdizct+TunPHshyao6a6YkbqMRbDwUxiPE1JN4WRzLE81
 jqPh8/T6XGN3ZiWc=
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr2587664wmg.127.1567680488330; 
 Thu, 05 Sep 2019 03:48:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXIlD7yzcW84+7EWOWNTXwsTIdEE+fUJeCJ+FBQSCM3NPT+mPCAEFm9xJ4LZEWZG1egOBMoQ==
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr2587648wmg.127.1567680488115; 
 Thu, 05 Sep 2019 03:48:08 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t203sm2781008wmf.42.2019.09.05.03.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:48:07 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190904193059.26202-1-richard.henderson@linaro.org>
 <20190904193059.26202-61-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4ca91971-bfdd-976a-5b9d-d38b42f826a7@redhat.com>
Date: Thu, 5 Sep 2019 12:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904193059.26202-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 60/69] target/arm: Split gen_nop_hint
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

On 9/4/19 9:30 PM, Richard Henderson wrote:
> Now that all callers pass a constant value, split the switch
> statement into the individual trans_* functions.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 67 +++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 43 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 69092c12c3..d076c962ea 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -3061,46 +3061,6 @@ static void gen_exception_return(DisasContext *s=
, TCGv_i32 pc)
>      gen_rfe(s, pc, load_cpu_field(spsr));
>  }
> =20
> -/*
> - * For WFI we will halt the vCPU until an IRQ. For WFE and YIELD we
> - * only call the helper when running single threaded TCG code to ensur=
e
> - * the next round-robin scheduled vCPU gets a crack. In MTTCG mode we
> - * just skip this instruction. Currently the SEV/SEVL instructions
> - * which are *one* of many ways to wake the CPU from WFE are not
> - * implemented so we can't sleep like WFI does.
> - */
> -static void gen_nop_hint(DisasContext *s, int val)
> -{
> -    switch (val) {
> -        /* When running in MTTCG we don't generate jumps to the yield =
and
> -         * WFE helpers as it won't affect the scheduling of other vCPU=
s.
> -         * If we wanted to more completely model WFE/SEV so we don't b=
usy
> -         * spin unnecessarily we would need to do something more invol=
ved.
> -         */
> -    case 1: /* yield */
> -        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
> -            gen_set_pc_im(s, s->base.pc_next);
> -            s->base.is_jmp =3D DISAS_YIELD;
> -        }
> -        break;
> -    case 3: /* wfi */
> -        gen_set_pc_im(s, s->base.pc_next);
> -        s->base.is_jmp =3D DISAS_WFI;
> -        break;
> -    case 2: /* wfe */
> -        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
> -            gen_set_pc_im(s, s->base.pc_next);
> -            s->base.is_jmp =3D DISAS_WFE;
> -        }
> -        break;
> -    case 4: /* sev */
> -    case 5: /* sevl */
> -        /* TODO: Implement SEV, SEVL and WFE.  May help SMP performanc=
e.  */
> -    default: /* nop */
> -        break;
> -    }
> -}
> -
>  #define CPU_V001 cpu_V0, cpu_V0, cpu_V1
> =20
>  static inline void gen_neon_add(int size, TCGv_i32 t0, TCGv_i32 t1)
> @@ -8194,19 +8154,40 @@ DO_SMLAWX(SMLAWT, 1, 1)
> =20
>  static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
>  {
> -    gen_nop_hint(s, 1);
> +    /*
> +     * When running single-threaded TCG code, use the helper to ensure=
 that
> +     * the next round-robin scheduled vCPU gets a crack.  When running=
 in
> +     * MTTCG we don't generate jumps to the helper as it won't affect =
the
> +     * scheduling of other vCPUs.
> +     */
> +    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
> +        gen_set_pc_im(s, s->base.pc_next);
> +        s->base.is_jmp =3D DISAS_YIELD;
> +    }
>      return true;
>  }
> =20
>  static bool trans_WFE(DisasContext *s, arg_WFE *a)
>  {
> -    gen_nop_hint(s, 2);
> +    /*
> +     * When running single-threaded TCG code, use the helper to ensure=
 that
> +     * the next round-robin scheduled vCPU gets a crack.  In MTTCG mod=
e we
> +     * just skip this instruction.  Currently the SEV/SEVL instruction=
s,
> +     * which are *one* of many ways to wake the CPU from WFE, are not
> +     * implemented so we can't sleep like WFI does.
> +     */
> +    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
> +        gen_set_pc_im(s, s->base.pc_next);
> +        s->base.is_jmp =3D DISAS_WFE;
> +    }
>      return true;
>  }
> =20
>  static bool trans_WFI(DisasContext *s, arg_WFI *a)
>  {
> -    gen_nop_hint(s, 3);
> +    /* For WFI, halt the vCPU until an IRQ. */
> +    gen_set_pc_im(s, s->base.pc_next);
> +    s->base.is_jmp =3D DISAS_WFI;
>      return true;
>  }

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



