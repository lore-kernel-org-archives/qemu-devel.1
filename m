Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894FDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D2520714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D2520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwrE-0001cs-Kv
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jkw8M-0000kJ-6Q; Mon, 15 Jun 2020 16:55:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jkw8J-0002Yb-M0; Mon, 15 Jun 2020 16:55:09 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FKXSl9029822; Mon, 15 Jun 2020 16:53:20 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31p5euut6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 16:53:20 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FKnrRt010749;
 Mon, 15 Jun 2020 20:53:19 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03wdc.us.ibm.com with ESMTP id 31ngqtyn9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 20:53:19 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FKrGSY23593298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 20:53:16 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 651DA136051;
 Mon, 15 Jun 2020 20:53:18 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A946313604F;
 Mon, 15 Jun 2020 20:53:17 +0000 (GMT)
Received: from [9.160.92.109] (unknown [9.160.92.109])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Jun 2020 20:53:17 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] target/ppc: add vmsumudm vmsumcud instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <4f0e24af-5043-98d3-0f7b-e8d460bac617@linaro.org>
Date: Mon, 15 Jun 2020 15:53:16 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <73404995-1D90-4E2B-A328-CA5C47C933D5@linux.vnet.ibm.com>
References: <20200613035546.22041-1-ljp@linux.ibm.com>
 <4f0e24af-5043-98d3-0f7b-e8d460bac617@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_03:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150111
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:53:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2020 17:16:13 -0400
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



> On Jun 15, 2020, at 11:12 AM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/12/20 8:55 PM, Lijun Pan wrote:
>> vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword =
Modulo
>> VA-form.
>> vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out =
Unsigned
>> Doubleword VA-form.
>>=20
>> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
>> ---
>> v2: move vmsumcudm() to qemu/int128.h as Richard Henderson suggested,
>>    also rename addu128() to uint128_add() and include it in =
qemu/int128.h
>>=20
>> disas/ppc.c                         |  2 +
>> include/qemu/int128.h               | 97 =
+++++++++++++++++++++++++++++
>> target/ppc/helper.h                 |  4 +-
>> target/ppc/int_helper.c             | 19 +++++-
>> target/ppc/translate.c              |  1 -
>> target/ppc/translate/vmx-impl.inc.c | 39 ++++++------
>> target/ppc/translate/vmx-ops.inc.c  |  2 +
>> 7 files changed, 143 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/disas/ppc.c b/disas/ppc.c
>> index 63e97cfe1d..3ed4d23ed3 100644
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
>> +{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> +{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,		{ VD, =
VA, VB, VC } },
>> { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } =
},
>> diff --git a/include/qemu/int128.h b/include/qemu/int128.h
>> index 5c9890db8b..3362973cc5 100644
>> --- a/include/qemu/int128.h
>> +++ b/include/qemu/int128.h
>> @@ -3,6 +3,7 @@
>>=20
>> #ifdef CONFIG_INT128
>> #include "qemu/bswap.h"
>> +#include "qemu/host-utils.h"
>>=20
>> typedef __int128_t Int128;
>>=20
>> @@ -143,6 +144,55 @@ static inline Int128 bswap128(Int128 a)
>>     return int128_make128(bswap64(int128_gethi(a)), =
bswap64(int128_getlo(a)));
>> }
>>=20
>> +/**
>> + * uint128_add - add two 128-bit values (r=3Da+b, ca=3Dcarry-out)
>> + * @ah: high 64 bits of a
>> + * @al: low 64 bits of a
>> + * @bh: high 64 bits of b
>> + * @bl: low 64 bits of b
>> + * @rh: high 64 bits of r to be returned
>> + * @rl: low 64 bits of r to be returned
>> + * @ca: carry out to be returned.
>> + */
>> +static inline void uint128_add(uint64_t ah, uint64_t al, uint64_t =
bh,
>> +		uint64_t bl, uint64_t *rh, uint64_t *rl, uint64_t *ca)
>> +{
>> +	__uint128_t a =3D (__uint128_t)ah << 64 | (__uint128_t)al;
>> +	__uint128_t b =3D (__uint128_t)bh << 64 | (__uint128_t)bl;
>> +	__uint128_t r =3D a + b;
>> +
>> +	*rh =3D (uint64_t)(r >> 64);
>> +	*rl =3D (uint64_t)r;
>> +	*ca =3D (~a < b);
>> +}
>=20
> This is *not* what I had in mind at all.
>=20
> int128.h should be operating on Int128, and *not* component uint64_t =
values.

