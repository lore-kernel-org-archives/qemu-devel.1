Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BEDC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 10:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEE6206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 10:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEE6206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht8Y5-0006yz-M7
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 06:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1ht8XB-0006SF-9C
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 06:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ht8X9-0000yi-O8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 06:42:09 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:42698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ht8X9-0000y9-J6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 06:42:07 -0400
Received: from player157.ha.ovh.net (unknown [10.109.143.175])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3688113D47C
 for <qemu-devel@nongnu.org>; Thu,  1 Aug 2019 12:42:05 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 0FB16874B1D8;
 Thu,  1 Aug 2019 10:42:00 +0000 (UTC)
Date: Thu, 1 Aug 2019 12:41:59 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190801124159.75d9fa48@bahia.lan>
In-Reply-To: <20190801033819.29664-1-daniel@linux.ibm.com>
References: <20190801033819.29664-1-daniel@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13978047347330292144
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.148
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: quantify error
 messages regarding capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  1 Aug 2019 13:38:19 +1000
Daniel Black <daniel@linux.ibm.com> wrote:

> Its not immediately obvious how cap-X=Y setting need to be applied
> to the command line so, for spapr capability error messages, this
> has been clarified to:
> 
>   ..[try] appending -machine cap-X=Y
> 
> The wrong value messages have been left as is, as the user has found
> the right location.
> 
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>
> ---
> v2 Improved error message thanks David Gibson
> 
> Left the "appending" as its not obvious more that one -machine
> arguement is allowed.
> ---
>  hw/ppc/spapr_caps.c | 47 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..1c0222a081 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -37,6 +37,8 @@
>  
>  #include "hw/ppc/spapr.h"
>  
> +#define CAPABILITY_ERROR(X) "appending -machine " X

I would make that:

#define CAPABILITY_HINT() "try appending -machine " X

because it is really an hint for the user, not an
error, and all original strings have "try", except...

> +
>  typedef struct SpaprCapPossible {
>      int num;            /* size of vals array below */
>      const char *help;   /* help text for vals */
> @@ -194,10 +196,12 @@ static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>      }
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Transactional Memory support in TCG, try cap-htm=off");
> +                   "No Transactional Memory support in TCG, try "
> +                   CAPABILITY_ERROR("cap-htm=off"));
>      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>          error_setg(errp,
> -"KVM implementation does not support Transactional Memory, try cap-htm=off"
> +"KVM implementation does not support Transactional Memory, try "
> +                   CAPABILITY_ERROR("cap-htm=off")
>              );
>      }
>  }
> @@ -215,7 +219,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>       * rid of anything that doesn't do VMX */
>      g_assert(env->insns_flags & PPC_ALTIVEC);
>      if (!(env->insns_flags2 & PPC2_VSX)) {
> -        error_setg(errp, "VSX support not available, try cap-vsx=off");
> +        error_setg(errp, "VSX support not available, try "
> +                   CAPABILITY_ERROR("cap-vsx=off"));
>      }
>  }
>  
> @@ -229,7 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>          return;
>      }
>      if (!(env->insns_flags2 & PPC2_DFP)) {
> -        error_setg(errp, "DFP support not available, try cap-dfp=off");
> +        error_setg(errp, "DFP support not available, try "
> +                   CAPABILITY_ERROR("cap-dfp=off"));
>      }
>  }
>  
> @@ -249,11 +255,13 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>      if (tcg_enabled() && val) {
>          /* TCG only supports broken, allow other values and print a warning */
>          error_setg(&local_err,
> -                   "TCG doesn't support requested feature, cap-cfpc=%s",
> +                   "TCG doesn't support requested feature, "
> +                   CAPABILITY_ERROR("cap-cfpc=%s"),

... this one, but it doesn't look like a hint to me. It just tells which
is the unsupported cap.

>                     cap_cfpc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe cache capability level not supported by kvm, try cap-cfpc=%s",
> +"Requested safe cache capability level not supported by kvm, try "
> +                   CAPABILITY_ERROR("cap-cfpc=%s"),
>                     cap_cfpc_possible.vals[kvm_val]);

Also, we have a dedicated API for hints, which are only printed under
the monitor but ignored under QMP.

Not sure why it isn't used here but it should be something like:

        error_setg(errp, 
                   "Requested safe cache capability level not supported by kvm");
        error_append_hint(errp, CAPABILITY_HINT("cap-cfpc=%s") "\n",
                          cap_cfpc_possible.vals[kvm_val]);

>      }
>  
> @@ -281,7 +289,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
>                     cap_sbbc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe bounds check capability level not supported by kvm, try cap-sbbc=%s",
> +"Requested safe bounds check capability level not supported by kvm, try "
> +                   CAPABILITY_ERROR("cap-sbbc=%s"),
>                     cap_sbbc_possible.vals[kvm_val]);
>      }
>  
> @@ -312,7 +321,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
>                     cap_ibs_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested safe indirect branch capability level not supported by kvm, try cap-ibs=%s",
> +"Requested safe indirect branch capability level not supported by kvm, try "
> +                   CAPABILITY_ERROR("cap-ibs=%s"),
>                     cap_ibs_possible.vals[kvm_val]);
>      }
>  
> @@ -401,11 +411,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>  
>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Nested KVM-HV support in tcg, try cap-nested-hv=off");
> +                   "No Nested KVM-HV support in tcg, try "
> +                   CAPABILITY_ERROR("cap-nested-hv=off"));
>      } else if (kvm_enabled()) {
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
> -"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=off");
> +"KVM implementation does not support Nested KVM-HV, try "
> +                       CAPABILITY_ERROR("cap-nested-hv=off"));
>          } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>                  error_setg(errp,
>  "Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
> @@ -435,10 +447,12 @@ static void cap_large_decr_apply(SpaprMachineState *spapr,
>  
>          if (!kvm_nr_bits) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=off");
> +                       "No large decrementer support, try "
> +                        CAPABILITY_ERROR("cap-large-decr=off"));
>          } else if (pcc->lrg_decr_bits != kvm_nr_bits) {
>              error_setg(errp,
> -"KVM large decrementer size (%d) differs to model (%d), try -cap-large-decr=off",
> +"KVM large decrementer size (%d) differs to model (%d), try "
> +                CAPABILITY_ERROR("cap-large-decr=off"),
>                  kvm_nr_bits, pcc->lrg_decr_bits);
>          }
>      }
> @@ -454,7 +468,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
>      if (kvm_enabled()) {
>          if (kvmppc_enable_cap_large_decr(cpu, val)) {
>              error_setg(errp,
> -                       "No large decrementer support, try cap-large-decr=off");
> +                       "No large decrementer support, try "
> +                       CAPABILITY_ERROR("cap-large-decr=off"));
>          }
>      }
>  
> @@ -474,10 +489,12 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>      if (tcg_enabled() && val) {
>          /* TODO - for now only allow broken for TCG */
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by tcg, try cap-ccf-assist=off");
> +"Requested count cache flush assist capability level not supported by tcg, try "
> +                   CAPABILITY_ERROR("cap-ccf-assist=off"));
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
> -"Requested count cache flush assist capability level not supported by kvm, try cap-ccf-assist=off");
> +"Requested count cache flush assist capability level not supported by kvm, try "
> +                   CAPABILITY_ERROR("cap-ccf-assist=off"));
>      }
>  }
>  


