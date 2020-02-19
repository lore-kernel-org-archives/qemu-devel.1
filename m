Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EEC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD41D206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD41D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Q8u-0005g8-TA
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1j4Q8F-000529-Ho
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1j4Q8E-0002fG-82
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:15:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10660
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1j4Q8E-0002dz-34; Wed, 19 Feb 2020 09:15:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01JE9hb6109983; Wed, 19 Feb 2020 09:15:11 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y93keqa01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2020 09:15:11 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01JEA4e0111363;
 Wed, 19 Feb 2020 09:15:10 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y93keq9yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2020 09:15:10 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01JEALlc031712;
 Wed, 19 Feb 2020 14:15:10 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2y68974rd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2020 14:15:10 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01JEF9Iv49807760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2020 14:15:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4145BAC05F;
 Wed, 19 Feb 2020 14:15:09 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3D16AC067;
 Wed, 19 Feb 2020 14:15:08 +0000 (GMT)
Received: from localhost (unknown [9.86.26.230])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Feb 2020 14:15:08 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 philmd@redhat.com, qemu-devel@nongnu.org, clg@kaod.org
Subject: Re: [PATCH v3 01/12] ppc: Remove stub support for 32-bit hypervisor
 mode
In-Reply-To: <20200219005414.15635-2-david@gibson.dropbear.id.au>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
 <20200219005414.15635-2-david@gibson.dropbear.id.au>
Date: Wed, 19 Feb 2020 11:15:01 -0300
Message-ID: <878skyd5p6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-19_03:2020-02-19,
 2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> a4f30719a8cd, way back in 2007 noted that "PowerPC hypervisor mode is not
> fundamentally available only for PowerPC 64" and added a 32-bit version
> of the MSR[HV] bit.
>
> But nothing was ever really done with that; there is no meaningful support
> for 32-bit hypervisor mode 13 years later.  Let's stop pretending and just
> remove the stubs.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

> ---
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

