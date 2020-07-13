Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D3C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083262068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083262068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4BT-0006HZ-AN
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jv4AA-0005EC-Lu; Mon, 13 Jul 2020 15:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39934
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jv4A7-0007ey-L5; Mon, 13 Jul 2020 15:30:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06DJP9E5022591; Mon, 13 Jul 2020 15:30:43 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32771x9k5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 15:30:43 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DJOe7m007827;
 Mon, 13 Jul 2020 19:30:42 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 327ursbhkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 19:30:42 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06DJUfeS15598050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2020 19:30:41 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 568DD6E060;
 Mon, 13 Jul 2020 19:30:41 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DEAF6E052;
 Mon, 13 Jul 2020 19:30:40 +0000 (GMT)
Received: from [9.65.204.75] (unknown [9.65.204.75])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Jul 2020 19:30:39 +0000 (GMT)
From: Lijun Pan <ljp@linux.vnet.ibm.com>
Message-Id: <17011220-20C0-436C-8106-7398E76B479B@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2DF16364-2220-4877-82C1-577807A3016B"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] target/ppc: add vmsumudm vmsumcud instructions
Date: Mon, 13 Jul 2020 14:30:38 -0500
In-Reply-To: <20200706075320.GA5996@umbus.fritz.box>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200623042501.47065-1-ljp@linux.ibm.com>
 <20200706075320.GA5996@umbus.fritz.box>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-13_15:2020-07-13,
 2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=2 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130132
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:30:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_2DF16364-2220-4877-82C1-577807A3016B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Jul 6, 2020, at 2:53 AM, David Gibson <david@gibson.dropbear.id.au> =
wrote:
>=20
> On Mon, Jun 22, 2020 at 11:25:01PM -0500, Lijun Pan wrote:
>> vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword =
Modulo
>> VA-form.
>> vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out =
Unsigned
>> Doubleword VA-form.
>=20
> If this is only in ISA 3.1, shouldn't it be conditional on some
> instruction flag for that?

I will change to,

--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -276,6 +276,8 @@ GEN_VAFORM_PAIRED(vmsumuhm, vmsumuhs, 19),
GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20),
GEN_VAFORM_PAIRED(vsel, vperm, 21),
GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),
+GEN_HANDLER(vmsumcud, 0x4, 11, 0xFF, 0x00000000, PPC2_ISA310),


>=20
> SHould this maybe be integrated into your other series of ISA 3.1
> instructions.

I can do that.
I know some of the v4 patches of the ISA3.1 sereies are already =
accepted.
When I resend the v5 of that series, shall I include the already =
accepted one?
or just resend the not-accepted-yet patches.

