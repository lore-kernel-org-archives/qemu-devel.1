Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B89C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D5320716
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPradkGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D5320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzfb-0002YH-IQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDzem-00021Q-5R; Thu, 03 Sep 2020 20:32:44 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDzek-0007qQ-47; Thu, 03 Sep 2020 20:32:43 -0400
Received: by mail-qk1-x741.google.com with SMTP id d20so4937849qka.5;
 Thu, 03 Sep 2020 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LniupfLaUvhYoqEFf4SwpG4Fm+loZmfqPHJ5wOXE/fw=;
 b=SPradkGgZUMBGwh1F252Dr949boVjML/1Ybu7ivNEgdN772vI26u8zqmIJB4mI1JyB
 owZIznzJ28V8p56j7MddBV90GSa4ly9Ar9OZX1p/mtVBRoebVbmmu2ONgYCntDv6uQbm
 F4DTNRWR8/3J2jXtcqy8U2u/eDoZ8RONkhd5kZf2Y+0+xL6YREKysx59Ad2YAyCsntq6
 eZUrbw4NgDFk3+3lRa6YTR/SpV+BwP7vFa780NyDxv3xKMVHk7+ERTGJ7XR/DGOSePvE
 ryyMCri1EafWkB+x2zyBs4ztl9pdiRZxnYDOIdqRipHx0fXqwEWsaqB3fvMb/tl5RM2s
 bKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LniupfLaUvhYoqEFf4SwpG4Fm+loZmfqPHJ5wOXE/fw=;
 b=EV8e3buyA59WsVqllOowfsJzmgS3Ukz3Lld/q8b52U31VhFz8mx7CPiPVdYjGOWAV1
 5osv1AjMlce9bjEracxKVuKE62nu5veNd9vRrwcNPllv4W3F8PZb7XorE+I9nRREVjuj
 DV97QBbziPgW1EtJa7XDLkOfvVTVGYmzCC/3RzzitY3zgSheyRdZHbZ+3VoB/3bNBoO7
 RTZKrMazl6Y7PY80d8HmDjgcP7cuKYls4q9p7RC76J1UR61ehjZ6AOwokC06M32/ivKw
 jWIsjzfCuvjB6DaQaPoMnSvHiT5zq0Sgf0KLazv4ASjkZIxjGz1SpB+NGyUtZkX669tR
 Mntw==
X-Gm-Message-State: AOAM531bNxkgmIT+K8f75Hb5BaBj4CpBKYZ0I83ZQbpuASkB5X/zPGJG
 uVDnG/ixgm9XSzSR2mef9df0b1TBeq4=
X-Google-Smtp-Source: ABdhPJz3zih7layF6VjWgfiN92WyhJGvDYt8NadAVXyOunreJaXZ6ckUy7F1YVDwXkx0Z4/k7Vg7mw==
X-Received: by 2002:a37:a514:: with SMTP id o20mr5676275qke.374.1599179560466; 
 Thu, 03 Sep 2020 17:32:40 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id f127sm3245842qke.133.2020.09.03.17.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 17:32:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] spapr, spapr_numa: handle vcpu ibm,associativity
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200903220639.563090-1-danielhb413@gmail.com>
 <20200903220639.563090-3-danielhb413@gmail.com>
 <20200903232346.GB341806@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <4a4a6cd2-ca3d-fd86-84f3-b08e6667d348@gmail.com>
Date: Thu, 3 Sep 2020 21:32:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903232346.GB341806@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/3/20 8:23 PM, David Gibson wrote:
> On Thu, Sep 03, 2020 at 07:06:34PM -0300, Daniel Henrique Barboza wrote:
>> Vcpus have an additional paramenter to be appended, vcpu_id. This
>> also changes the size of the of property itself, which is being
>> represented in index 0 of numa_assoc_array[cpu->node_id],
>> and defaults to MAX_DISTANCE_REF_POINTS for all cases but
>> vcpus.
>>
>> All this logic makes more sense in spapr_numa.c, where we handle
>> everything NUMA and associativity. A new helper spapr_numa_fixup_cpu_dt()
>> was added, and spapr.c uses it the same way as it was using the former
>> spapr_fixup_cpu_numa_dt().
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr.c              | 17 +----------------
>>   hw/ppc/spapr_numa.c         | 27 +++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_numa.h |  2 ++
>>   3 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 1ad6f59863..badfa86319 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -202,21 +202,6 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
>>       return ret;
>>   }
>>   
>> -static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
>> -{
>> -    int index = spapr_get_vcpu_id(cpu);
>> -    uint32_t associativity[] = {cpu_to_be32(0x5),
>> -                                cpu_to_be32(0x0),
>> -                                cpu_to_be32(0x0),
>> -                                cpu_to_be32(0x0),
>> -                                cpu_to_be32(cpu->node_id),
>> -                                cpu_to_be32(index)};
>> -
>> -    /* Advertise NUMA via ibm,associativity */
>> -    return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
>> -                          sizeof(associativity));
>> -}
>> -
>>   static void spapr_dt_pa_features(SpaprMachineState *spapr,
>>                                    PowerPCCPU *cpu,
>>                                    void *fdt, int offset)
>> @@ -785,7 +770,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
>>                         pft_size_prop, sizeof(pft_size_prop))));
>>   
>>       if (ms->numa_state->num_nodes > 1) {
>> -        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
>> +        _FDT(spapr_numa_fixup_cpu_dt(spapr, fdt, offset, cpu));
>>       }
>>   
>>       _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index f6b6fe648f..1a1ec8bcff 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -45,6 +45,33 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>>                         sizeof(spapr->numa_assoc_array[nodeid]))));
>>   }
>>   
>> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> +                            int offset, PowerPCCPU *cpu)
>> +{
>> +    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
>> +    uint32_t vcpu_assoc[vcpu_assoc_size];
>> +    int index = spapr_get_vcpu_id(cpu);
>> +    int i;
>> +
>> +    /*
>> +     * VCPUs have an extra 'cpu_id' value in ibm,associativity
>> +     * compared to other resources. Increment the size at index
>> +     * 0, copy all associativity domains already set, then put
>> +     * cpu_id last.
>> +     */
>> +    vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
>> +
>> +    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
>> +        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
>> +    }
> 
> You could use a single memcpy() here as well.

I'm moving this code to a new function in patch 06. I'll change this for memcpy()
there for v4.


Thanks,


DHB




> 
>> +
>> +    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
>> +
>> +    /* Advertise NUMA via ibm,associativity */
>> +    return fdt_setprop(fdt, offset, "ibm,associativity",
>> +                       vcpu_assoc, sizeof(vcpu_assoc));
>> +}
>> +
>>   /*
>>    * Helper that writes ibm,associativity-reference-points and
>>    * max-associativity-domains in the RTAS pointed by @rtas
>> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
>> index a2a4df55f7..43c6a16fe3 100644
>> --- a/include/hw/ppc/spapr_numa.h
>> +++ b/include/hw/ppc/spapr_numa.h
>> @@ -27,5 +27,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>   void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>>                                          int offset, int nodeid);
>> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> +                            int offset, PowerPCCPU *cpu);
>>   
>>   #endif /* HW_SPAPR_NUMA_H */
> 

