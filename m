Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5942BC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFB921848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7kF9KM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFB921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFyO-0007Z7-OE
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iIAWt-00024v-4o
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iIAWr-0006xh-Ma
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:53:18 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iIAWr-0006xP-GW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:53:17 -0400
Received: by mail-io1-xd41.google.com with SMTP id c6so4173826ioo.13
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=03YwMWE0Ew/a3SON8Z+vIAmBp2VAb4Ga2ZUj8kxeh4Q=;
 b=Q7kF9KM1Z9NHtYGsm9C0EmU7QO47cx65aGyxX8xoPzG4dTcin/ZsCMgSyU4W1oCzQQ
 GwG8gOl8M4fjlsV/5kVBu0z1DOISiTWm5KbKgKkDH7pncxCb7dTrnsybk3az+1You8I6
 v1YG9kDvjwYb7hx6nw+daueTLsb/Yc5SUtIt9BXiOt9j3OHTAwObV1xGxgkbKdvuNwDQ
 zleIy2QcuPYObi1WwOfdEjBowsD/JYFpb96bsmHSI4j/qZOE70XFBfgCakDa4xRF57+s
 tFNn+aV4jhWyJnbifzxRXvUo2BM0RRhc/3SL6+PlV8+DFZ8WW8aB/KbZieoQKfy04g8s
 5gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=03YwMWE0Ew/a3SON8Z+vIAmBp2VAb4Ga2ZUj8kxeh4Q=;
 b=fqor+bUrULn06ulq5Pi1bzfvTgJoBg09vGQUtNvg0t/2SbNiqWYc8QmeTTDHmWgR5p
 7a4h3TZ3ScFuYf5G949KoEiMHRGBoEbzyajtVYyVHvAb0ulhsfvu+Fycxw13g+QP9ZBr
 8cHD74nXj4O5Q2YjNFwsYg7311/+cPvfVrKQA4an6IeLjm+gRuJQ3b27NxhiiIMXAPgx
 54hsfIN8zBKXPRcsZQxgvOVfM43bBaGtqn+Qj9/sCpwITE2WdxOIglh4C6M/YbrqGHHs
 H8GMGUUmcHrsXDtJ7VuExnXQNm6nSDlma9RVfnLS2SKnoj8U1n43nrmTiczczNB+YTIA
 g2Rg==
X-Gm-Message-State: APjAAAUfh9BA828Jci3qPCeSXl0GOz8ZbWyvtGe2Cf+IyDL3EvV0EZRc
 jgfmD8ixAa/ZZLbWB6m1T8Zzn5Lc+KAsE2jLTdX4bg==
X-Google-Smtp-Source: APXvYqyAA2JtUfu8yHC+jx3J4NJsyaRZN1J05enNfjdIoqrhnCS5ypX7oSq+xWL7ui2MY22UZLah6IrcUk0HKsavFRk=
X-Received: by 2002:a92:360b:: with SMTP id d11mr2745579ila.143.1570621996706; 
 Wed, 09 Oct 2019 04:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-5-beata.michalska@linaro.org>
 <c70f7562-c988-5eab-fa1e-fc8b5897e171@linaro.org>
In-Reply-To: <c70f7562-c988-5eab-fa1e-fc8b5897e171@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 9 Oct 2019 12:53:05 +0100
Message-ID: <CADSWDzs=kSveEbLdAwoCNSRYJS=NxXGSEGWHMXM+xxUJ215taQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Add support for DC CVAP & DC
 CVADP ins
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 shameerali.kolothum.thodi@huawei.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/10/19 2:56 AM, Beata Michalska wrote:
> > @@ -2229,7 +2229,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
> >  #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
> >  #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
> >  #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
> > -#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
> > +#define ARM_CP_DC_CVAP           (ARM_CP_SPECIAL | 0x0600)
> > +#define ARM_LAST_SPECIAL         ARM_CP_DC_CVAP
>
> I don't see that this operation needs to be handled via "special".  It's a
> function call upon write, as for many other system registers.
>

