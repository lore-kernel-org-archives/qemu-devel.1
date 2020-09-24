Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7528C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AD22395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVXXWOfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AD22395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPQG-0001aB-UR
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLPJy-00015x-Tb; Thu, 24 Sep 2020 07:21:54 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:38226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLPJw-0004Lb-CY; Thu, 24 Sep 2020 07:21:54 -0400
Received: by mail-qv1-xf41.google.com with SMTP id p15so1661607qvk.5;
 Thu, 24 Sep 2020 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GWjwEsNKQ+uxluvP+KLzww5PGUj37jyu1XPEmDA4lPI=;
 b=kVXXWOfptqW860LIrGbD0OZGda0UNzPGa1cC44wBKbbJlP9PanOFdqMIeZT4gaUYxP
 eczApW3hqQ3tlnwWx8rBDIPJLdr2OJHQRXisEyNPEcV+QPqunOKsABxNKtx9qR9MwaIQ
 jYqADROmlZpYVyAu7n8aZ11whf+GoXMSxDfhykmRJkf/3bU7M8UtHpCK4P3d2Pv6N6FX
 lNY7sA+cFuL7eipxiWaSwJKsp1BjjiFgd3AVM1Pp8ktW4f2YEMEDMOyeenXFMN/i+tOz
 fNLE24XnFXUheXcKqFRlE9KYr4OkfOLgJVs4N1BMrEVDEagvm5dgAM+fjUc9gD9QwWa2
 BIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GWjwEsNKQ+uxluvP+KLzww5PGUj37jyu1XPEmDA4lPI=;
 b=Yxw5Ui3HxwtPV30wfWErvD2GffvGSyAw/mZ0uGg+Ij2DY05fLfyS71KG7UcK4rwMjv
 NyWfr6977m15xzY70SBp9hUVzuQAD6UF6n89YWGtz9HiUBNJp2uS38yEvIQuNPmSnN2s
 j4OBdnjQKwYWIe6PVA1FFFH1FVXSgqCluTWQCcdmJLxe2SVecLAEmWL106OSCL+WZ7ov
 +6cyIKgi56lxoFZOSDx4q08zyuOtwnXPqFfXeh6IVmMsasdfiIBGJFS7vgVvdJt7lgk1
 KOaSMCz1XwlBt8RdiPHYtDoOJoIZu8WAJCK2bJ+WJIB6rkupwB7q1Hp8Xcp0ld8OAlP5
 H8Wg==
X-Gm-Message-State: AOAM532dvNmEvWBJU+pfXpi9FeJA6HuCLgWa+J50p5hsN6zB/L8jxhpZ
 l4Ryk39tuBcTBJ0P8DA/hcnVHgYUO9w=
X-Google-Smtp-Source: ABdhPJzz1uxLC8ycbfy1y7zRWpB/dOBunCodGcYGDTW2mjVElon3xowz9GjQeLlpkd9wgQtKR0uZww==
X-Received: by 2002:a0c:e6ea:: with SMTP id m10mr4723259qvn.53.1600946510960; 
 Thu, 24 Sep 2020 04:21:50 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id s47sm2017363qtb.13.2020.09.24.04.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 04:21:50 -0700 (PDT)
Subject: Re: [PATCH 5/6] spapr_numa: consider user input when defining
 associativity
To: Greg Kurz <groug@kaod.org>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-6-danielhb413@gmail.com>
 <20200924122251.1edc5113@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <311ef932-7527-fc9a-99e8-269e946d7eb5@gmail.com>
