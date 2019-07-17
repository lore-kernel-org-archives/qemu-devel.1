Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E7FC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F65520880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F65520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhTM-0003t1-2s
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnhT4-00037d-0J
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnhT1-0000Kg-Ev
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:47:25 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:51573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnhT1-0000Hp-7H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:47:23 -0400
Received: from player771.ha.ovh.net (unknown [10.108.57.226])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id AC44F13B151
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 12:47:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 7FA8980595CA;
 Wed, 17 Jul 2019 10:47:15 +0000 (UTC)
Date: Wed, 17 Jul 2019 12:47:14 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190717124714.3c55b854@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156335159028.82682.5404622104535818162.stgit@lep8c.aus.stglabs.ibm.com>
References: <156335150620.82682.9535735857478533420.stgit@lep8c.aus.stglabs.ibm.com>
 <156335159028.82682.5404622104535818162.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18210023620238547285
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.140
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/4] ppc: fix memory leak in
 spapr_dt_drc()
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

On Wed, 17 Jul 2019 03:20:01 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Leaking the drc_name while preparing the DT properties.
> Fixing that.
> 
> Also, remove the const qualifier from spapr_drc_name().
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr_drc.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index bacadfcac5..695a0b2285 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -226,7 +226,7 @@ static uint32_t drc_set_unusable(SpaprDrc *drc)
>      return RTAS_OUT_SUCCESS;
>  }
>  
> -static const char *spapr_drc_name(SpaprDrc *drc)
> +static char *spapr_drc_name(SpaprDrc *drc)
>  {
>      SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>  
> @@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>          Object *obj;
>          SpaprDrc *drc;
>          SpaprDrcClass *drck;
> +        char *drc_name = NULL;
>          uint32_t drc_index, drc_power_domain;
>  
>          if (!strstart(prop->type, "link<", NULL)) {
> @@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>          g_array_append_val(drc_power_domains, drc_power_domain);
>  
>          /* ibm,drc-names */
> -        drc_names = g_string_append(drc_names, spapr_drc_name(drc));
> +        drc_name = spapr_drc_name(drc);
> +        drc_names = g_string_append(drc_names, drc_name);
>          drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
> +        g_free(drc_name);
>  

This could even be called just after g_string_append(). No big deal.

Reviewed-by: Greg Kurz <groug@kaod.org>

>          /* ibm,drc-types */
>          drc_types = g_string_append(drc_types, drck->typename);
> 
> 