>=20
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> v3: implement vmsumudm/vmsumcud through int128 functions,
>>    suggested by Richard Henderson.
>>=20
>> disas/ppc.c                         |  2 ++
>> target/ppc/helper.h                 |  4 ++-
>> target/ppc/int_helper.c             | 49 =
++++++++++++++++++++++++++++-
>> target/ppc/translate.c              |  1 -
>> target/ppc/translate/vmx-impl.inc.c | 39 ++++++++++++-----------
>> target/ppc/translate/vmx-ops.inc.c  |  2 ++
>> 6 files changed, 76 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/disas/ppc.c b/disas/ppc.c
>> index 63e97cfe1d..bd76fae4c4 100644
>> --- a/disas/ppc.c
>> +++ b/disas/ppc.c
>> @@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] =3D=
 {
>> { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, =
VA, VB, VC } },
>> { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> +{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,         { VD, VA, =
VB, VC } },
>> { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> +{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,         { VD, VA, =
VB, VC } },
>> { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index 2dfa1c6942..d540e8f30b 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -263,10 +263,12 @@ DEF_HELPER_3(vpkpx, void, avr, avr, avr)
>> DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)
>> +DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
>> DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
>> -DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
>> +DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)
>> +DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)
>> DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
>> DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
>> DEF_HELPER_3(lvebx, void, env, avr, tl)
>> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>> index be53cd6f68..37ea343cb3 100644
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -926,7 +926,8 @@ void helper_vmhraddshs(CPUPPCState *env, =
ppc_avr_t *r, ppc_avr_t *a,
>>     }
>> }
>>=20
>> -void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, =
ppc_avr_t *c)
>> +void helper_vmladduhm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
>> +                      ppc_avr_t *b, ppc_avr_t *c)
>> {
>>     int i;
>>=20
>> @@ -1064,6 +1065,52 @@ void helper_vmsumuhs(CPUPPCState *env, =
ppc_avr_t *r, ppc_avr_t *a,
>>     }
>> }
>>=20
>> +void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,
>> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
>> +{
>> +    Int128 sum;
>> +    uint64_t lo, hi;
>> +
>> +    sum =3D int128_make128(c->VsrD(1), c->VsrD(0));
>> +
>> +    mulu64(&lo, &hi, a->VsrD(0), b->VsrD(0));
>> +    sum =3D int128_add(sum, int128_make128(lo, hi));
>> +
>> +    mulu64(&lo, &hi, a->VsrD(1), b->VsrD(1));
>> +    sum =3D int128_add(sum, int128_make128(lo, hi));
>> +
>> +    r->VsrD(0) =3D int128_gethi(sum);
>> +    r->VsrD(1) =3D int128_getlo(sum);
>> +}
>> +
>> +void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,
>> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
>> +{
>> +    Int128 sum;
>> +    uint64_t p1lo, p1hi, p2lo, p2hi;
>> +
>> +    mulu64(&p1lo, &p1hi, a->VsrD(0), b->VsrD(0));
>> +    mulu64(&p2lo, &p2hi, a->VsrD(1), b->VsrD(1));
>> +
>> +    /* Sum lowest 64-bit elements.  */
>> +    sum =3D int128_make128(c->VsrD(1), 0);
>> +    sum =3D int128_add(sum, int128_make128(p1lo, 0));
>> +    sum =3D int128_add(sum, int128_make128(p2lo, 0));
>> +
>> +    /*
>> +     * Discard low 64-bits, leaving the carry into bit 64.
>> +     * Then sum the higher 64-bit elements.
>> +     */
>> +    sum =3D int128_rshift(sum, 64);
>> +    sum =3D int128_add(sum, int128_make128(c->VsrD(0), 0));
>> +    sum =3D int128_add(sum, int128_make128(p1hi, 0));
>> +    sum =3D int128_add(sum, int128_make128(p2hi, 0));
>> +
>> +    /* The result is only the carry into bits 64 & 65. */
>> +    r->VsrD(1) =3D int128_gethi(sum);
>> +    r->VsrD(0) =3D 0;
>> +}
>> +
>> #define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast) =
  \
>>     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)     =
  \
>>     {                                                                 =
  \
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 4ce3d664b5..35ff1aa77e 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -7281,7 +7281,6 @@ GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, =
PPC_ALTIVEC),
>> GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
>> GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
>> GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
>> -GEN_HANDLER(vmladduhm, 0x04, 0x11, 0xFF, 0x00000000, PPC_ALTIVEC),
>> #if defined(TARGET_PPC64)
>> GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
>>               PPC2_ISA300),
>> diff --git a/target/ppc/translate/vmx-impl.inc.c =
b/target/ppc/translate/vmx-impl.inc.c
>> index 403ed3a01c..520b49a773 100644
>> --- a/target/ppc/translate/vmx-impl.inc.c
>> +++ b/target/ppc/translate/vmx-impl.inc.c
>> @@ -1248,6 +1248,25 @@ static void gen_vsldoi(DisasContext *ctx)
>>     tcg_temp_free_i32(sh);
>> }
>>=20
>> +#define GEN_VAFORM(name, opc2)                                       =
   \
>> +static void glue(gen_, name)(DisasContext *ctx)                      =
   \
