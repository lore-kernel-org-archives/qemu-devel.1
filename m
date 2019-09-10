Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A74C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E51206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E51206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bTW-0006RF-Vx
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bSQ-0005oU-3L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bSO-0005ei-T8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:25:02 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bSO-0005eY-KK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:25:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MzkK9-1iKZpY3cQ5-00vdAr; Tue, 10 Sep 2019 10:24:58 +0200
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20190906165713.5558-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7e4d0c43-e9f8-a231-0d21-4e05415cfec1@vivier.eu>
Date: Tue, 10 Sep 2019 10:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906165713.5558-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IXeHdKL1dXTJdnm0RLL9fXch7+F3USVFm1Ml6ZqHJSVEwiA9bUf
 aWAdjsL278lAXpiiQ5oaq8E8YfFfjvZ7rUK1Y+Tj8Gvzu/MgEV3RM56LYxUJObau+fZwWiu
 z7NSEyEEqRkgEBKALCah2DC15FT3RcOidFHXBTDfTaguvxWGVtWMQqzEkPpsG3vktUZHTOs
 S1cN1v2b/aWJFuDnAR70g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7CSG/XxiU0E=:6cFP+W4EkxPxVVtXBAcjEG
 wjL4HI4rcAH7bJ97BdmWRjYbKA+pYgzuKo2s08qdYhvfHtfd/ArkX7q4tUECpdT5yckVagESH
 LZdqk2d+tNgFcPyBuazvE/eJD98L1OGpYlx7tr8HaPdcyBwSWr1Xk4COVJnmx3wvsOd5qLcmB
 DO+1M/6Q/57jYNIGuFjBLdYIDrPCIeWYPcVcAe/3DBLb1hfAbo8IrQpPH00aOdNMPo2kMc/H1
 ANHy9SijwQOmAZn335FPsVpbgJUZFzAirZpgZnl4tSv0vbq+TNv6D96UIhPEh+F3xYVXpdrGd
 YrAP94XLNAiZRgCLsUvnL6FfdQd8OqMml/hqZimRhMAlXohrvI5/ogd8hVhNDCdJCnl4NDlcJ
 UYGCxtHKwHa1Q9byNs2uQHQzIcruaE0rQfdZvJA9PkG6P3D/l9CAdHTW7N1E8jiDa9d9GirCa
 xJmxr/t5Bv3Glm4kTMirpzGK8OAIOrQt8NPs1XHSVNtkwpZkd8eQ77HUxIjP/XLtjVD320LYG
 U+0pF4h/AaNeivIPZbzWOQdVQ3F/V19gsWUT9mtc1OCQ4CLy6Kd/Coh+AuXzvFPz0zuJCPxD5
 /SaMTCrXJTnt+9Qm7k2Vh7YMe/AMAP+ox9Tt4NFZoE2hvma9GgLljrLLRf60iSdyyLivDJOpY
 E5O4sHrE2U0dqQFSV3cpOjovdFIdwssYlFfUpMdLQSx/KAUzIJlh8hVSFPlZ0LOZeJ835jeuD
 1IYjME4xsdKX8CtXrf7ipTQr/yq/r+zsqe6Ws5GEUkRFL+31InopMLj19FjOts5MLbgeBWc8y
 KZdqf8h6zc3FQc57nVANbVvbEexYo8j0dSfDKRIwLc4So1os8U=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH v4] target/xtensa: linux-user: add call0
 ABI support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/09/2019 à 18:57, Max Filippov a écrit :
