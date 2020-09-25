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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188E021D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spSRXJqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188E021D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoxM-0004cD-VP
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLowF-0003Mz-CI; Fri, 25 Sep 2020 10:43:07 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLowC-0007gs-KP; Fri, 25 Sep 2020 10:43:07 -0400
Received: by mail-qk1-x741.google.com with SMTP id q5so3008500qkc.2;
 Fri, 25 Sep 2020 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B3j0sC/wOfQbY9BdEkm7z0TbVwmzg8Rz923IXeqG4/Y=;
 b=spSRXJqzSqsOuJq2I7V9UVRitR5v5Gdwty7vYSVDEhG907TqTkTuKPBklH1z3swZsl
 GWJJw6CdSVvi0ZQEBNhTX0uUzQyfI1ENChMx/0cArAPIKbTjUqI8tbZlNdi6b4lM8vwn
 O84ziu+loeVtAvHDWByCAJoLE0flA8rt2PRNYwrqEM5QpKS41z2+byOHUqiVITAhl+aS
 oIq5KGnFyFZ3Mw+sWJohGmOvOlTJIm1ZoMDs4PGMC+VB08aMrCKBC+VRLtIVLthoryv8
 uFomX1mkf+fONUjpR1UUynIeeJXZnzfbpZcKVv4uc+dVA9Clxn67gDuhaDfvV3y3QVYt
 1YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B3j0sC/wOfQbY9BdEkm7z0TbVwmzg8Rz923IXeqG4/Y=;
 b=oF9FjOU+fr9bMYBVNIlJTMZYcJCsoU+ukgbpaZZ9SobvNlENOHm7lni3usGAwHoXkf
 wJj6hIUM8+nNEHr4Ugh+Wna/C/UwIcEe75tOcBi4aVyLh62zM5vvuM1SyPWe0DhmZDJn
 vyHRhqdIOE26CLg+kcdWpxArztr8frjxX6Hcc92KlvRDugEXsHOgaROzujweuZ9vvMUD
 yg0jn9IKZBDBAOdKzfy+Rh2RiXGa75UC+cY9+BjXQLB6kF0uKnFYW0wwE2QtEl2xhdLj
 vcgLSzHa0rnIPM+nSml2pLCxwEq4cFRhWF3it3bg+zAXHOknAFuzRrFYNG2/47vLvnVE
 ekWw==
X-Gm-Message-State: AOAM531LpABQO5m0yHYdpMFLV3UlbaryRxSQJZYHGju99O8sXCOPAFDR
 y4FQOSrtm9ZtfwkDj3cWlbg=
X-Google-Smtp-Source: ABdhPJxD7vkwId9ToMZ9uNUif70zZdNCnoZCGN/fOWo3LkgupnMsQdY5CrOaIxddrqXbm7+MlS+d4g==
X-Received: by 2002:ae9:eb57:: with SMTP id b84mr308099qkg.450.1601044982942; 
 Fri, 25 Sep 2020 07:43:02 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id d10sm1817764qkk.1.2020.09.25.07.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:43:01 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] spapr_numa: consider user input when defining
 associativity
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-6-danielhb413@gmail.com>
 <20200925033945.GT2298@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <9809a86e-d54e-507c-b9fa-74c4b66b2ed2@gmail.com>
Date: Fri, 25 Sep 2020 11:42:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925033945.GT2298@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
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



