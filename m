Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BCDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1004C21741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reL+hxe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1004C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnDq-000076-Vk
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLn5M-00019d-IR; Fri, 25 Sep 2020 08:44:24 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLn5K-0000Gi-KR; Fri, 25 Sep 2020 08:44:24 -0400
Received: by mail-qk1-x742.google.com with SMTP id 16so2593860qkf.4;
 Fri, 25 Sep 2020 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/i6nj4tbiwLX1+KBy5Ylg7HAbJZyPN/vGWHVtdE9rf8=;
 b=reL+hxe6EA2DhijIySr7wdXrrSsJyMlifXO2uyuZs3uFHJx1UC2ObfnKD6I5V8CxUN
 WP8p/mnNhoN88kzKZITk/V4/rlpMaA3ATZo/BJngZ8jALSHB6T4kFcLTRoQyUep8hJoX
 6S68FOhnsL57jkA8haYtzneqhx8iLAvAnf1w946R9tCYw5CuXcbCI7Ak24l0dfXew/el
 kjMMY9tY6TW9YOkUj0Zn8ZtHh/SXsFzAK3VMq2rSecJb8Kj8wOqTLuNSwXW6PgVmrhy0
 VpCY7gKUy8vMib7wIOjCRC96E6YDAbeMArBze7zfvwMywD7AiVn5ubH6oipNxXuqIEQ1
 bVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/i6nj4tbiwLX1+KBy5Ylg7HAbJZyPN/vGWHVtdE9rf8=;
 b=S0IMz+lAjLtruruIfkL0brqVQkljesZ83TRBBwP8vekPtfT8gm0JQrUnyGLUPlxRU5
 fMX7xkfJvYcKLDiW2Yy7VKcbyHnHkCwMuk+3yYMmyN0MFmU9fpxTRSbDkvzT979JWL88
 u+bFvcg5jvsRWX1tk3/qiK9UExLtW8y847YZ2GLOlK6KL/F+Z8gtst1fvDDzpNJPy21t
 61sDREi4DwlW1rzUGs/Y61rBpkXfo5nw51Jp5y+o+dYJD6Ckypm1OIps5jLkjuq8pUAG
 A3B68xFSVQXSIfJbHLi8bR9NhMS1tisB98WIPw7KTh4DoAd4jmQ7dL5bUi6fK+BFhwMt
 BB4w==
X-Gm-Message-State: AOAM531+/vObctDB5LhKtEHzalDsXb5n8SpG14/qG7sPr8teDnZRqATo
 cnOMYtvx12jWqP2GPbz+x7E=
X-Google-Smtp-Source: ABdhPJyiuIultynL+rWtMgV6AispgAVmgdpZldZXsBU5jEHT6EJEobgcmzWoqGu3LrmJxyhM5tcAoA==
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr3759629qkc.24.1601037860748; 
 Fri, 25 Sep 2020 05:44:20 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f127sm1610932qke.133.2020.09.25.05.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 05:44:17 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] spapr_numa: translate regular NUMA distance to
 PAPR distance
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-4-danielhb413@gmail.com>
 <20200925023524.GQ2298@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <5a80b9ae-3954-7e01-dcda-759ce50fe5e7@gmail.com>
