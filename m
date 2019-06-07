Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9434C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24AF2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24AF2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHVM-0004iU-Lv
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47749)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alifm@linux.ibm.com>) id 1hZGea-0002Qe-0I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alifm@linux.ibm.com>) id 1hZGeX-0004T1-UF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:19:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39148
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hZGeU-0003Oi-3x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:19:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x57FI3oe085505
 for <qemu-devel@nongnu.org>; Fri, 7 Jun 2019 11:19:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2syqmc0p7s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:19:13 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
 Fri, 7 Jun 2019 16:19:13 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 7 Jun 2019 16:19:10 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x57FJ9aL28770582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Jun 2019 15:19:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79DD0112062;
 Fri,  7 Jun 2019 15:19:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BEF4112061;
 Fri,  7 Jun 2019 15:19:09 +0000 (GMT)
Received: from [9.56.58.18] (unknown [9.56.58.18])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  7 Jun 2019 15:19:09 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190607145353.2052-1-cohuck@redhat.com>
 <77395432-9619-1fee-4aeb-5685b8aa9be3@linux.ibm.com>
 <20190607170907.1d682513.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 7 Jun 2019 11:19:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190607170907.1d682513.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060715-0060-0000-0000-0000034D9A77
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011228; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214578; UDB=6.00638465; IPR=6.00995663; 
 MB=3.00027222; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-07 15:19:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060715-0061-0000-0000-000049AD2D8A
Message-Id: <e8d6deb4-2e9a-188a-7171-ff9b85d625b3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-07_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070107
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



On 06/07/2019 11:09 AM, Cornelia Huck wrote:
> On Fri, 7 Jun 2019 11:02:36 -0400
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
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index ad310b9f94bc..b92395f165e6 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -22,6 +22,7 @@
>>>    #include "trace.h"
>>>    #include "hw/s390x/s390_flic.h"
>>>    #include "hw/s390x/s390-virtio-ccw.h"
>>> +#include "hw/s390x/s390-ccw.h"
>>>    
>>>    typedef struct CrwContainer {
>>>        CRW crw;
>>> @@ -1205,6 +1206,26 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>>>    
>>>    }
>>>    
>>> +static void sch_handle_halt_func_passthrough(SubchDev *sch)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = s390_ccw_halt(sch);
>>> +    if (ret == -ENOSYS) {
>>> +        sch_handle_halt_func(sch);
>>> +    }
>>> +}
>>> +
>>> +static void sch_handle_clear_func_passthrough(SubchDev *sch)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = s390_ccw_clear(sch);
>>> +    if (ret == -ENOSYS) {
>>> +        sch_handle_clear_func(sch);
>>> +    }
>>> +}
>>> +
>>
>> do we need an extra s390_ccw_clear/halt functions? can't we just call
>> cdc->clear/halt in the passthrough functions?
> 
> I mostly added them for symmetry reasons... we still need to check for
> presence of the callback in any case, though.
> 
> (vfio is not always built, e.g. on windows or os x.)


right, but if we are calling do_subchannel_work_passthrough, then we 
know for sure we are building the S390CCWDevice which is the vfio 
device, no?

So we could just add checks for callbacks in 
sch_handle_clear/halt_func_passthrough, no?

I would even like to get rid of the s390_ccw_cmd_request if we can, but 
that is out of scope for this patch. :)


> 
>>
>>>    static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>>>    {
>>>        SCHIB *schib = &sch->curr_status;
>>> @@ -1244,11 +1265,9 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
>>>        SCHIB *schib = &sch->curr_status;
>>>    
>>>        if (schib->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
>>> -        /* TODO: Clear handling */
>>> -        sch_handle_clear_func(sch);
>>> +        sch_handle_clear_func_passthrough(sch);
>>>        } else if (schib->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
>>> -        /* TODO: Halt handling */
>>> -        sch_handle_halt_func(sch);
>>> +        sch_handle_halt_func_passthrough(sch);
>>>        } else if (schib->scsw.ctrl & SCSW_FCTL_START_FUNC) {
>>>            return sch_handle_start_func_passthrough(sch);
>>>        }
>>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>>> index f5f025d1b6ca..951be5ab0245 100644
>>> --- a/hw/s390x/s390-ccw.c
>>> +++ b/hw/s390x/s390-ccw.c
>>> @@ -29,6 +29,26 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
>>>        return cdc->handle_request(sch);
>>>    }
>>>    
>>> +int s390_ccw_halt(SubchDev *sch)
>>> +{
>>> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
>>> +
>>> +    if (!cdc->handle_halt) {
>>> +        return -ENOSYS;
>>> +    }
>>> +    return cdc->handle_halt(sch);
>>> +}
>>> +
>>> +int s390_ccw_clear(SubchDev *sch)
>>> +{
>>> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
>>> +
>>> +    if (!cdc->handle_clear) {
>>> +        return -ENOSYS;
>>> +    }
>>> +    return cdc->handle_clear(sch);
>>> +}
>>> +
>>
> 
> 


