Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C86CC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C6A206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C6A206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNdIP-00083H-GY
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 09:04:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hNdHM-0007VG-4I
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hNdHL-00033f-5y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hNdHK-00030c-Rn
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:03:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x46D2lCS028314
	for <qemu-devel@nongnu.org>; Mon, 6 May 2019 09:03:30 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sajd1fxd5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 09:03:29 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 6 May 2019 14:03:27 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
	by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 6 May 2019 14:03:25 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x46D3Nmn63897626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 6 May 2019 13:03:24 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4CA5C605D;
	Mon,  6 May 2019 13:03:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7054AC6055;
	Mon,  6 May 2019 13:03:23 +0000 (GMT)
Received: from [9.60.75.221] (unknown [9.60.75.221])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2019 13:03:23 +0000 (GMT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, cohuck@redhat.com, alifm@linux.ibm.com
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<2913f865-2119-f6cf-b2f8-b22d351fcca1@redhat.com>
	<19c9edb6-fd85-564e-8342-80042e90ae3e@de.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Date: Mon, 6 May 2019 09:03:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <19c9edb6-fd85-564e-8342-80042e90ae3e@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050613-0020-0000-0000-00000EE44D49
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011059; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01199404; UDB=6.00629238;
	IPR=6.00980281; 
	MB=3.00026753; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-06 13:03:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050613-0021-0000-0000-000065B719CB
Message-Id: <7d728050-cc8f-e730-9bfe-845857251392@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-06_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905060113
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
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
Reply-To: jjherne@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 4:08 AM, Christian Borntraeger wrote:
> On 03.05.19 11:34, Thomas Huth wrote:
>> On 29/04/2019 15.09, Jason J. Herne wrote:
>>> Newer versions of zipl have the ability to write signature entries to the boot
>>> script for secure boot. We don't yet support secure boot, but we need to skip
>>> over signature entries while reading the boot script in order to maintain our
>>> ability to boot guest operating systems that have a secure bootloader.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>>>   pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>>>   2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>>
>> Jason, Christian, do you have any other changes to the s390-ccw firmware
>> currently pending that you plan to send out within the next week? If so,
>> I'll wait a little bit longer with building a new binary for the
>> repository ... if not, I'll pick this patch up next week.
> 
> 
> I have nothing at the moment.
> 

I also have nothing right now.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)


