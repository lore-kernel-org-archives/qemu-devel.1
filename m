Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF12C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F73B2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F73B2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Q0n-00086T-Qp
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1j4Q01-0006lf-1f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1j4Pzv-00045W-OT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37940
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1j4Pzv-000458-K0; Wed, 19 Feb 2020 09:06:43 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01JDxT7M115483; Wed, 19 Feb 2020 09:06:29 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubyxtts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2020 09:06:29 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01JE03Uw132873;
 Wed, 19 Feb 2020 09:06:28 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubyxtt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2020 09:06:28 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01JE5TCl008074;
 Wed, 19 Feb 2020 14:06:28 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 2y6896vpdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2020 14:06:28 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01JE6RHB54395256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2020 14:06:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50C6EAC059;
 Wed, 19 Feb 2020 14:06:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99FFCAC05E;
 Wed, 19 Feb 2020 14:06:26 +0000 (GMT)
Received: from localhost (unknown [9.86.26.230])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Feb 2020 14:06:26 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 philmd@redhat.com, qemu-devel@nongnu.org, clg@kaod.org
Subject: Re: [PATCH v3 04/12] target/ppc: Introduce ppc_hash64_use_vrma()
 helper
In-Reply-To: <20200219005414.15635-5-david@gibson.dropbear.id.au>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
 <20200219005414.15635-5-david@gibson.dropbear.id.au>
Date: Wed, 19 Feb 2020 11:06:20 -0300
Message-ID: <87blpud63n.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-19_03:2020-02-19,
 2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190108
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

> When running guests under a hypervisor, the hypervisor obviously needs to
> be protected from guest accesses even if those are in what the guest
> considers real mode (translation off).  The POWER hardware provides two
> ways of doing that: The old way has guest real mode accesses simply offset
> and bounds checked into host addresses.  It works, but requires that a
> significant chunk of the guest's memory - the RMA - be physically
> contiguous in the host, which is pretty inconvenient.  The new way, known
> as VRMA, has guest real mode accesses translated in roughly the normal way
> but with some special parameters.
>
> In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes, b=
ut
> in POWER9 only VRMA mode is supported

... when translation is off, right? Because I see in the 3.0 ISA that
LPCR[VPM1] is still there.

> and LPCR[VPM0] no longer exists.  We
> handle that difference in behaviour in ppc_hash64_set_isi().. but not in
> other places that we blindly check LPCR[VPM0].
>
> Correct those instances with a new helper to tell if we should be in VRMA
> mode.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/mmu-hash64.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 5fabd93c92..d878180df5 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -668,6 +668,19 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU=
 *cpu,
>      return 0;
>  }
>=20=20
> +static bool ppc_hash64_use_vrma(CPUPPCState *env)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /* ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
> +         * register no longer exist */
> +        return true;
> +
> +    default:
> +        return !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +    }
> +}
> +
>  static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
>  {
>      CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
> @@ -676,15 +689,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint64_=
t error_code)
>      if (msr_ir) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HISI;
> @@ -702,15 +707,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
>      if (msr_dr) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HDSI;
> @@ -799,7 +796,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>              if (!(eaddr >> 63)) {
>                  raddr |=3D env->spr[SPR_HRMOR];
>              }
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -967,7 +964,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
>          } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
>              /* In HV mode, add HRMOR if top EA bit is clear */
>              return raddr | env->spr[SPR_HRMOR];
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -1056,8 +1053,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>      slb->sps =3D NULL;
>=20=20
>      /* Is VRMA enabled ? */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    if (!(lpcr & LPCR_VPM0)) {
> +    if (ppc_hash64_use_vrma(env)) {

Shouldn't this be !ppc_hash64_use_vrma(env)?

And a comment about the original code: all other places that check
LPCR_VPM0 do it after verifying that translation is off, except here
(ppc_hash64_update_vrma). Could that be an issue?

>          return;
>      }
>=20=20
> @@ -1065,6 +1061,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>       * Make one up. Mostly ignore the ESID which will not be needed
>       * for translation
>       */
> +    lpcr =3D env->spr[SPR_LPCR];
>      vsid =3D SLB_VSID_VRMA;
>      vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
>      vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);

