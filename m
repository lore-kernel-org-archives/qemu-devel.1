Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE18C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 18:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4882086D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTtsD/0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4882086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv4IO-0008R7-Bu
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hv4I0-00082O-SR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hv4Hz-00023f-Pr
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:34:28 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hv4Hz-00022d-Gf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:34:27 -0400
Received: by mail-lj1-x241.google.com with SMTP id r9so83066463ljg.5
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qpgm09NJuAH3GeRzEWUCU09blZwr8Lpdek1YBsEHgPQ=;
 b=dTtsD/0VWsy54eVjJU0JInupNDhiur6L4jypmW37nJ/g0iwtTSxjc+ZjmoJxjeGweC
 y9JxSNwqMDGr/fKOuq2YUloIYQEDFao5XMaxhU9BwWAZYPVEGufCFAeuTaObsFc28pzw
 rss23A+75Kj7w9WuGle8W+o428zL5pjtPfk5IN+n0kvtJLUDgxC2kNTkGKmZjES+Ti9n
 xXKFgj0mi7R7DK24qtc/AgOQaaGM7MtAlSZJlacvVp/S1fa1qzII9r/MImXKwyO1Siyh
 wTG8tYhNLWBFqB30iFfWkhAijD5hfxWQQKQ3j+JFyH1K2zo9lHXOlICldxsjf6hBeGnl
 JQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qpgm09NJuAH3GeRzEWUCU09blZwr8Lpdek1YBsEHgPQ=;
 b=clzEKQ8YHynKCzkYhA3Iu4wIISX16BItUtDuy6gPb8HH9zddIm0A+UmmVMbieAUpXV
 LIQzzvE8SySsdDuMJIiNrAhZWZxw/11P8ni02KdhAoxtP10Ii/66xNckfIDG4WFnYZP9
 QHm9mVHR9pCOSjJECTAn5IAO23Sqrp+b7EWOR5wEp+XDaJ1gqyYbN9AtaVKtTurObmQK
 EI7uYAHP5bD44mlgsgQItpPbeTmzk5ma74sEzu1QzMf3k5sxBUkOaEZfFtjGIMOoDoO3
 UsVtw07S1OSZkrGr4TJtMPEoCjGSMzrIO6KDnw87C13wLqph4OWCqqmJ4YNvjb2HcdUx
 Ac7g==
X-Gm-Message-State: APjAAAWFrU6jlr8Y/PQSzE6mkCKyaLGCbVrdi3DVlNeumy0BXvWJLkVB
 2F0ECVAxo4xvtE1g6ZhrChCc3C/LberLoSrbbSk=
X-Google-Smtp-Source: APXvYqxlHGRMAJdFxdLSnHkSPdNgO5FuO4LCmBdpcREhSkdgrjguyM9EQZAMmmdAUVlJPBNJzCr+DwgSU0g0KYppqF4=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr2546870ljg.33.1565116465403;
 Tue, 06 Aug 2019 11:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <B6797C6C-483E-4D08-92C8-BC109B149E50@espressif.com>
In-Reply-To: <B6797C6C-483E-4D08-92C8-BC109B149E50@espressif.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2019 11:30:44 -0700
Message-ID: <CAKmqyKMrWQ=4097AkAb1Dz7rM8FgrmBC527hNWk+uGomvfVTZQ@mail.gmail.com>
To: Ivan Grokhotkov <ivan@espressif.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: don't overwrite
 priv_version and resetvec when realizing
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 5:14 AM Ivan Grokhotkov <ivan@espressif.com> wrote:
>
> CPU-specific init functions (riscv_*_cpu_init) configure members of
> CPURISCVState, such as priv_version and resetvec. However
> riscv_cpu_realize unconditionally overwrites these members. The
> result is that some CPUs (such as CPU_SIFIVE_U34) are getting created
> with incorrect priv_version.
>
> Only set priv_version in riscv_cpu_realize if priv_spec property was
> set. Don't set resetvec in riscv_cpu_realize, rely on the init
> function to set it. Set default priv_version and resetvec in init
> functions where this was missing.
>
> Signed-off-by: Ivan Grokhotkov <ivan@espressif.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> target/riscv/cpu.c | 12 +++++++-----
> target/riscv/cpu.h |  1 +
> 2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20a..8f3cb0c6bf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -110,7 +110,7 @@ static void riscv_any_cpu_init(Object *obj)
> {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> -    set_priv_version(env, PRIV_VERSION_1_11_0);
> +    set_priv_version(env, PRIV_VERSION_DEFAULT);
>      set_resetvec(env, DEFAULT_RSTVEC);
> }
>
> @@ -119,6 +119,8 @@ static void riscv_any_cpu_init(Object *obj)
> static void riscv_base32_cpu_init(Object *obj)
> {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_priv_version(env, PRIV_VERSION_DEFAULT);
> +    set_resetvec(env, DEFAULT_RSTVEC);
>      /* We set this in the realise function */
>      set_misa(env, 0);
> }
> @@ -157,6 +159,8 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
> static void riscv_base64_cpu_init(Object *obj)
> {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_priv_version(env, PRIV_VERSION_DEFAULT);
> +    set_resetvec(env, DEFAULT_RSTVEC);
>      /* We set this in the realise function */
>      set_misa(env, 0);
> }
> @@ -316,7 +320,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      RISCVCPU *cpu = RISCV_CPU(dev);
>      CPURISCVState *env = &cpu->env;
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
> -    int priv_version = PRIV_VERSION_1_11_0;
> +    int priv_version = PRIV_VERSION_DEFAULT;
>      target_ulong target_misa = 0;
>      Error *local_err = NULL;
>
> @@ -339,11 +343,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>                         cpu->cfg.priv_spec);
>              return;
>          }
> +        set_priv_version(env, priv_version);
>      }
>
> -    set_priv_version(env, priv_version);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -
>      if (cpu->cfg.mmu) {
>          set_feature(env, RISCV_FEATURE_MMU);
>      }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..88a52a1c8c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -81,6 +81,7 @@ enum {
> #define PRIV_VERSION_1_09_1 0x00010901
> #define PRIV_VERSION_1_10_0 0x00011000
> #define PRIV_VERSION_1_11_0 0x00011100
> +#define PRIV_VERSION_DEFAULT PRIV_VERSION_1_11_0
>
> #define TRANSLATE_PMP_FAIL 2
> #define TRANSLATE_FAIL 1
> --
> 2.20.1 (Apple Git-117)
>
>
>
> Re-sending with corrected indentation.

Just for future reference this should go below:

Signed-off-by: Ivan Grokhotkov <ivan@espressif.com>
---

^ This line.

Alistair

>
> ---
> Best regards,
> Ivan Grokhotkov
>
>
>

