Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7065C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBA020768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joZEW-0005Sf-Qm
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 17:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZDX-0004Mi-RI; Thu, 25 Jun 2020 17:15:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZDV-0008NC-Q0; Thu, 25 Jun 2020 17:15:31 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PL4HPY110384; Thu, 25 Jun 2020 17:15:25 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux03xb9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:15:25 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PL6Efi007701;
 Thu, 25 Jun 2020 21:15:23 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma05wdc.us.ibm.com with ESMTP id 31uus1f3wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 21:15:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PLFMVE15008060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 21:15:22 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC71B136055;
 Thu, 25 Jun 2020 21:15:22 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0FE5136053;
 Thu, 25 Jun 2020 21:15:21 +0000 (GMT)
Received: from [9.160.117.167] (unknown [9.160.117.167])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2020 21:15:21 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 8/8] target/ppc: add vdiv{su}{wd} vmod{su}{wd}
 instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <4561adf0-2be1-e9c3-49d8-9de8c414ec40@linaro.org>
Date: Thu, 25 Jun 2020 16:15:20 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <233C7E06-CCB3-4164-82D5-7BC765CC8E01@linux.vnet.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-9-ljp@linux.ibm.com>
 <4561adf0-2be1-e9c3-49d8-9de8c414ec40@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_16:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=479 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250124
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 17:13:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 25, 2020, at 1:37 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/25/20 10:00 AM, Lijun Pan wrote:
>> +#define VDIV_MOD_DO(name, op, element, sign, bit)                    =
   \
>> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)    =
   \
>> +    {                                                                =
   \
>> +        int i;                                                       =
   \
>> +                                                                     =
   \
>> +                                                                     =
   \
>> +        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {             =
     \
>> +            if (unlikely((b->element[i] =3D=3D 0) ||                 =
       \
>> +                (sign &&                                             =
   \
>> +                (b->element[i] =3D=3D UINT##bit##_MAX) &&            =
       \
>> +                (a->element[i] =3D=3D INT##bit##_MIN))))             =
       \
>> +                continue;                                            =
   \
>> +            r->element[i] =3D a->element[i] op b->element[i];        =
     \
>> +        }                                                            =
   \
>> +    }
>=20
> Missing braces for the if.  Extra blank line before the for.

No, the braces are enough. "unlikely" is to describe the whole logic,
eg. if (unlikely( (divisor =3D=3D 0) || (sign && (divisor =3D=3D =
0xFFFFFFFF) && (dividend =3D 0x80000000) ) ) )

I will remove that blank line.

>=20
> I see that the ISA document says divide-by-zero produces an undefined =
result,
> so leaving the previous contents does seem to be within the letter of =
the law.
>=20
> However... Are you able to test what real hardware produces?  It would =
be nice
> (but not required) to match if it is simple to do so.
>=20
> Whichever way we go with the undefined result, this deserves a =
comment.

I will add =E2=80=9Ccontinue; / * Undefined, No Special Registers =
Altered */ "

Lijun

