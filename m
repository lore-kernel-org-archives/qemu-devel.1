Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410FC31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F876206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GB0tSsF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F876206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsL6-0004UA-GG
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsJC-0002kn-U8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsJA-0008Aq-WE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:08:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsJ8-00086L-Vj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:08:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so10133057wrs.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7jKN2spktfMVgvgMRdSdZLjUPL156nZVxHWF9nsQkiI=;
 b=GB0tSsF6r3FD1PccgAqWVg/+ggNkytoA/ha7igZNkmIT4Gewg/SpQC7OXYL1fafG+i
 7laRuHMal2eqc4JqH4gW2UK0pN7lVUt2RLpmRO/XGB5ZXdV7wN0ey/gJn68QfW91pDYE
 0FH4mQeYlYiJtNFxjEI8qQIJz7gxXwDt9V0h2vDhVqqhMxPN6DnzESZ/pf/Kw2oJwHIL
 RzqhxUkaqz9T/i10Yih3sC8mJ9vqbyLCiMQo7JRoZtem1YpJWCG/wF3p8vsJ89fYFTCS
 W8B6rLfA47LDdJZcfkTnstTRLcUC5NbJ598AETBTWG6a0GfSf3hDBXND5OV/dy6nmS4l
 Vb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7jKN2spktfMVgvgMRdSdZLjUPL156nZVxHWF9nsQkiI=;
 b=cSsjMItrtkagt8lLSz/QyliVHC8wmFZ/Qi4tm+Qp5GX7s9mvfQailYTy0MnrXTgPPP
 3LEUwSxe7m0WWcTxadJb03mf9A0YGHGl4t8gQHbRlwOaW6JdwXVOjgIyAUfgAzJt4KID
 Ur94rvo4NtPUnACRAwthiFevyUW1qfi1wpCzZpjwxrl5mXwhKFQAOTHgR/3/hgfLIRUd
 CQtj6PWPjVAEPPhxIxBfYFoCX3ff9lPpRWz9AFV6YhNX1FgaXPOHv+fBi1WpIjHB9Nt/
 ULwr50Hehu7X8wCmzWZJ4AYbWfo7IRrln/lJKklE3HEEesy5zLZhvi3BnCdCLFDTYcK1
 xCxA==
X-Gm-Message-State: APjAAAVZcXB+OJO9taBq5BtEfkSouahAdTW0L8h53FvZhpP5oxVpz0Oc
 sBMgJ0CpM1Epy2rWIpAzoZ94Ug==
X-Google-Smtp-Source: APXvYqz5KAsT3MXD2GRHDVhaP+WpEzjzNRY/aY44ISh2H4jJRDp1JB5uCGBXw5Q01QCk61C8Fp/0AA==
X-Received: by 2002:a05:6000:114b:: with SMTP id
 d11mr10550384wrx.167.1560780504466; 
 Mon, 17 Jun 2019 07:08:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t14sm8473241wrr.33.2019.06.17.07.08.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:08:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EDD91FF87;
 Mon, 17 Jun 2019 15:08:23 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-11-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-11-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:08:23 +0100
