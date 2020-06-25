Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0688820768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0688820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joZCb-0002zl-AJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 17:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZBY-0001jF-KK; Thu, 25 Jun 2020 17:13:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZBW-0007Za-Va; Thu, 25 Jun 2020 17:13:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PL3FhA171365; Thu, 25 Jun 2020 17:13:21 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vx91a4av-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:13:21 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PL5fXg024586;
 Thu, 25 Jun 2020 21:13:20 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 31uurqavcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 21:13:20 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PLDG6r30605750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 21:13:16 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1607B6E04C;
 Thu, 25 Jun 2020 21:13:19 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AC826E053;
 Thu, 25 Jun 2020 21:13:18 +0000 (GMT)
Received: from [9.160.117.167] (unknown [9.160.117.167])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2020 21:13:17 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 2/8] target/ppc: add byte-reverse br[dwh] instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <199eadcf-9d05-ce25-8b7a-6a0e1a01c1a1@linaro.org>
Date: Thu, 25 Jun 2020 16:13:17 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <C02EC1A9-FC40-4B03-A8AD-ADC42CF9EFE3@linux.vnet.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-3-ljp@linux.ibm.com>
 <199eadcf-9d05-ce25-8b7a-6a0e1a01c1a1@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_16:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=2
 lowpriorityscore=0 mlxlogscore=722 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250124
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 17:13:06
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 25, 2020, at 12:42 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/25/20 10:00 AM, Lijun Pan wrote:
>> +static void gen_brh(DisasContext *ctx)
>> +{
>> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
>> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
>> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
>> +
>> +    tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
>> +    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
>> +    tcg_gen_and_i64(t2, t1, t0);
>> +    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
>> +    tcg_gen_shli_i64(t1, t1, 8);
>> +    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
>> +
>> +    tcg_temp_free_i64(t0);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +}
>> +
>> static opcode_t opcodes[] =3D {
>> +#if defined(TARGET_PPC64)
>> +GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, =
PPC2_ISA310),
>> +GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, =
PPC2_ISA310),
>> +GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, =
PPC2_ISA310),
>> +#endif
>=20
> No.  You haven't even tested this -- it doesn't compile.
>=20
>>  CC      ppc-softmmu/target/ppc/translate.o
>> /home/rth/qemu/qemu/target/ppc/translate.c: In function =
=E2=80=98gen_brd=E2=80=99:
>> /home/rth/qemu/qemu/target/ppc/translate.c:6980:32: error: passing =
argument 1 of =E2=80=98tcg_gen_bswap64_i64=E2=80=99 from incompatible =
pointer type [-Werror=3Dincompatible-pointer-types]
>> 6980 |     tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], =
cpu_gpr[rS(ctx->opcode)]);
>>      |                         ~~~~~~~^~~~~~~~~~~~~~~~~
>>      |                                |
>>      |                                TCGv_i32 {aka struct TCGv_i32_d =
*}
>> In file included from /home/rth/qemu/qemu/target/ppc/translate.c:26:
>> /home/rth/qemu/qemu/include/tcg/tcg-op.h:533:35: note: expected =
=E2=80=98TCGv_i64=E2=80=99 {aka =E2=80=98struct TCGv_i64_d *=E2=80=99} =
but argument is of type =E2=80=98TCGv_i32=E2=80=99 {aka =E2=80=98struct =
TCGv_i32_d *=E2=80=99}
>>  533 | void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
>>      |                          ~~~~~~~~~^~~
>> /home/rth/qemu/qemu/target/ppc/translate.c:6980:58: error: passing =
argument 2 of =E2=80=98tcg_gen_bswap64_i64=E2=80=99 from incompatible =
pointer type [-Werror=3Dincompatible-pointer-types]
>> 6980 |     tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], =
cpu_gpr[rS(ctx->opcode)]);
>>      |                                                   =
~~~~~~~^~~~~~~~~~~~~~~~~
>>      |                                                          |
>>      |                                                          =
TCGv_i32 {aka struct TCGv_i32_d *}
>=20
> and so forth.
>=20
> I warned you before about this.  Why are you still building only a =
restricted
> set of targets?
>=20

I will configure all the target-list, and add "#if =
defined(TARGET_PPC64)" for all gen_brd/w/h().

Lijun


