Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B44C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A202120872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4ERP71r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A202120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCofQ-0008Oj-Bb
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCoVs-0008Jl-2K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCoVq-0001vA-GK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:22:07 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCoVq-0001uU-7j
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:22:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id q7so1757347pfh.8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ShJu3UJ26MTFMk5sHkGBGMjA9yGJor0G5wu1YDqz3nQ=;
 b=m4ERP71ruEA+f7f3VOzwS6CnKrgBqPcP/dllq3dUR4yZL/teOtgQU0IiPH0tuMokfJ
 /8lYNRJx7QAZQ4rP5i9oxtYZJwB2lhQ8y879JiCZn/KQbf37s12Qlpk80L873GM97E0D
 eOfN2B/mUQNMIcXJSnMYpdaokDNrsstdAtU8NTV0nAscP4oTYN/UIXYOW//l7jbRpf93
 sKVwn8VPp5WWky5vzR17zDhMJ49I0chQVYMqIYe8/IjMOUavNK2mVoDnsGDfV9k4J/Q9
 PKC3IvddrRHWeannTG50Y9/tqCgZ+QCO3Bv3lYnMhu9A2amaRiez/+Hv2Ri/nyNd3lWY
 WlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ShJu3UJ26MTFMk5sHkGBGMjA9yGJor0G5wu1YDqz3nQ=;
 b=n970/34hLbFCwdfJRbwY/A5q7zA+3g387k+Eb/40ll7E4+X620uxPiRPz6/jmu1zo7
 QzN7jhRf5aanwBTiGNpK9nka+CdFmM1FhNvk61SbuoHSEdeT5TvdI8XiuNyshvUb971i
 8IQUYfJ+gkfDhILqKPFVqjR3KqMlY8SpUyKfk2/QXXA9Lw39pR8p2DfGNXLu9NuTZByR
 tSq2wdm1NAOrdUUqFOPIF8HFbreMt5TFAuA1q+egShUN4dCYbiDFOfvEvsQ/AFLomNZi
 y+sPKtkcJ/cibMp+PX+oNJnoYoihemYJvvKWFJ24RJRq39QeoYTYFtl0CEP/G5GV7bvL
 RYQw==
X-Gm-Message-State: APjAAAXmnwj8luMOLmrSECVTfB3tSjoP2ePadh8VmGKSCJ1ZC+C0tI8o
 XAhCorTi/lZp2whaQvPllnTOKg==
X-Google-Smtp-Source: APXvYqwdES36iTDesBszAPu1c9WMNm8/Acg71GaJMmSuV3Qws/XGOZ+ajo2HZnjIpRE92UHPF5K1sQ==
X-Received: by 2002:a63:594f:: with SMTP id j15mr4193469pgm.57.1569345724490; 
 Tue, 24 Sep 2019 10:22:04 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id r185sm2848063pfr.68.2019.09.24.10.22.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 10:22:03 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Add support for DC CVAP & DC
 CVADP ins
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-5-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c70f7562-c988-5eab-fa1e-fc8b5897e171@linaro.org>
Date: Tue, 24 Sep 2019 10:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910095610.4546-5-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 2:56 AM, Beata Michalska wrote:
> @@ -2229,7 +2229,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
>  #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
>  #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
>  #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
> -#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
> +#define ARM_CP_DC_CVAP           (ARM_CP_SPECIAL | 0x0600)
> +#define ARM_LAST_SPECIAL         ARM_CP_DC_CVAP

I don't see that this operation needs to be handled via "special".  It's a
function call upon write, as for many other system registers.

> +static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
> +}
> +
> +static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
> +{
> +    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >> 1) != 0;
> +}

The correct check is FIELD_EX(...) >= 2.  This is a 4-bit field, as with all of
the others.

> +static CPAccessResult aa64_cacheop_persist_access(CPUARMState *env,
> +                                                  const ARMCPRegInfo *ri,
> +                                                  bool isread)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    /*
> +     * Access is UNDEF if lacking implementation for either DC CVAP or DC CVADP
> +     * DC CVAP ->  CRm: 0xc
> +     * DC CVADP -> CRm: 0xd
> +     */
> +    return (ri->crm == 0xc && !cpu_isar_feature(aa64_dcpop, cpu)) ||
> +           (ri->crm == 0xd && !cpu_isar_feature(aa64_dcpodp, cpu))
> +           ? CP_ACCESS_TRAP_UNCATEGORIZED
> +           : aa64_cacheop_access(env, ri, isread);
> +}
...
> +    { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
> +      .access = PL0_W, .type = ARM_CP_DC_CVAP,
> +      .accessfn = aa64_cacheop_persist_access },
> +    { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
> +      .access = PL0_W, .type = ARM_CP_DC_CVAP,
> +      .accessfn = aa64_cacheop_persist_access },

While this access function works, it's better to simply not register these at
all when they're not supported.  Compare the registration of rndr_reginfo.

As I described above, I think this can use a normal write function.  In which
case this would use .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END.

(I believe that ARM_CP_IO is not required, but I'm not 100% sure.  Certainly
there does not seem to be anything in dc_cvap() that affects state which can
queried from another virtual cpu, so there does not appear to be any reason to
grab the global i/o lock.  The host kernel should be just fine with concurrent
msync syscalls, or whatever it is that libpmem uses.)


> +void HELPER(dc_cvap)(CPUARMState *env, uint64_t vaddr_in)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    ARMCPU *cpu = env_archcpu(env);
> +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
> +    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
> +    uint64_t vaddr = vaddr_in & ~(dline_size - 1);
> +    void *haddr;
> +    int mem_idx = cpu_mmu_index(env, false);
> +
> +    /* This won't be crossing page boundaries */
> +    haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> +    if (haddr) {
> +
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        /*
> +         * RCU critical section + ref counting,
> +         * so that MR won't disappear behind the scene
> +         */
> +        rcu_read_lock();
> +        mr = memory_region_from_host(haddr, &offset);
> +        if (mr) {
> +            memory_region_ref(mr);
> +        }
> +        rcu_read_unlock();
> +
> +        if (mr) {
> +            memory_region_do_writeback(mr, offset, dline_size);
> +            memory_region_unref(mr);
> +        }
> +    }
> +#endif


We hold the rcu lock whenever a TB is executing.  I don't believe there's any
point in increasing the lock count here.  Similarly with memory_region
refcounts -- they cannot vanish while we're executing a TB.

Thus I believe that about half of this function can fold away.


r~

