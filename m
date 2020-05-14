Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F59C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5D820657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5D820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZInD-0001mR-NO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1jZIlj-0000wZ-SQ; Thu, 14 May 2020 14:39:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1jZIld-0005Jm-Qz; Thu, 14 May 2020 14:39:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04EIXbNb165614; Thu, 14 May 2020 14:39:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310ub0ds7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 14:39:33 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EIZ20R171623;
 Thu, 14 May 2020 14:39:33 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310ub0ds7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 14:39:33 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EIUOg9017355;
 Thu, 14 May 2020 18:39:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 3100uc5190-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 18:39:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04EIdVwr51249528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 18:39:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D590AB2065;
 Thu, 14 May 2020 18:39:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F434B2064;
 Thu, 14 May 2020 18:39:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 14 May 2020 18:39:31 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 14 May 2020 14:39:31 -0400
From: Jared Rossi <jrossi@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] vfio-ccw: allow non-prefetch ORBs
In-Reply-To: <20200514172021.5a66bc56.cohuck@redhat.com>
References: <20200512181535.18630-1-jrossi@linux.ibm.com>
 <20200512181535.18630-2-jrossi@linux.ibm.com>
 <20200514172021.5a66bc56.cohuck@redhat.com>
Message-ID: <5e5a1a3d037cf3bcbd87da051b09b173@linux.vnet.ibm.com>
X-Sender: jrossi@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-14_07:2020-05-14,
 2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648
 mlxlogscore=999 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 14:39:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-05-14 11:20, Cornelia Huck wrote:
> On Tue, 12 May 2020 14:15:35 -0400
> Jared Rossi <jrossi@linux.ibm.com> wrote:
> 
>> Remove the explicit prefetch check when using vfio-ccw devices.
>> This check does not trigger in practice as all Linux channel programs
>> are intended to use prefetch.
>> 
>> It is no longer required to force the PFCH flag when using vfio-ccw
>> devices.
> 
> That's not quite true: Only kernels that include the currently-queued
> patch do not require it. Maybe
> 
> "Newer Linux kernel versions do not require to force the PFCH flag with
> vfio-ccw devices anymore."
> 
> ?
> 

This is a good point and your proposed message is reasonable.

>> 
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>  hw/vfio/ccw.c | 13 +++----------
>>  1 file changed, 3 insertions(+), 10 deletions(-)
>> 
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 50cc2ec75c..e649377b68 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -74,16 +74,9 @@ static IOInstEnding 
>> vfio_ccw_handle_request(SubchDev *sch)
>>      struct ccw_io_region *region = vcdev->io_region;
>>      int ret;
>> 
>> -    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
>> -        if (!(vcdev->force_orb_pfch)) {
>> -            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
>> -            sch_gen_unit_exception(sch);
>> -            css_inject_io_interrupt(sch);
>> -            return IOINST_CC_EXPECTED;
>> -        } else {
>> -            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>> -            warn_once_pfch(vcdev, sch, "PFCH flag forced");
>> -        }
>> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && 
>> vcdev->force_orb_pfch) {
>> +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>> +        warn_once_pfch(vcdev, sch, "PFCH flag forced");
>>      }
>> 
>>      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
> 
> Let me spell out what happens:
> - PFCH bit set -> no change
> - PFCH bit not set, but force_orb_pfch set -> no change
> - neither PFCH bit nor force_orb_pfch set:
>   - older kernels: QEMU makes the request, the kernel rejects it, guest
>     gets a unit exception (same result for the guest as before, only a
>     different code flow)
>   - newer kernels: QEMU makes the request, the kernel forwards the
>     request (logging a rate-limited warning); the result depends on
>     whether the guest actually tries to rewrite the channel program or
>     not
> 

This is correct, but I think it is worth noting that while the exception
is the same in the case of new QEMU + old kernel, the logging is 
different.
The old kernel code did not issue any warning if a non-prefetch ORB was
rejected, it simply raised the exception. In reality, the old kernel 
code
path was not accessible because QEMU would always reject ORBs before 
then
with the "requires PFCH flag set" message.  The new QEMU code does not
issue a warning in this case.

I considered keeping a warning for the non-prefetch path, but it seemed
excessive to me, since it causes a redundant warning when used with the
new kernel code (which I expect to be the case normally). Do you think
some sort of warning should still be issued by QEMU in this case, even
if it is redundant with the kernel warning?

> I think that is what we want, and I think I'll queue this patch with
> the tweaked commit message, but I'd like a second opinion.
> 
> (We should also deprecate force_orb_pfch in the future.)