> Xtensa binaries built for call0 ABI don't rotate register window on
> function calls and returns. Invocation of signal handlers from the
> kernel is therefore different in windowed and call0 ABIs.
> There's currently no way to determine xtensa ELF binary ABI from the
> binary itself. Add handler for the -xtensa-abi-call0 command line
> parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
> and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset.
> Check PS.WOE in setup_rt_frame to determine how a signal should be
> delivered.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/main.c          | 11 +++++++++++
>  linux-user/xtensa/signal.c | 25 +++++++++++++++++--------
>  target/xtensa/cpu.c        | 24 ++++++++++++++++++++----
>  target/xtensa/cpu.h        |  3 +++
>  4 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 47917bbb20fc..c9d97d2b1fc6 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -393,6 +393,13 @@ static void handle_arg_trace(const char *arg)
>      trace_file = trace_opt_parse(arg);
>  }
>  
> +#if defined(TARGET_XTENSA)
> +static void handle_arg_abi_call0(const char *arg)
> +{
> +    xtensa_set_abi_call0();
> +}
> +#endif
> +
>  struct qemu_argument {
>      const char *argv;
>      const char *env;
> @@ -446,6 +453,10 @@ static const struct qemu_argument arg_table[] = {
>       "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
>      {"version",    "QEMU_VERSION",     false, handle_arg_version,
>       "",           "display version information and exit"},
> +#if defined(TARGET_XTENSA)
> +    {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_call0,
> +     "",           "assume CALL0 Xtensa ABI"},
> +#endif
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>  
> diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
> index 8d54ef3ae34b..590f0313ffe9 100644
> --- a/linux-user/xtensa/signal.c
> +++ b/linux-user/xtensa/signal.c
> @@ -134,6 +134,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>      abi_ulong frame_addr;
>      struct target_rt_sigframe *frame;
>      uint32_t ra;
> +    bool abi_call0;
> +    unsigned base;
>      int i;
>  
>      frame_addr = get_sigframe(ka, env, sizeof(*frame));
> @@ -182,20 +184,27 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>          __put_user(0x00, &frame->retcode[5]);
>  #endif
>      }
> -    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
> -    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER)) {
> -        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
> -    }
>      memset(env->regs, 0, sizeof(env->regs));
>      env->pc = ka->_sa_handler;
>      env->regs[1] = frame_addr;
>      env->sregs[WINDOW_BASE] = 0;
>      env->sregs[WINDOW_START] = 1;
>  
> -    env->regs[4] = (ra & 0x3fffffff) | 0x40000000;
> -    env->regs[6] = sig;
> -    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, info);
> -    env->regs[8] = frame_addr + offsetof(struct target_rt_sigframe, uc);
> +    abi_call0 = (env->sregs[PS] & PS_WOE) == 0;
> +    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
> +
> +    if (abi_call0) {
> +        base = 0;
> +        env->regs[base] = ra;
> +    } else {
> +        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
> +        base = 4;
> +        env->regs[base] = (ra & 0x3fffffff) | 0x40000000;
> +    }
> +    env->regs[base + 2] = sig;
> +    env->regs[base + 3] = frame_addr + offsetof(struct target_rt_sigframe,
> +                                                info);
> +    env->regs[base + 4] = frame_addr + offsetof(struct target_rt_sigframe, uc);
>      unlock_user_struct(frame, frame_addr, 1);
>      return;
>  
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 76db1741a796..c65dcf9dd782 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -53,6 +53,20 @@ static bool xtensa_cpu_has_work(CPUState *cs)
>  #endif
>  }
>  
> +#ifdef CONFIG_USER_ONLY
> +static bool abi_call0;
> +
> +void xtensa_set_abi_call0(void)
> +{
> +    abi_call0 = true;
> +}
> +
> +bool xtensa_abi_call0(void)
> +{
> +    return abi_call0;
> +}
> +#endif
> +
>  /* CPUClass::reset() */
>  static void xtensa_cpu_reset(CPUState *s)
>  {
> @@ -70,10 +84,12 @@ static void xtensa_cpu_reset(CPUState *s)
>              XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
>      env->pending_irq_level = 0;
>  #else
> -    env->sregs[PS] =
> -        (xtensa_option_enabled(env->config,
> -                               XTENSA_OPTION_WINDOWED_REGISTER) ? PS_WOE : 0) |
> -        PS_UM | (3 << PS_RING_SHIFT);
> +    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
> +    if (xtensa_option_enabled(env->config,
> +                              XTENSA_OPTION_WINDOWED_REGISTER) &&
> +        !xtensa_abi_call0()) {
> +        env->sregs[PS] |= PS_WOE;
> +    }
>  #endif
>      env->sregs[VECBASE] = env->config->vecbase;
>      env->sregs[IBREAKENABLE] = 0;
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 0459243e6bb1..b363ffcf1066 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -673,6 +673,9 @@ static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
>  {
>      return env->system_er;
>  }
> +#else
> +void xtensa_set_abi_call0(void);
> +bool xtensa_abi_call0(void);
>  #endif
>  
>  static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
> 

Applied to my linux-user branch.

Thanks,
Laurent

