Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E552068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E552068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4Lx-0004Xf-I0
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jv4Ji-0001ZV-VI; Mon, 13 Jul 2020 15:40:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jv4Jf-0001dw-GQ; Mon, 13 Jul 2020 15:40:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06DJPB4I183250; Mon, 13 Jul 2020 15:40:39 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3279aafeak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 15:40:39 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DJdqHn007751;
 Mon, 13 Jul 2020 19:40:38 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 327528q4hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 19:40:38 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06DJebbm47972626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2020 19:40:37 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11DD86E050;
 Mon, 13 Jul 2020 19:40:37 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53A086E056;
 Mon, 13 Jul 2020 19:40:36 +0000 (GMT)
Received: from [9.65.204.75] (unknown [9.65.204.75])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Jul 2020 19:40:36 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 07/11] target/ppc: add vmulld to INDEX_op_mul_vec case
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <20200701234344.91843-8-ljp@linux.ibm.com>
Date: Mon, 13 Jul 2020 14:40:35 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <A08A6E75-BEE1-4002-8270-6EE75D930F2F@linux.vnet.ibm.com>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-8-ljp@linux.ibm.com>
To: Lijun Pan <ljp@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-13_16:2020-07-13,
 2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130136
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:30:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 1, 2020, at 6:43 PM, Lijun Pan <ljp@linux.ibm.com> wrote:
>=20
> Group vmuluwm and vmulld. Make vmulld-specific
> changes since it belongs to new ISA 3.1.
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v4: add missing changes, and split to 5/11, 6/11, 7/11
> v3: use tcg_gen_gvec_mul()
> v2: fix coding style
>    use Power ISA 3.1 flag
>=20

Richard,
Do you have any opinion on this one?
Thanks,
Lijun


> tcg/ppc/tcg-target.h     |  2 ++
> tcg/ppc/tcg-target.inc.c | 12 ++++++++++--
> 2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index 4fa21f0e71..ff1249ef8e 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -63,6 +63,7 @@ typedef enum {
>     tcg_isa_2_06,
>     tcg_isa_2_07,
>     tcg_isa_3_00,
> +    tcg_isa_3_10,
> } TCGPowerISA;
>=20
> extern TCGPowerISA have_isa;
> @@ -72,6 +73,7 @@ extern bool have_vsx;
> #define have_isa_2_06  (have_isa >=3D tcg_isa_2_06)
> #define have_isa_2_07  (have_isa >=3D tcg_isa_2_07)
> #define have_isa_3_00  (have_isa >=3D tcg_isa_3_00)
> +#define have_isa_3_10  (have_isa >=3D tcg_isa_3_10)
>=20
> /* optional instructions automatically implemented */
> #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index ee1f9227c1..caa8985b46 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -564,6 +564,7 @@ static int tcg_target_const_match(tcg_target_long =
val, TCGType type,
> #define VMULOUH    VX4(72)
> #define VMULOUW    VX4(136)       /* v2.07 */
> #define VMULUWM    VX4(137)       /* v2.07 */
> +#define VMULLD     VX4(457)       /* v3.10 */
> #define VMSUMUHM   VX4(38)
>=20
> #define VMRGHB     VX4(12)
> @@ -3015,6 +3016,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType =
type, unsigned vece)
>             return -1;
>         case MO_32:
>             return have_isa_2_07 ? 1 : -1;
> +        case MO_64:
> +            return have_isa_3_10;
>         }
>         return 0;
>     case INDEX_op_bitsel_vec:
> @@ -3149,6 +3152,7 @@ static void tcg_out_vec_op(TCGContext *s, =
TCGOpcode opc,
>     static const uint32_t
>         add_op[4] =3D { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
>         sub_op[4] =3D { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
> +        mul_op[4] =3D { 0, 0, VMULUWM, VMULLD },
>         neg_op[4] =3D { 0, 0, VNEGW, VNEGD },
>         eq_op[4]  =3D { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
>         ne_op[4]  =3D { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
> @@ -3199,8 +3203,7 @@ static void tcg_out_vec_op(TCGContext *s, =
TCGOpcode opc,
>         a1 =3D 0;
>         break;
>     case INDEX_op_mul_vec:
> -        tcg_debug_assert(vece =3D=3D MO_32 && have_isa_2_07);
> -        insn =3D VMULUWM;
> +        insn =3D mul_op[vece];
>         break;
>     case INDEX_op_ssadd_vec:
>         insn =3D ssadd_op[vece];
> @@ -3709,6 +3712,11 @@ static void tcg_target_init(TCGContext *s)
>         have_isa =3D tcg_isa_3_00;
>     }
> #endif
> +#ifdef PPC_FEATURE2_ARCH_3_10
> +    if (hwcap2 & PPC_FEATURE2_ARCH_3_10) {
> +        have_isa =3D tcg_isa_3_10;
> +    }
> +#endif
>=20
> #ifdef PPC_FEATURE2_HAS_ISEL
>     /* Prefer explicit instruction from the kernel. */
> --=20
> 2.23.0
>=20
>=20


