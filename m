Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266C82085A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVFkrmHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266C82085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnIk-0006zi-DW
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:57:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnFU-00040G-2g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnFT-00074d-5P
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:54:28 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnFS-000747-Ud
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:54:27 -0400
Received: by mail-lj1-x243.google.com with SMTP id r76so2760861lja.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Uim8SC4aabEl7ZG6h3dDZRMI/ptirZ7TMkOpDhSx6ao=;
	b=aVFkrmHj31RZytXTXSfFKcT4bbHtY98GijvZ9fob1DSl7bCtRv2akip4y+Jw5S6kjp
	5C1is+09iVe8hoiFLC3hmoBrdQkfaS88aPOerHaZUMI7+Cbmq2Tju9fBSWiaaYestjs3
	LSxUAiglI/Ww7fbvVgpDe+qqfagiHJCyJ980djTvqjiRoWVG2Qm1nPcEB3QGaMvOoklk
	0dMJE84gQ9ei6rh2ibRyRJNPmTNmHbj8AqrQ2PxOs0drZX3qS10ZmIz4fc1821ahaKtR
	e3bsaanlapqds5Fcuq+KMXZN70BUb9FiCXwm1J+i6C7f3uRwHCz5AhTZGhKSd/skG/Ey
	0RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Uim8SC4aabEl7ZG6h3dDZRMI/ptirZ7TMkOpDhSx6ao=;
	b=mhDH+eLkntHEX9lRkOk31tWMNxqBa4lRGxUT7+7a/wTvlr9A4L2hOu4iHHQWjlS+mY
	U5u+v664s9qKD0bdWFxRCj12AJnbUaMbkDY6CD6VID86sGVSLfizlTu3AhHnNkJdKcmn
	ZHePL78KLpYVWWUq14EgYHcsdOLPZnl8V/YcmhUfcetfQg78CfSMAj0/gq1+Bw7D5Uml
	IXurPXgoeICf6hDRWg+Vk5DWSV2NoKk2JbT0sqbtnbvsXOFTjzapquDXk8wWHqX9pQU0
	PzTfLSQh4JR+7cZy8u/DYosiGnAhm8rJxbtHLcNYyDMm/jrr5dj82jv8jpQzdK/FkQGV
	7MLA==
X-Gm-Message-State: APjAAAXHptZQap4zsTlblimsHeA4ZRwH83opvTUbN2Sn3IX3Wm2Xz+xv
	ekF2sHmXTjU1lr0H/zr+4oMaFhrozsjj+WjjV/I=
X-Google-Smtp-Source: APXvYqysOMNQFZr5zbhW9gPOivtAJzPXHExGjoppWGmZtFakC7ogRQi45bJRVBQI9zT4nNwDXyKlalAEYwV+0TAP5Zc=
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr3170910ljk.129.1557424465642; 
	Thu, 09 May 2019 10:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-8-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-8-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 10:52:12 -0700
Message-ID: <CAKmqyKNRGVhoyrL2tH5Nwixvm+d1yT2anrjimU=pfKL6Q86j+w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v3 07/39] cpu: Introduce env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:07 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will replace foo_env_get_cpu with a generic definition.
> No changes to the target specific code so far.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/cpu-all.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 454f6d663f..c62f07b354 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
>
>  int cpu_exec(CPUState *cpu);
>
> +/**
> + * env_archcpu(env)
> + * @env: The architecture environment
> + *
> + * Return the ArchCPU associated with the environment.
> + */
> +static inline ArchCPU *env_archcpu(CPUArchState *env)
> +{
> +    return container_of(env, ArchCPU, env);
> +}
> +
>  /**
>   * env_cpu(env)
>   * @env: The architecture environment
> @@ -379,8 +390,7 @@ int cpu_exec(CPUState *cpu);
>   */
>  static inline CPUState *env_cpu(CPUArchState *env)
>  {
> -    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
> -    return &arch_cpu->parent_obj;
> +    return &env_archcpu(env)->parent_obj;
>  }
>
>  #endif /* CPU_ALL_H */
> --
> 2.17.1
>
>

