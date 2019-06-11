Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C938C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 19:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E952173C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 19:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E952173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hamb9-0003PT-Fb
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 15:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alifm@linux.ibm.com>) id 1hama9-0002aj-PH
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alifm@linux.ibm.com>) id 1hama8-0005xA-JJ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 15:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hama8-0005wX-7B
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 15:37:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5BJb65T111169
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:37:19 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t2htnj61r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:37:18 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
 Tue, 11 Jun 2019 20:37:18 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Jun 2019 20:37:15 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5BJbDvi35389874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 19:37:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9961A7805F;
 Tue, 11 Jun 2019 19:37:13 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A3D478063;
 Tue, 11 Jun 2019 19:37:13 +0000 (GMT)
Received: from [9.56.58.18] (unknown [9.56.58.18])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 11 Jun 2019 19:37:13 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190607145353.2052-1-cohuck@redhat.com>
 <77395432-9619-1fee-4aeb-5685b8aa9be3@linux.ibm.com>
 <20190607170907.1d682513.cohuck@redhat.com>
 <e8d6deb4-2e9a-188a-7171-ff9b85d625b3@linux.ibm.com>
 <20190611133716.427269b5.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 11 Jun 2019 15:37:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190611133716.427269b5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061119-0012-0000-0000-000017434356
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216565; UDB=6.00639666; IPR=6.00997664; 
 MB=3.00027268; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 19:37:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061119-0013-0000-0000-000057A85D1E
Message-Id: <298b9c16-e4b1-16e7-6fe6-671d482c65d8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-11_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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



On 06/11/2019 07:37 AM, Cornelia Huck wrote:
> On Fri, 7 Jun 2019 11:19:09 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 06/07/2019 11:09 AM, Cornelia Huck wrote:
>>> On Fri, 7 Jun 2019 11:02:36 -0400
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>    
>>>> On 06/07/2019 10:53 AM, Cornelia Huck wrote:
> 
>>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>>> index ad310b9f94bc..b92395f165e6 100644
>>>>> --- a/hw/s390x/css.c
>>>>> +++ b/hw/s390x/css.c
>>>>> @@ -22,6 +22,7 @@
>>>>>     #include "trace.h"
>>>>>     #include "hw/s390x/s390_flic.h"
>>>>>     #include "hw/s390x/s390-virtio-ccw.h"
>>>>> +#include "hw/s390x/s390-ccw.h"
>>>>>     
>>>>>     typedef struct CrwContainer {
>>>>>         CRW crw;
>>>>> @@ -1205,6 +1206,26 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>>>>>     
>>>>>     }
>>>>>     
>>>>> +static void sch_handle_halt_func_passthrough(SubchDev *sch)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = s390_ccw_halt(sch);
>>>>> +    if (ret == -ENOSYS) {
>>>>> +        sch_handle_halt_func(sch);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static void sch_handle_clear_func_passthrough(SubchDev *sch)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = s390_ccw_clear(sch);
>>>>> +    if (ret == -ENOSYS) {
>>>>> +        sch_handle_clear_func(sch);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>
>>>> do we need an extra s390_ccw_clear/halt functions? can't we just call
>>>> cdc->clear/halt in the passthrough functions?
>>>
>>> I mostly added them for symmetry reasons... we still need to check for
>>> presence of the callback in any case, though.
>>>
>>> (vfio is not always built, e.g. on windows or os x.)
>>
>>
>> right, but if we are calling do_subchannel_work_passthrough, then we
>> know for sure we are building the S390CCWDevice which is the vfio
>> device, no?
>>
>> So we could just add checks for callbacks in
>> sch_handle_clear/halt_func_passthrough, no?
>>
>> I would even like to get rid of the s390_ccw_cmd_request if we can, but
>> that is out of scope for this patch. :)
> 
> Ok, I just walked through various source files (some of which are a bit
> confusingly named) again and now I understand again why it was done
> that way in the first place.
> 
> - hw/s390x/s390-ccw.c provides some interfaces for pass-through ccw
>    devices. It is built unconditionally, and its interfaces are called
>    unconditionally from the css code.
>    It also provides a device class where code can hook up callbacks.
> - hw/vfio/ccw.c (which is not built for !KVM) actually hooks up
>    callbacks in that device class.
> 
> So, s390-ccw.c (not to be confused with ccw-device.c...) provides a
> layer that makes it possible to call things unconditionally, regardless
> whether we have vfio-ccw available or not. Not that the code ends up
> being called without vfio-ccw support; but the class indirection
> enables the code to be built.
> 

Okay, now I get it. Thanks for the explanation, I really do appreciate 
it! :)

> There's possibly a way to make this work without the class indirection
> as well, but I think we'd end up doing code juggling before ending up
> with something that's not really nicer than the code we have now.
> Therefore, I'd prefer to keep the class handling and hook up the
> halt/clear callbacks there as well.
> 
> 

Yeah I agree, given the constraints I don't think any code juggling 
would look any prettier.

Thanks
Farhan