>> +{                                                                    =
   \
>> +    TCGv_ptr ra, rb, rc, rd;                                         =
   \
>> +    if (unlikely(!ctx->altivec_enabled)) {                           =
   \
>> +        gen_exception(ctx, POWERPC_EXCP_VPU);                        =
   \
>> +        return;                                                      =
   \
>> +    }                                                                =
   \
>> +    ra =3D gen_avr_ptr(rA(ctx->opcode));                             =
     \
>> +    rb =3D gen_avr_ptr(rB(ctx->opcode));                             =
     \
>> +    rc =3D gen_avr_ptr(rC(ctx->opcode));                             =
     \
>> +    rd =3D gen_avr_ptr(rD(ctx->opcode));                             =
     \
>> +    gen_helper_##name(cpu_env, rd, ra, rb, rc);                      =
   \
>> +    tcg_temp_free_ptr(ra);                                           =
   \
>> +    tcg_temp_free_ptr(rb);                                           =
   \
>> +    tcg_temp_free_ptr(rc);                                           =
   \
>> +    tcg_temp_free_ptr(rd);                                           =
   \
>> +}
>> +
>> #define GEN_VAFORM_PAIRED(name0, name1, opc2)                         =
  \
>> static void glue(gen_, name0##_##name1)(DisasContext *ctx)            =
  \
>>     {                                                                 =
  \
>> @@ -1272,24 +1291,8 @@ static void glue(gen_, =
name0##_##name1)(DisasContext *ctx)              \
>>     }
>>=20
>> GEN_VAFORM_PAIRED(vmhaddshs, vmhraddshs, 16)
>> -
>> -static void gen_vmladduhm(DisasContext *ctx)
>> -{
>> -    TCGv_ptr ra, rb, rc, rd;
>> -    if (unlikely(!ctx->altivec_enabled)) {
>> -        gen_exception(ctx, POWERPC_EXCP_VPU);
>> -        return;
>> -    }
>> -    ra =3D gen_avr_ptr(rA(ctx->opcode));
>> -    rb =3D gen_avr_ptr(rB(ctx->opcode));
>> -    rc =3D gen_avr_ptr(rC(ctx->opcode));
>> -    rd =3D gen_avr_ptr(rD(ctx->opcode));
>> -    gen_helper_vmladduhm(rd, ra, rb, rc);
>> -    tcg_temp_free_ptr(ra);
>> -    tcg_temp_free_ptr(rb);
>> -    tcg_temp_free_ptr(rc);
>> -    tcg_temp_free_ptr(rd);
>> -}
>> +GEN_VAFORM(vmsumcud, 11)
>> +GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17)
>>=20
>> static void gen_vpermr(DisasContext *ctx)
>> {
>> diff --git a/target/ppc/translate/vmx-ops.inc.c =
b/target/ppc/translate/vmx-ops.inc.c
>> index 84e05fb827..aee23e31c6 100644
>> --- a/target/ppc/translate/vmx-ops.inc.c
>> +++ b/target/ppc/translate/vmx-ops.inc.c
>> @@ -276,6 +276,8 @@ GEN_VAFORM_PAIRED(vmsumuhm, vmsumuhs, 19),
>> GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20),
>> GEN_VAFORM_PAIRED(vsel, vperm, 21),
>> GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),
>> +GEN_HANDLER(vmsumcud, 0x4, 11, 0xFF, 0x00000000, PPC_ALTIVEC),
>> +GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17),
>>=20
>> GEN_VXFORM_DUAL(vclzb, vpopcntb, 1, 28, PPC_NONE, PPC2_ALTIVEC_207),
>> GEN_VXFORM_DUAL(vclzh, vpopcnth, 1, 29, PPC_NONE, PPC2_ALTIVEC_207),
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my =
code
> david AT gibson.dropbear.id.au <http://gibson.dropbear.id.au/>	=
| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson <http://www.ozlabs.org/~dgibson>

