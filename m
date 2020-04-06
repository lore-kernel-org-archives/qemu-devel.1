Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8169C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 21:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE98206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 21:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE98206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLZRR-0003gS-Mj
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 17:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jLZQq-0003Gd-A5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jLZQp-0004MK-5V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 17:37:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jLZQo-0004Lu-TM; Mon, 06 Apr 2020 17:37:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 036LY7QE112558; Mon, 6 Apr 2020 17:37:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3082k2aeee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 17:37:21 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 036LZjM7118178;
 Mon, 6 Apr 2020 17:37:21 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3082k2aee0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 17:37:21 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 036LZsSc008317;
 Mon, 6 Apr 2020 21:37:20 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 306hv680p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 21:37:20 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 036LbJv440173878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2020 21:37:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99A8A124053;
 Mon,  6 Apr 2020 21:37:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11A2A124052;
 Mon,  6 Apr 2020 21:37:19 +0000 (GMT)
Received: from [9.160.96.56] (unknown [9.160.96.56])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2020 21:37:18 +0000 (GMT)
Subject: Re: [RFC PATCH v2 7/7] vfio-ccw: Add support for the CRW irq
To: Cornelia Huck <cohuck@redhat.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-8-farman@linux.ibm.com>
 <20200406182255.129a6798.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <ff56c045-b4eb-bb54-c719-091cd16b6b7e@linux.ibm.com>
Date: Mon, 6 Apr 2020 17:37:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406182255.129a6798.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_10:2020-04-06,
 2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060160
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/6/20 12:22 PM, Cornelia Huck wrote:
> On Thu,  6 Feb 2020 22:45:09 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> The CRW irq will be used by vfio-ccw to notify the userspace
>> about any CRWs the userspace needs to handle. Let's add support
>> for it.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>      - Add a loop to continually read region while data is
>>        present, queueing CRWs as found [CH]
>>     v0->v1: [EF]
>>      - Check vcdev->crw_region before registering the irq,
>>        in case host kernel does not have matching support
>>      - Split the refactoring changes to an earlier (new) patch
>>        (and don't remove the "num_irqs" check in the register
>>        routine, but adjust it to the check the input variable)
>>      - Don't revert the cool vfio_set_irq_signaling() stuff
>>      - Unregister CRW IRQ before IO IRQ in unrealize
>>      - s/crw1/crw0/
>>
>>  hw/vfio/ccw.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
> 
>> @@ -265,6 +266,40 @@ static void vfio_ccw_reset(DeviceState *dev)
>>      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
>>  }
>>  
>> +static void vfio_ccw_crw_notifier_handler(void *opaque)
>> +{
>> +    VFIOCCWDevice *vcdev = opaque;
>> +    struct ccw_crw_region *region = vcdev->crw_region;
>> +    CRW crw;
>> +    int size;
>> +    uint8_t rsc, erc;
>> +
>> +    if (!event_notifier_test_and_clear(&vcdev->crw_notifier)) {
>> +        return;
>> +    }
>> +
>> +    do {
>> +        memset(region, 0, sizeof(*region));
>> +        size = pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
>> +                     vcdev->crw_region_offset);
>> +
>> +        if (size == -1) {
>> +            error_report("vfio-ccw: Read crw region failed with errno=%d", errno);
>> +            break;
>> +        }
>> +
>> +        if (size == 0 || region->crw0 == 0) {
> 
> Does it make any sense to expect both of them as an indication that
> there are no more crws at the moment? Grabbing a zeroed crw makes the
> most sense as a stop condition, I think.

I think it was overkill on my part.  Though it appears I am missing the
"zeroing" of the region once it got read.  Whoops.  Okay, those are easy
fixups.

> 
> Also, I'm not sure anymore whether having space for two crws makes too
> much sense. If we have a case in the future where we get two chained
> crws, the code will retry anyway and just fetch the chained crw and
> queue it, wouldn't it?

I suppose.

I thought the reason for including them now was to avoid "if region size
== 4 vs 8 vs XX" logic at some mysterious time in the future.  But
certainly ripping it out so we only pass a single CRW at a time would
simplify this quite a bit.

> 
>> +            /* No more CRWs to queue */
>> +            break;
>> +        }
>> +
>> +        memcpy(&crw, &region->crw0, sizeof(CRW));
>> +        rsc = (crw.flags & 0x0f00) >> 8;
>> +        erc = crw.flags & 0x003f;
> 
> I think we already have something for that... ah yes,
> CRW_FLAGS_MASK_RSC and CRW_FLAGS_MASK_ERC.

Huh, look at that.  :)

> 
>> +        css_queue_crw(rsc, erc, 0, 0, crw.rsid);
> 
> ...or maybe an alternative interface that allows us to queue a
> ready-made crw?

Sure, that would be nice.  I'll add that as an additional patch to this
series, prior to this one.

> 
>> +    } while (1);
>> +}
>> +
>>  static void vfio_ccw_io_notifier_handler(void *opaque)
>>  {
>>      VFIOCCWDevice *vcdev = opaque;
> 