Date: Thu, 24 Sep 2020 08:21:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924122251.1edc5113@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.214,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/24/20 7:22 AM, Greg Kurz wrote:
> On Wed, 23 Sep 2020 16:34:57 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> This patch puts all the pieces together to finally allow user
>> input when defining the NUMA topology of the spapr guest.
>>
>> We have one more kernel restriction to handle in this patch:
>> the associativity array of node 0 must be filled with zeroes
>> [1]. The strategy below ensures that this will happen.
>>
>> spapr_numa_define_associativity_domains() will read the distance
>> (already PAPRified) between the nodes from numa_state and determine
>> the appropriate NUMA level. The NUMA domains, processed in ascending
>> order, are going to be matched via NUMA levels, and the lowest
>> associativity domain value is assigned to that specific level for
>> both.
>>
>> This will create an heuristic where the associativities of the first
>> nodes have higher priority and are re-used in new matches, instead of
>> overwriting them with a new associativity match. This is necessary
>> because neither QEMU, nor the pSeries kernel, supports multiple
>> associativity domains for each resource, meaning that we have to
>> decide which associativity relation is relevant.
>>
>> Ultimately, all of this results in a best effort approximation for
>> the actual NUMA distances the user input in the command line. Given
>> the nature of how PAPR itself interprets NUMA distances versus the
>> expectations risen by how ACPI SLIT works, there might be better
>> algorithms but, in the end, it'll also result in another way to
>> approximate what the user really wanted.
>>
>> To keep this commit message no longer than it already is, the next
>> patch will update the existing documentation in ppc-spapr-numa.rst
>> with more in depth details and design considerations/drawbacks.
>>
>> [1] https://lore.kernel.org/linuxppc-dev/5e8fbea3-8faf-0951-172a-b41a2138fbcf@gmail.com/
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr_numa.c | 81 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 688391278e..c84f77cda7 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -80,12 +80,79 @@ static void spapr_numa_PAPRify_distances(MachineState *ms)
>>       }
>>   }
>>   
>> +static uint8_t spapr_numa_get_NUMA_level(uint8_t distance)
> 
> The funky naming doesn't improve clarity IMHO. I'd rather make
> it lowercase only.
> 
>> +{
>> +    uint8_t numa_level;
>> +
>> +    switch (distance) {
>> +    case 20:
>> +        numa_level = 0x3;
>> +        break;
>> +    case 40:
>> +        numa_level = 0x2;
>> +        break;
>> +    case 80:
>> +        numa_level = 0x1;
>> +        break;
>> +    default:
>> +        numa_level = 0;
> 
> Hmm... same level for distances 10 and 160 ? Is this correct ?


This will never be called with distance = 10 because we won't
evaluate distance between the node to itself. But I'll put a
'case 10:' clause there that does nothing to make it clearer.



DHB

> 
>> +    }
>> +
>> +    return numa_level;
>> +}
>> +
>> +static void spapr_numa_define_associativity_domains(SpaprMachineState *spapr,
>> +                                                    MachineState *ms)
> 
> Passing ms seems to indicate that it could have a different value than spapr,
> which is certainly no true.
> 
> I'd rather make it a local variable:
> 
>      MachineState *ms = MACHINE(spapr);
> 
> This is an slow path : we don't really care to do dynamic type checking
> multiple times.
> 
>> +{
>> +    int src, dst;
>> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>> +
>> +    for (src = 0; src < nb_numa_nodes; src++) {
>> +        for (dst = src; dst < nb_numa_nodes; dst++) {
>> +            /*
>> +             * This is how the associativity domain between A and B
>> +             * is calculated:
>> +             *
>> +             * - get the distance between them
>> +             * - get the correspondent NUMA level for this distance
>> +             * - the arrays were initialized with their own numa_ids,
>> +             * and we're calculating the distance in node_id ascending order,
>> +             * starting from node 0. This will have a cascade effect in the
>> +             * algorithm because the associativity domains that node 0 defines
>> +             * will be carried over to the other nodes, and node 1
>> +             * associativities will be carried over unless there's already a
>> +             * node 0 associativity assigned, and so on. This happens because
>> +             * we'll assign the lowest value of assoc_src and assoc_dst to be
>> +             * the associativity domain of both, for the given NUMA level.
>> +             *
>> +             * The PPC kernel expects the associativity domains of node 0 to
>> +             * be always 0, and this algorithm will grant that by default.
>> +             */
>> +            uint8_t distance = numa_info[src].distance[dst];
>> +            uint8_t n_level = spapr_numa_get_NUMA_level(distance);
>> +            uint32_t assoc_src, assoc_dst;
>> +
>> +            assoc_src = be32_to_cpu(spapr->numa_assoc_array[src][n_level]);
>> +            assoc_dst = be32_to_cpu(spapr->numa_assoc_array[dst][n_level]);
>> +
>> +            if (assoc_src < assoc_dst) {
>> +                spapr->numa_assoc_array[dst][n_level] = cpu_to_be32(assoc_src);
>> +            } else {
>> +                spapr->numa_assoc_array[src][n_level] = cpu_to_be32(assoc_dst);
>> +            }
>> +        }
>> +    }
>> +
>> +}
>> +
>>   void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>                                      MachineState *machine)
>>   {
>>       SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>>       int nb_numa_nodes = machine->numa_state->num_nodes;
>>       int i, j, max_nodes_with_gpus;
>> +    bool using_legacy_numa = spapr_machine_using_legacy_numa(spapr);
>>   
>>       /*
>>        * For all associativity arrays: first position is the size,
>> @@ -99,6 +166,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>       for (i = 0; i < nb_numa_nodes; i++) {
>>           spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
>>           spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
>> +
>> +        /*
>> +         * Fill all associativity domains of the node with node_id.
>> +         * This is required because the kernel makes valid associativity
> 
> It would be appreciated to have an URL to the corresponding code in the
> changelog.
> 
>> +         * matches with the zeroes if we leave the matrix unitialized.
>> +         */
>> +        if (!using_legacy_numa) {
>> +            for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
>> +                spapr->numa_assoc_array[i][j] = cpu_to_be32(i);
>> +            }
>> +        }
>>       }
>>   
>>       /*
>> @@ -128,7 +206,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>        * 1 NUMA node) will not benefit from anything we're going to do
>>        * after this point.
>>        */
>> -    if (spapr_machine_using_legacy_numa(spapr)) {
>> +    if (using_legacy_numa) {
>>           return;
>>       }
>>   
>> @@ -139,6 +217,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>       }
>>   
>>       spapr_numa_PAPRify_distances(machine);
>> +    spapr_numa_define_associativity_domains(spapr, machine);
>>   }
>>   
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> 

