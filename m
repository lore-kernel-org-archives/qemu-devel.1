Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E8CC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D925F2183F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx0GJiVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D925F2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHcbO-00077q-0p
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:07:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHcaH-0006am-0h
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHcaF-0005i3-4V
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:06:16 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hHcaE-0005dt-Pm; Fri, 19 Apr 2019 19:06:15 -0400
Received: by mail-lj1-x242.google.com with SMTP id r24so5742297ljg.3;
	Fri, 19 Apr 2019 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=UsHaQzQmEb+869mpwz2lIz/Iyj03aaGow594ag9rLkM=;
	b=cx0GJiVAarXYvWG6YiFzO5/bEZ8vR84GO5hf58zJ0fgYZJzqf7QDc4NQoA13iJiuzU
	WL+j63WHVfr5OKCTFNUfbP2YiS3V9fhEMNi+vcJ4GZRCTMaix1Vau612V4AQLIiicn5v
	DHyh7pBk1TJIGQBarY0gyQW2mEW1Tovm5Cnecu6o2Jk096tyY5NqgqX45xS7B4fYCcOr
	pKb6/14xOEvfGDpoK+uMvxoRCeYCrrm7eQqrVgg22M0d1d7mIcOp60nvVkDtv8zV0263
	Z2eEedCNbMGmmdaRz+BL1W2Pd8w0H36jJofM8jN7rtLL1Qxy0elr1g5kwnOs/8fEq+RF
	LJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=UsHaQzQmEb+869mpwz2lIz/Iyj03aaGow594ag9rLkM=;
	b=VLXRPba1kebMr28YKEgyQEAcaiL2ao0eZmpzUfGrN0PAaHl415rV49fG6859OKtg0i
	0YFB0/LJJ8jK1xH5HdOHr8Z55VLqRk+9BAdj41ew0AhUnEoLXx2n3dAjyupklSy1ZIP2
	gnGBgwWW1FUIoY9WKVhrqr8rAxmGJ5ooPx9V+j79Q3HMsIMv7LbhEQm768H+He0Demm0
	Z3iedAnF6Bvgw8sGQm1kdu4fTao1W6/O0Wdygu7xW219de9eNdchD1rL7Hf08wV/TZxZ
	It6DBsid7L0jxpjqmvsl4BLWOhruQH73K9Z+cJr0wBhEvJ5/Fgaio4vQNL42HRUwtEOo
	8+sQ==
X-Gm-Message-State: APjAAAUWMHRYT/TX6X99BkEJKOG4XGhX+EoHGQ/oJbnQx9iQN+Qy3pJ0
	3rQox2RAqBYpqfdfUxK0kVgP47fkyj/7dsW19nU=
X-Google-Smtp-Source: APXvYqwNZkxbaiRo40+wCSM5L5rmVoDu7tpggq2HoxC0/GWIS7o1DID62EbPDW3hzEJgJnI604Mmh7Opw5QsPvsbmLg=
X-Received: by 2002:a2e:1257:: with SMTP id t84mr3771966lje.115.1555715162053; 
	Fri, 19 Apr 2019 16:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVEkpkBAOo566s1BJk9YQBVeNkf2kpbS_kdjkn9j=3i1VA@mail.gmail.com>
	<CAKmqyKPM=XUyF+KweO2CLBQ3bEuu_BTU2fu+R7R09rV-1O9TkQ@mail.gmail.com>
	<CANnJOVFOq4-kQASRMiFhAQrAdm5tL6fZf1VofDO=s2_yrEU63w@mail.gmail.com>
In-Reply-To: <CANnJOVFOq4-kQASRMiFhAQrAdm5tL6fZf1VofDO=s2_yrEU63w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 16:05:35 -0700
Message-ID:
 <CAKmqyKOZ2Dfhk1HgnJqG1hSHHSpm0bpuE-MK8A0aHNjmcT9=ug@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Expose time CSRs when
 allowed by [m|s]counteren
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419230535.o9RfaZ4pt-Zqb7YJoWU1sHaxD-vJRBeT-M0iK-2aD6Q@z>

On Mon, Apr 15, 2019 at 5:46 PM Jonathan Behrens <fintelia@gmail.com> wrote=
:
>
> For any chip that has a CLINT, we want the frequency of the time register=
 and the frequency of the CLINT to match. That frequency, SIFIVE_CLINT_TIME=
BASE_FREQ (=3D10MHz) is currently defined in hw/riscv/sifive_clint.h and so=
 isn't visible to target/riscv/cpu.c where the CPURISCVState is first creat=
ed. Instead, I first initialize the frequency to a reasonable default (1GHz=
) and then let the CLINT override the value if one is attached. Phrased dif=
ferently, the values produced by the `sifive_clint.c: cpu_riscv_read_rtc()`=
 and `csr.c: read_time()` must match, and this is one way of doing that.

Ah that seems fine. Can you add a comment in the code to indicate that
it will be overwritten later?

Alistair

