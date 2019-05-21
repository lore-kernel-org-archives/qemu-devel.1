Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A71C18E7C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9F42182B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9F42182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTBi9-0007eJ-1C
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:50:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hTBg1-0006U3-O7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hTBg0-0003Od-Cc
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:48:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hTBfy-0003H5-5j
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:48:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4LKhBTG088066
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 16:47:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2smp4dwwq1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 16:47:50 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Tue, 21 May 2019 21:47:49 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
	by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 21 May 2019 21:47:47 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4LKlkP841746738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 21 May 2019 20:47:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19DB4AC05E;
	Tue, 21 May 2019 20:47:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE4C8AC059;
	Tue, 21 May 2019 20:47:45 +0000 (GMT)
Received: from [9.60.85.4] (unknown [9.60.85.4])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 21 May 2019 20:47:45 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<f2c65517-f6d8-41a4-3f8a-88a530cdcd41@linux.ibm.com>
	<20190521183235.7c3d0b37.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 21 May 2019 16:47:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521183235.7c3d0b37.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052120-0072-0000-0000-000004315766
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011138; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01206660; UDB=6.00633640;
	IPR=6.00987628; 
	MB=3.00026992; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 20:47:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052120-0073-0000-0000-00004C4F7B4D
Message-Id: <192d35fa-12be-c840-e61c-716a3bd80943@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-21_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905210129
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
Cc: Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/21/19 12:32 PM, Cornelia Huck wrote:
> On Mon, 20 May 2019 12:29:56 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 5/7/19 11:47 AM, Cornelia Huck wrote:
>>> A vfio-ccw device may provide an async command subregion for
>>> issuing halt/clear subchannel requests. If it is present, use
>>> it for sending halt/clear request to the device; if not, fall
>>> back to emulation (as done today).
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  hw/s390x/css.c              |  27 +++++++--
>>>  hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
>>>  include/hw/s390x/s390-ccw.h |   3 +
>>>  3 files changed, 134 insertions(+), 6 deletions(-)
>>>
> 
>>> +int vfio_ccw_handle_clear(SubchDev *sch)
>>> +{
>>> +    S390CCWDevice *cdev = sch->driver_data;
>>> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>>> +    struct ccw_cmd_region *region = vcdev->async_cmd_region;
>>> +    int ret;
>>> +
>>> +    if (!vcdev->async_cmd_region) {
>>> +        /* Async command region not available, fall back to emulation */
>>> +        return -ENOSYS;
>>> +    }
>>> +
>>> +    memset(region, 0, sizeof(*region));
>>> +    region->command = VFIO_CCW_ASYNC_CMD_CSCH;  
>>
>> Considering the serialization you added on the kernel side, what happens
>> if another vcpu runs this code (or _halt) and clears the async region
>> before the kernel code gains control from the pwrite() call below?
>> Asked another way, there's nothing preventing us from issuing more than
>> one asynchronous command concurrently, so how do we make sure the
>> command gets to the kernel rather than "current command wins"  ?
> 
> This send me digging through the code, because if two threads can call
> this at the same time for passthrough, we'd also have the same problem
> for virtual.
> 
> If I followed the code correctly, all I/O instruction interpretation is
> currently serialized via qemu_mutex_{lock,unlock}_iothread() (see
> target/s390x/kvm.c respectively target/s390x/misc_helper.c). This
> should mostly be enough to avoid stepping on each other's toes.

Ahhh, I didn't follow the bread crumbs back far enough to notice that.
Yes, that should help keep things in line.

> 
> Why mostly? I'm not sure yet whether we handling multiple requests for
> passthrough devices correctly yet (virtual should be fine.)
> 
> Start vs. (start|halt|clear) is fine, as the code checks whether
> something is already pending before poking the kernel interface.
> Likewise, halt vs. (start|halt|clear) is fine, as the code checks for
> halt or clear and start and halt use different regions. The problematic
> one is clear, as that's something that's always supposed to go through.
> Probably fine if clear should always "win", but I need to think some
> more about that.

I suspect you are right, because of the check on the halt side, and
considering that the clear is the biggest recovery action we have.  So
this does seem like things are okay.  I'll ponder this overnight and
finish my review tomorrow.

> 
>>
>> That possibly worrisome question aside, this seems generally fine.
>>
>>
>>> +
>>> +again:
>>> +    ret = pwrite(vcdev->vdev.fd, region,
>>> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
>>> +    if (ret != vcdev->async_cmd_region_size) {
>>> +        if (errno == EAGAIN) {
>>> +            goto again;
>>> +        }
>>> +        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
>>> +        ret = -errno;
>>> +    } else {
>>> +        ret = region->ret_code;
>>> +    }
>>> +    switch (ret) {
>>> +    case 0:
>>> +    case -ENODEV:
>>> +    case -EACCES:
>>> +        return 0;
>>> +    case -EFAULT:
>>> +    default:
>>> +        sch_gen_unit_exception(sch);
>>> +        css_inject_io_interrupt(sch);
>>> +        return 0;
>>> +    }
>>> +}
> 