On 9/25/20 12:39 AM, David Gibson wrote:
> On Thu, Sep 24, 2020 at 04:50:57PM -0300, Daniel Henrique Barboza wrote:
>> This patch puts all the pieces together to finally allow user
>> input when defining the NUMA topology of the spapr guest.
>>
>> We have one more kernel restriction to handle in this patch:
>> the associativity array of node 0 must be filled with zeroes
>> [1]. The strategy below ensures that this will happen.
> 
> Can you clarify exactly what "node 0" means?  Qemu and the guest
> kernel each have node numberings, which I don't think are necessarily
> the same.  With PAPR's scheme, it's not totally clear what "node 0"
> even means.
> 
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
> 
> Hmm.  I find that a bit hard to follow.  So IIUC, what's going on is
> you start out by treating every node as as distant as possible from
> every other: they have a unique value at every level of the
> associativity array.  Then you collapse together nodes that are
> supposed to be closer by making some of their associativity entries
> match.  Is that right?
> 
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
>>   hw/ppc/spapr_numa.c | 101 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
>> index ea33439a15..21cae3f799 100644
>> --- a/hw/ppc/spapr_numa.c
>> +++ b/hw/ppc/spapr_numa.c
>> @@ -80,12 +80,99 @@ static void spapr_numa_PAPRify_distances(MachineState *ms)
>>       }
>>   }
>>   
>> +static uint8_t spapr_numa_get_numa_level(uint8_t distance)
>> +{
>> +    uint8_t numa_level;
> 
> This function reinforces my feeling that pre-PAPRizing the distances
> might not be the best idea.  It could go directly from the user
> distance to level just as easily.

Yeah, the logic from patch 3 will ended up being folded into this
function.

> 
>> +
>> +    switch (distance) {
>> +    case 10:
>> +        numa_level = 0x4;
>> +        break;
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
>> +    }
>> +
>> +    return numa_level;
>> +}
>> +
>> +static void spapr_numa_define_associativity_domains(SpaprMachineState *spapr)
>> +{
>> +    MachineState *ms = MACHINE(spapr);
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    int src, dst;
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
> 
> Ok, I follow this description better than the one in the commit message.
> 
>> +             * The PPC kernel expects the associativity domains of node 0 to
>> +             * be always 0, and this algorithm will grant that by default.
>> +             */
>> +            uint8_t distance = numa_info[src].distance[dst];
>> +            uint8_t n_level = spapr_numa_get_numa_level(distance);
>> +            uint32_t assoc_src, assoc_dst;
>> +
>> +            /*
>> +             * n_level = 0 means that the distance is greater than our last
>> +             * rounded value (120). In this case there is no NUMA level match
>> +             * between src and dst and we can skip the remaining of the loop.
>> +             *
>> +             * The Linux kernel will assume that the distance between src and
>> +             * dst, in this case of no match, is 10 (local distance) doubled
>> +             * for each NUMA it didn't match. We have MAX_DISTANCE_REF_POINTS
>> +             * levels (4), so this gives us 10*2*2*2*2 = 160.
>> +             *
>> +             * This logic can be seen in the Linux kernel source code, as of
>> +             * v5.9, in arch/powerpc/mm/numa.c, function __node_distance().
>> +             */
>> +            if (n_level == 0) {
>> +                continue;
>> +            }
>> +
>> +            assoc_src = be32_to_cpu(spapr->numa_assoc_array[src][n_level]);
>> +            assoc_dst = be32_to_cpu(spapr->numa_assoc_array[dst][n_level]);
>> +
>> +            if (assoc_src < assoc_dst) {
> 
> So, I don't think you need this logic.  It doesn't really matter which
> associativity value you let win, as long as you're consistent.  So you
> can just base it on src < dst, rather than assooc_src < assoc_dst.
> But src <= dst always, because of the way you've constructed the loops.
> 
>> +                spapr->numa_assoc_array[dst][n_level] = cpu_to_be32(assoc_src);
>> +            } else {
>> +                spapr->numa_assoc_array[src][n_level] = cpu_to_be32(assoc_dst);
>> +            }
> 
> Don't you need to match the values a all levels >= n_level, rather
> than just n_level?  AFAICT it doesn't make sense for two components to
> be in the same associativity domain at one level, but different
> domains at "bigger" levels (i.e. something like two cores sharing an
> L2 cache, but not an L3 cache).


I'm not sure what you meant, so let's go through an example. Let's say we
have something like:

      0    1     2
0    10   20   80
1    20   10   40
2    80   40   10

Starting arrays are:

    0x1 0x2 0x3 0x4
0:  0   0   0   0
1:  1   1   1   1
2:  2   2   2   2

What the code will do is:

a) distance 0 to 1 is 20 (0x3 match), 0 to 2 is 80 (0x1 match):

    0x1 0x2 0x3 0x4