>
> I'd be open to other suggestions.
>
> Jonathan
>
> On Mon, Apr 15, 2019 at 8:23 PM Alistair Francis <alistair23@gmail.com> w=
rote:
>>
>> On Fri, Apr 12, 2019 at 12:04 PM Jonathan Behrens <fintelia@gmail.com> w=
rote:
>> >
>> > Currently mcounteren.TM acts as though it is hardwired to zero, even t=
hough
>> > QEMU
>> > allows it to be set. This change resolves the issue by allowing reads =
to the
>> > time and timeh control registers when running in a privileged mode whe=
re
>> > such
>> > accesses are allowed.
>> >
>> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
>> > ---
>> >  hw/riscv/sifive_clint.c |  1 +
>> >  target/riscv/cpu.c      | 14 ++++++++++++++
>> >  target/riscv/cpu.h      |  2 ++
>> >  target/riscv/csr.c      | 17 +++++++++++------
>> >  4 files changed, 28 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
>> > index d4c159e937..3ad4fe6139 100644
>> > --- a/hw/riscv/sifive_clint.c
>> > +++ b/hw/riscv/sifive_clint.c
>> > @@ -237,6 +237,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwad=
dr
>> > size, uint32_t num_harts,
>> >          env->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> >                                    &sifive_clint_timer_cb, cpu);
>> >          env->timecmp =3D 0;
>> > +        env->time_freq =3D SIFIVE_CLINT_TIMEBASE_FREQ;
>>
>> Why do you need to set this here?
>>
>> Alistair
>>
>> >      }
>> >
>> >      DeviceState *dev =3D qdev_create(NULL, TYPE_SIFIVE_CLINT);
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > index d61bce6d55..ff17d54691 100644
>> > --- a/target/riscv/cpu.c
>> > +++ b/target/riscv/cpu.c
>> > @@ -103,12 +103,20 @@ static void set_resetvec(CPURISCVState *env, int
>> > resetvec)
>> >  #endif
>> >  }
>> >
>> > +static void set_time_freq(CPURISCVState *env, uint64_t freq)
>> > +{
>> > +#ifndef CONFIG_USER_ONLY
>> > +    env->time_freq =3D freq;
>> > +#endif
>> > +}
>> > +
>> >  static void riscv_any_cpu_init(Object *obj)
>> >  {
>> >      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>> >      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>> >      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  #if defined(TARGET_RISCV32)
>> > @@ -121,6 +129,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *o=
bj)
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> >      set_feature(env, RISCV_FEATURE_MMU);
>> >      set_feature(env, RISCV_FEATURE_PMP);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>> > @@ -131,6 +140,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *o=
bj)
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> >      set_feature(env, RISCV_FEATURE_MMU);
>> >      set_feature(env, RISCV_FEATURE_PMP);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  static void rv32imacu_nommu_cpu_init(Object *obj)
>> > @@ -140,6 +150,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>> >      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> >      set_feature(env, RISCV_FEATURE_PMP);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  #elif defined(TARGET_RISCV64)
>> > @@ -152,6 +163,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *o=
bj)
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> >      set_feature(env, RISCV_FEATURE_MMU);
>> >      set_feature(env, RISCV_FEATURE_PMP);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>> > @@ -162,6 +174,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *o=
bj)
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> >      set_feature(env, RISCV_FEATURE_MMU);
>> >      set_feature(env, RISCV_FEATURE_PMP);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  static void rv64imacu_nommu_cpu_init(Object *obj)
>> > @@ -171,6 +184,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>> >      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>> >      set_resetvec(env, DEFAULT_RSTVEC);
>> >      set_feature(env, RISCV_FEATURE_PMP);
>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>> >  }
>> >
>> >  #endif
>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > index 20bce8742e..67b1769ad3 100644
>> > --- a/target/riscv/cpu.h
>> > +++ b/target/riscv/cpu.h
>> > @@ -173,7 +173,9 @@ struct CPURISCVState {
>> >      /* temporary htif regs */
>> >      uint64_t mfromhost;
>> >      uint64_t mtohost;
>> > +
>> >      uint64_t timecmp;
>> > +    uint64_t time_freq;
>> >
>> >      /* physical memory protection */
>> >      pmp_table_t pmp_state;
>> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > index e1d91b6c60..6083c782a1 100644
>> > --- a/target/riscv/csr.c
>> > +++ b/target/riscv/csr.c
>> > @@ -191,22 +191,31 @@ static int read_instreth(CPURISCVState *env, int
>> > csrno, target_ulong *val)
>> >  }
>> >  #endif /* TARGET_RISCV32 */
>> >
>> > -#if defined(CONFIG_USER_ONLY)
>> >  static int read_time(CPURISCVState *env, int csrno, target_ulong *val=
)
>> >  {
>> > +#if !defined(CONFIG_USER_ONLY)
>> > +    *val =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>> > +                    env->time_freq, NANOSECONDS_PER_SECOND);
>> > +#else
>> >      *val =3D cpu_get_host_ticks();
>> > +#endif
>> >      return 0;
>> >  }
>> >
>> >  #if defined(TARGET_RISCV32)
>> >  static int read_timeh(CPURISCVState *env, int csrno, target_ulong *va=
l)
>> >  {
>> > +#if !defined(CONFIG_USER_ONLY)
>> > +    *val =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>> > +                    env->time_freq, NANOSECONDS_PER_SECOND) >> 32;
>> > +#else
>> >      *val =3D cpu_get_host_ticks() >> 32;
>> > +#endif
>> >      return 0;
>> >  }
>> >  #endif
>> >
>> > -#else /* CONFIG_USER_ONLY */
>> > +#if !defined(CONFIG_USER_ONLY)
>> >
>> >  /* Machine constants */
>> >
>> > @@ -854,14 +863,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SI=
ZE] =3D
>> > {
>> >      [CSR_INSTRETH] =3D            { ctr,
>> > read_instreth                       },
>> >  #endif
>> >
>> > -    /* User-level time CSRs are only available in linux-user
>> > -     * In privileged mode, the monitor emulates these CSRs */
>> > -#if defined(CONFIG_USER_ONLY)
>> >      [CSR_TIME] =3D                { ctr,
>> > read_time                           },
>> >  #if defined(TARGET_RISCV32)
>> >      [CSR_TIMEH] =3D               { ctr,
>> > read_timeh                          },
>> >  #endif
>> > -#endif
>> >
>> >  #if !defined(CONFIG_USER_ONLY)
>> >      /* Machine Timers and Counters */
>> > --
>> > 2.20.1

