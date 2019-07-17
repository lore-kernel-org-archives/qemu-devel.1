Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD5BC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C390920665
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C390920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhU1-00052V-1p
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnhTo-0004UD-62
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnhTk-0000v3-CQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:48:10 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:36612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnhTh-0000rP-5x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:48:06 -0400
Received: from player762.ha.ovh.net (unknown [10.108.54.52])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 701791D5FF5
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 12:48:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id CEA6D8082F72;
 Wed, 17 Jul 2019 10:47:56 +0000 (UTC)
Date: Wed, 17 Jul 2019 12:47:55 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190717124755.2bb38834@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156335160761.82682.11912058325777251614.stgit@lep8c.aus.stglabs.ibm.com>
References: <156335150620.82682.9535735857478533420.stgit@lep8c.aus.stglabs.ibm.com>
 <156335160761.82682.11912058325777251614.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18221845571207403861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.228
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/4] ppc: fix leak in
 h_client_architecture_support
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

On Wed, 17 Jul 2019 03:20:31 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Free all SpaprOptionVector local pointers after use.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_hcall.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6808d4cda8..71cfe7c41d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1612,6 +1612,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      ov5_updates = spapr_ovec_new();
>      spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
>                                          ov5_cas_old, spapr->ov5_cas);
> +    spapr_ovec_cleanup(ov5_cas_old);
>      /* Now that processing is finished, set the radix/hash bit for the
>       * guest if it requested a valid mode; otherwise terminate the boot. */
>      if (guest_radix) {
> @@ -1629,6 +1630,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      }
>      spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
>                                                            OV1_PPC_3_00);
> +    spapr_ovec_cleanup(ov1_guest);
>      if (!spapr->cas_reboot) {
>          /* If spapr_machine_reset() did not set up a HPT but one is necessary
>           * (because the guest isn't going to use radix) then set it up here. */
> 
> 


