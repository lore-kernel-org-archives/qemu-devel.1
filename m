Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00697C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB592074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfSUZsX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB592074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfs3I-0005Cr-1O
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jfs1n-0004X7-G7; Mon, 01 Jun 2020 17:31:29 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jfs1g-0000cL-Cw; Mon, 01 Jun 2020 17:31:25 -0400
Received: by mail-il1-x144.google.com with SMTP id 18so10826730iln.9;
 Mon, 01 Jun 2020 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jP/3dXSbxgRicClhxwF+kWA7sGYvLvpEOVmeGSG+W3U=;
 b=NfSUZsX3PRmYD7ZqKnspe8HvrM2OkDtYvjF5IOGLkhUfWKoaQvvPOAvwZ9w5mk01pP
 b6qRJVgLfP0KpCM244TXz3qO+oVpodzA+OSnye4yBVYcA/9zfRQwzj8hJ0bcbhk0BpRl
 wN6tdcoharIQuFZNm8mTr9pGvqH5Q/lpofRZLbQmbceQnmUpuiop0NiuifqfN1lRN1LI
 SZW0ucnEJv5QTQEj1tpW2ih/XujfxNIP5FyOOwE1nBGHWoNVNhoJvk0OIDURnsSQvLUL
 sZ8Y5w9liapJHFjuFUrRpLLeD7rcRxdl+R3a8Fi31ArifVRvRdW8sHqVY+qReitjD6NG
 L9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jP/3dXSbxgRicClhxwF+kWA7sGYvLvpEOVmeGSG+W3U=;
 b=nsMw71xTbBhsFhJCGQwuoX/C6kE2EDcfbaGIWCe0f6KZ5MUivYjz4tkEXHuxSSyhbQ
 Wi6IwHB0uhptRPr2g5ZoBiqu5JtaNgGid+z6yYh/NxwNNv68TO5r1BM2Vyq3utP3jNDE
 LC3yV7F3mKsHlgPuiDaGyfb/T6sQ3PTw5w9eEysd2bLzStvLP/r2t9ij1aQbkv58F1++
 iecVS3no9C4gqHM0xV12DJ4uZ+iiR5Ohpj1sWImA7HPhTM+HU8rDWAHbWSNAEZQA/1Py
 gWePIUCgEsvPy+LS/VDkoiDtQ/Kf8+vfk3z1iC2c6jN9WLPSujLLZ3l77Ef/U/7Nm22L
 w2Xg==
X-Gm-Message-State: AOAM533SjinOwwYj3RbbXgEfX39cH59ANwJIQrHBPaA6nQ9tMeloE3ke
 4126E5toHBTnnuY/jMzV6mBwU5GIfJhinYH7xTU=
X-Google-Smtp-Source: ABdhPJxIXeOe8xpoGaljDc3rKf7brmo3sIGQySVPyfBRB+TbyPDzdqBNB+miQOWhyfZUTAUla3qbHa0WU9uS+HTIvzY=
X-Received: by 2002:a92:d647:: with SMTP id x7mr6308086ilp.267.1591047078853; 
 Mon, 01 Jun 2020 14:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704110.git.alistair.francis@wdc.com>
 <0cc377a397d5e22123545e397a9bd443fadaf43f.1590704110.git.alistair.francis@wdc.com>
 <CAEUhbmWktWX1CjS3qnDrVC9JHwz6MFC-oOAN-DvvsFbRC148cA@mail.gmail.com>
