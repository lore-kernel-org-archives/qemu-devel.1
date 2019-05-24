Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D3AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D533820863
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D533820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUDfX-0003cB-6c
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:07:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hUDcJ-0000v2-V4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hUDXN-0002MH-KI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:59:22 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:60887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hUDXN-0002KM-BU
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:59:21 -0400
Received: from player729.ha.ovh.net (unknown [10.108.42.82])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 75C4E1090A5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 18:59:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player729.ha.ovh.net (Postfix) with ESMTPSA id 484E064D255C;
	Fri, 24 May 2019 16:59:12 +0000 (UTC)
Date: Fri, 24 May 2019 18:59:11 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190524185911.22173b13@bahia.lan>
In-Reply-To: <20190523052918.1129-4-david@gibson.dropbear.id.au>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190523052918.1129-4-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2514415971182483942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduiedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.44
Subject: Re: [Qemu-devel] [PATCH 4/8] spapr: Clean up spapr_drc_populate_dt()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mdroth@linux.ibm.com, mst@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 15:29:14 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This makes some minor cleanups to spapr_drc_populate_dt(), renaming it to
> the shorter and more idiomatic spapr_dt_drc() along the way.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c             |  7 +++----
>  hw/ppc/spapr_drc.c         | 13 ++++++-------
>  hw/ppc/spapr_pci.c         |  3 +--
>  include/hw/ppc/spapr_drc.h |  3 +--
>  4 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 44573adce7..507fd50dd5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1320,13 +1320,12 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>      spapr_populate_cpus_dt_node(fdt, spapr);
>  
>      if (smc->dr_lmb_enabled) {
> -        _FDT(spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_LMB));
> +        _FDT(spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_LMB));
>      }
>  
>      if (mc->has_hotpluggable_cpus) {
>          int offset = fdt_path_offset(fdt, "/cpus");
> -        ret = spapr_drc_populate_dt(fdt, offset, NULL,
> -                                    SPAPR_DR_CONNECTOR_TYPE_CPU);
> +        ret = spapr_dt_drc(fdt, offset, NULL, SPAPR_DR_CONNECTOR_TYPE_CPU);
>          if (ret < 0) {
>              error_report("Couldn't set up CPU DR device tree properties");
>              exit(1);
> @@ -1363,7 +1362,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>      }
>  
>      if (smc->dr_phb_enabled) {
> -        ret = spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
> +        ret = spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
>          if (ret < 0) {
>              error_report("Couldn't set up PHB DR device tree properties");
>              exit(1);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 597f236b9c..bacadfcac5 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -781,7 +781,7 @@ SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id)
>  }
>  
>  /**
> - * spapr_drc_populate_dt
> + * spapr_dt_drc
>   *
>   * @fdt: libfdt device tree
>   * @path: path in the DT to generate properties
> @@ -794,8 +794,7 @@ SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id)
>   *
>   * as documented in PAPR+ v2.1, 13.5.2
>   */
> -int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
> -                          uint32_t drc_type_mask)
> +int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>  {
>      Object *root_container;
>      ObjectProperty *prop;
> @@ -873,7 +872,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
>      *(uint32_t *)drc_names->str = cpu_to_be32(drc_count);
>      *(uint32_t *)drc_types->str = cpu_to_be32(drc_count);
>  
> -    ret = fdt_setprop(fdt, fdt_offset, "ibm,drc-indexes",
> +    ret = fdt_setprop(fdt, offset, "ibm,drc-indexes",
>                        drc_indexes->data,
>                        drc_indexes->len * sizeof(uint32_t));
>      if (ret) {
> @@ -881,7 +880,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
>          goto out;
>      }
>  
> -    ret = fdt_setprop(fdt, fdt_offset, "ibm,drc-power-domains",
> +    ret = fdt_setprop(fdt, offset, "ibm,drc-power-domains",
>                        drc_power_domains->data,
>                        drc_power_domains->len * sizeof(uint32_t));
>      if (ret) {
> @@ -889,14 +888,14 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
>          goto out;
>      }
>  
> -    ret = fdt_setprop(fdt, fdt_offset, "ibm,drc-names",
> +    ret = fdt_setprop(fdt, offset, "ibm,drc-names",
>                        drc_names->str, drc_names->len);
>      if (ret) {
>          error_report("Couldn't finalize ibm,drc-names property");
>          goto out;
>      }
>  
> -    ret = fdt_setprop(fdt, fdt_offset, "ibm,drc-types",
> +    ret = fdt_setprop(fdt, offset, "ibm,drc-types",
>                        drc_types->str, drc_types->len);
>      if (ret) {
>          error_report("Couldn't finalize ibm,drc-types property");
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index c166df4145..04855d3125 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2282,8 +2282,7 @@ int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>          return ret;
>      }
>  
> -    ret = spapr_drc_populate_dt(fdt, bus_off, OBJECT(phb),
> -                                SPAPR_DR_CONNECTOR_TYPE_PCI);
> +    ret = spapr_dt_drc(fdt, bus_off, OBJECT(phb), SPAPR_DR_CONNECTOR_TYPE_PCI);
>      if (ret) {
>          return ret;
>      }
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index fad0a887f9..c2c543a591 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -266,8 +266,7 @@ SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
>                                           uint32_t id);
>  SpaprDrc *spapr_drc_by_index(uint32_t index);
>  SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id);
> -int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
> -                          uint32_t drc_type_mask);
> +int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask);
>  
>  void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
>  void spapr_drc_detach(SpaprDrc *drc);


