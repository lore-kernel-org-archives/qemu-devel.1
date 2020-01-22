Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB08CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAE224688
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAE224688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEHw-0001vB-By
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuEGY-0000a3-HS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuEGW-0007EP-Bn
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:33:45 -0500
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:41062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuEGV-0007D3-4a
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:33:44 -0500
Received: from player690.ha.ovh.net (unknown [10.108.35.12])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2C17F2210A2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 12:33:39 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 4EE5DE615C0A;
 Wed, 22 Jan 2020 11:33:29 +0000 (UTC)
Date: Wed, 22 Jan 2020 12:33:27 +0100
From: Greg Kurz <groug@kaod.org>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v20 7/7] ppc: spapr: Activate the FWNMI functionality
Message-ID: <20200122123327.469dc7df@bahia.lan>
In-Reply-To: <20200117093855.19074-8-ganeshgr@linux.ibm.com>
References: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
 <20200117093855.19074-8-ganeshgr@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3680285321814776082
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.33.73
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 15:08:55 +0530
Ganesh Goudar <ganeshgr@linux.ibm.com> wrote:

> From: Aravinda Prasad <arawinda.p@gmail.com>
> 
> This patch sets the default value of SPAPR_CAP_FWNMI_MCE
> to SPAPR_CAP_ON for machine type 4.2.
> 

Now that 4.2 has been released, we want this for 5.0...

> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> ---
>  hw/ppc/spapr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c8bc2fa9f3..a81c18b6b6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4454,7 +4454,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> @@ -4544,6 +4544,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
>      smc->smp_threads_vsmt = false;
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;

... this should go to spapr_machine_4_2_class_options().

>  }
>  
>  DEFINE_SPAPR_MACHINE(4_1, "4.1", false);


