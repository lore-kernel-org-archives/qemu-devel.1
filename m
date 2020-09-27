Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E6C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B941221E5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR2K4n0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B941221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMZTA-0006uK-Dc
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 12:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZS0-0006DV-J0; Sun, 27 Sep 2020 12:23:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZRz-0002uW-2s; Sun, 27 Sep 2020 12:23:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so9186946wrn.0;
 Sun, 27 Sep 2020 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M68JkmRXaozYjBHt+u+yslwOFge8Z0KksyRMqb7/+0s=;
 b=YR2K4n0QJwvqsKRBYC/4WFcK5nYw9IDqJJ5pEnINzTS4gR4etAmer5isyw+58zUoqN
 iqvYONIfwx23M69FAkbLCvm+39+c2V88RSqUBynoWBdQa8prRPkVeT9ThTupiwdxKWLb
 zTlQ2hTunTgCUKZMGZEtrP+Oe3sdW9zrkTsOtIsz3retSDHuV44blVWcgBoAw0YNDmmL
 Xth3mF7H17kle4u126DJ2Ae+ncpxV/HH87Wlt1O7mkGQYiyzjbBfKvG6WMclvvzjAmXs
 MOzoJ6bU1AB4AeqnuGImYN5PQUtvNP1LgAGENofYvGsglz5j8w0JkFfNAPGnwMQ5GEK3
 aaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M68JkmRXaozYjBHt+u+yslwOFge8Z0KksyRMqb7/+0s=;
 b=C9XfMzNBedJIqF+o6lyhOMFKLh2Nw86Rvx9G8rqEYZMMUQJAVWVGqudqJ/fid01DoN
 GtuKDo38xaC+H0LOmm+y3J6kh5/BMiFdrkdXc6kAp41hFeVwsBvUppg+2rG+5KdbPUvD
 l+4s+ZedpLdUlfoyNQUm/sMDW0FCAWl7990g/iQS17+/sold0NdNPRfcOzEOLdG3ZDB8
 jpRj7xgnJ/r57Gg1ioKXZ7wti8ws3ngIxnFJfboMBn1WUM57cyxOFlHXedbXsU8S5DXZ
 BpG07Jf9TyxzKaZDHWwTm8O6Bsf72IdViCtwKsFlRh7yAvxY8lMoYNBHTkaB9Gt+m/tu
 KyTw==
X-Gm-Message-State: AOAM530ykiaNAoBWIjbeZ4LfRCnP8Kcwx0/OLVYJwxS8LOaCFiEtY+iN
 dYK1R2xsomYmEnr2LsVrjvE=
X-Google-Smtp-Source: ABdhPJw8kE79NGJ8Gq0sRe249T4iu7rz6SGwGb45jAxrdgOUtONGymnS0GdeiIdNjHy8IaTuexG/ng==
X-Received: by 2002:adf:9e43:: with SMTP id v3mr14999956wre.306.1601223777306; 
 Sun, 27 Sep 2020 09:22:57 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m185sm6069286wmf.5.2020.09.27.09.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 09:22:56 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] riscv: Convert interrupt logs to use
 qemu_log_mask()
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20e41bdc81dbde7f9b3fdc1c768510ea99e8f565.1601214416.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ac03d37-b899-c9ae-fa48-4f30e3c3d82f@amsat.org>
Date: Sun, 27 Sep 2020 18:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20e41bdc81dbde7f9b3fdc1c768510ea99e8f565.1601214416.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.078, NICE_REPLY_A=-0.011,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/20 3:47 PM, Alistair Francis wrote:
> Currently we log interrupts and exceptions using the trace backed in

s/backed/backend/

> riscv_cpu_do_interrupt(). We also log execptions using the interrupt log

Typo "exceptions".

> mask (-d int) in riscv_raise_exception().
> 
> This PR converts riscv_cpu_do_interrupt() to log both interrupts and

s/PR/patch/

> exceptions with the interrupt log mask, so that both are printed when a
> user runs QEMU with -d int.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 7 +++++--
>  target/riscv/op_helper.c  | 1 -
>  target/riscv/trace-events | 3 ---
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 904899054d..9df3238213 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -894,8 +894,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          }
>      }
>  
> -    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
> -        riscv_cpu_get_trap_name(cause, async));
> +    qemu_log_mask(CPU_LOG_INT,
> +                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_FMT_lx", "
> +                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
> +                  __func__, env->mhartid, async, cause, env->pc, tval,
> +                  riscv_cpu_get_trap_name(cause, async));

Maybe you want to keep the trace event, as the trace framework allow you
to select traced events at runtime, events come with timestamp and for
some backends the events are machine-parsable.

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      if (env->priv <= PRV_S &&
>              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 9b9ada45a9..e987bd262f 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -29,7 +29,6 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
>                                            uint32_t exception, uintptr_t pc)
>  {
>      CPUState *cs = env_cpu(env);
> -    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
>      cs->exception_index = exception;
>      cpu_loop_exit_restore(cs, pc);
>  }
> diff --git a/target/riscv/trace-events b/target/riscv/trace-events
> index b7e371ee97..6be2147c8f 100644
> --- a/target/riscv/trace-events
> +++ b/target/riscv/trace-events
> @@ -1,6 +1,3 @@
> -# cpu_helper.c
> -riscv_trap(uint64_t hartid, bool async, uint64_t cause, uint64_t epc, uint64_t tval, const char *desc) "hart:%"PRId64", async:%d, cause:%"PRId64", epc:0x%"PRIx64", tval:0x%"PRIx64", desc=%s"
> -
>  # pmp.c
>  pmpcfg_csr_read(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRIu64 ": read reg%" PRIu32", val: 0x%" PRIx64
>  pmpcfg_csr_write(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRIu64 ": write reg%" PRIu32", val: 0x%" PRIx64
> 


