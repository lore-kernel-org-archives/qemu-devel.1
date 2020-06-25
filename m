Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C453C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205EF20768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205EF20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joZCE-0002Rq-DU
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 17:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZBH-0001Lk-Q6; Thu, 25 Jun 2020 17:13:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1joZBF-0007XS-Tn; Thu, 25 Jun 2020 17:13:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PL3hZH149548; Thu, 25 Jun 2020 17:13:00 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vbn7kxv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:13:00 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PL6IDq027079;
 Thu, 25 Jun 2020 21:12:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04wdc.us.ibm.com with ESMTP id 31uuryf3fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 21:12:58 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PLCvED27656576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 21:12:57 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C652D6E052;
 Thu, 25 Jun 2020 21:12:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBBF46E04C;
 Thu, 25 Jun 2020 21:12:56 +0000 (GMT)
Received: from [9.160.117.167] (unknown [9.160.117.167])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2020 21:12:56 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/8] target/ppc: Introduce Power ISA 3.1 flag
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <bc918ea4-8023-9186-b603-27e9050ac8d2@linaro.org>
Date: Thu, 25 Jun 2020 16:12:55 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <835A870F-32B8-4A36-ABC8-850365BE7827@linux.vnet.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-2-ljp@linux.ibm.com>
 <bc918ea4-8023-9186-b603-27e9050ac8d2@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_16:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=954 classifier=spam adjust=0 reason=mlx
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



> On Jun 25, 2020, at 12:40 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 6/25/20 10:00 AM, Lijun Pan wrote:
>> +    /* POWER ISA 3.1                                                 =
        */
>> +    PPC2_ISA310        =3D 0x0000000000100000ULL,
>=20
> This goes in the first patch, but...
>=20
>> #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | =
PPC2_DBRX | \
>>                         PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 =
| \
>> @@ -2199,7 +2201,7 @@ enum {
>>                         PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
>>                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | =
\
>>                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | =
\
>> -                        PPC2_ISA300)
>> +                        PPC2_ISA300 | PPC2_ISA310)
>=20
> ... all of the rest belongs in a separate patch, which will be sorted =
to the
> end of the patch set.
>=20

Do you mean the first patch has
=E2=80=9C
>> +    /* POWER ISA 3.1                                                 =
        */
>> +    PPC2_ISA310        =3D 0x0000000000100000ULL,

=E2=80=9C
the second patch has

=E2=80=9C
>> #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | =
PPC2_DBRX | \
>>                         PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 =
| \
>> @@ -2199,7 +2201,7 @@ enum {
>>                         PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
>>                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | =
\
>>                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | =
\
>> -                        PPC2_ISA300)
>> +                        PPC2_ISA300 | PPC2_ISA310)


+++ b/target/ppc/translate_init.inc.c
@@ -9206,7 +9206,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void =
*data)
                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
+                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | =
PPC2_ISA310;

"


> It's ok to keep the second patch at the beginning during development, =
so that
> you can test each instruction as you add it.  But for final commit you =
do not
> want to enable the feature until it is complete.
>=20

Do you mean not submiting the second patch until all the instructions =
are enabled in the future?

Lijun=