Should uint128_add() be included in a new file called uint128.h? or =
still at host-utils.h?

>=20
>=20
>> +
>> +/**
>> + * mulsum - (rh, rl) =3D ah*bh + al*bl + (ch, cl)
>> + * @ah: high 64 bits of a
>> + * @al: low 64 bits of a
>> + * @bh: high 64 bits of b
>> + * @bl: low 64 bits of b
>> + * @ch: high 64 bits of c
>> + * @cl: low 64 bits of c
>> + * @rh: high 64 bits of r to be returned
>> + * @rl: low 64 bits of r to be returned
>> + * @ca: carry-out to be returned.
>> + */
>> +static inline void mulsum(uint64_t ah, uint64_t al, uint64_t bh,
>> +		uint64_t bl, uint64_t ch, uint64_t cl, uint64_t *rh,
>> +		uint64_t *rl, uint64_t *ca)
>> +{
>> +	__uint128_t prod1, prod2, r;
>> +	__uint128_t c =3D (__uint128_t)ch << 64 | (__uint128_t)cl;
>> +
>> +	prod1 =3D (__uint128_t)ah * (__uint128_t)bh;
>> +	prod2 =3D (__uint128_t)al * (__uint128_t)bl;
>> +	r =3D prod1 + prod2 + c;
>> +	*rh =3D (uint64_t)(r >> 64);
>> +	*rl =3D (uint64_t)r;
>> +	*ca =3D (~prod1 < prod2) + (~c < (prod1 + prod2));
>> +}
>=20
> Why is mulsum an interesting primitive for int128.h?
> I would think int128_mul and int128_add sufficient here.

But prod1, prod2, r are unsigned 128-bit values. Changing above code to =
the following
implementation doesn=E2=80=99t seem right.
prod1 =3D int128_mul((__uint128_t)ah, (__uint128_t)bh);
prod2 =3D int128_mul((__uint128_t)al * (__uint128_t)bl);
r =3D int128_add(prod1, prod2);
r =3D int128_add(r,  c);

Maybe you mean using uint128_mul & uint128_add?

>=20
> I did not ask you to place the entire ppc instruction in int128.h.

vmsumudm/vmsumcud operate as follows:
1. 128-bit prod1 =3D (high 64 bits of a) * (high 64 bits of b), // I =
reuse mulu64()
2. 128-bit prod2 =3D (high 64 bits of b) * (high 64 bits of b), // I =
reuse mulu64()
3. 128-bit result =3D prod1 + prod2 + c; // I added addu128() in v1, =
renamed it to uint128_add() in v2
vmsumudm takes the result,
vmsumcud takes the carry-out

v1 patch adds addu128() in host-utils.h and reuse the mulu64() from =
host-utils.h.

To better understand your request, may I ask you several questions:
1. keep mulsum() in target/ppc/int_helper.c?
If so, it will inevitably have  #ifdef CONFIG_INT128 #else #endif in =
that function. =20
2. still add addu128()/uint128_add() in host-utils.h?
3. Do you want int128_mul() to replace mulu64()?
4. Do you want int128_add() to relace uint128_add()?
5. If I add int128_mul and int128_add, shouldn=E2=80=99t I also add =
uint128_mul and uint128_add?=20
should I also create uint128.h to include uint128_add & uint128_mul?

Thanks,
Lijun


