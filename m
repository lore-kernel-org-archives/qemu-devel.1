Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C657C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F6920833
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F6920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icFD1-0007v9-BH
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1icEMK-0001pe-BB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 15:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1icEMA-0000oH-SG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 15:01:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3448
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1icEM9-0000ec-Ny; Tue, 03 Dec 2019 15:01:10 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB3JbI0E133981; Tue, 3 Dec 2019 15:01:04 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wnsqu4nm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2019 15:01:03 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xB3JeVZR046113;
 Tue, 3 Dec 2019 15:01:03 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wnsqu4nkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2019 15:01:03 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB3JgM0f006839;
 Tue, 3 Dec 2019 20:01:02 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03wdc.us.ibm.com with ESMTP id 2wkg26pypk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2019 20:01:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB3K11tX49807636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Dec 2019 20:01:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CEAD124058;
 Tue,  3 Dec 2019 20:01:01 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B1D5124055;
 Tue,  3 Dec 2019 20:01:01 +0000 (GMT)
Received: from [9.80.211.231] (unknown [9.80.211.231])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  3 Dec 2019 20:01:01 +0000 (GMT)
Subject: Re: [RFC PATCH v1 7/8] vfio-ccw: Refactor ccw irq handler
To: Cornelia Huck <cohuck@redhat.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-8-farman@linux.ibm.com>
 <20191120133914.554210c1.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <715d3f70-5090-2174-b557-1db26fce4838@linux.ibm.com>
Date: Tue, 3 Dec 2019 15:01:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120133914.554210c1.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_06:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=2 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912030144
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



On 11/20/19 7:39 AM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 04:34:36 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> Make it easier to add new ones in the future.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>  hw/vfio/ccw.c | 55 ++++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 39 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 2b1a83b94c..b16526d5de 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -334,22 +334,35 @@ read_err:
>>      css_inject_io_interrupt(sch);
>>  }
>>  
>> -static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>> +static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev, int irq,
> 
> Maybe make this unsigned?

Yeah, seems proper.

> 
>> +                                           Error **errp)
>>  {
>>      VFIODevice *vdev = &vcdev->vdev;
>>      struct vfio_irq_info *irq_info;
>>      size_t argsz;
>>      int fd;
>> +    EventNotifier *notifier;
>> +    IOHandler *fd_read;
>> +
>> +    switch (irq) {
>> +    case VFIO_CCW_IO_IRQ_INDEX:
>> +        notifier = &vcdev->io_notifier;
>> +        fd_read = vfio_ccw_io_notifier_handler;
>> +        break;
>> +    default:
>> +        error_setg(errp, "vfio: Unsupported device irq(%d) fd: %m", irq);
> 
> Hm, which errno is this supposed to print?

Um...  Dealers choice?  :)  I'll fix this up.

> 
>> +        return;
>> +    }
>>  
>> -    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
>> -        error_setg(errp, "vfio: unexpected number of io irqs %u",
>> +    if (vdev->num_irqs < irq + 1) {
>> +        error_setg(errp, "vfio: unexpected number of irqs %u",
>>                     vdev->num_irqs);
>>          return;
>>      }
>>  
>>      argsz = sizeof(*irq_info);
>>      irq_info = g_malloc0(argsz);
>> -    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
>> +    irq_info->index = irq;
>>      irq_info->argsz = argsz;
>>      if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>>                irq_info) < 0 || irq_info->count < 1) {
>> @@ -357,37 +370,47 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>>          goto out_free_info;
>>      }
>>  
>> -    if (event_notifier_init(&vcdev->io_notifier, 0)) {
>> +    if (event_notifier_init(notifier, 0)) {
>>          error_setg_errno(errp, errno,
>> -                         "vfio: Unable to init event notifier for IO");
>> +                         "vfio: Unable to init event notifier for irq (%d)", irq);
>>          goto out_free_info;
>>      }
>>  
>> -    fd = event_notifier_get_fd(&vcdev->io_notifier);
>> -    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
>> +    fd = event_notifier_get_fd(notifier);
>> +    qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
>>  
>> -    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
>> +    if (vfio_set_irq_signaling(vdev, irq, 0,
>>                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>>          qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>> -        event_notifier_cleanup(&vcdev->io_notifier);
>> +        event_notifier_cleanup(notifier);
>>      }
>>  
>>  out_free_info:
>>      g_free(irq_info);
>>  }
>>  
>> -static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
>> +static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev, int irq)
> 
> Also unsigned here?
> 
>>  {
>>      Error *err = NULL;
>> +    EventNotifier *notifier;
>> +
>> +    switch (irq) {
>> +    case VFIO_CCW_IO_IRQ_INDEX:
>> +        notifier = &vcdev->io_notifier;
>> +        break;
>> +    default:
>> +        error_report("vfio: Unsupported device irq(%d) fd: %m", irq);
> 
> Same comment for the %m.
> 
>> +        return;
>> +    }
>>  
>> -    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
>> +    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
>>                                 VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>>          error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>>      }
>>  
>> -    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
>> +    qemu_set_fd_handler(event_notifier_get_fd(notifier),
>>                          NULL, NULL, vcdev);
>> -    event_notifier_cleanup(&vcdev->io_notifier);
>> +    event_notifier_cleanup(notifier);
>>  }
>>  
>>  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>> @@ -590,7 +613,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>>          goto out_region_err;
>>      }
>>  
>> -    vfio_ccw_register_io_notifier(vcdev, &err);
>> +    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
>>      if (err) {
>>          goto out_notifier_err;
>>      }
>> @@ -619,7 +642,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>>      VFIOGroup *group = vcdev->vdev.group;
>>  
>> -    vfio_ccw_unregister_io_notifier(vcdev);
>> +    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
>>      vfio_ccw_put_region(vcdev);
>>      vfio_ccw_put_device(vcdev);
>>      vfio_put_group(group);
> 
> Otherwise, looks good.
> 

