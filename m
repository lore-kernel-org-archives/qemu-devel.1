Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC6C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3E32220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3E32220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPVl-0000CM-2V
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLPUW-0007lP-Pl; Thu, 24 Sep 2020 07:32:48 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLPUT-0005fq-Hl; Thu, 24 Sep 2020 07:32:48 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.52])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 8B86B5E66250;
 Thu, 24 Sep 2020 13:32:41 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 24 Sep
 2020 13:32:40 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0011c48e0f0-548e-4346-b6af-dd70f2abe35b,
 85AEC8A2294FDACAA0F214F2A1981C2CEEF9973D) smtp.auth=groug@kaod.org
Date: Thu, 24 Sep 2020 13:32:39 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 5/6] spapr_numa: consider user input when defining
 associativity
Message-ID: <20200924133239.11bed8da@bahia.lan>
In-Reply-To: <311ef932-7527-fc9a-99e8-269e946d7eb5@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-6-danielhb413@gmail.com>
 <20200924122251.1edc5113@bahia.lan>
 <311ef932-7527-fc9a-99e8-269e946d7eb5@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 40b27f3c-b996-4ea5-b3d3-26cea10b119c
X-Ovh-Tracer-Id: 9500624889374087648
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkeegffehgeejgedvjeeuveelieffkeehgefhieejteevudekheduteelhfetfefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 05:33:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 24 Sep 2020 08:21:47 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> 
> 
> On 9/24/20 7:22 AM, Greg Kurz wrote:
> > On Wed, 23 Sep 2020 16:34:57 -0300
> > Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> > 
> >> This patch puts all the pieces together to finally allow user
> >> input when defining the NUMA topology of the spapr guest.
> >>
> >> We have one more kernel restriction to handle in this patch:
> >> the associativity array of node 0 must be filled with zeroes
> >> [1]. The strategy below ensures that this will happen.
> >>
> >> spapr_numa_define_associativity_domains() will read the distance
> >> (already PAPRified) between the nodes from numa_state and determine
> >> the appropriate NUMA level. The NUMA domains, processed in ascending
> >> order, are going to be matched via NUMA levels, and the lowest
> >> associativity domain value is assigned to that specific level for
> >> both.
> >>
> >> This will create an heuristic where the associativities of the first
> >> nodes have higher priority and are re-used in new matches, instead of
> >> overwriting them with a new associativity match. This is necessary
> >> because neither QEMU, nor the pSeries kernel, supports multiple
> >> associativity domains for each resource, meaning that we have to
> >> decide which associativity relation is relevant.
> >>
> >> Ultimately, all of this results in a best effort approximation for
> >> the actual NUMA distances the user input in the command line. Given
> >> the nature of how PAPR itself interprets NUMA distances versus the
> >> expectations risen by how ACPI SLIT works, there might be better
> >> algorithms but, in the end, it'll also result in another way to
> >> approximate what the user really wanted.
> >>
> >> To keep this commit message no longer than it already is, the next
> >> patch will update the existing documentation in ppc-spapr-numa.rst
> >> with more in depth details and design considerations/drawbacks.
> >>
> >> [1] https://lore.kernel.org/linuxppc-dev/5e8fbea3-8faf-0951-172a-b41a2138fbcf@gmail.com/
> >>
> >> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> >> ---
> >>   hw/ppc/spapr_numa.c | 81 ++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 80 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> >> index 688391278e..c84f77cda7 100644
> >> --- a/hw/ppc/spapr_numa.c
> >> +++ b/hw/ppc/spapr_numa.c
> >> @@ -80,12 +80,79 @@ static void spapr_numa_PAPRify_distances(MachineState *ms)
> >>       }
> >>   }
> >>   
> >> +static uint8_t spapr_numa_get_NUMA_level(uint8_t distance)
> > 
> > The funky naming doesn't improve clarity IMHO. I'd rather make
> > it lowercase only.
> > 
> >> +{
> >> +    uint8_t numa_level;
> >> +
> >> +    switch (distance) {
> >> +    case 20:
> >> +        numa_level = 0x3;
> >> +        break;
> >> +    case 40:
> >> +        numa_level = 0x2;
> >> +        break;
> >> +    case 80:
> >> +        numa_level = 0x1;
> >> +        break;
> >> +    default:
> >> +        numa_level = 0;
> > 
> > Hmm... same level for distances 10 and 160 ? Is this correct ?
> 
> 
> This will never be called with distance = 10 because we won't
> evaluate distance between the node to itself. But I'll put a
> 'case 10:' clause there that does nothing to make it clearer.
> 

You should make it g_assert_not_reached() in this case.

> 
> 
> DHB
> 
> > 
> >> +    }
> >> +
> >> +    return numa_level;
> >> +}
> >> +
> >> +static void spapr_numa_define_associativity_domains(SpaprMachineState *spapr,
> >> +                                                    MachineState *ms)
> > 
> > Passing ms seems to indicate that it could have a different value than spapr,
> > which is certainly no true.
> > 
> > I'd rather make it a local variable:
> > 
> >      MachineState *ms = MACHINE(spapr);
> > 
> > This is an slow path : we don't really care to do dynamic type checking
> > multiple times.
> > 
> >> +{
> >> +    int src, dst;
> >> +    int nb_numa_nodes = ms->numa_state->num_nodes;
> >> +    NodeInfo *numa_info = ms->numa_state->nodes;
> >> +
> >> +    for (src = 0; src < nb_numa_nodes; src++) {
> >> +        for (dst = src; dst < nb_numa_nodes; dst++) {
> >> +            /*
> >> +             * This is how the associativity domain between A and B
> >> +             * is calculated:
> >> +             *
> >> +             * - get the distance between them
> >> +             * - get the correspondent NUMA level for this distance
> >> +             * - the arrays were initialized with their own numa_ids,
> >> +             * and we're calculating the distance in node_id ascending order,
> >> +             * starting from node 0. This will have a cascade effect in the
> >> +             * algorithm because the associativity domains that node 0 defines
> >> +             * will be carried over to the other nodes, and node 1
> >> +             * associativities will be carried over unless there's already a
> >> +             * node 0 associativity assigned, and so on. This happens because
> >> +             * we'll assign the lowest value of assoc_src and assoc_dst to be
> >> +             * the associativity domain of both, for the given NUMA level.
> >> +             *
> >> +             * The PPC kernel expects the associativity domains of node 0 to
> >> +             * be always 0, and this algorithm will grant that by default.
> >> +             */
> >> +            uint8_t distance = numa_info[src].distance[dst];
> >> +            uint8_t n_level = spapr_numa_get_NUMA_level(distance);
> >> +            uint32_t assoc_src, assoc_dst;
> >> +
> >> +            assoc_src = be32_to_cpu(spapr->numa_assoc_array[src][n_level]);
> >> +            assoc_dst = be32_to_cpu(spapr->numa_assoc_array[dst][n_level]);
> >> +
> >> +            if (assoc_src < assoc_dst) {
> >> +                spapr->numa_assoc_array[dst][n_level] = cpu_to_be32(assoc_src);
> >> +            } else {
> >> +                spapr->numa_assoc_array[src][n_level] = cpu_to_be32(assoc_dst);
> >> +            }
> >> +        }
> >> +    }
> >> +
> >> +}
> >> +
> >>   void spapr_numa_associativity_init(SpaprMachineState *spapr,
> >>                                      MachineState *machine)
> >>   {
> >>       SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> >>       int nb_numa_nodes = machine->numa_state->num_nodes;
> >>       int i, j, max_nodes_with_gpus;
> >> +    bool using_legacy_numa = spapr_machine_using_legacy_numa(spapr);
> >>   
> >>       /*
> >>        * For all associativity arrays: first position is the size,
> >> @@ -99,6 +166,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
> >>       for (i = 0; i < nb_numa_nodes; i++) {
> >>           spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
> >>           spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
> >> +
> >> +        /*
> >> +         * Fill all associativity domains of the node with node_id.
> >> +         * This is required because the kernel makes valid associativity
> > 
> > It would be appreciated to have an URL to the corresponding code in the
> > changelog.
> > 
> >> +         * matches with the zeroes if we leave the matrix unitialized.
> >> +         */
> >> +        if (!using_legacy_numa) {
> >> +            for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
> >> +                spapr->numa_assoc_array[i][j] = cpu_to_be32(i);
> >> +            }
> >> +        }
> >>       }
> >>   
> >>       /*
> >> @@ -128,7 +206,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
> >>        * 1 NUMA node) will not benefit from anything we're going to do
> >>        * after this point.
> >>        */
> >> -    if (spapr_machine_using_legacy_numa(spapr)) {
> >> +    if (using_legacy_numa) {
> >>           return;
> >>       }
> >>   
> >> @@ -139,6 +217,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
> >>       }
> >>   
> >>       spapr_numa_PAPRify_distances(machine);
> >> +    spapr_numa_define_associativity_domains(spapr, machine);
> >>   }
> >>   
> >>   void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
> > 


