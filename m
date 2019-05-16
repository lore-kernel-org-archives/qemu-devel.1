Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5A2C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D77204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D77204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRC7h-0002AX-Ap
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 04:52:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hRC6u-0001qI-Vq
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hRC6t-000308-SQ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:51:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hRC6t-0002qH-M4
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:51:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4G8hDAb143416
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:51:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh42r1pfs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:51:22 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 16 May 2019 09:51:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 09:51:17 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4G8pFND46268534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 08:51:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B0F5204E;
	Thu, 16 May 2019 08:51:15 +0000 (GMT)
Received: from [9.152.222.58] (unknown [9.152.222.58])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E6A455204F;
	Thu, 16 May 2019 08:51:14 +0000 (GMT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
	<1557499133-24169-2-git-send-email-pmorel@linux.ibm.com>
	<20190512142218-mutt-send-email-mst@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 16 May 2019 10:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512142218-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051608-0008-0000-0000-000002E73E28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051608-0009-0000-0000-00002253E230
Message-Id: <7a1f78b7-fad9-2fc7-2015-186c6bdc9de8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160060
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0a-001b2d01.pphosted.com id x4G8hDAb143416
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio: vfio_iommu_type1: linux header
 place holder
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
Cc: pasic@linux.vnet.ibm.com, david@redhat.com, qemu-s390x@nongnu.org,
	cohuck@redhat.com, walling@linux.ibm.com, qemu-devel@nongnu.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2019 20:22, Michael S. Tsirkin wrote:
> On Fri, May 10, 2019 at 04:38:49PM +0200, Pierre Morel wrote:
>> This should be copied from Linux kernel UAPI includes.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>=20
> pls add a note which linux version did you sync with.

I will, thanks.
Pierre

>=20
>> ---
>>   linux-headers/linux/vfio.h | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>> index 12a7b1d..eaecaef 100644
>> --- a/linux-headers/linux/vfio.h
>> +++ b/linux-headers/linux/vfio.h
>> @@ -9,8 +9,8 @@
>>    * it under the terms of the GNU General Public License version 2 as
>>    * published by the Free Software Foundation.
>>    */
>> -#ifndef VFIO_H
>> -#define VFIO_H
>> +#ifndef _UAPIVFIO_H
>> +#define _UAPIVFIO_H
>>  =20
>>   #include <linux/types.h>
>>   #include <linux/ioctl.h>
>> @@ -711,6 +711,16 @@ struct vfio_iommu_type1_info {
>>   	__u32	flags;
>>   #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes inf=
o */
>>   	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
>> +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilitie=
s info */
>> +	__u64   cap_offset;     /* Offset within info struct of first cap */
>> +};
>> +
>> +#define VFIO_IOMMU_INFO_CAP_QFN		1
>> +#define VFIO_IOMMU_INFO_CAP_QGRP	2
>> +
>> +struct vfio_iommu_type1_info_block {
>> +	struct vfio_info_cap_header header;
>> +	__u32 data[];
>>   };
>>  =20
>>   #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>> @@ -910,4 +920,4 @@ struct vfio_iommu_spapr_tce_remove {
>>  =20
>>   /* *****************************************************************=
 */
>>  =20
>> -#endif /* VFIO_H */
>> +#endif /* _UAPIVFIO_H */
>> --=20
>> 2.7.4
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany


