Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABBECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ED5206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Km5iUE+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ED5206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5j1-0005IR-W0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5i1-0004Lz-1x
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5hz-00068V-W3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:08:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5hz-00068F-P6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:08:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so17800260wml.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IsxFNjNTjkAErm8eA+1ngUEPz0N+TCkVu3/ewdhXkag=;
 b=Km5iUE+FS5nVVZ0+/xWxGE8rZkdn371fgiebJBqpB+JO5UIXp8gV6NUKOTdJz82rLS
 YoyKJFqK1fhgMi3kJn4Fn/Xv8jfv/bJ7xHy7RTwnzAEzfoV9cRz4QGUrDI1UgoOXtUeV
 lUs4rMtA1OmSVPIZ3CjQfzHPNx0ji0Yn0KLo9LxexY2pacd1LNAdUSofKsr5Vj7SRnP3
 tHFDL9h050AXCywxdUVAxyrW9+z1DBsHb0VJfe4LZs6NKbU42sEpBt/8lm2pOgLOCM1u
 Ta5rGf53Q35SP2+Y01u2qh2uqImgRjot6Y65iJkuKFX3fmSeOXy1E2wyqWqC9dKj592h
 DXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IsxFNjNTjkAErm8eA+1ngUEPz0N+TCkVu3/ewdhXkag=;
 b=dPPFDZR5Kgd6JIMC5C72EFF2PV7A8sUYF7e1mBu1luXya+6/bHXlp2WYlbKyqdBPbt
 EgI6R1H519Mjtln3d8LW5lBfoKe8QHkkJhFeWgWB2jESiJyH6kFoqL4okBbeMH1MxTje
 87twWbVlq9ixpCeTRDRhX50Hj9pTNvfZwmLUH1WLT4X5grVhorr4296+tZJh77dbRlc4
 iLPwwB0XSxA6aExxWRVGonqd0y8f/lHyTLuy2Da1+43NMYvefiEB6acThEYnpgYHVbSX
 1SmzgXkgsuk123X6Um5t/2rj1x8I7kQBgD4nhbzTRhCt3LOUEZ9yw4wKGshpQ5w8F7Ia
 iMMA==
X-Gm-Message-State: APjAAAU6VTrTcjiokk2HwHSxgLsKVuJEXcYAQZBYzfXzUwqTHnRmUekF
 x7NkextRmKun0D3kDI7VAL5vuw==
X-Google-Smtp-Source: APXvYqyBcTYNlyCcip0hHFxjKCoy/k3w9Q6XBtAmZOHYWb0lD2ytMgjx+EPnN3NC/W3Rwbv6t3LLBw==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr8806695wmi.147.1571080122438; 
 Mon, 14 Oct 2019 12:08:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d193sm33594091wmd.0.2019.10.14.12.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 12:08:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 46CFC1FF87;
 Mon, 14 Oct 2019 20:08:41 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-20-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 19/20] target/arm: Rebuild hflags for M-profile.
In-reply-to: <20191011155546.14342-20-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 20:08:41 +0100
Message-ID: <874l0bm9fq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Continue setting, but not relying upon, env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/m_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
> index 27cd2f3f96..f2512e448e 100644
> --- a/target/arm/m_helper.c
> +++ b/target/arm/m_helper.c
> @@ -494,6 +494,7 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
>      switch_v7m_security_state(env, dest & 1);
>      env->thumb =3D 1;
>      env->regs[15] =3D dest & ~1;
> +    arm_rebuild_hflags(env);
>  }
>
>  void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> @@ -555,6 +556,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t des=
t)
>      switch_v7m_security_state(env, 0);
>      env->thumb =3D 1;
>      env->regs[15] =3D dest;
> +    arm_rebuild_hflags(env);
>  }
>
>  static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool thre=
admode,
> @@ -895,6 +897,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t=
 lr, bool dotailchain,
>      env->regs[14] =3D lr;
>      env->regs[15] =3D addr & 0xfffffffe;
>      env->thumb =3D addr & 1;
> +    arm_rebuild_hflags(env);
>  }
>
>  static void v7m_update_fpccr(CPUARMState *env, uint32_t frameptr,
> @@ -1765,6 +1768,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>
>      /* Otherwise, we have a successful exception exit. */
>      arm_clear_exclusive(env);
> +    arm_rebuild_hflags(env);
>      qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
>  }
>
> @@ -1837,6 +1841,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
>      xpsr_write(env, 0, XPSR_IT);
>      env->thumb =3D newpc & 1;
>      env->regs[15] =3D newpc & ~1;
> +    arm_rebuild_hflags(env);
>
>      qemu_log_mask(CPU_LOG_INT, "...function return successful\n");
>      return true;
> @@ -1959,6 +1964,7 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
>      switch_v7m_security_state(env, true);
>      xpsr_write(env, 0, XPSR_IT);
>      env->regs[15] +=3D 4;
> +    arm_rebuild_hflags(env);
>      return true;
>
>  gen_invep:


--
Alex Benn=C3=A9e

