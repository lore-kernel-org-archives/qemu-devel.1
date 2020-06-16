Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16AFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E1A208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS+o3TjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E1A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFHr-0003Ww-Oi
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFCj-0003ks-Qd; Tue, 16 Jun 2020 13:17:00 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFCh-0000gq-VQ; Tue, 16 Jun 2020 13:16:57 -0400
Received: by mail-io1-xd41.google.com with SMTP id r77so22802870ior.3;
 Tue, 16 Jun 2020 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kyELr1j5Q9CU6yRF3AQPUtdlxj++86z0uXt0t7vQWs8=;
 b=rS+o3TjUHKAWMJIjHE2lSrsbuY5LjP9kgd3WNiS6LViyJbDhIXYhfpswI2RlNbGWyI
 00JtrbZgnP2VVKGxhAiHcZpz01GpUJvUdTUi9gMUeLGAn+26A7wNqVvDeNZg5jqDwXjm
 KrIhO2ayPmSYyELOdsXV7SU62sVDPoqdiJESxlG6Mjq7pj5276mPcizWQVvZKbVBKUZK
 LeduhB2gMztNeUKD1RPv3uceZxJTuNB3Xfe2t8pZXSniBQLn2jy7CiQs4S0FskhYCwJz
 lTjZj9JrMZ0GfaRj+WqhNAVG2+/grMvbGrekvTy6VkBVbNfWeqLzJVBjiIhaFkEPva04
 xURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kyELr1j5Q9CU6yRF3AQPUtdlxj++86z0uXt0t7vQWs8=;
 b=Tn/P+n9+JQ9mL6K1tM0j3jCId1WKi8WYe/ASyiOeom2MnADkI9j8ZJi3UlFvlecMdY
 7FDn/0vFeKnNmENdaEJ5f/C388WLFrzz2Zbf67azfqMLBk0kTgZ2LC2Au5nVA1SY2//v
 SacJW4rv6SmJTT2QSG1CEZnUlf4HbmKCaNrDWg4BXgElUa0jT2f66GjNwkxldokBbTZx
 SLvd+Q5HmkC4ul98Nx3QPVr/kKkkux5XVfzaV7e3G96C3HkZeHVzI59MNBdqJ9P+ovOp
 Hw/uzMJ56TIDpmh0kxbQ18au4sA0l+0e+APmi9RV5EH0c2ZmaNPniqbhsDFiXrfrIt9s
 ThUQ==
X-Gm-Message-State: AOAM532oSH9OuMOl50Qbpym5Pr6fWmCgxJxJ88DH7DqJgVHo3AY8kdtZ
 LwHlm+JFox8xhDs71r4javP8rVg/zY47fXQjBhA=
X-Google-Smtp-Source: ABdhPJxT4Ol5cZBfBJYyXKNxQBRCrYqsPx3CHR5Gvw3mna69DYVoR6HPwOOTWOTZAXoio62gbvQ7d/8KycUrimV0Lgs=
X-Received: by 2002:a5d:9413:: with SMTP id v19mr3865218ion.105.1592327813677; 
 Tue, 16 Jun 2020 10:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
 <1592268641-7478-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1592268641-7478-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2020 10:07:29 -0700
Message-ID: <CAKmqyKNF5GfTUtfHBswB23Wc+OXR7299zpiNBbypAUhoeS+XZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] target/riscv: Rename IBEX CPU init routine
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 5:51 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Current IBEX CPU init routine name seems to be too generic.
> Since it uses a different reset vector from the generic one,
> it merits a dedicated name.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v2:
> - new patch: Rename IBEX CPU init routine
>
>  target/riscv/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e867766..5f03458 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -153,7 +153,7 @@ static void rvxx_imacu_nommu_cpu_init(Object *obj)
>
>  #if defined(TARGET_RISCV32)
>
> -static void rv32_imcu_nommu_cpu_init(Object *obj)
> +static void rv32_ibex_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVC | RVU);
> @@ -577,7 +577,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
>  #if defined(TARGET_RISCV32)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_imcu_nommu_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
> --
> 2.7.4
>
>

