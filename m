Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D2CC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576652082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576652082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Tlp-0002WR-Jd
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 01:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6TlE-00021u-MQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6TlD-0003lm-8m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:32:04 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:45388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6TlD-0003iy-2Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:32:03 -0500
Received: from player773.ha.ovh.net (unknown [10.108.54.34])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 057A41FE86F
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:32:00 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id CDA09FCDECE1;
 Tue, 25 Feb 2020 06:31:43 +0000 (UTC)
Date: Tue, 25 Feb 2020 07:31:42 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 02/18] ppc: Remove stub support for 32-bit hypervisor
 mode
Message-ID: <20200225073142.317b01a8@bahia.home>
In-Reply-To: <20200224233724.46415-3-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-3-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13790022062540495334
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledugdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.150
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:08 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> a4f30719a8cd, way back in 2007 noted that "PowerPC hypervisor mode is not
> fundamentally available only for PowerPC 64" and added a 32-bit version
> of the MSR[HV] bit.
> 
> But nothing was ever really done with that; there is no meaningful support
> for 32-bit hypervisor mode 13 years later.  Let's stop pretending and just
> remove the stubs.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu.h                | 21 +++++++--------------
>  target/ppc/translate_init.inc.c |  6 +++---
>  2 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b283042515..8077fdb068 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -24,8 +24,6 @@
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
>  
> -/* #define PPC_EMULATE_32BITS_HYPV */
> -
>  #define TCG_GUEST_DEFAULT_MO 0
>  
>  #define TARGET_PAGE_BITS_64K 16
> @@ -300,13 +298,12 @@ typedef struct ppc_v3_pate_t {
>  #define MSR_SF   63 /* Sixty-four-bit mode                            hflags */
>  #define MSR_TAG  62 /* Tag-active mode (POWERx ?)                            */
>  #define MSR_ISF  61 /* Sixty-four-bit interrupt mode on 630                  */
> -#define MSR_SHV  60 /* hypervisor state                               hflags */
> +#define MSR_HV   60 /* hypervisor state                               hflags */
>  #define MSR_TS0  34 /* Transactional state, 2 bits (Book3s)                  */
>  #define MSR_TS1  33
>  #define MSR_TM   32 /* Transactional Memory Available (Book3s)               */
>  #define MSR_CM   31 /* Computation mode for BookE                     hflags */
>  #define MSR_ICM  30 /* Interrupt computation mode for BookE                  */
> -#define MSR_THV  29 /* hypervisor state for 32 bits PowerPC           hflags */
>  #define MSR_GS   28 /* guest state for BookE                                 */
>  #define MSR_UCLE 26 /* User-mode cache lock enable for BookE                 */
>  #define MSR_VR   25 /* altivec available                            x hflags */
> @@ -401,10 +398,13 @@ typedef struct ppc_v3_pate_t {
>  
>  #define msr_sf   ((env->msr >> MSR_SF)   & 1)
>  #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
> -#define msr_shv  ((env->msr >> MSR_SHV)  & 1)
> +#if defined(TARGET_PPC64)
> +#define msr_hv   ((env->msr >> MSR_HV)   & 1)
> +#else
> +#define msr_hv   (0)
> +#endif
>  #define msr_cm   ((env->msr >> MSR_CM)   & 1)
>  #define msr_icm  ((env->msr >> MSR_ICM)  & 1)
> -#define msr_thv  ((env->msr >> MSR_THV)  & 1)
>  #define msr_gs   ((env->msr >> MSR_GS)   & 1)
>  #define msr_ucle ((env->msr >> MSR_UCLE) & 1)
>  #define msr_vr   ((env->msr >> MSR_VR)   & 1)
> @@ -449,16 +449,9 @@ typedef struct ppc_v3_pate_t {
>  
>  /* Hypervisor bit is more specific */
>  #if defined(TARGET_PPC64)
> -#define MSR_HVB (1ULL << MSR_SHV)
> -#define msr_hv  msr_shv
> -#else
> -#if defined(PPC_EMULATE_32BITS_HYPV)
> -#define MSR_HVB (1ULL << MSR_THV)
> -#define msr_hv  msr_thv
> +#define MSR_HVB (1ULL << MSR_HV)
>  #else
>  #define MSR_HVB (0ULL)
> -#define msr_hv  (0)
> -#endif
>  #endif
>  
>  /* DSISR */
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 53995f62ea..a0d0eaabf2 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8804,7 +8804,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_PM_ISA206;
>      pcc->msr_mask = (1ull << MSR_SF) |
> -                    (1ull << MSR_SHV) |
> +                    (1ull << MSR_HV) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |
>                      (1ull << MSR_VSX) |
> @@ -9017,7 +9017,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>      pcc->msr_mask = (1ull << MSR_SF) |
> -                    (1ull << MSR_SHV) |
> +                    (1ull << MSR_HV) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |
>                      (1ull << MSR_VSX) |
> @@ -9228,7 +9228,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>      pcc->msr_mask = (1ull << MSR_SF) |
> -                    (1ull << MSR_SHV) |
> +                    (1ull << MSR_HV) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |
>                      (1ull << MSR_VSX) |


