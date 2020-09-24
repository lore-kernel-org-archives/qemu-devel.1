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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DAC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80436239A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWT5e9iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80436239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPRb-0003sl-4P
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLPGy-0005DO-57; Thu, 24 Sep 2020 07:18:49 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLPGw-0003xT-6P; Thu, 24 Sep 2020 07:18:47 -0400
Received: by mail-qt1-x842.google.com with SMTP id k25so2594844qtu.4;
 Thu, 24 Sep 2020 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LdHRg1X1WPu+nzmX2IxfvedbJtQeAJMB+niaJPcRek4=;
 b=GWT5e9iwALVxi895mMw4WMu9KUR4fzUgWSMbnDOCMKpA1DxQedVf5yHJMDVfVKhpW7
 QOMK3tzqSPivEEIpccOi+d6ildjGkICYdHStSG+oa1i6J+ak96gzkyWkZEJbIKK1G9Rg
 v2iYyXGcsebWR4EaLvi6FssEl3Fr/djiVHmfgt6jaFeRG2SAtjHYjkCIjR8OkDg/zdwc
 MJQcbTqUKdGn3difwMJZIvIUzch8967s6xk/X7ZZn/9Y6SXZoQA0YUv5uPsFiADARoEP
 FdSiWZftMxRIir2QN8mLhWvMIabt/facHY4YHGVGAbt/DKzaVvLchX0KjVNG61wevEWA
 o4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LdHRg1X1WPu+nzmX2IxfvedbJtQeAJMB+niaJPcRek4=;
 b=EGC4258xyyilp6pt63ef2StNVWLuq960xCK6j+yl18lIcogftp1M3o4BjqSOudysWW
 S+oD9OLlhLJ4oCRasprX9IJk5cZ2kSbjHksaSooHNpEM6FNiOfKaFAxsQZUw4iT6XZwG
 D6VyLoFmw0reE0qV9PRyuIdkYXv8OKrsH7umvIINIsOOJXmw8z2X5NlVzK0Tg6F6nRcF
 2Cvbsfr6QVV2yDw45OnGRYUy1un0JTqQz1DJSiopdr7pToM7XJftainiJoJjwFv62lnd
 rGDuUsoDTrAu4TfbaRU2OaxOSBthVXnyos3RAWG5HKQqc0NhTdbVitXldsSuz97jqVIj
 fVIg==
X-Gm-Message-State: AOAM5317WpIk//svK7Ca6ztTBy/8uNEksgtYb8lA75r5diOrVjtgJKjF
 cahXkEZ4QqLU4mFDNg4lNzw=
X-Google-Smtp-Source: ABdhPJwOFjSIGzVyq51h4090Np9eS5V86lU56V+l7gkLYix/KZjLKR9HBizTQEWBGQf1s2u4hFItvA==
X-Received: by 2002:aed:39e3:: with SMTP id m90mr5035959qte.43.1600946322374; 
 Thu, 24 Sep 2020 04:18:42 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id g5sm1774696qtx.43.2020.09.24.04.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 04:18:41 -0700 (PDT)
Subject: Re: [PATCH 3/6] spapr_numa: translate regular NUMA distance to PAPR
 distance
To: Greg Kurz <groug@kaod.org>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-4-danielhb413@gmail.com>
 <20200924101629.16cfec36@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <69dcb671-dcc9-fe8b-97ac-2c2ed69603d9@gmail.com>
Date: Thu, 24 Sep 2020 08:18:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924101629.16cfec36@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
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



On 9/24/20 5:16 AM, Greg Kurz wrote:
> On Wed, 23 Sep 2020 16:34:55 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
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
> 
> Funky naming but meaningful and funny, for me at least :)
> 
>> that translates the user distances to kernel distance, which
>> we're going to use to determine the associativity domains for
>> the NUMA nodes.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/ppc/spapr_numa.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index 36aaa273ee..180800b2f3 100644
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
>> + *  - distances between 11 and 30 -> rounded to 20
>> + *  - distances between 31 and 60 -> rounded to 40
>> + *  - distances between 61 and 120 -> rounded to 80
>> + *  - everything above 120 -> 160
> 
> It isn't clear what happens when the distances are exactly
> 30, 60 or 120...

30 is rounded to 20, 60 is rounded to 40 and 120 is rounded to 80.
Perhaps I should change this to mention "between 11 and 30
inclusive" and so on.

> 
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
>> +            if (distance > 11 && distance < 30) {
>> +                rounded_distance = 20;
>> +            } else if (distance > 31 && distance < 60) {
>> +                rounded_distance = 40;
>> +            } else if (distance > 61 && distance < 120) {
>> +                rounded_distance = 80;
>> +            }
> 
> ... and this code doesn't convert them to PAPR-friendly values
> actually. I guess < should be turned into <= .


Good catch. Yep, this needs to be <=.


Thanks,


DHB

> 
>> +
>> +            numa_info[src].distance[dst] = rounded_distance;
>> +            numa_info[dst].distance[src] = rounded_distance;
>> +        }
>> +    }
>> +}
>> +
>>   void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>                                      MachineState *machine)
>>   {
>> @@ -95,6 +138,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>           exit(1);
>>       }
>>   
>> +    spapr_numa_PAPRify_distances(machine);
>>   }
>>   
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> 

