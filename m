Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7607C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C62B20818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C62B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRCBi-0003QP-US
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 04:56:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hRCAx-00036H-84
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hRCAw-00026y-7l
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:55:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hRCAv-00024W-TX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:55:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4G8qXhA034434
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:55:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh3umtrgy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:55:39 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 16 May 2019 09:55:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 09:55:33 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4G8tV9H61800666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 08:55:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56DE52054;
	Thu, 16 May 2019 08:55:31 +0000 (GMT)
Received: from [9.152.222.58] (unknown [9.152.222.58])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 53FF65204F;
	Thu, 16 May 2019 08:55:31 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
	<1557499133-24169-4-git-send-email-pmorel@linux.ibm.com>
	<20190514134904.67decb8b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 16 May 2019 10:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514134904.67decb8b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051608-0016-0000-0000-0000027C47BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051608-0017-0000-0000-000032D91CCF
Message-Id: <7a0a03c0-f774-b550-4e1f-0072b718d4f1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160061
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0a-001b2d01.pphosted.com id x4G8qXhA034434
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH 3/5] s390: vfio_pci: Use a PCI Group
 structure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: pmorel@linux.ibm.com
Cc: pasic@linux.vnet.ibm.com, mst@redhat.com, qemu-s390x@nongnu.org,
	david@redhat.com, walling@linux.ibm.com, qemu-devel@nongnu.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2019 13:49, Cornelia Huck wrote:
> On Fri, 10 May 2019 16:38:51 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> We use a S390PCIGroup structure to hold the information
>> related to zPCI Function group.
>>
>> This allows us to be ready to support multiple groups and to retrieve
>> the group information from the host.
>=20
> What if there is no host to retrieve information from?

There is a default group for emulate devices.
I will enhance the comment.

Thanks

>=20
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++=
++++
>>   hw/s390x/s390-pci-bus.h  | 11 ++++++++++-
>>   hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
>>   3 files changed, 65 insertions(+), 10 deletions(-)
>=20
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index be28962..8147847 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -284,21 +284,25 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, u=
intptr_t ra)
>>           stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
>>           stl_p(&resquery->fid, pbdev->fid);
>>           stw_p(&resquery->pchid, 0);
>> -        stw_p(&resquery->ug, 1);
>> +        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
>>           stl_p(&resquery->uid, pbdev->uid);
>>           stw_p(&resquery->hdr.rsp, CLP_RC_OK);
>>           break;
>>       }
>>       case CLP_QUERY_PCI_FNGRP: {
>>           ClpRspQueryPciGrp *resgrp =3D (ClpRspQueryPciGrp *)resh;
>> -        resgrp->fr =3D 1;
>> -        stq_p(&resgrp->dasm, 0);
>> -        stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
>> -        stw_p(&resgrp->mui, DEFAULT_MUI);
>> -        stw_p(&resgrp->i, 128);
>> -        stw_p(&resgrp->maxstbl, 128);
>> -        resgrp->version =3D 0;
>>  =20
>> +        ClpReqQueryPciGrp *reqgrp =3D (ClpReqQueryPciGrp *)reqh;
>> +        S390PCIGroup *grp;
>> +
>> +        grp =3D s390_grp_find(reqgrp->g);
>> +        if (!grp) {
>> +            /* We do not allow access to unknown groups */
>> +            /* The group must have been obtained with a vfio device *=
/
>=20
> What about non-vfio devices? How does this whole feature work for
> emulated devices?

Emulated devices get a default group with predefined values.
The predefined values we used before this series.
I will modify the patch comment to explain the emulated devices case.
Thanks for the comments.

Regards,
Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany


