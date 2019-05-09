Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E9C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E11217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQQAxK0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E11217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnif-0000yR-QC
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:24:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOngw-0008Af-B4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOngv-0000Kd-8C
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:22:50 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOngu-0000Jr-Vl
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:22:49 -0400
Received: by mail-lf1-x143.google.com with SMTP id h126so2255919lfh.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0StlAt3QJN+Z9wkSX8AbHhI76fw6UP4DMmuVKSn9X8k=;
	b=NQQAxK0a5QKAExmfAv1PnPFuXYYpqmSZLL+Fd6c0vdAkC8kvhQi6n9vHDJTnfbQvGU
	+eqxfQCo9pNwFZVK6LXN0GCHbSGmcByY5d79KdBRQG5YOFYuQlINtEuAn7RpBul6eLpo
	sI+/UnYW4vEl9b3mYIx7aBT3VJmMUPP6autLpgvoTEe3VUY8oVCm1pB7VbqjqmRxHOK8
	c7esaGw6Pa/VK406vJ7CyLTni0pN6wm69w2Wcj7t/n1mTjw7fv9SitbAhI67YVSQ9pWO
	/iN4hGHJ7s2a9YzG70rta/LIrXctL7qi7tbdhMlgSAZj/5E1MMEPzNvnGKoOXZneJEdg
	aUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0StlAt3QJN+Z9wkSX8AbHhI76fw6UP4DMmuVKSn9X8k=;
	b=gMdomKU1nHHd+iiLtMSmfSSXrPqPbDGatwenzJtJbjZZnb8/F/UnmWSIJNvxMyhG11
	haEBb8OwkDSq5cgtPoxiBJMUjUCQpEOgBMEvy4BgKsaqEPPMblYHYigcMKbGctqo5jzq
	rm8eR+9O7tJjQXuR80g7td3AnkBvdYunKrCE2HcpA9JSE/Saess1XItnS543UQatAV7J
	04S1D3hAZgLqNcZ22UUzIbdK9ECFt0APKJ9fCb7Pip/Z0tzPN6HIERGzK7toMU1Tr6xy
	AHoculL1UXPAYJzHKhc7b4cI5ESRJlvycve4JWQY8xDirmGIDAbJr5SGWhXdfcI6L6ru
	aFZw==
X-Gm-Message-State: APjAAAUqs28U8363BN1QXvwU/q3/DIPIFMYUNlmZe7Pfw9TO32vQ4ceV
	2RTHzBKbdYZey1l28Z8+dEyYmlreDAgPh//0XpE=
X-Google-Smtp-Source: APXvYqzXqpAIVBwJw7hsKCE/Mx5QU/0p06BiYQifTkndAYRiGJN4YjZD0xWG9FqLqdE0o+QXKczS8LGGUKURTU8WHqM=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr3281558lfl.118.1557426167576; 
	Thu, 09 May 2019 11:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-22-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-22-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:20:40 -0700
Message-ID: <CAKmqyKPDXsFcknXpCGZRe88GvzATbWNDQGv-ZqOFpDr1znXxHg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v3 21/39] target/openrisc: Use env_cpu,
 env_archcpu
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

On Tue, May 7, 2019 at 5:22 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/openrisc/cpu.h              | 5 -----
>  linux-user/openrisc/cpu_loop.c     | 2 +-
>  target/openrisc/exception_helper.c | 5 ++---
>  target/openrisc/sys_helper.c       | 8 ++++----
>  4 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 0ba4ae3356..91ba667139 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -317,11 +317,6 @@ typedef struct OpenRISCCPU {
>
>  } OpenRISCCPU;
>
> -static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
> -{
> -    return container_of(env, OpenRISCCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(OpenRISCCPU, env)
>
>  void cpu_openrisc_list(void);
> diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
> index f496e4b48a..4b8165b261 100644
> --- a/linux-user/openrisc/cpu_loop.c
> +++ b/linux-user/openrisc/cpu_loop.c
> @@ -23,7 +23,7 @@
>
>  void cpu_loop(CPUOpenRISCState *env)
>  {
> -    CPUState *cs = CPU(openrisc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr;
>      abi_long ret;
>      target_siginfo_t info;
> diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
> index 6073a5b21c..dd639ba5f2 100644
> --- a/target/openrisc/exception_helper.c
> +++ b/target/openrisc/exception_helper.c
> @@ -25,15 +25,14 @@
>
>  void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
>  {
> -    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> +    OpenRISCCPU *cpu = env_archcpu(env);
>
>      raise_exception(cpu, excp);
>  }
>
>  static void QEMU_NORETURN do_range(CPUOpenRISCState *env, uintptr_t pc)
>  {
> -    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = EXCP_RANGE;
>      cpu_loop_exit_restore(cs, pc);
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index 05f66c455b..8f11cb8202 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -30,8 +30,8 @@
>  void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    OpenRISCCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
>      target_ulong mr;
>      int idx;
>
> @@ -194,8 +194,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>                             target_ulong spr)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    OpenRISCCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
>      int idx;
>
>      switch (spr) {
> --
> 2.17.1
>
>

