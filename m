Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0A020732
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0A020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm9WM-0003iM-Tu
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 01:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9Vk-0003D2-O7; Fri, 19 Jun 2020 01:24:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9Vi-00083f-Pl; Fri, 19 Jun 2020 01:24:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J53xY0181499; Fri, 19 Jun 2020 01:24:15 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rhrsf3hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 01:24:15 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J5Jr4e004655;
 Fri, 19 Jun 2020 05:24:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma05wdc.us.ibm.com with ESMTP id 31qu27tket-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 05:24:14 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05J5OCAl10289866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 05:24:12 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F58B6A04F;
 Fri, 19 Jun 2020 05:24:13 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C97376A04D;
 Fri, 19 Jun 2020 05:24:12 +0000 (GMT)
Received: from [9.160.87.86] (unknown [9.160.87.86])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jun 2020 05:24:12 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/6] target/ppc: add byte-reverse br[dwh] instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <e28b81dd-96ab-78ab-52d1-d751dd38315f@linaro.org>
Date: Fri, 19 Jun 2020 00:24:11 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <311E28F8-05EE-4530-9C5E-3DE6034AEF09@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-2-ljp@linux.ibm.com>
 <e28b81dd-96ab-78ab-52d1-d751dd38315f@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_01:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190034
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:10:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 18, 2020, at 6:19 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/12/20 9:20 PM, Lijun Pan wrote:
>> POWER ISA 3.1 introduces following byte-reverse instructions:
>> brd: Byte-Reverse Doubleword X-form
>> brw: Byte-Reverse Word X-form
>> brh: Byte-Reverse Halfword X-form
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> target/ppc/translate.c | 62 =
++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 62 insertions(+)
>>=20
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 4ce3d664b5..2d48fbc8db 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -6971,7 +6971,69 @@ static void gen_dform3D(DisasContext *ctx)
>>     return gen_invalid(ctx);
>> }
>>=20
>> +/* brd */
>> +static void gen_brd(DisasContext *ctx)
>> +{
>> +	TCGv_i64 temp =3D tcg_temp_new_i64();
>> +
>> +	tcg_gen_bswap64_i64(temp, cpu_gpr[rS(ctx->opcode)]);
>> +	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, =
gpr[rA(ctx->opcode)]));
>=20
>=20
> The store is wrong.  You cannot modify storage behind a tcg global =
variable
> like that.  This should just be
>=20
>    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)],
>                        cpu_gpr[rS(ctx->opcode)]);

Why can=E2=80=99t I retrieve the offset via =E2=80=9Coffsetof(CPUPPCState,=
 gpr[rA(ctx->opcode)])=E2=80=9D?
I would like to learn more.

> Is this code is within an ifdef for TARGET_PPC64?

I will change it to=20
+#if defined(TARGET_PPC64)
+GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, =
PPC2_ISA300),
+GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, =
PPC2_ISA300),
+GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, =
PPC2_ISA300),
+#endif

> If not, then this will break the 32-bit qemu-system-ppc build.
> Are you sure you have built and tested all configurations?
>=20
>=20
>> +/* brw */
>> +static void gen_brw(DisasContext *ctx)
>> +{
>> +	TCGv_i64 temp =3D tcg_temp_new_i64();
>> +	TCGv_i64 lsb =3D tcg_temp_new_i64();
>> +	TCGv_i64 msb =3D tcg_temp_new_i64();
>> +
>> +	tcg_gen_movi_i64(lsb, 0x00000000ffffffffull);
>> +	tcg_gen_and_i64(temp, lsb, cpu_gpr[rS(ctx->opcode)]);
>> +	tcg_gen_bswap32_i64(lsb, temp);
>> +=09
>> +	tcg_gen_shri_i64(msb, cpu_gpr[rS(ctx->opcode)], 32);
>> +	tcg_gen_bswap32_i64(temp, msb);
>> +	tcg_gen_shli_i64(msb, temp, 32);
>> +=09
>> +	tcg_gen_or_i64(temp, lsb, msb);
>> +
>> +	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, =
gpr[rA(ctx->opcode)]));
>=20
> Again, the store is wrong.
>=20
> In addition, this can be computed as
>=20
>    tcg_gen_bswap64_i64(dest, source);
>    tcg_gen_rotli_i64(dest, dest, 32);
>=20
>> +static void gen_brh(DisasContext *ctx)
>> +{
>> +	TCGv_i64 temp =3D tcg_temp_new_i64();
>> +	TCGv_i64 t0 =3D tcg_temp_new_i64();
>> +	TCGv_i64 t1 =3D tcg_temp_new_i64();
>> +	TCGv_i64 t2 =3D tcg_temp_new_i64();
>> +	TCGv_i64 t3 =3D tcg_temp_new_i64();
>> +
>> +	tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
>> +	tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
>> +	tcg_gen_and_i64(t2, t1, t0);
>> +	tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
>> +	tcg_gen_shli_i64(t1, t1, 8);
>> +	tcg_gen_or_i64(temp, t1, t2);
>> +	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, =
gpr[rA(ctx->opcode)]));
>=20
> Again, the store is wrong.
>=20
>=20
> r~
>=20


