Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB9C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 00:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E55A2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 00:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NET2Y47J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E55A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2laC-0007ND-Lv
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 20:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i2lZL-0006eA-O8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i2lZK-0000JH-LO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:12:11 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i2lZK-0000Io-Di; Tue, 27 Aug 2019 20:12:10 -0400
Received: by mail-lf1-x142.google.com with SMTP id w67so515436lff.4;
 Tue, 27 Aug 2019 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4hRlrmFP06/1JRTRiJ5WRR6Ii0rh/52IH0rpBQCRJqg=;
 b=NET2Y47JUrmXL06CzWELiaWwVCNGpcWJbGnQqrEVw0XhWqyxKtzSBYc3c9ClxM+cbl
 72+mqRWy685faoF8r49skbIC9AYI2oHD8NDYc9CutQX4+EcLVqyJs6wUowsGBKF1m60s
 lp+Uzz+B0TuZVgBC9n5ilMpkq68tDrbcZ9byKyVOLCTQOj3AMT4m7gQz3x7Qxr3kj+JT
 SVFcW6R6mXaPYKeTilLPm2ImtzxisMKHhTp+kD8jFTAD+usomJgbQspVFcgy0yc3vFZY
 XxyvdH30+8tFbRNiDvjtjIAA5kiCttrUv69i28eb8b31512Ech91eTu6Sj264N28gL/b
 Ul/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4hRlrmFP06/1JRTRiJ5WRR6Ii0rh/52IH0rpBQCRJqg=;
 b=Ypl1zoqYNn326KYsv9s6By8+5v/sQFJ/OYgQkCPtOkAoIEfUcYDlM6BtlkifKRgFTh
 BfCR065u/nP4U65A1+Y8V+TWrVKO8Y+Yf5lAm3s/5+UZFZekeunicMfYszoKizMB20XI
 W5C9/hX15TC2iQm1wa0B9xqBhNGEHSeVBdJ1coxyoapYPexm7ey+Yx+cw3fFnWgc/QIQ
 2mR5R2Jl+/CNJMoGUHoYzUeT2GE5cTX/f6cVDzpHjFVKEEvbrX9/9McvuehXvw2BeiK/
 35pGadn/bQeN+R7PMpSBVyHFIT5/soWPzVDm+TEyYp9MOJvbTmsSng4iMm1V/Bbzs9Di
 kMQg==
X-Gm-Message-State: APjAAAV/Nfb0v79kMWZ2Fzs+Du2GdAuHxj8Wbn+9jNywmSQFqkszmpC9
 Ka4piML5Z9Rzgx47cfIGkhW5H3KOow/FoXqCffE=
X-Google-Smtp-Source: APXvYqx+bDfLSO9UCawx4Zm0+uZev+Vr2kNk9UIX/Tr9q0DnnrtD/yKE3Oa4FCFU6ESYtcGUIOKWwhdYT3MTTdHZxmQ=
X-Received: by 2002:ac2:528c:: with SMTP id q12mr650739lfm.135.1566951128667; 
 Tue, 27 Aug 2019 17:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566603412.git.alistair.francis@wdc.com>
 <1c1d359caa6633349158debc38e07156a10b63e8.1566603412.git.alistair.francis@wdc.com>
 <CAEiOBXUeKnPyZd7i5Aqw5+G2G9M-OeWxsBqTsF0MTV_abkDe5A@mail.gmail.com>
In-Reply-To: <CAEiOBXUeKnPyZd7i5Aqw5+G2G9M-OeWxsBqTsF0MTV_abkDe5A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2019 17:08:02 -0700
Message-ID: <CAKmqyKOphhLWZfbDPdPU3EPy8rsgpL5GzqTtdpFBA+rOxTSYsA@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 02/28] target/riscv: Add
 the virtulisation mode
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup.Patel@wdc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 27, 2019 at 8:44 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Sat, Aug 24, 2019 at 7:41 AM Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  target/riscv/cpu.h        |  4 ++++
>>  target/riscv/cpu_bits.h   |  6 ++++++
>>  target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
>>  3 files changed, 33 insertions(+)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 7f54fb8c87..0ef1ecb0e0 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -117,6 +117,8 @@ struct CPURISCVState {
>>
>>  #ifndef CONFIG_USER_ONLY
>>      target_ulong priv;
>> +    /* This contains QEMU specific information about the virt state. */
>> +    target_ulong virt;
>>      target_ulong resetvec;
>>
>>      target_ulong mhartid;
>> @@ -257,6 +259,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
>> +bool riscv_cpu_virt_enabled(CPURISCVState *env);
>> +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index e99834856c..1fbde516be 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -422,6 +422,12 @@
>>  #define PRV_H 2 /* Reserved */
>>  #define PRV_M 3
>>
>> +/* Virtulisation modes */
>> +#define VIRT_OFF            0
>> +#define VIRT_ON             1
>> +#define VIRT_MODE_SHIFT     0
>> +#define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
>> +
>>
>>  /* RV32 satp CSR field masks */
>>  #define SATP32_MODE         0x80000000
>>  #define SATP32_ASID         0x7fc00000
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 225e407cff..7b0bb14c01 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -81,6 +81,29 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>>      return false;
>>  }
>>
>> +bool riscv_cpu_virt_enabled(CPURISCVState *env)
>> +{
>> +    bool tmp;
>> +
>> +    if (!riscv_has_ext(env, RVH)) {
>> +        return false;
>> +    }
>> +
>> +    tmp = (env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT;
>> +
>> +    return tmp == VIRT_ON;
>> +}
>> +
>> +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
>> +{
>> +    if (!riscv_has_ext(env, RVH)) {
>> +        return;
>> +    }
>> +
>> +    env->virt &= ~VIRT_MODE_MASK;
>> +    env->virt |= enable << VIRT_MODE_SHIFT;
>> +}
>> +
>>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>>  {
>>      CPURISCVState *env = &cpu->env;
>> --
>> 2.22.0
>>
> Why not to use get_field and set_field though it is not a real register but an internal state
>
> #define VIRT_ONOFF            0x01
> #define VIRT_OFF             0
> #define VIRT_ON             1
>
> access
>        get_field(env->virt, VIRT_ONOFF);
>        set_field(env->virt, VIRT_ONOFF, enable);

Good idea, I have updated this.

Alistair

>
>
> chihmin