0:  0   0   0   0
1:  1   1   0   1
2:  0   2   2   2


b) distance from 1 to 2 is 40 (0x2 match):

    0x1 0x2 0x3 0x4
0:  0   0   0   0
1:  1   1   0   1
2:  0   1   2   2

What the kernel will do (via __node_distance()) is to stop at the first match.
So:

- distance 0 to 1: first match at 0x3, distance = 20:

    0x1 0x2 0x3 0x4
0:  0   0   0*   0
1:  1   1   0*   1

- distance 0 to 2: first match at 0x1, distance = 80:

    0x1 0x2 0x3 0x4
0:  0*   0   0   0
2:  0*   1   2   2

- distance 1 to 2: first match at 0x2, distance = 40:

    0x1 0x2 0x3 0x4
1:  1   *1   0   1
2:  0   *1   2   2


Note that, for this example, we have an exact match between user input and
what the kernel calculates.

Back in (a), the reason why I'm not doing matches in all n_levels above the
first one is because it doesn't matter for the kernel (it'll stop at the
first match) and it'll lead to unintended matches between the earlier and
newer nodes due to how I'm cascading the associativity domains.

Let's say we go back to (a) and do this:

a2) distance 0 to 1 is 20 (0x3 match), 0 to 2 is 80 (0x1 match):

    0x1 0x2 0x3 0x4
0:  0   0   0   0
1:  0   0   0   1
2:  0   2   2   2

We forced the match on all n_levels above the first match in the associativity
array of 1. Then in (b), where we evaluate 1 to 2:

b2) distance 1 to 2 is 40 (0x2 match), cascade the 0 associativity already
existent:

    0x1 0x2 0x3 0x4
0:  0   0   0   0
1:  0   0   0   1
2:  0   0   2   2

The kernel will read this as:

0 to 1: 20
0 to 2: 40 <--- this was 80 via user input
1 to 2: 40


In fact, reading what you said again, that sounds more like a vision in line
with the "Form 0" interpretation of the reference-points, where it would
represent something more close with the physical SMP topology itself.
With the "Form 1" format we're using, we're talking about 'near' and 'far'
resources and most significant boundaries, regardless of any correlation
of the underlying topology. So instead of thinking

"(i.e. something like two cores sharing an L2 cache, but not an L3 cache)"

We would think "node 0 and 1 most significant performance boundary is on
the 0x2 position of the reference-points".


Hope that clarified a bit.


DHB


> 
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
>> @@ -99,6 +186,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>       for (i = 0; i < nb_numa_nodes; i++) {
>>           spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
>>           spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
>> +
>> +        /*
>> +         * Fill all associativity domains of non-zero NUMA nodes with
>> +         * node_id. This is required because the default value (0) is
>> +         * considered a match with associativity domains of node 0.
>> +         */
>> +        if (!using_legacy_numa && i != 0) {
>> +            for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
>> +                spapr->numa_assoc_array[i][j] = cpu_to_be32(i);
>> +            }
>> +        }
>>       }
>>   
>>       /*
>> @@ -128,7 +226,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>        * 1 NUMA node) will not benefit from anything we're going to do
>>        * after this point.
>>        */
>> -    if (spapr_machine_using_legacy_numa(spapr)) {
>> +    if (using_legacy_numa) {
>>           return;
>>       }
>>   
>> @@ -139,6 +237,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>>       }
>>   
>>       spapr_numa_PAPRify_distances(machine);
>> +    spapr_numa_define_associativity_domains(spapr);
>>   }
>>   
>>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> 

