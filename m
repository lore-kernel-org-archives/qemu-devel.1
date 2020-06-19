Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61FA206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61FA206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm9In-0005jq-RX
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 01:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9I8-0004Vw-9k; Fri, 19 Jun 2020 01:10:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9I6-000677-84; Fri, 19 Jun 2020 01:10:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J52TwH140650; Fri, 19 Jun 2020 01:10:10 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rkgjcjtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 01:10:10 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J59XKP014692;
 Fri, 19 Jun 2020 05:10:09 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01wdc.us.ibm.com with ESMTP id 31q6bdh41t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 05:10:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05J5A8JM59048400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 05:10:08 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AE3113605D;
 Fri, 19 Jun 2020 05:10:08 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D4DA136059;
 Fri, 19 Jun 2020 05:10:07 +0000 (GMT)
Received: from [9.160.87.86] (unknown [9.160.87.86])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jun 2020 05:10:07 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] target/ppc: add vmsumudm vmsumcud instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <13dac383-7d04-faf2-7a87-c4e92e693148@linaro.org>
Date: Fri, 19 Jun 2020 00:10:06 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <772D8DFD-8784-435A-AB9B-E0A78B12A7E4@linux.vnet.ibm.com>
References: <20200613035546.22041-1-ljp@linux.ibm.com>
 <4f0e24af-5043-98d3-0f7b-e8d460bac617@linaro.org>
 <73404995-1D90-4E2B-A328-CA5C47C933D5@linux.vnet.ibm.com>
 <13dac383-7d04-faf2-7a87-c4e92e693148@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_01:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=815
 impostorscore=0 phishscore=0 cotscore=-2147483648 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190029
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:10:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 18, 2020, at 6:09 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/15/20 1:53 PM, Lijun Pan wrote:
>>>> +static inline void uint128_add(uint64_t ah, uint64_t al, uint64_t =
bh,
>>>> +		uint64_t bl, uint64_t *rh, uint64_t *rl, uint64_t *ca)
>>>> +{
>>>> +	__uint128_t a =3D (__uint128_t)ah << 64 | (__uint128_t)al;
>>>> +	__uint128_t b =3D (__uint128_t)bh << 64 | (__uint128_t)bl;
>>>> +	__uint128_t r =3D a + b;
>>>> +
>>>> +	*rh =3D (uint64_t)(r >> 64);
>>>> +	*rl =3D (uint64_t)r;
>>>> +	*ca =3D (~a < b);
>>>> +}
>>>=20
>>> This is *not* what I had in mind at all.
>>>=20
>>> int128.h should be operating on Int128, and *not* component uint64_t =
values.
>>=20
>> Should uint128_add() be included in a new file called uint128.h? or =
still at host-utils.h?
>=20
> If you want this sort of specific operation, you should leave it in =
target/ppc/.
>=20
> I had been hoping that you could make use of Int128 as-is, or with =
minimal
> adjustment in the same style.
>=20
>> vmsumudm/vmsumcud operate as follows:
>> 1. 128-bit prod1 =3D (high 64 bits of a) * (high 64 bits of b), // I =
reuse mulu64()

This is an implementation not relying on 128 bit compiler support (not =
defined CONFIG_INT128),=20
hence using mulu64().

>> 2. 128-bit prod2 =3D (high 64 bits of b) * (high 64 bits of b), // I =
reuse mulu64()
>> 3. 128-bit result =3D prod1 + prod2 + c; // I added addu128() in v1, =
renamed it to uint128_add() in v2
>=20
> Really?  That seems a very odd computation.  Your code,
>=20
>> +	prod1 =3D (__uint128_t)ah * (__uint128_t)bh;
>> +	prod2 =3D (__uint128_t)al * (__uint128_t)bl;
>> +	r =3D prod1 + prod2 + c;
>=20
> is slightly different, but still very odd.

Above 3 lines of code are using 128 bit compiler suppor (#ifdef =
CONFIG_INT128).=20

>=20
> Why would we be adding the intermediate 128th bit of the 256-bit =
product
> (prod1, bit 0) with the 0th bit of the 256-bit product (prod2, bit 0).
>=20
> Unfortunately, I can't find the v3.1 spec online yet, so I can't look =
at this
> myself.  What is the instruction supposed to produce?

https://ibm.ent.box.com/s/hhjfw0x0lrbtyzmiaffnbxh2fuo0fog0

>=20
>> To better understand your request, may I ask you several questions:
>> 1. keep mulsum() in target/ppc/int_helper.c?
>=20
> Probably.
>=20
>> If so, it will inevitably have  #ifdef CONFIG_INT128 #else #endif in =
that function. =20
>=20
> No, you don't have to ifdef.  You can use uint64_t alone and not rely =
on
> compiler support for __uint128_t at all.
>=20
>=20
> r~
>=20


