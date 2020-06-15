Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462AAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C3120714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C3120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwql-0000wP-AY
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jkw9I-0002Wd-23; Mon, 15 Jun 2020 16:56:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.vnet.ibm.com>)
 id 1jkw9G-00037B-9L; Mon, 15 Jun 2020 16:56:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FK8S21162852; Mon, 15 Jun 2020 16:55:58 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31n0j874v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 16:55:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FKoT22001994;
 Mon, 15 Jun 2020 20:55:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01dal.us.ibm.com with ESMTP id 31pckfjs92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 20:55:57 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FKsute28246442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 20:54:56 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2F986A047;
 Mon, 15 Jun 2020 20:54:55 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73A006A04D;
 Mon, 15 Jun 2020 20:54:55 +0000 (GMT)
Received: from [9.160.92.109] (unknown [9.160.92.109])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Jun 2020 20:54:55 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/6] Add several Power ISA 3.1 32/64-bit vector
 instructions
From: Lijun Pan <ljp@linux.vnet.ibm.com>
In-Reply-To: <ef31bb82-607c-3fde-577b-559ff5033be6@kaod.org>
Date: Mon, 15 Jun 2020 15:54:54 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A745EBC-6605-4688-9D1A-A29773C14FE3@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <ef31bb82-607c-3fde-577b-559ff5033be6@kaod.org>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_03:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 cotscore=-2147483648
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=936
 mlxscore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150111
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ljp@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:53:21
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2020 17:16:16 -0400
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



> On Jun 15, 2020, at 12:36 PM, C=C3=A9dric Le Goater <clg@kaod.org> =
wrote:
>=20
> Hello,
>=20
> On 6/13/20 6:20 AM, Lijun Pan wrote:
>> This patch series add several newly introduced 32/64-bit vector
>> instructions in Power ISA 3.1. The newly added instructions are
>> flagged as ISA300 temporarily in vmx-ops.inc.c and vmx-impl.inc.c
>> to make them compile and function since Power ISA 3.1, together
>> with next generation processor, has not been fully enabled in QEMU
>> yet. When Power ISA 3.1 and next generation processor are fully
>> supported, the flags should be changed.
>=20
> What do you mean ?=20
>=20
> ISA 3.1 and POWER10 are merged in Linux and in the QEMU pseries=20
> and PowerNV (OPAL) machines.
>=20
> It's very much empty but it's there.

I mean it does not work if you boots the guest in TCG mode, not KVM =
mode.

Lijun

>=20
> C.=20
>=20
>=20
>>=20
>> Lijun Pan (6):
>>  target/ppc: add byte-reverse br[dwh] instructions
>>  target/ppc: add vmulld instruction
>>  targetc/ppc: add vmulh{su}w instructions
>>  target/ppc: add vmulh{su}d instructions
>>  fix the prototype of muls64/mulu64
>>  target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
>>=20
>> include/qemu/host-utils.h           |  4 +-
>> target/ppc/helper.h                 | 13 ++++++
>> target/ppc/int_helper.c             | 58 +++++++++++++++++++++++++
>> target/ppc/translate.c              | 65 =
+++++++++++++++++++++++++++++
>> target/ppc/translate/vmx-impl.inc.c | 24 +++++++++++
>> target/ppc/translate/vmx-ops.inc.c  | 22 ++++++++--
>> 6 files changed, 180 insertions(+), 6 deletions(-)
>>=20
>=20


