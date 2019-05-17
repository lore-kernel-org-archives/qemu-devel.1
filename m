Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABBAC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC9920848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC9920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgSE-0008WD-Hy
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:15:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRgRN-000891-BC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRgRL-0005gn-TQ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:14:41 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:52739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRgRL-0005f4-MO
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:14:39 -0400
Received: from player168.ha.ovh.net (unknown [10.108.54.172])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A77A4131A11
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 19:14:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player168.ha.ovh.net (Postfix) with ESMTPSA id E66A15CB469B;
	Fri, 17 May 2019 17:14:31 +0000 (UTC)
Date: Fri, 17 May 2019 19:14:30 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190517191430.7daa11be@bahia.lan>
In-Reply-To: <20190517041823.23871-1-david@gibson.dropbear.id.au>
References: <20190517041823.23871-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17004466294712277478
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.220
Subject: Re: [Qemu-devel] [PATCH] spapr: Add forgotten capability to
 migration stream
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 14:18:23 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr machine capabilities are supposed to be sent in the migration stream
> so that we can sanity check the source and destination have compatible
> configuration.  Unfortunately, when we added the hpt-max-page-size
> capability, we forgot to add it to the migration state.  This means that we
> can generate spurious warnings when both ends are configured for large
> pages, or potentially fail to warn if the source is configured for huge
> pages, but the destination is not.
> 
> Fixes: 2309832afda "spapr: Maximum (HPT) pagesize property"
> 

Sorry I didn't spot that during review :-\

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

This breaks backward migration if the cap is set to a non-default
value, since older QEMUs don't expect the "spapr/cap/hpt_maxpagesize"
subsection.

This being said, I'm not sure any other value but the current default (16)
actually works, so maybe we don't care. If so,

Reviewed-by: Greg Kurz <groug@kaod.org>

Otherwise, I was thinking about something like this:

8<=============================================================================
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9fc91c8f5eac..4f5becf1f3cc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -119,6 +119,7 @@ struct SpaprMachineClass {
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
     bool broken_host_serial_model; /* present real host info to the guest */
+    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bcae30ad26c3..c8b3cccd5375 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4413,8 +4413,12 @@ DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
  */
 static void spapr_machine_4_0_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_4_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+
+    smc->pre_4_1_migration = true;
 }
 
 DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 658eb15a147b..8a77bbdcf322 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -64,6 +64,7 @@ typedef struct SpaprCapabilityInfo {
     void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
     void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                       uint8_t val, Error **errp);
+    bool (*migrate_needed)(void *opaque);
 } SpaprCapabilityInfo;
 
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
@@ -350,6 +351,11 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
     spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
 
+static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
+{
+    return SPAPR_MACHINE_CLASS(opaque)->pre_4_1_migration;
+}
+
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
                               uint32_t pshift)
 {
@@ -542,6 +548,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "int",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
+        .migrate_needed = cap_hpt_maxpagesize_migrate_needed,
     },
     [SPAPR_CAP_NESTED_KVM_HV] = {
         .name = "nested-hv",
@@ -679,8 +686,11 @@ int spapr_caps_post_migration(SpaprMachineState *spapr)
 static bool spapr_cap_##sname##_needed(void *opaque)    \
 {                                                       \
     SpaprMachineState *spapr = opaque;                  \
+    bool (*needed)(void *opaque) =                      \
+        capability_table[cap].migrate_needed;           \
                                                         \
-    return spapr->cmd_line_caps[cap] &&                 \
+    return needed ? needed(opaque) : true &&            \
+           spapr->cmd_line_caps[cap] &&                 \
            (spapr->eff.caps[cap] !=                     \
             spapr->def.caps[cap]);                      \
 }                                                       \
8<============================================================================


>  hw/ppc/spapr.c         | 1 +
>  hw/ppc/spapr_caps.c    | 1 +
>  include/hw/ppc/spapr.h | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8580a8dc67..bcae30ad26 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2125,6 +2125,7 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_cap_cfpc,
>          &vmstate_spapr_cap_sbbc,
>          &vmstate_spapr_cap_ibs,
> +        &vmstate_spapr_cap_hpt_maxpagesize,
>          &vmstate_spapr_irq_map,
>          &vmstate_spapr_cap_nested_kvm_hv,
>          &vmstate_spapr_dtb,
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9b1c10baa6..658eb15a14 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -703,6 +703,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
>  SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> +SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 7e32f309c2..9fc91c8f5e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -849,6 +849,7 @@ extern const VMStateDescription vmstate_spapr_cap_dfp;
>  extern const VMStateDescription vmstate_spapr_cap_cfpc;
>  extern const VMStateDescription vmstate_spapr_cap_sbbc;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
> +extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;