--Apple-Mail=_2DF16364-2220-4877-82C1-577807A3016B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jul 6, 2020, at 2:53 AM, David Gibson &lt;<a =
href=3D"mailto:david@gibson.dropbear.id.au" =
class=3D"">david@gibson.dropbear.id.au</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">On Mon, Jun 22, 2020 at =
11:25:01PM -0500, Lijun Pan wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">vmsumudm (Power ISA 3.0) - Vector =
Multiply-Sum Unsigned Doubleword Modulo<br class=3D"">VA-form.<br =
class=3D"">vmsumcud (Power ISA 3.1) - Vector Multiply-Sum &amp; write =
Carry-out Unsigned<br class=3D"">Doubleword VA-form.<br =
class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">If this is only in ISA 3.1, shouldn't it be conditional on =
some</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">instruction =
flag for that?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div><br =
class=3D""></div><div>I will change to,</div><div><br =
class=3D""></div><div><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);" class=3D"">--- =
a/target/ppc/translate/vmx-ops.inc.c</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D""><span style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">+++ =
b/target/ppc/translate/vmx-ops.inc.c</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D""><span style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">@@ -276,6 +276,8 @@ =
GEN_VAFORM_PAIRED(vmsumuhm, vmsumuhs, 19),</span><br style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" =
class=3D"">GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20),</span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D""><span=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" =
class=3D"">GEN_VAFORM_PAIRED(vsel, vperm, 21),</span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D""><span=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" =
class=3D"">GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),</span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D""><span=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" =
class=3D"">+GEN_HANDLER(vmsumcud, 0x4, 11, 0xFF, 0x00000000, =
PPC2_ISA310),</span></div><div><br class=3D""></div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">SHould this maybe be integrated =
into your other series of ISA 3.1</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">instructions.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div><br =
class=3D""></div><div>I can do that.</div><div>I know some of the v4 =
patches of the ISA3.1 sereies are already accepted.</div><div>When I =
resend the v5 of that series, shall I include the already accepted =
one?</div><div>or just resend the not-accepted-yet patches.</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 14px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
class=3D"">Signed-off-by: Lijun Pan &lt;<a =
href=3D"mailto:ljp@linux.ibm.com" class=3D"">ljp@linux.ibm.com</a>&gt;<br =
class=3D"">---<br class=3D"">v3: implement vmsumudm/vmsumcud through =
int128 functions,<br class=3D"">&nbsp;&nbsp;&nbsp;suggested by Richard =
Henderson.<br class=3D""><br class=3D"">disas/ppc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;2 ++<br class=3D"">target/ppc/helper.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| &nbsp;4 ++-<br class=3D"">target/ppc/int_helper.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
49 ++++++++++++++++++++++++++++-<br class=3D"">target/ppc/translate.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;1 -<br class=3D"">target/ppc/translate/vmx-impl.inc.c | 39 =
++++++++++++-----------<br class=3D"">target/ppc/translate/vmx-ops.inc.c =
&nbsp;| &nbsp;2 ++<br class=3D"">6 files changed, 76 insertions(+), 21 =
deletions(-)<br class=3D""><br class=3D"">diff --git a/disas/ppc.c =
b/disas/ppc.c<br class=3D"">index 63e97cfe1d..bd76fae4c4 100644<br =
class=3D"">--- a/disas/ppc.c<br class=3D"">+++ b/disas/ppc.c<br =
class=3D"">@@ -2261,7 +2261,9 @@ const struct powerpc_opcode =
powerpc_opcodes[] =3D {<br class=3D"">{ "vmsumshs", &nbsp;VXA(4, =
&nbsp;41), VXA_MASK,<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PPCVEC,<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{ VD, VA, VB, VC } },<br class=3D"">{ "vmsumubm", =
&nbsp;VXA(4, &nbsp;36), VXA_MASK, &nbsp;&nbsp;PPCVEC,<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>{ VD, VA, =
VB, VC } },<br class=3D"">{ "vmsumuhm", &nbsp;VXA(4, &nbsp;38), =
VXA_MASK, &nbsp;&nbsp;PPCVEC,<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{ VD, VA, VB, VC } },<br =
class=3D"">+{ "vmsumudm", &nbsp;VXA(4, &nbsp;35), VXA_MASK, =
&nbsp;&nbsp;PPCVEC, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ =
VD, VA, VB, VC } },<br class=3D"">{ "vmsumuhs", &nbsp;VXA(4, &nbsp;39), =
VXA_MASK, &nbsp;&nbsp;PPCVEC,<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>{ VD, VA, VB, VC } },<br =
class=3D"">+{ "vmsumcud", &nbsp;VXA(4, &nbsp;23), VXA_MASK, =
&nbsp;&nbsp;PPCVEC, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ =
VD, VA, VB, VC } },<br class=3D"">{ "vmulesb", &nbsp;&nbsp;VX(4, =
&nbsp;776), VX_MASK,<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PPCVEC,<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{ VD, VA, VB } },<br class=3D"">{ "vmulesh", =
&nbsp;&nbsp;VX(4, &nbsp;840), VX_MASK,<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PPCVEC,<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>{ VD, VA, =
VB } },<br class=3D"">{ "vmuleub", &nbsp;&nbsp;VX(4, &nbsp;520), =
VX_MASK,<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>PPCVEC,<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>{ VD, VA, VB } },<br class=3D"">diff --git =
a/target/ppc/helper.h b/target/ppc/helper.h<br class=3D"">index =
2dfa1c6942..d540e8f30b 100644<br class=3D"">--- a/target/ppc/helper.h<br =
class=3D"">+++ b/target/ppc/helper.h<br class=3D"">@@ -263,10 +263,12 @@ =
DEF_HELPER_3(vpkpx, void, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)<br =
class=3D"">-DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)<br =
class=3D"">+DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)<br =
class=3D"">DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, =
i32)<br class=3D"">DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, =
env)<br class=3D"">DEF_HELPER_3(lvebx, void, env, avr, tl)<br =
class=3D"">diff --git a/target/ppc/int_helper.c =
b/target/ppc/int_helper.c<br class=3D"">index be53cd6f68..37ea343cb3 =
100644<br class=3D"">--- a/target/ppc/int_helper.c<br class=3D"">+++ =
b/target/ppc/int_helper.c<br class=3D"">@@ -926,7 +926,8 @@ void =
helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">}<br class=3D""><br =
class=3D"">-void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t =
*b, ppc_avr_t *c)<br class=3D"">+void helper_vmladduhm(CPUPPCState *env, =
ppc_avr_t *r, ppc_avr_t *a,<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_avr_t *b, =
ppc_avr_t *c)<br class=3D"">{<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;int =
i;<br class=3D""><br class=3D"">@@ -1064,6 +1065,52 @@ void =
helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">}<br class=3D""><br =
class=3D"">+void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_avr_t *a, ppc_avr_t =
*b, ppc_avr_t *c)<br class=3D"">+{<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;Int128 sum;<br class=3D"">+ &nbsp;&nbsp;&nbsp;uint64_t =
lo, hi;<br class=3D"">+<br class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D =
int128_make128(c-&gt;VsrD(1), c-&gt;VsrD(0));<br class=3D"">+<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;mulu64(&amp;lo, &amp;hi, a-&gt;VsrD(0), =
b-&gt;VsrD(0));<br class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D =
int128_add(sum, int128_make128(lo, hi));<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;mulu64(&amp;lo, &amp;hi, a-&gt;VsrD(1), =
b-&gt;VsrD(1));<br class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D =
int128_add(sum, int128_make128(lo, hi));<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;r-&gt;VsrD(0) =3D int128_gethi(sum);<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;r-&gt;VsrD(1) =3D int128_getlo(sum);<br class=3D"">+}<br=
 class=3D"">+<br class=3D"">+void helper_vmsumcud(CPUPPCState *env, =
ppc_avr_t *r,<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_avr_t *a, ppc_avr_t =
*b, ppc_avr_t *c)<br class=3D"">+{<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;Int128 sum;<br class=3D"">+ &nbsp;&nbsp;&nbsp;uint64_t =
p1lo, p1hi, p2lo, p2hi;<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;mulu64(&amp;p1lo, &amp;p1hi, a-&gt;VsrD(0), =
b-&gt;VsrD(0));<br class=3D"">+ &nbsp;&nbsp;&nbsp;mulu64(&amp;p2lo, =
&amp;p2hi, a-&gt;VsrD(1), b-&gt;VsrD(1));<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;/* Sum lowest 64-bit elements. &nbsp;*/<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;sum =3D int128_make128(c-&gt;VsrD(1), 0);<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D int128_add(sum, =
int128_make128(p1lo, 0));<br class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D =
int128_add(sum, int128_make128(p2lo, 0));<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;/*<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;* Discard =
low 64-bits, leaving the carry into bit 64.<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Then sum the higher 64-bit elements.<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;sum =3D int128_rshift(sum, 64);<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;sum =3D int128_add(sum, int128_make128(c-&gt;VsrD(0), =
0));<br class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D int128_add(sum, =
int128_make128(p1hi, 0));<br class=3D"">+ &nbsp;&nbsp;&nbsp;sum =3D =
int128_add(sum, int128_make128(p2hi, 0));<br class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;/* The result is only the carry into bits 64 &amp; 65. =
*/<br class=3D"">+ &nbsp;&nbsp;&nbsp;r-&gt;VsrD(1) =3D =
int128_gethi(sum);<br class=3D"">+ &nbsp;&nbsp;&nbsp;r-&gt;VsrD(0) =3D =
0;<br class=3D"">+}<br class=3D"">+<br class=3D"">#define =
VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast) =
&nbsp;&nbsp;\<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;void =
helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;{ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">diff --git =
a/target/ppc/translate.c b/target/ppc/translate.c<br class=3D"">index =
4ce3d664b5..35ff1aa77e 100644<br class=3D"">--- =
a/target/ppc/translate.c<br class=3D"">+++ b/target/ppc/translate.c<br =
class=3D"">@@ -7281,7 +7281,6 @@ GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, =
0x00000001, PPC_ALTIVEC),<br class=3D"">GEN_HANDLER(lvsr, 0x1f, 0x06, =
0x01, 0x00000001, PPC_ALTIVEC),<br class=3D"">GEN_HANDLER(mfvscr, 0x04, =
0x2, 0x18, 0x001ff800, PPC_ALTIVEC),<br class=3D"">GEN_HANDLER(mtvscr, =
0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),<br =
class=3D"">-GEN_HANDLER(vmladduhm, 0x04, 0x11, 0xFF, 0x00000000, =
PPC_ALTIVEC),<br class=3D"">#if defined(TARGET_PPC64)<br =
class=3D"">GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, =
PPC_NONE,<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;PPC2_ISA300),<br class=3D"">diff --git =
a/target/ppc/translate/vmx-impl.inc.c =
b/target/ppc/translate/vmx-impl.inc.c<br class=3D"">index =
403ed3a01c..520b49a773 100644<br class=3D"">--- =
a/target/ppc/translate/vmx-impl.inc.c<br class=3D"">+++ =
b/target/ppc/translate/vmx-impl.inc.c<br class=3D"">@@ -1248,6 +1248,25 =
@@ static void gen_vsldoi(DisasContext *ctx)<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;tcg_temp_free_i32(sh);<br =
class=3D"">}<br class=3D""><br class=3D"">+#define GEN_VAFORM(name, =
opc2) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+static void glue(gen_, =
name)(DisasContext *ctx) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br=
 class=3D"">+{ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;TCGv_ptr ra, rb, rc, rd; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;if (unlikely(!ctx-&gt;altivec_enabled)) { =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gen_exception(ctx, =
POWERPC_EXCP_VPU); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;} =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ &nbsp;&nbsp;&nbsp;ra =3D =
gen_avr_ptr(rA(ctx-&gt;opcode)); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;rb =3D gen_avr_ptr(rB(ctx-&gt;opcode)); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;rc =3D gen_avr_ptr(rC(ctx-&gt;opcode)); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;rd =3D gen_avr_ptr(rD(ctx-&gt;opcode)); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;gen_helper_##name(cpu_env, rd, ra, rb, rc); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br=
 class=3D"">+ &nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(ra); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(rb); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(rc); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(rd); =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">+}<br =
class=3D"">+<br class=3D"">#define GEN_VAFORM_PAIRED(name0, name1, opc2) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;\<br class=3D"">static void glue(gen_, =
name0##_##name1)(DisasContext *ctx) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;{ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">@@ -1272,24 +1291,8 @@ static =
void glue(gen_, name0##_##name1)(DisasContext *ctx) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D""><br =
class=3D"">GEN_VAFORM_PAIRED(vmhaddshs, vmhraddshs, 16)<br class=3D"">-<br=
 class=3D"">-static void gen_vmladduhm(DisasContext *ctx)<br =
class=3D"">-{<br class=3D"">- &nbsp;&nbsp;&nbsp;TCGv_ptr ra, rb, rc, =
rd;<br class=3D"">- &nbsp;&nbsp;&nbsp;if =
(unlikely(!ctx-&gt;altivec_enabled)) {<br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gen_exception(ctx, =
POWERPC_EXCP_VPU);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br class=3D"">- =
&nbsp;&nbsp;&nbsp;}<br class=3D"">- &nbsp;&nbsp;&nbsp;ra =3D =
gen_avr_ptr(rA(ctx-&gt;opcode));<br class=3D"">- &nbsp;&nbsp;&nbsp;rb =3D =
gen_avr_ptr(rB(ctx-&gt;opcode));<br class=3D"">- &nbsp;&nbsp;&nbsp;rc =3D =
gen_avr_ptr(rC(ctx-&gt;opcode));<br class=3D"">- &nbsp;&nbsp;&nbsp;rd =3D =
gen_avr_ptr(rD(ctx-&gt;opcode));<br class=3D"">- =
&nbsp;&nbsp;&nbsp;gen_helper_vmladduhm(rd, ra, rb, rc);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(ra);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(rb);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(rc);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;tcg_temp_free_ptr(rd);<br class=3D"">-}<br =
class=3D"">+GEN_VAFORM(vmsumcud, 11)<br =
class=3D"">+GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17)<br class=3D""><br =
class=3D"">static void gen_vpermr(DisasContext *ctx)<br class=3D"">{<br =
class=3D"">diff --git a/target/ppc/translate/vmx-ops.inc.c =
b/target/ppc/translate/vmx-ops.inc.c<br class=3D"">index =
84e05fb827..aee23e31c6 100644<br class=3D"">--- =
a/target/ppc/translate/vmx-ops.inc.c<br class=3D"">+++ =
b/target/ppc/translate/vmx-ops.inc.c<br class=3D"">@@ -276,6 +276,8 @@ =
GEN_VAFORM_PAIRED(vmsumuhm, vmsumuhs, 19),<br =
class=3D"">GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20),<br =
class=3D"">GEN_VAFORM_PAIRED(vsel, vperm, 21),<br =
class=3D"">GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),<br =
class=3D"">+GEN_HANDLER(vmsumcud, 0x4, 11, 0xFF, 0x00000000, =
PPC_ALTIVEC),<br class=3D"">+GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, =
17),<br class=3D""><br class=3D"">GEN_VXFORM_DUAL(vclzb, vpopcntb, 1, =
28, PPC_NONE, PPC2_ALTIVEC_207),<br class=3D"">GEN_VXFORM_DUAL(vclzh, =
vpopcnth, 1, 29, PPC_NONE, PPC2_ALTIVEC_207),<br =
class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span></span><br=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">David Gibson</span><span =
class=3D"Apple-tab-span" style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">	</span><span class=3D"Apple-tab-span" style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: pre; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">	</span><span class=3D"Apple-tab-span" =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">	=
</span><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 14px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">| I'll have =
my music baroque, and my code</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">david AT<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"http://gibson.dropbear.id.au/" style=3D"font-family: Helvetica; =
font-size: 14px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">gibson.dropbear.id.au</a><span=
 class=3D"Apple-tab-span" style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">	</span><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">| minimalist, =
thank you. &nbsp;NOT _the_ _other_</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">	=
</span><span class=3D"Apple-tab-span" style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
pre; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">	</span><span class=3D"Apple-tab-span" style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 14px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: pre; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">	</span><span class=3D"Apple-tab-span" =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
14px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">	=
</span><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 14px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">| _way_ =
_around_!</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 14px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><a href=3D"http://www.ozlabs.org/~dgibson" =
style=3D"font-family: Helvetica; font-size: 14px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">http://www.ozlabs.org/~dgibson</a></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_2DF16364-2220-4877-82C1-577807A3016B--


