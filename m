Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C8CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C822078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C822078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm9jT-0003UL-Tm
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 01:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9is-0002Wb-7s; Fri, 19 Jun 2020 01:37:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jm9iq-0001n9-Jd; Fri, 19 Jun 2020 01:37:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J5W8tw138491; Fri, 19 Jun 2020 01:37:49 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rmhrkx03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 01:37:49 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J5ZF28007892;
 Fri, 19 Jun 2020 05:37:48 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 31rdtr45cs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 05:37:48 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05J5blRG40305114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 05:37:47 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 495B56A047;
 Fri, 19 Jun 2020 05:37:47 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CA186A04F;
 Fri, 19 Jun 2020 05:37:46 +0000 (GMT)
Received: from [9.160.87.86] (unknown [9.160.87.86])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jun 2020 05:37:46 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 3/6] targetc/ppc: add vmulh{su}w instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <0777c1df-6010-ff2a-2bdf-72c381da7cbf@linaro.org>
Date: Fri, 19 Jun 2020 00:37:45 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <D397FCD9-91C5-4C7B-89EE-67163264A79C@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-4-ljp@linux.ibm.com>
 <0777c1df-6010-ff2a-2bdf-72c381da7cbf@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_01:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=869 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 cotscore=-2147483648
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190034
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



> On Jun 18, 2020, at 6:29 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/12/20 9:20 PM, Lijun Pan wrote:
>> +#define VMULH_DO(name, op, element, cast_orig, cast_temp)		=
\
>> +    void helper_vmulh##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t =
*b)	\
>> +    {									=
\
>> +	int i;								=
\
>> +									=
\
>> +	for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {			=
\
>> +		r->element[i] =3D (cast_orig)(((cast_temp)a->element[i] =
op \
>> +				(cast_temp)b->element[i]) >> 32);	=
\
>> +	}								=
\
>> +    }
>> +VMULH_DO(sw, *, s32, int32_t, int64_t)
>> +VMULH_DO(uw, *, u32, uint32_t, uint64_t)
>> +#undef VMULH_DO
>=20
> There's no point in calling the macro "VMUL" and then passing in "op" =
as a
> parameter.  Just inline the multiply directly.

Do you mean writing two functions directly,=20

void helper_vmulhsw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
{
    int i;

    for (i =3D 0; i < 4; i++) {
        r->s32[i] =3D (int32_t)((int64_t)a->s32[i] * (int64_t)b->s32[i]) =
>> 32);
    }
}

void helper_vmulhuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
{
    int i;

    for (i =3D 0; i < 4; i++) {
        r->u32[i] =3D (uint32_t)((uint64_t)a->u32[i] * =
(uint64_t)b->u32[i]) >> 32);
    }
}

Thanks,
Lijun=

