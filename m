Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F12C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406E6206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406E6206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5wF-0003by-IC
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alifm@linux.ibm.com>) id 1hb5t9-0002SH-W9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alifm@linux.ibm.com>) id 1hb5t8-0007ei-Lo
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:14:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60542
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hb5t8-0007e4-Fl
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:14:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5CGCUKe052172
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:14:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t33bcvapj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:14:12 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
 Wed, 12 Jun 2019 17:14:11 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 12 Jun 2019 17:14:08 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5CGE75M27656698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 16:14:07 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76D9D12405C;
 Wed, 12 Jun 2019 16:14:07 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68FC5124055;
 Wed, 12 Jun 2019 16:14:07 +0000 (GMT)
Received: from [9.56.58.18] (unknown [9.56.58.18])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 12 Jun 2019 16:14:07 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190607145353.2052-1-cohuck@redhat.com>
 <e07bf42d-2b8a-382c-85c8-520985ddfe8a@linux.ibm.com>
 <20190612113808.06fec7d7.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 12 Jun 2019 12:14:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190612113808.06fec7d7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061216-2213-0000-0000-0000039E5EDB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011251; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216969; UDB=6.00639913; IPR=6.00998076; 
 MB=3.00027281; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-12 16:14:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061216-2214-0000-0000-00005ED61D2E
Message-Id: <98385bc7-85ce-8572-4997-0257aaafa19b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-12_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v5] vfio-ccw: support async command
 subregion
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06/12/2019 05:38 AM, Cornelia Huck wrote:
> On Tue, 11 Jun 2019 15:33:59 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 06/07/2019 10:53 AM, Cornelia Huck wrote:
>>> A vfio-ccw device may provide an async command subregion for
>>> issuing halt/clear subchannel requests. If it is present, use
>>> it for sending halt/clear request to the device; if not, fall
>>> back to emulation (as done today).
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> v4->v5:
>>> - It seems we need to take the indirection via the class for the
>>>     callbacks after all :(
>>> - Dropped Eric's R-b: for that reason
>>>
>>> ---
>>>    hw/s390x/css.c              |  27 +++++++--
>>>    hw/s390x/s390-ccw.c         |  20 +++++++
>>>    hw/vfio/ccw.c               | 112 +++++++++++++++++++++++++++++++++++-
>>>    include/hw/s390x/css.h      |   3 +
>>>    include/hw/s390x/s390-ccw.h |   2 +
>>>    5 files changed, 158 insertions(+), 6 deletions(-)
>>>
> 
>>> @@ -309,11 +400,26 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>>>        vcdev->io_region_offset = info->offset;
>>>        vcdev->io_region = g_malloc0(info->size);
>>>    
>>> +    /* check for the optional async command region */
>>> +    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
>>> +                                   VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &info);
>>> +    if (!ret) {
>>> +        vcdev->async_cmd_region_size = info->size;
>>> +        if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
>>> +            error_setg(errp, "vfio: Unexpected size of the async cmd region");
>>> +            g_free(info);
>>> +            return;
>>> +        }
>>> +        vcdev->async_cmd_region_offset = info->offset;
>>> +        vcdev->async_cmd_region = g_malloc0(info->size);
>>> +    }
>>> +
>>>        g_free(info);
>>>    }
>>>    
>>>    static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>>>    {
>>> +    g_free(vcdev->async_cmd_region);
>>>        g_free(vcdev->io_region);
>>>    }
>>
>> I think we can have a memory leak given how the code is currently
>> structured and how we call vfio_ccw_get_region.
>>
>> vfio_ccw_get_region is called in vfio_ccw_realize. So if we return an
>> error from vfio_ccw_get_region, we would jump to out_region_err in
>> vfio_ccw_realize which would call vfio_ccw_put_device.
>>
>> Now we can also return an error from vfio_ccw_get_region for the async
>> region, and so we might never end up freeing the io_region for which we
>> allocated memory successfully.
>>
>> I think we would also need to change vfio_ccw_realize, no?
> 
> Indeed, you're right. I have the following change on top:
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index c9d1c76b4d04..d21ac24f743c 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -407,6 +407,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           vcdev->async_cmd_region_size = info->size;
>           if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
>               error_setg(errp, "vfio: Unexpected size of the async cmd region");
> +            g_free(vcdev->io_region);
>               g_free(info);
>               return;
>           }

This looks good to me.

> 
> Anything else before I respin?
> 
> 

Nothing else that jumped out to me.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>