Message-ID: <87sgs89ueg.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 10/23] target/arm: Move the
 v7-M Security State helpers to v7m_helper
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c     | 73 -----------------------------------------
>  target/arm/v7m_helper.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 73 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b4fd9b42d7..cf76010ea1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7885,79 +7885,6 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *en=
v)
>       */
>  }
>
> -/*
> - * Write to v7M CONTROL.SPSEL bit for the specified security bank.
> - * This may change the current stack pointer between Main and Process
> - * stack pointers if it is done for the CONTROL register for the current
> - * security state.
> - */
> -void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> -                                          bool new_spsel,
> -                                          bool secstate)
> -{
> -    bool old_is_psp =3D v7m_using_psp(env);
> -
> -    env->v7m.control[secstate] =3D
> -        deposit32(env->v7m.control[secstate],
> -                  R_V7M_CONTROL_SPSEL_SHIFT,
> -                  R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
> -
> -    if (secstate =3D=3D env->v7m.secure) {
> -        bool new_is_psp =3D v7m_using_psp(env);
> -        uint32_t tmp;
> -
> -        if (old_is_psp !=3D new_is_psp) {
> -            tmp =3D env->v7m.other_sp;
> -            env->v7m.other_sp =3D env->regs[13];
> -            env->regs[13] =3D tmp;
> -        }
> -    }
> -}
> -
> -/*
> - * Write to v7M CONTROL.SPSEL bit. This may change the current
> - * stack pointer between Main and Process stack pointers.
> - */
> -void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
> -{
> -    write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
> -}
> -
> -/* Switch M profile security state between NS and S */
> -void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
> -{
> -    uint32_t new_ss_msp, new_ss_psp;
> -
> -    if (env->v7m.secure =3D=3D new_secstate) {
> -        return;
> -    }
> -
> -    /*
> -     * All the banked state is accessed by looking at env->v7m.secure
> -     * except for the stack pointer; rearrange the SP appropriately.
> -     */
> -    new_ss_msp =3D env->v7m.other_ss_msp;
> -    new_ss_psp =3D env->v7m.other_ss_psp;
> -
> -    if (v7m_using_psp(env)) {
> -        env->v7m.other_ss_psp =3D env->regs[13];
> -        env->v7m.other_ss_msp =3D env->v7m.other_sp;
> -    } else {
> -        env->v7m.other_ss_msp =3D env->regs[13];
> -        env->v7m.other_ss_psp =3D env->v7m.other_sp;
> -    }
> -
> -    env->v7m.secure =3D new_secstate;
> -
> -    if (v7m_using_psp(env)) {
> -        env->regs[13] =3D new_ss_psp;
> -        env->v7m.other_sp =3D new_ss_msp;
> -    } else {
> -        env->regs[13] =3D new_ss_msp;
> -        env->v7m.other_sp =3D new_ss_psp;
> -    }
> -}
> -
>  static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool thre=
admode,
>                                  bool spsel)
>  {
> diff --git a/target/arm/v7m_helper.c b/target/arm/v7m_helper.c
> index 321154966e..558e143039 100644
> --- a/target/arm/v7m_helper.c
> +++ b/target/arm/v7m_helper.c
> @@ -88,6 +88,79 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t add=
r, uint32_t op)
>
>  #else
>
> +/*
> + * Write to v7M CONTROL.SPSEL bit for the specified security bank.
> + * This may change the current stack pointer between Main and Process
> + * stack pointers if it is done for the CONTROL register for the current
> + * security state.
> + */
> +void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> +                                          bool new_spsel,
> +                                          bool secstate)
> +{
> +    bool old_is_psp =3D v7m_using_psp(env);
> +
> +    env->v7m.control[secstate] =3D
> +        deposit32(env->v7m.control[secstate],
> +                  R_V7M_CONTROL_SPSEL_SHIFT,
> +                  R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
> +
> +    if (secstate =3D=3D env->v7m.secure) {
> +        bool new_is_psp =3D v7m_using_psp(env);
> +        uint32_t tmp;
> +
> +        if (old_is_psp !=3D new_is_psp) {
> +            tmp =3D env->v7m.other_sp;
> +            env->v7m.other_sp =3D env->regs[13];
> +            env->regs[13] =3D tmp;
> +        }
> +    }
> +}
> +
> +/*
> + * Write to v7M CONTROL.SPSEL bit. This may change the current
> + * stack pointer between Main and Process stack pointers.
> + */
> +void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
> +{
> +    write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
> +}
> +
> +/* Switch M profile security state between NS and S */
> +void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
> +{
> +    uint32_t new_ss_msp, new_ss_psp;
> +
> +    if (env->v7m.secure =3D=3D new_secstate) {
> +        return;
> +    }
> +
> +    /*
> +     * All the banked state is accessed by looking at env->v7m.secure
> +     * except for the stack pointer; rearrange the SP appropriately.
> +     */
> +    new_ss_msp =3D env->v7m.other_ss_msp;
> +    new_ss_psp =3D env->v7m.other_ss_psp;
> +
> +    if (v7m_using_psp(env)) {
> +        env->v7m.other_ss_psp =3D env->regs[13];
> +        env->v7m.other_ss_msp =3D env->v7m.other_sp;
> +    } else {
> +        env->v7m.other_ss_msp =3D env->regs[13];
> +        env->v7m.other_ss_psp =3D env->v7m.other_sp;
> +    }
> +
> +    env->v7m.secure =3D new_secstate;
> +
> +    if (v7m_using_psp(env)) {
> +        env->regs[13] =3D new_ss_psp;
> +        env->v7m.other_sp =3D new_ss_msp;
> +    } else {
> +        env->regs[13] =3D new_ss_msp;
> +        env->v7m.other_sp =3D new_ss_psp;
> +    }
> +}
> +
>  void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
>  {
>      /*


--
Alex Benn=C3=A9e

