Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25C7C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77B621726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77B621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nso-0001h0-9q
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3NlC-0001pE-5b
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3NlA-0003L3-Vy
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3NlA-0003Ko-Ob
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:58:56 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C30232A09B3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:58:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id v4so1412021wmh.9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oZDPIkMF/l6lea0HZB7P7CTwU6rQtBAG8KkUS5wwk80=;
 b=tcWIs9tRdbkp+B3nBuGkALHd2zc0ni+gptPL1TzqtnOdsdWUJNpYsTfxVX4wzk/JjE
 C7bcW4jscBUcYiMyWsk9yiVcisvyAOxowQZ34f9ZtvUk7HYX93x1h1spMMdl1SaHruWr
 geRyXy4QA6tVLBgrSazNIzQap9h9/wxVJIi/en7rzqWHfbDWhcee7J2pY6rGE/6Jr4aV
 nHybopYymYsOQrlF5GzWzj8rB1nV+2+YuqI2htVgyOlSQpkdoOnuyP9LX0L08ML999gm
 O7XqFxH04svp8P0RD2qA/otmt+0drrnws4na/GHqwVVEsv+GMe1gavYhPtKLPxwYrnTX
 Jtag==
X-Gm-Message-State: APjAAAX1DuFOusGR5VSQvKjO4DAViQpI8STvOK2C2nc14PRF53vaMhdW
 lT9j1n+4bF9wlU5xBvWQbm9FRv66IWsI5wWCq/L8v2zrYOceGHhnkIc/lVLXZVGW5weaUYa9nEG
 XZitRyw4r19VEA/Q=
X-Received: by 2002:adf:9e09:: with SMTP id u9mr12973120wre.169.1567097934579; 
 Thu, 29 Aug 2019 09:58:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8xEsucy0ZVZunfk0bSXRYCodk/D5Qb4aInrjyMIwx/HLYJZ3lfiz/aojhlFqbILKojAI87Q==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr12973098wre.169.1567097934361; 
 Thu, 29 Aug 2019 09:58:54 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id k9sm4522005wrq.15.2019.08.29.09.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:58:53 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <841e3900-81ab-a3c9-b4f9-5fbd023a2259@redhat.com>
Date: Thu, 29 Aug 2019 18:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/8] exec: Move user-only watchpoint
 stubs inline
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 1:16 AM, Richard Henderson wrote:
> Let the user-only watchpoint stubs resolve to empty inline functions.
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  include/hw/core/cpu.h | 23 +++++++++++++++++++++++
>  exec.c                | 26 ++------------------------
>  2 files changed, 25 insertions(+), 24 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 77fca95a40..6de688059d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1070,12 +1070,35 @@ static inline bool cpu_breakpoint_test(CPUState=
 *cpu, vaddr pc, int mask)
>      return false;
>  }
> =20
> +#ifdef CONFIG_USER_ONLY
> +static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vad=
dr len,
> +                                        int flags, CPUWatchpoint **wat=
chpoint)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> +                                        vaddr len, int flags)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
> +                                                CPUWatchpoint *wp)
> +{
> +}
> +
> +static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +{
> +}
> +#else
>  int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                            int flags, CPUWatchpoint **watchpoint);
>  int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>                            vaddr len, int flags);
>  void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchp=
oint);
>  void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> +#endif
> =20
>  /**
>   * cpu_get_address_space:
> diff --git a/exec.c b/exec.c
> index 53a15b7ad7..31fb75901f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1062,28 +1062,7 @@ static void breakpoint_invalidate(CPUState *cpu,=
 target_ulong pc)
>  }
>  #endif
> =20
> -#if defined(CONFIG_USER_ONLY)
> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> -
> -{
> -}
> -
> -int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags)
> -{
> -    return -ENOSYS;
> -}
> -
> -void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchp=
oint)
> -{
> -}
> -
> -int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags, CPUWatchpoint **watchpoint)
> -{
> -    return -ENOSYS;
> -}
> -#else
> +#ifndef CONFIG_USER_ONLY
>  /* Add a watchpoint.  */
>  int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                            int flags, CPUWatchpoint **watchpoint)
> @@ -1173,8 +1152,7 @@ static inline bool cpu_watchpoint_address_matches=
(CPUWatchpoint *wp,
> =20
>      return !(addr > wpend || wp->vaddr > addrend);
>  }
> -
> -#endif
> +#endif /* !CONFIG_USER_ONLY */
> =20
>  /* Add a breakpoint.  */
>  int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
>=20

