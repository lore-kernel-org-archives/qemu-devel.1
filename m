Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7AFC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B6A2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B6A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg17H-0000ve-51
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 02:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg160-000052-A9
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg15z-0002ix-6c
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg15z-0002hq-1U
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so724549pfy.13
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 23:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=EmGZqkWZXz+TznH7WqJXu6yj6AO4KHO44rr6hePQgrs=;
 b=GeA2dCZYouHplGQr+FjWRDZj00tRKV7tKZzP6sT9+gACgOVMyv8TstqPMaPNk1/W96
 ZKvoHoMMK4wCc1UjnftGaRFHyKnIu4gavVGBuqYdCUU4XwcoACK5JwuSJItdG/sK/Oyp
 GjBUbx9LdVZOidJTZGnyX3DlSzB3hHdfMbuxKIXVB1THGoUxCOONbtYgRUyGl0vMjPju
 R/d9sRhPDV6/qK1ONPwoCmD7fwRS0eB7DZuVAhFPY9XJ8g/zAf5uBxSaQ41AJmy6UbAx
 pPpzNW+MvBl3m92Vmxvipz/ArGrAaQ7QwAs8qSX+uI0M2lWSo7dMpN2dUhz8kclMCecl
 Ypqg==
X-Gm-Message-State: APjAAAUIysbtvCHLVkpPxluLV82F3nUcI2p4NhNqvovKbIiXquQkypxI
 T8/GvQdzIhk/BIsoI2lv/7Z4IQ==
X-Google-Smtp-Source: APXvYqzXFdyOlcRsq0ehCife6IjFondFhfG8Gxh0s/+OgauV14yDlln/7qLxLGHJP4njXHScufagBg==
X-Received: by 2002:a63:2323:: with SMTP id j35mr1215735pgj.166.1561529269373; 
 Tue, 25 Jun 2019 23:07:49 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id x65sm20879927pfd.139.2019.06.25.23.07.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 23:07:48 -0700 (PDT)
Date: Tue, 25 Jun 2019 23:07:48 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 22:32:56 PDT (-0700)
In-Reply-To: <CAKmqyKOGKuMJXSPJJEWn7s6OkUZ4ZRL7KFOqtaBWTErrbi6+aQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-9ce79f43-2d09-489c-a089-be1ad81057ee@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Add support for the Zicsr extension
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 08:20:55 PDT (-0700), alistair23@gmail.com wrote:
> On Tue, Jun 25, 2019 at 3:09 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> The various CSR instructions have been split out of the base ISA as part
>> of the ratification process.  This patch adds a Zicsr argument, which
>> disables all the CSR instructions.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>  target/riscv/cpu.c | 1 +
>>  target/riscv/cpu.h | 1 +
>>  target/riscv/csr.c | 5 +++++
>>  3 files changed, 7 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index bbad39a337b3..915b9e77df33 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -442,6 +442,7 @@ static Property riscv_cpu_properties[] = {
>>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>> +    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index ba551cd3082c..0adb307f3298 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -224,6 +224,7 @@ typedef struct RISCVCPU {
>>          bool ext_u;
>>          bool ext_counters;
>>          bool ext_ifencei;
>> +        bool ext_icsr;
>>
>>          char *priv_spec;
>>          char *user_spec;
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index de67741f3648..ff988917b995 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -793,6 +793,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>>  {
>>      int ret;
>>      target_ulong old_value;
>> +    RISCVCPU *cpu = env_archcpu(env);
>>
>>      /* check privileges and return -1 if check fails */
>>  #if !defined(CONFIG_USER_ONLY)
>> @@ -803,6 +804,10 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>>      }
>>  #endif
>>
>> +    /* ensure the CSR extension is enabled. */
>> +    if (!cpu->cfg.ext_icsr)
>> +        return -1;
>
> QEMU style include curly braces around a single line if. Plus I think
> it makes it less error prone. Can you add braces?
>
> After that:
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks.

>
> Alistair
>
>> +
>>      /* check predicate */
>>      if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
>>          return -1;
>> --
>> 2.21.0
>>
>>

