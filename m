Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B39C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1042D212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042D212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMS4-0004bO-U0
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLMQu-0003zp-VI; Thu, 24 Sep 2020 04:16:52 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:55025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLMQs-0005qp-QH; Thu, 24 Sep 2020 04:16:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.243])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 80DAB64F3917;
 Thu, 24 Sep 2020 10:16:31 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 24 Sep
 2020 10:16:30 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0063bc074bf-5440-4f82-88ea-7961076f9078,
 85AEC8A2294FDACAA0F214F2A1981C2CEEF9973D) smtp.auth=groug@kaod.org
Date: Thu, 24 Sep 2020 10:16:29 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 3/6] spapr_numa: translate regular NUMA distance to PAPR
 distance
Message-ID: <20200924101629.16cfec36@bahia.lan>
In-Reply-To: <20200923193458.203186-4-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-4-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: c8f8259b-8972-4b96-8d93-0eb880592c1f
X-Ovh-Tracer-Id: 6187664413312915936
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 03:47:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Wed, 23 Sep 2020 16:34:55 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> QEMU allows the user to set NUMA distances in the command line.
> For ACPI architectures like x86, this means that user input is
> used to populate the SLIT table, and the guest perceives the
> distances as the user chooses to.
> 
> PPC64 does not work that way. In the PAPR concept of NUMA,
> associativity relations between the NUMA nodes are provided by
> the device tree, and the guest kernel is free to calculate the
> distances as it sees fit. Given how ACPI architectures works,
> this puts the pSeries machine in a strange spot - users expect
> to define NUMA distances like in the ACPI case, but QEMU does
> not have control over it. To give pSeries users a similar
> experience, we'll need to bring kernel specifics to QEMU
> to approximate the NUMA distances.
> 
> The pSeries kernel works with the NUMA distance range 10,
> 20, 40, 80 and 160. The code starts at 10 (local distance) and
> searches for a match in the first NUMA level between the
> resources. If there is no match, the distance is doubled and
> then it proceeds to try to match in the next NUMA level. Rinse
> and repeat for MAX_DISTANCE_REF_POINTS levels.
> 
> This patch introduces a spapr_numa_PAPRify_distances() helper

Funky naming but meaningful and funny, for me at least :)

> that translates the user distances to kernel distance, which
> we're going to use to determine the associativity domains for
> the NUMA nodes.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 36aaa273ee..180800b2f3 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -37,6 +37,49 @@ static bool spapr_numa_is_symmetrical(MachineState *ms)
>      return true;
>  }
>  
> +/*
> + * This function will translate the user distances into
> + * what the kernel understand as possible values: 10
> + * (local distance), 20, 40, 80 and 160. Current heuristic
> + * is:
> + *
> + *  - distances between 11 and 30 -> rounded to 20
> + *  - distances between 31 and 60 -> rounded to 40
> + *  - distances between 61 and 120 -> rounded to 80
> + *  - everything above 120 -> 160

It isn't clear what happens when the distances are exactly
30, 60 or 120...

> + *
> + * This step can also be done in the same time as the NUMA
> + * associativity domains calculation, at the cost of extra
> + * complexity. We chose to keep it simpler.
> + *
> + * Note: this will overwrite the distance values in
> + * ms->numa_state->nodes.
> + */
> +static void spapr_numa_PAPRify_distances(MachineState *ms)
> +{
> +    int src, dst;
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
> +    NodeInfo *numa_info = ms->numa_state->nodes;
> +
> +    for (src = 0; src < nb_numa_nodes; src++) {
> +        for (dst = src; dst < nb_numa_nodes; dst++) {
> +            uint8_t distance = numa_info[src].distance[dst];
> +            uint8_t rounded_distance = 160;
> +
> +            if (distance > 11 && distance < 30) {
> +                rounded_distance = 20;
> +            } else if (distance > 31 && distance < 60) {
> +                rounded_distance = 40;
> +            } else if (distance > 61 && distance < 120) {
> +                rounded_distance = 80;
> +            }

... and this code doesn't convert them to PAPR-friendly values
actually. I guess < should be turned into <= .

> +
> +            numa_info[src].distance[dst] = rounded_distance;
> +            numa_info[dst].distance[src] = rounded_distance;
> +        }
> +    }
> +}
> +
>  void spapr_numa_associativity_init(SpaprMachineState *spapr,
>                                     MachineState *machine)
>  {
> @@ -95,6 +138,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>          exit(1);
>      }
>  
> +    spapr_numa_PAPRify_distances(machine);
>  }
>  
>  void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,


