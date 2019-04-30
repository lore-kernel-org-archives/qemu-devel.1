Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CCAC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EC22080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EC22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLSAB-0007mS-Iz
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:47:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oberpar@linux.ibm.com>) id 1hLP0C-0000LK-Uv
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oberpar@linux.ibm.com>) id 1hLP0B-00021N-TI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:24:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <oberpar@linux.ibm.com>)
	id 1hLP0B-00020J-Hi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:24:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3U9MFUw083277
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:24:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s6hj3druw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:24:34 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <oberpar@linux.ibm.com>;
	Tue, 30 Apr 2019 10:24:32 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 30 Apr 2019 10:24:30 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3U9OS8654919316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 30 Apr 2019 09:24:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54A03A4062;
	Tue, 30 Apr 2019 09:24:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06167A405C;
	Tue, 30 Apr 2019 09:24:28 +0000 (GMT)
Received: from [9.152.212.191] (unknown [9.152.212.191])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 30 Apr 2019 09:24:27 +0000 (GMT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<20190429154003.7f8fc423.cohuck@redhat.com>
	<ef10a003-3eb8-df60-bfb1-bc99bfd6b7af@de.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Tue, 30 Apr 2019 11:24:27 +0200
MIME-Version: 1.0
In-Reply-To: <ef10a003-3eb8-df60-bfb1-bc99bfd6b7af@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19043009-0008-0000-0000-000002E1C4A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19043009-0009-0000-0000-0000224E2BB2
Message-Id: <099881e7-b0a9-055a-ba3e-2ebb66b4e15c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-30_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904300062
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Tue, 30 Apr 2019 08:45:40 -0400
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
Cc: thuth@redhat.com, Stefan Haberland <sth@linux.vnet.ibm.com>,
	qemu-s390x@nongnu.org, alifm@linux.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430092427.795VyYyuLIGa9L-Nx8HiPSq71Cu_wCmmIWbHmMXQDts@z>

On 29.04.2019 15:45, Christian Borntraeger wrote:
> 
> 
> On 29.04.19 15:40, Cornelia Huck wrote:
>> On Mon, 29 Apr 2019 09:09:41 -0400
>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
>>
>>> Newer versions of zipl have the ability to write signature entries to the boot
>>> script for secure boot. We don't yet support secure boot, but we need to skip
>>> over signature entries while reading the boot script in order to maintain our
>>> ability to boot guest operating systems that have a secure bootloader.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> Skipping something that we don't have support for yet, but that doesn't
>> hinder normal operation sounds reasonable; but can you point me to the
>> relevant commit implementing this in zipl or some documentation? I
>> haven't been able to find something like that in the s390-tools git
>> tree.
> 
> the s390-tools update is currently in preparation, adding Stefan and Peter.

Here's the link to the s390-tools commit that introduces the new
signature component to zipl:

https://github.com/ibm-s390-tools/s390-tools/commit/7c7e10ed8fb048efc4e0cd91b0f6fa704fba128e


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany


