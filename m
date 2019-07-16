Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707AAC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BCB20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BCB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnNBC-00049E-Fs
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <iii@linux.ibm.com>) id 1hnNAy-0003MR-7j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <iii@linux.ibm.com>) id 1hnNAx-0001C2-6b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:07:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <iii@linux.ibm.com>) id 1hnNAw-0001AZ-Qf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:07:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6GCwHRw020717
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 09:07:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tsd1ddwjn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 09:07:19 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <iii@linux.ibm.com>;
 Tue, 16 Jul 2019 14:07:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Jul 2019 14:07:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6GD7D4o46399696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 13:07:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 706B25204F;
 Tue, 16 Jul 2019 13:07:13 +0000 (GMT)
Received: from dyn-9-152-96-205.boeblingen.de.ibm.com (unknown [9.152.96.205])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3D12552050; 
 Tue, 16 Jul 2019 13:07:13 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20190716150419.6452ab9c.cohuck@redhat.com>
Date: Tue, 16 Jul 2019 15:07:12 +0200
Content-Transfer-Encoding: quoted-printable
References: <20190716123446.24039-1-iii@linux.ibm.com>
 <f3989d45-5451-db13-c5d7-f4601bfff55c@redhat.com>
 <20598EE9-577B-4C96-A106-4CFA2DB5D914@linux.ibm.com>
 <20190716150419.6452ab9c.cohuck@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19071613-4275-0000-0000-0000034D708E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071613-4276-0000-0000-0000385D8295
Message-Id: <B5DDDE7F-D33F-4AA2-ABAD-123B4D354681@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160161
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH] s390: support EDAT-2 in
 mmu_translate_region
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Am 16.07.2019 um 15:04 schrieb Cornelia Huck <cohuck@redhat.com>:
>=20
> On Tue, 16 Jul 2019 14:52:03 +0200
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>=20
>>> Am 16.07.2019 um 14:41 schrieb David Hildenbrand <david@redhat.com>:
>>>=20
>>> How urgent is this? If this can wait, I can polish and send my =
series I have here
>>> instead, which also implents
>>> - IEP support
>>> - access-exception-fetch/store-indication facility
>>> - ESOP-1, ESOP-2 =20
>>=20
>> This is not urgent, I can live with my patch for now.
>> It=E2=80=99s good to know that proper EDAT-2 support is being worked =
on.
>>=20
>> Thanks!
>> Ilya
>=20
> Ok, so I will not queue this patch right now (I assume you're fine =
with
> keeping this locally for now?), but wait for David's series for 4.2.
>=20
> Sounds reasonable?

Yes, that sounds good.=


