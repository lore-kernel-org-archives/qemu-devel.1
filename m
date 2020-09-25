Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9392823976
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9392823976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnhk-0006Ob-PI
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLnal-00061g-OM; Fri, 25 Sep 2020 09:16:52 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:54417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLnai-0004VK-Jw; Fri, 25 Sep 2020 09:16:51 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.59])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 0C2285EDAFF2;
 Fri, 25 Sep 2020 15:16:35 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 25 Sep
 2020 15:16:34 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055d6d8ade-ad58-4d72-b4a1-c1d99a967c57,
 A5F0BA03093B57E977C960A2BE809674B2E579B9) smtp.auth=groug@kaod.org
Date: Fri, 25 Sep 2020 15:16:33 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 4/6] spapr_numa: change reference-points and
 maxdomain settings
Message-ID: <20200925151633.12982bf0@bahia.lan>
In-Reply-To: <20200924195058.362984-5-danielhb413@gmail.com>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-5-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 563753aa-4c03-48ec-93c8-174e0490230b
X-Ovh-Tracer-Id: 17127752334968986080
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 09:16:35
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

On Thu, 24 Sep 2020 16:50:56 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> This is the first guest visible change introduced in
> spapr_numa.c. The previous settings of both reference-points
> and maxdomains were too restrictive, but enough for the
> existing associativity we're setting in the resources.
> 
> We'll change that in the following patches, populating the
> associativity arrays based on user input. For those changes
> to be effective, reference-points and maxdomains must be
> more flexible. After this patch, we'll have 4 distinct
> levels of NUMA (0x4, 0x3, 0x2, 0x1) and maxdomains will
> allow for any type of configuration the user intends to
> do - under the scope and limitations of PAPR itself, of
> course.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_numa.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 990a5fce08..ea33439a15 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -222,24 +222,48 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
>   */
>  void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
>  {
> +    MachineState *ms = MACHINE(spapr);
>      SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>      uint32_t refpoints[] = {
>          cpu_to_be32(0x4),
> -        cpu_to_be32(0x4),
> +        cpu_to_be32(0x3),
>          cpu_to_be32(0x2),
> +        cpu_to_be32(0x1),
>      };
>      uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
> -    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
> +    uint32_t maxdomain = ms->numa_state->num_nodes + spapr->gpu_numa_id;
>      uint32_t maxdomains[] = {
>          cpu_to_be32(4),
> -        maxdomain,
> -        maxdomain,
> -        maxdomain,
> -        cpu_to_be32(spapr->gpu_numa_id),
> +        cpu_to_be32(maxdomain),
> +        cpu_to_be32(maxdomain),
> +        cpu_to_be32(maxdomain),
> +        cpu_to_be32(maxdomain)
>      };
>  
> -    if (smc->pre_5_1_assoc_refpoints) {
> -        nr_refpoints = 2;
> +    if (spapr_machine_using_legacy_numa(spapr)) {
> +        uint32_t legacy_refpoints[] = {
> +            cpu_to_be32(0x4),
> +            cpu_to_be32(0x4),
> +            cpu_to_be32(0x2),
> +        };
> +        uint32_t legacy_maxdomain = spapr->gpu_numa_id > 1 ? 1 : 0;
> +        uint32_t legacy_maxdomains[] = {
> +            cpu_to_be32(4),
> +            cpu_to_be32(legacy_maxdomain),
> +            cpu_to_be32(legacy_maxdomain),
> +            cpu_to_be32(legacy_maxdomain),
> +            cpu_to_be32(spapr->gpu_numa_id),
> +        };
> +
> +        nr_refpoints = 3;
> +
> +        memcpy(refpoints, legacy_refpoints, sizeof(legacy_refpoints));
> +        memcpy(maxdomains, legacy_maxdomains, sizeof(legacy_maxdomains));
> +
> +        /* pseries-5.0 and older reference-points array is {0x4, 0x4} */
> +        if (smc->pre_5_1_assoc_refpoints) {
> +            nr_refpoints = 2;
> +        }
>      }
>  
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",


