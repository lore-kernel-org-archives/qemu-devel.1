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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA9AC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46AD20748
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzCHltBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46AD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE7pR-0004UD-KP
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE7o0-0003Lq-Hp; Fri, 04 Sep 2020 05:14:48 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE7nw-0001cc-Co; Fri, 04 Sep 2020 05:14:47 -0400
Received: by mail-qt1-x843.google.com with SMTP id e5so4090428qth.5;
 Fri, 04 Sep 2020 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LZFnRcJqOhQRsSCxd2s8D9Kmr6nmrFtNb8yncLDWW+s=;
 b=NzCHltBCXQbMDPrBPFwMPU6NRx4MOGHgGv/u5lC8WmMO18Hu9+b0xgeFTY04+ztXKR
 HmjE/Ocvw21AdMChcykdLLf0UypN5NvpU86IeIwJkr+gE2wfDvMvF3eyt0xVYnA4+t8I
 9XkoNGdFO3CrBFtGsMe2AdZVcf+IbwqgE3iCISHDAlfhVMCcGpzZ8NllsD2Wypuo7fWS
 D+p0zV6L5EtaaUwxsk3mQ/ijyOHv8m2S+VVom5d0oV7bogU0L/3RJcTHv+96vhU/sWiP
 r8AwiDkq8ZKTXY92JIKd6krIHZJQRBC82jlkNboZervnhnFi0NmNSxct3EgdvYbDAqa4
 QO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LZFnRcJqOhQRsSCxd2s8D9Kmr6nmrFtNb8yncLDWW+s=;
 b=J+8EhJpBGVahjl/wq4Q1cTJ5s1cjcM8ALiHpP4+wFbXP5Rf2MNLwTfhMiFJRuIAZix
 R+4/5fLK6Dv6Tkqxgdzi542oqxu13EU3zbm7r4AHnTESolrTA285KoX3uz/U17S/FDng
 kv2ogl2jzau+DcWw6YokH8gb2s26x8KaB/Vj2F+TBvgfCaZBBy1x03v7GU8NHWThVNZt
 +6ivmXq9GcvMQD1bWPqY7OnWjDAttkFpJhrFHv78COfzwh/MBUu1/OKDIjOa6XNlnzEW
 KyExBUp9li2TmieLKXaSInVn6Pm9wqS9ST9Yp02Nwgs/SCrsOD2EHFBS6fQ7f0JTAWVx
 jCyw==
X-Gm-Message-State: AOAM530Y5VaU2YrGiaiOjvoPWfWXA3CLJfYLq9p2Omz/qrhasjlaGXbJ
 R381DAG0UzuBKRxAq1Vt4f193tJFhNk=
X-Google-Smtp-Source: ABdhPJybzLUbx++C03Vs581LsfCOBi5+ruEA3fvqdGUoJJh06SworrPbPy4XVs9D6PGecPPgECy25w==
X-Received: by 2002:aed:3387:: with SMTP id v7mr7610481qtd.68.1599210881228;
 Fri, 04 Sep 2020 02:14:41 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id f3sm4008827qth.56.2020.09.04.02.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:14:40 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] spapr_numa: create a vcpu associativity helper
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200904010439.581957-1-danielhb413@gmail.com>
 <20200904010439.581957-3-danielhb413@gmail.com>
 <20200904041033.GG341806@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <38fb3047-96f1-f5fa-dac3-0876522d4172@gmail.com>
Date: Fri, 4 Sep 2020 06:14:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904041033.GG341806@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x843.google.com
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



On 9/4/20 1:10 AM, David Gibson wrote:
> On Thu, Sep 03, 2020 at 10:04:38PM -0300, Daniel Henrique Barboza wrote:
>> The work to be done in h_home_node_associativity() intersects
>> with what is already done in spapr_numa_fixup_cpu_dt(). This
>> patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
>> be used for both spapr_numa_fixup_cpu_dt() and
>> h_home_node_associativity().
>>
>> While we're at it, use memcpy() instead of loop assignment
>> to created the returned array.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr_numa.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 368c1a494d..980a6488bf 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -71,13 +71,15 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>>                         sizeof(spapr->numa_assoc_array[nodeid]))));
>>   }
>>   
>> -int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> -                            int offset, PowerPCCPU *cpu)
>> +static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
>> +                                          PowerPCCPU *cpu,
>> +                                          uint *vcpu_assoc_size)
>>   {
>> -    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
>> -    uint32_t vcpu_assoc[vcpu_assoc_size];
>> +    uint32_t *vcpu_assoc = NULL;
>>       int index = spapr_get_vcpu_id(cpu);
>> -    int i;
>> +
>> +    *vcpu_assoc_size = (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);
>> +    vcpu_assoc = g_malloc(*vcpu_assoc_size);
>>   
>>       /*
>>        * VCPUs have an extra 'cpu_id' value in ibm,associativity
>> @@ -86,16 +88,24 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>>        * cpu_id last.
>>        */
>>       vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
>> +    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
>> +           MAX_DISTANCE_REF_POINTS);
> 
> That needs to be MAX_DISTANCE_REF_POINTS * sizeof(uint32_t), doesn't it?

Hmmmm yeah it does. Even if this didn't break spectacularly in my guest (not
sure why), we're doing a similar operation in spapr_numa_write_assoc_lookup_arrays()
using 'sizeof(uint32_t)'. Might as well do the same here.


Thanks,



DHB

> 
>> +    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] = cpu_to_be32(index);
>>   
>> -    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
>> -        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
>> -    }
>> +    return vcpu_assoc;
>> +}
>> +
>> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>> +                            int offset, PowerPCCPU *cpu)
>> +{
>> +    g_autofree uint32_t *vcpu_assoc = NULL;
>> +    uint vcpu_assoc_size;
>>   
>> -    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
>> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_size);
>>   
>>       /* Advertise NUMA via ibm,associativity */
>>       return fdt_setprop(fdt, offset, "ibm,associativity",
>> -                       vcpu_assoc, sizeof(vcpu_assoc));
>> +                       vcpu_assoc, vcpu_assoc_size);>  }
>>   
>>   
> 