Too inspired by ZVA I guess. Will make the appropriate changes in the
next version.

> > +static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
> > +{
> > +    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
> > +}
> > +
> > +static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
> > +{
> > +    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >> 1) != 0;
> > +}
>
> The correct check is FIELD_EX(...) >= 2.  This is a 4-bit field, as with all of
> the others.
>
Noted.
> > +static CPAccessResult aa64_cacheop_persist_access(CPUARMState *env,
> > +                                                  const ARMCPRegInfo *ri,
> > +                                                  bool isread)
> > +{
> > +    ARMCPU *cpu = env_archcpu(env);
> > +    /*
> > +     * Access is UNDEF if lacking implementation for either DC CVAP or DC CVADP
> > +     * DC CVAP ->  CRm: 0xc
> > +     * DC CVADP -> CRm: 0xd
> > +     */
> > +    return (ri->crm == 0xc && !cpu_isar_feature(aa64_dcpop, cpu)) ||
> > +           (ri->crm == 0xd && !cpu_isar_feature(aa64_dcpodp, cpu))
> > +           ? CP_ACCESS_TRAP_UNCATEGORIZED
> > +           : aa64_cacheop_access(env, ri, isread);
> > +}
> ...
> > +    { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
> > +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
> > +      .access = PL0_W, .type = ARM_CP_DC_CVAP,
> > +      .accessfn = aa64_cacheop_persist_access },
> > +    { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
> > +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
> > +      .access = PL0_W, .type = ARM_CP_DC_CVAP,
> > +      .accessfn = aa64_cacheop_persist_access },
>
> While this access function works, it's better to simply not register these at
> all when they're not supported.  Compare the registration of rndr_reginfo.
>
> As I described above, I think this can use a normal write function.  In which
> case this would use .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END.
>
> (I believe that ARM_CP_IO is not required, but I'm not 100% sure.  Certainly
> there does not seem to be anything in dc_cvap() that affects state which can
> queried from another virtual cpu, so there does not appear to be any reason to
> grab the global i/o lock.  The host kernel should be just fine with concurrent
> msync syscalls, or whatever it is that libpmem uses.)
>
>
OK, will move that to conditional registration and double check the type.
Thanks for the suggestion.

> > +void HELPER(dc_cvap)(CPUARMState *env, uint64_t vaddr_in)
> > +{
> > +#ifndef CONFIG_USER_ONLY
> > +    ARMCPU *cpu = env_archcpu(env);
> > +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
> > +    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
> > +    uint64_t vaddr = vaddr_in & ~(dline_size - 1);
> > +    void *haddr;
> > +    int mem_idx = cpu_mmu_index(env, false);
> > +
> > +    /* This won't be crossing page boundaries */
> > +    haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> > +    if (haddr) {
> > +
> > +        ram_addr_t offset;
> > +        MemoryRegion *mr;
> > +
> > +        /*
> > +         * RCU critical section + ref counting,
> > +         * so that MR won't disappear behind the scene
> > +         */
> > +        rcu_read_lock();
> > +        mr = memory_region_from_host(haddr, &offset);
> > +        if (mr) {
> > +            memory_region_ref(mr);
> > +        }
> > +        rcu_read_unlock();
> > +
> > +        if (mr) {
> > +            memory_region_do_writeback(mr, offset, dline_size);
> > +            memory_region_unref(mr);
> > +        }
> > +    }
> > +#endif
>
>
> We hold the rcu lock whenever a TB is executing.  I don't believe there's any
> point in increasing the lock count here.  Similarly with memory_region
> refcounts -- they cannot vanish while we're executing a TB.
>
> Thus I believe that about half of this function can fold away.
>
>
So I was chasing the wrong locking herre...
Indeed if the RCU lock is being already held I can safely drop the locking here.

> r~

Thank you for the review,

BR
Beata