Date: Fri, 25 Sep 2020 09:44:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925023524.GQ2298@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.238,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/24/20 11:35 PM, David Gibson wrote:
> On Thu, Sep 24, 2020 at 04:50:55PM -0300, Daniel Henrique Barboza wrote:
>> QEMU allows the user to set NUMA distances in the command line.
>> For ACPI architectures like x86, this means that user input is
>> used to populate the SLIT table, and the guest perceives the
>> distances as the user chooses to.
>>
>> PPC64 does not work that way. In the PAPR concept of NUMA,
>> associativity relations between the NUMA nodes are provided by
>> the device tree, and the guest kernel is free to calculate the
>> distances as it sees fit. Given how ACPI architectures works,
>> this puts the pSeries machine in a strange spot - users expect
>> to define NUMA distances like in the ACPI case, but QEMU does
>> not have control over it. To give pSeries users a similar
>> experience, we'll need to bring kernel specifics to QEMU
>> to approximate the NUMA distances.
>>
>> The pSeries kernel works with the NUMA distance range 10,
>> 20, 40, 80 and 160. The code starts at 10 (local distance) and
>> searches for a match in the first NUMA level between the
>> resources. If there is no match, the distance is doubled and
>> then it proceeds to try to match in the next NUMA level. Rinse
>> and repeat for MAX_DISTANCE_REF_POINTS levels.
>>
>> This patch introduces a spapr_numa_PAPRify_distances() helper
>> that translates the user distances to kernel distance, which
>> we're going to use to determine the associativity domains for
>> the NUMA nodes.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> 
> The idea of rounding the distances like this seems pretty good to me.
> Since each level is a multiple of a distance from the preivous one it
> might be more theoretically correct to place the thresholds at the
> geometric mean between each level, rather than the arithmetic mean.  I
> very much doubt it makes much different in practice though, and this
> is simpler.
> 
> There is one nit, I'm less happy with though..
> 
>> ---
>>   hw/ppc/spapr_numa.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index fe395e80a3..990a5fce08 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -37,6 +37,49 @@ static bool spapr_numa_is_symmetrical(MachineState *ms)
>>       return true;
>>   }
>>   
>> +/*
>> + * This function will translate the user distances into
>> + * what the kernel understand as possible values: 10
>> + * (local distance), 20, 40, 80 and 160. Current heuristic
>> + * is:
>> + *
>> + *  - distances between 11 and 30 inclusive -> rounded to 20
>> + *  - distances between 31 and 60 inclusive -> rounded to 40
>> + *  - distances between 61 and 120 inclusive -> rounded to 80
>> + *  - everything above 120 -> 160
>> + *
>> + * This step can also be done in the same time as the NUMA
>> + * associativity domains calculation, at the cost of extra
>> + * complexity. We chose to keep it simpler.
>> + *
>> + * Note: this will overwrite the distance values in
>> + * ms->numa_state->nodes.
>> + */
>> +static void spapr_numa_PAPRify_distances(MachineState *ms)
>> +{
>> +    int src, dst;
>> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>> +
>> +    for (src = 0; src < nb_numa_nodes; src++) {
>> +        for (dst = src; dst < nb_numa_nodes; dst++) {
>> +            uint8_t distance = numa_info[src].distance[dst];
>> +            uint8_t rounded_distance = 160;
>> +
>> +            if (distance > 11 && distance <= 30) {
>> +                rounded_distance = 20;
>> +            } else if (distance > 31 && distance <= 60) {
>> +                rounded_distance = 40;
>> +            } else if (distance > 61 && distance <= 120) {
>> +                rounded_distance = 80;
>> +            }
>> +
>> +            numa_info[src].distance[dst] = rounded_distance;
>> +            numa_info[dst].distance[src] = rounded_distance;
> 
> ..I don't love the fact that we alter the distance table in place.
> Even though it was never exposed to the guest, I'd prefer not to
> destroy the information the user passed in.  It could lead to
> surprising results with QMP introspection, and it may make future
> extensions more difficult.
> 
> So I'd prefer to either (a) just leave the table as is and round
> on-demand with a paprify_distance(NN) -> {20,40,80,..} type function,
> or (b) create a parallel, spapr local, table with the rounded
> distances


I did something similar with (a) in the very first version of this series.
I'll fall back to on-demand translation logic to avoid changing numa_info.



Thanks,


DHB

> 
>> +        }
>> +    }
>> +}
>> +
>>   void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>                                      MachineState *machine)
>>   {
>> @@ -95,6 +138,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>           exit(EXIT_FAILURE);
>>       }
>>   
>> +    spapr_numa_PAPRify_distances(machine);
>>   }
>>   
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> 