In-Reply-To: <CAEUhbmWktWX1CjS3qnDrVC9JHwz6MFC-oOAN-DvvsFbRC148cA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2020 14:22:10 -0700
Message-ID: <CAKmqyKP_4G4ojCtKt3YK=Meo52TPsYwrKOaKgU7mEpAoZMq32g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] target/riscv: Remove the deprecated CPUs
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 31, 2020 at 9:51 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 6:24 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >  docs/system/deprecated.rst      | 33 ++++++++++++++++++---------------
> >  target/riscv/cpu.h              |  7 -------
> >  target/riscv/cpu.c              | 28 ----------------------------
> >  tests/qtest/machine-none-test.c |  4 ++--
> >  4 files changed, 20 insertions(+), 52 deletions(-)
> >
> > diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> > index 50927bad74..a6664bfca9 100644
> > --- a/docs/system/deprecated.rst
> > +++ b/docs/system/deprecated.rst
> > @@ -314,21 +314,6 @@ should be used instead of the 1.09.1 version.
> >  System emulator CPUS
> >  --------------------
> >
> > -RISC-V ISA CPUs (since 4.1)
> > -'''''''''''''''''''''''''''
> > -
> > -The RISC-V cpus with the ISA version in the CPU name have been depcreated. The
> > -four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
> > -``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
> > -option when using the ``rv32`` or ``rv64`` CPUs.
> > -
> > -RISC-V ISA CPUs (since 4.1)
>
> Not sure if this is a typo. Should we say: RISC-V no MMU CPUs ? If
> not, since the subsection titles are the same, should we merge the
> following description to above?

Good point.

To be more clear I have changed this to:

RISC-V ISA Specific CPUs (removed in 5.1)
...
RISC-V no MMU CPUs (removed in 5.1)


>
> > -'''''''''''''''''''''''''''
> > -
> > -The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` and
> > -``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
> > -via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> > -
> >  ``compat`` property of server class POWER CPUs (since 5.0)
> >  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> >
> > @@ -486,6 +471,24 @@ The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed in 5.0
> >  The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
> >  'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
> >
> > +System emulator CPUS
> > +--------------------
> > +
> > +RISC-V ISA CPUs (removed in 5.1)
> > +''''''''''''''''''''''''''''''''
> > +
> > +The RISC-V cpus with the ISA version in the CPU name have been removed. The
> > +four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
> > +``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
> > +option when using the ``rv32`` or ``rv64`` CPUs.
> > +
> > +RISC-V ISA CPUs (removed in 5.1)
> > +''''''''''''''''''''''''''''''''
> > +
> > +The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
> > +``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
> > +via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> > +
> >  System emulator machines
> >  ------------------------
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index d0e7f5b9c5..76b98d7a33 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -40,13 +40,6 @@
> >  #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
> >  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
> >  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
> > -/* Deprecated */
> > -#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
> > -#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
> > -#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
> > -#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
> > -#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
> > -#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")
> >
> >  #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
> >  #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 059d71f2c7..112f2e3a2f 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -135,16 +135,6 @@ static void riscv_base32_cpu_init(Object *obj)
> >      set_misa(env, 0);
> >  }
> >
> > -static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
> > -{
> > -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> > -    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> > -    set_priv_version(env, PRIV_VERSION_1_09_1);
> > -    set_resetvec(env, DEFAULT_RSTVEC);
> > -    set_feature(env, RISCV_FEATURE_MMU);
> > -    set_feature(env, RISCV_FEATURE_PMP);
> > -}
> > -
> >  static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
> >  {
> >      CPURISCVState *env = &RISCV_CPU(obj)->env;
> > @@ -182,16 +172,6 @@ static void riscv_base64_cpu_init(Object *obj)
> >      set_misa(env, 0);
> >  }
> >
> > -static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
> > -{
> > -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> > -    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> > -    set_priv_version(env, PRIV_VERSION_1_09_1);
> > -    set_resetvec(env, DEFAULT_RSTVEC);
> > -    set_feature(env, RISCV_FEATURE_MMU);
> > -    set_feature(env, RISCV_FEATURE_PMP);
> > -}
> > -
> >  static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
> >  {
> >      CPURISCVState *env = &RISCV_CPU(obj)->env;
> > @@ -621,18 +601,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
> > -    /* Depreacted */
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init)
> >  #elif defined(TARGET_RISCV64)
> >      DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
> > -    /* Deprecated */
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init)
> >  #endif
> >  };
> >
> > diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
> > index 8bb54a6360..b52311ec2e 100644
> > --- a/tests/qtest/machine-none-test.c
> > +++ b/tests/qtest/machine-none-test.c
> > @@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] = {
> >      { "xtensa", "dc233c" },
> >      { "xtensaeb", "fsf" },
> >      { "hppa", "hppa" },
> > -    { "riscv64", "rv64gcsu-v1.10.0" },
> > -    { "riscv32", "rv32gcsu-v1.9.1" },
> > +    { "riscv64", "sifive-u54" },
> > +    { "riscv32", "sifive-u34" },
>
> I believe we should use "rv32" and "rv64" here.

Done.

Alistair

>
> >      { "rx", "rx62n" },
> >  };
>
> Regards,
> Bin

