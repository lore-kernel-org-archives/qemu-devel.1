Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A027C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41802222A2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41802222A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5kX-0000VB-Dz
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iX5jT-0008QP-Bf
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iX5jS-0000Jv-17
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:47:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8640
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iX5jR-0000Jd-RP; Tue, 19 Nov 2019 10:47:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJFgh8e132763; Tue, 19 Nov 2019 10:47:56 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf34n3f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 10:47:56 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAJFhqjq137794;
 Tue, 19 Nov 2019 10:47:55 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf34n3ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 10:47:55 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAJFeKaQ006872;
 Tue, 19 Nov 2019 15:47:55 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04dal.us.ibm.com with ESMTP id 2wa8r6kh32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 15:47:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJFlsnl52494640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 15:47:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B791B2065;
 Tue, 19 Nov 2019 15:47:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF98B2064;
 Tue, 19 Nov 2019 15:47:54 +0000 (GMT)
Received: from [9.80.210.113] (unknown [9.80.210.113])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 15:47:53 +0000 (GMT)
Subject: Re: [RFC PATCH v1 2/8] vfio-ccw: Don't inject an I/O interrupt if the
 subchannel is not enabled
To: Cornelia Huck <cohuck@redhat.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-3-farman@linux.ibm.com>
 <20191118192310.6af29cd1.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <413cff23-0116-3862-616b-be39eddceadc@linux.ibm.com>
Date: Tue, 19 Nov 2019 10:47:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118192310.6af29cd1.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_05:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/18/19 1:23 PM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 04:34:31 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> According to PoPs, when the SCHIB.PMCW bit 8 is 0 status presented by
>> the device is not made available to the program. So don't inject an
>> interrupt in the guest if the guest OS has not enabled the
>> subchannel.
> 
> Have you managed to trigger this state in real life?

No, and I have no notes on how this came to be.  I'll try running some
of the config tests with this reverted, and see if I can find any weirdness.

> 
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v0->v1: [EF]
>>      - Update commit message, as the bit in question is bit 8 not 15
>>
>>  hw/vfio/ccw.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 0919ddbeb8..0590a6f512 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -230,6 +230,11 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
>>          return;
>>      }
>>  
>> +    /* Virtual subchannel is not enabled */
>> +    if (!(schib->pmcw.flags & PMCW_FLAGS_MASK_ENA)) {
> 
> How can that happen? We should not be able to disable the subchannel
> while it is in active use, should we? I fear I'm missing something
> here...

Me too...  Hrm...

> 
>> +        return;
>> +    }
>> +
>>      size = pread(vcdev->vdev.fd, region, vcdev->io_region_size,
>>                   vcdev->io_region_offset);
>>      if (size == -1) {
> 

