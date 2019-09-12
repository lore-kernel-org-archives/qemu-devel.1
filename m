Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA7DC4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3566C206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bx4KctH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3566C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8N9l-0005VR-CU
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8N8Z-0004ld-OP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8N8Y-0001a4-JX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:19:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8N8Y-0001Zd-Dl
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:19:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id k6so15851536wrn.11
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0vEnksmCr3Ko8QT0UrUz+qBA//eyI69NH7HtG70C50w=;
 b=Bx4KctH/AZVYaOPbfd0vDa+zregXOoPLvCrApDB9LckIFdDu2Jse5LlDt69XS/4LUZ
 h2cRzD/QPmxh8HCaBRP9pdg9lMt0UGUKq8GRzqQTtFX9E+d3LbQvWn1eUjDY0+avGOPx
 ggPx+SmMkcSzH1wGunPHB8uKAmBVYzly6fYbKzKtUMKpWMj1hRiQqdr2oNNQ04FGJwL4
 ORL+A1Avw9ThzOA8J/x5G6Rh7tMALpcZgw5DZGoOQ9Zejz8KSGKgEUakVf4r6ubz/8vr
 XdZuaQU7apqt7KPgKnOWEevN4GFVdQ2L/Gx5Vm8c6x08Qng6sPQaukfic3QLG1Q6P8aZ
 0fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0vEnksmCr3Ko8QT0UrUz+qBA//eyI69NH7HtG70C50w=;
 b=ucSQT+5PYsJQC0WsZJyWEkBrhK94V4fY8VhWHQhcFgjmIl0jokpv2TrhbDFYQuR6Ei
 qad6HIJfGBhJABOEeuDyHkzvrt5SAFcTcgU3YrKn3LO2ckLDvtFqBUqVmfsyF9ehD2XO
 9Zh1AvYpK8FZNXVDt+nJIrgo+ai3aeejK3hZwpfrH4hD97YkZ6Q9LjRBS7R4axwWqCbK
 uY0iimMjZ2xsvh8UeCQPzZQHbclpqi8zj8l1Gl8P0S9oXtWSwjck5LBpzrPprsE4FTZl
 1q7nBu0BtTYbIcQSlIgpuutctp/pdY4auCMXzlO5L9EtTMb1vOdcr+bB7ER44z6f1H9S
 FMAw==
X-Gm-Message-State: APjAAAVyV4U2RR49TfcYKFhbBuVfqf3MvZlNvyb9DM336DTYXM3YuUi7
 q0CcLBoTEkyhsyhOOKfr4CqfcA==
X-Google-Smtp-Source: APXvYqzaswBqclWgIT5g5fN5MB4eZt5Ya3Aie255etb7Bio5ID7kqKfISXht2+7J6uGvSJdEk1LgzA==
X-Received: by 2002:adf:e352:: with SMTP id n18mr463471wrj.89.1568287181044;
 Thu, 12 Sep 2019 04:19:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y14sm39876906wrd.84.2019.09.12.04.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:19:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 535FF1FF87;
 Thu, 12 Sep 2019 12:19:39 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-8-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-8-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:19:39 +0100
Message-ID: <87k1adzrqs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 07/13] target/arm/arm-semi:
 Factor out implementation of SYS_READ
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


Peter Maydell <peter.maydell@linaro.org> writes:

> Factor out the implementation of SYS_READ via the
> new function tables.

"As for SYS_WRITE we need env for lock_user in system emulation."?

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Either way:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 57 ++++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 0dec4c04e2f..48a10dd3c3a 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -347,6 +347,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_=
syscall_complete_cb cb,
>  typedef uint32_t sys_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
>  typedef uint32_t sys_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
>                               target_ulong buf, uint32_t len);
> +typedef uint32_t sys_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong buf, uint32_t len);
>
>  static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
> @@ -374,6 +376,29 @@ static uint32_t host_writefn(TaskState *ts, ARMCPU *=
cpu, GuestFD *gf,
>      return len - ret;
>  }
>
> +static uint32_t host_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong buf, uint32_t len)
> +{
> +    uint32_t ret;
> +#ifndef CONFIG_USER_ONLY
> +    CPUARMState *env =3D &cpu->env;
> +#endif
> +    char *s =3D lock_user(VERIFY_WRITE, buf, len, 0);
> +    if (!s) {
> +        /* return bytes not read */
> +        return len;
> +    }
> +    do {
> +        ret =3D set_swi_errno(ts, read(gf->hostfd, s, len));
> +    } while (ret =3D=3D -1 && errno =3D=3D EINTR);
> +    unlock_user(s, buf, len);
> +    if (ret =3D=3D (uint32_t)-1) {
> +        ret =3D 0;
> +    }
> +    /* Return bytes not read */
> +    return len - ret;
> +}
> +
>  static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
>      return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -387,19 +412,30 @@ static uint32_t gdb_writefn(TaskState *ts, ARMCPU *=
cpu, GuestFD *gf,
>                             gf->hostfd, buf, len);
>  }
>
> +static uint32_t gdb_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                           target_ulong buf, uint32_t len)
> +{
> +    arm_semi_syscall_len =3D len;
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
> +                           gf->hostfd, buf, len);
> +}
> +
>  typedef struct GuestFDFunctions {
>      sys_closefn *closefn;
>      sys_writefn *writefn;
> +    sys_readfn *readfn;
>  } GuestFDFunctions;
>
>  static const GuestFDFunctions guestfd_fns[] =3D {
>      [GuestFDHost] =3D {
>          .closefn =3D host_closefn,
>          .writefn =3D host_writefn,
> +        .readfn =3D host_readfn,
>      },
>      [GuestFDGDB] =3D {
>          .closefn =3D gdb_closefn,
>          .writefn =3D gdb_writefn,
> +        .readfn =3D gdb_readfn,
>      },
>  };
>
> @@ -551,26 +587,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, -1);
>          }
>
> -        if (use_gdb_syscalls()) {
> -            arm_semi_syscall_len =3D len;
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
> -                                   gf->hostfd, arg1, len);
> -        } else {
> -            s =3D lock_user(VERIFY_WRITE, arg1, len, 0);
> -            if (!s) {
> -                /* return bytes not read */
> -                return len;
> -            }
> -            do {
> -                ret =3D set_swi_errno(ts, read(gf->hostfd, s, len));
> -            } while (ret =3D=3D -1 && errno =3D=3D EINTR);
> -            unlock_user(s, arg1, len);
> -            if (ret =3D=3D (uint32_t)-1) {
> -                ret =3D 0;
> -            }
> -            /* Return bytes not read */
> -            return len - ret;
> -        }
> +        return guestfd_fns[gf->type].readfn(ts, cpu, gf, arg1, len);
>      case TARGET_SYS_READC:
>          qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func=
__);
>          return 0;


--
Alex Benn=C3=A9e

