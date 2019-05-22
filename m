Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACDAC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E2D20815
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E2D20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPpc-0000hg-MM
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:54:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hTPop-0000NN-9W
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hTPoo-00074B-CO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:54:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hTPoo-000733-1L
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:54:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4MBqS21104853
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:54:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sn5qfrkf1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:54:00 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 22 May 2019 12:53:59 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
	by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 22 May 2019 12:53:57 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4MBru0K10813828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 22 May 2019 11:53:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4049BC6055;
	Wed, 22 May 2019 11:53:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57077C605A;
	Wed, 22 May 2019 11:53:55 +0000 (GMT)
Received: from [9.85.136.32] (unknown [9.85.136.32])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2019 11:53:55 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<ee44aca2-708b-9ced-b658-731cf6528129@linux.ibm.com>
	<20190522121714.34f1740b.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 22 May 2019 07:53:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190522121714.34f1740b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052211-8235-0000-0000-00000E9CA349
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011142; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01206953; UDB=6.00633821;
	IPR=6.00987929; 
	MB=3.00027002; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-22 11:53:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052211-8236-0000-0000-000045AC7A43
Message-Id: <fd14fb7a-b547-8431-1c95-434453e9cf23@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-22_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905220087
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
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
Cc: Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 05/22/2019 06:17 AM, Cornelia Huck wrote:
> On Tue, 21 May 2019 16:50:47 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 05/07/2019 11:47 AM, Cornelia Huck wrote:
>>> A vfio-ccw device may provide an async command subregion for
>>> issuing halt/clear subchannel requests. If it is present, use
>>> it for sending halt/clear request to the device; if not, fall
>>> back to emulation (as done today).
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    hw/s390x/css.c              |  27 +++++++--
>>>    hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
>>>    include/hw/s390x/s390-ccw.h |   3 +
>>>    3 files changed, 134 insertions(+), 6 deletions(-)
> 
>>> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
>>> index 901d805d79a3..e9c7e1db5761 100644
>>> --- a/include/hw/s390x/s390-ccw.h
>>> +++ b/include/hw/s390x/s390-ccw.h
>>> @@ -37,4 +37,7 @@ typedef struct S390CCWDeviceClass {
>>>        IOInstEnding (*handle_request) (SubchDev *sch);
>>>    } S390CCWDeviceClass;
>>>    
>>> +int vfio_ccw_handle_clear(SubchDev *sch);
>>> +int vfio_ccw_handle_halt(SubchDev *sch);
>>> +
>>
>> We are not making clear and halt functions part of the
>> S390CCWDeviceClass, is there are reason for doing this?
>> Currently we handle ssch through the handle_request function, it just
>> looks a little inconsistent.
> 
> I don't quite remember why I did it this way; not sure if there is a
> good reason for that (that patch has been around for too long...)
> 
> We can change such internal details later on, though. (And I think your
> comment has merit.)
> 
> 
Yes, sure we could change it later on. I do prefer your way though, it 
avoids one more layer of indirection.

Thanks
Farhan


