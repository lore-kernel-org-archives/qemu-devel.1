Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC3FC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44DE20B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44DE20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMF9-0001ge-Bx
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLMBs-0000Ef-RX; Thu, 24 Sep 2020 04:01:22 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLMBl-0003zT-7Z; Thu, 24 Sep 2020 04:01:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.194])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 87D8364F1B40;
 Thu, 24 Sep 2020 10:01:09 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 24 Sep
 2020 10:01:09 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0024a0e23b4-db4f-4892-8b05-483cd6bf791a,
 85AEC8A2294FDACAA0F214F2A1981C2CEEF9973D) smtp.auth=groug@kaod.org
Date: Thu, 24 Sep 2020 10:01:06 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 2/6] spapr_numa: forbid asymmetrical NUMA setups
Message-ID: <20200924100106.45e49a84@bahia.lan>
In-Reply-To: <20200923193458.203186-3-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-3-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a1e971b7-0036-47b9-b321-a708179291ca
X-Ovh-Tracer-Id: 5928144488732793312
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudejgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
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

On Wed, 23 Sep 2020 16:34:54 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> The pSeries machine does not support asymmetrical NUMA
> configurations. This doesn't make much of a different
> since we're not using user input for pSeries NUMA setup,
> but this will change in the next patches.
> 
> To avoid breaking existing setups, gate this change by
> checking for legacy NUMA support.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 64fe567f5d..36aaa273ee 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -19,6 +19,24 @@
>  /* Moved from hw/ppc/spapr_pci_nvlink2.c */
>  #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
>  
> +static bool spapr_numa_is_symmetrical(MachineState *ms)
> +{
> +    int src, dst;
> +    int nb_numa_nodes = ms->numa_state->num_nodes;
> +    NodeInfo *numa_info = ms->numa_state->nodes;
> +
> +    for (src = 0; src < nb_numa_nodes; src++) {
> +        for (dst = src; dst < nb_numa_nodes; dst++) {
> +            if (numa_info[src].distance[dst] !=
> +                numa_info[dst].distance[src]) {
> +                return false;
> +            }
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  void spapr_numa_associativity_init(SpaprMachineState *spapr,
>                                     MachineState *machine)
>  {
> @@ -61,6 +79,22 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
>  
>          spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
>      }
> +
> +    /*
> +     * Legacy NUMA guests (pseries-5.1 and order, or guests with only

s/order/older

> +     * 1 NUMA node) will not benefit from anything we're going to do
> +     * after this point.
> +     */
> +    if (spapr_machine_using_legacy_numa(spapr)) {
> +        return;
> +    }
> +
> +    if (!spapr_numa_is_symmetrical(machine)) {
> +        error_report("Asymmetrical NUMA topologies aren't supported "
> +                     "in the pSeries machine");
> +        exit(1);

Even if the code base is still heavily populated with exit(1), it seems
that exit(EXIT_FAILURE) is preferred.

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    }
> +
>  }
>  
>  void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,


