Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA194C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7903C206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7903C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVIfm-0007Mk-Gt
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVIeO-0006Ik-A4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVIeM-0005aq-EN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:11:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36054
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iVIeM-0005Zv-7u
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:11:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xAEGpnES039753
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:11:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9agbs973-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:11:15 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 14 Nov 2019 17:11:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Nov 2019 17:11:10 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAEHB9pb54526180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 17:11:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AA885204E;
 Thu, 14 Nov 2019 17:11:09 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.27])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3D76D52051;
 Thu, 14 Nov 2019 17:11:09 +0000 (GMT)
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels
 tests
To: Cornelia Huck <cohuck@redhat.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 18:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191114113823.5d752648.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19111417-0020-0000-0000-0000038635A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111417-0021-0000-0000-000021DC4DED
Message-Id: <0092aef6-b8dc-f6f3-82ce-c9fcce9b51dc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140150
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
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, thuth@redhat.com,
 qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-11-14 11:38, Cornelia Huck wrote:
> On Wed, 13 Nov 2019 20:02:33 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
> Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
> one consumer :)


yes, right.


>
>> The PONG device accept two commands: PONG_READ and PONG_WRITE
>> which allow to read from and write to an internal buffer of
>> 1024 bytes.
>>
>> The QEMU device is named ccw-pong.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/Makefile.objs  |   1 +
>>   hw/s390x/ccw-pong.c     | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/s390x/pong.h |  47 ++++++++++++
>>   3 files changed, 234 insertions(+)
>>   create mode 100644 hw/s390x/ccw-pong.c
>>   create mode 100644 include/hw/s390x/pong.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index ee91152..3a83438 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) += tod-kvm.o
>>   obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>>   obj-$(CONFIG_KVM) += s390-stattrib-kvm.o s390-mchk.o
>>   obj-y += s390-ccw.o
>> +obj-y += ccw-pong.o
> Not sure if unconditionally introducing a test device is a good idea.


sure not.


>
>>   obj-y += ap-device.o
>>   obj-y += ap-bridge.o
>>   obj-y += s390-sei.o
>> diff --git a/hw/s390x/ccw-pong.c b/hw/s390x/ccw-pong.c
>> new file mode 100644
>> index 0000000..e7439d5
>> --- /dev/null
>> +++ b/hw/s390x/ccw-pong.c
>> @@ -0,0 +1,186 @@
>> +/*
>> + * CCW PING-PONG
>> + *
>> + * Copyright 2019 IBM Corp.
>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "cpu.h"
>> +#include "exec/address-spaces.h"
>> +#include "hw/s390x/css.h"
>> +#include "hw/s390x/css-bridge.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/s390x/pong.h"
>> +
>> +#define PONG_BUF_SIZE 0x1000
>> +static char buf[PONG_BUF_SIZE] = "Hello world\n";
>> +
>> +static inline int pong_rw(CCW1 *ccw, char *p, int len, bool dir)
>> +{
>> +    int ret;
>> +
>> +    ret = address_space_rw(&address_space_memory, ccw->cda,
>> +                           MEMTXATTRS_UNSPECIFIED,
>> +                           (unsigned char *)buf, len, dir);
>> +
>> +    return (ret == MEMTX_OK) ? -EIO : 0;
>> +}
>> +
>> +/* Handle READ ccw commands from guest */
>> +static int handle_payload_read(CcwPONGDevice *dev, CCW1 *ccw)
>> +{
>> +    CcwDevice *ccw_dev = CCW_DEVICE(dev);
>> +    int len;
>> +
>> +    if (!ccw->cda) {
>> +        return -EFAULT;
>> +    }
>> +
>> +    if (ccw->count > PONG_BUF_SIZE) {
>> +        len = PONG_BUF_SIZE;
>> +        ccw_dev->sch->curr_status.scsw.count = ccw->count - PONG_BUF_SIZE;
>> +    } else {
>> +        len = ccw->count;
>> +        ccw_dev->sch->curr_status.scsw.count = 0;
>> +    }
>> +
>> +    return pong_rw(ccw, buf, len, 1);
>> +}
>> +
>> +/*
>> + * Handle WRITE ccw commands to write data to client
>> + * The SCSW count is set to the number of bytes not transfered.
>> + */
>> +static int handle_payload_write(CcwPONGDevice *dev, CCW1 *ccw)
>> +{
>> +    CcwDevice *ccw_dev = CCW_DEVICE(dev);
>> +    int len;
>> +
>> +    if (!ccw->cda) {
>> +        ccw_dev->sch->curr_status.scsw.count = ccw->count;
>> +        return -EFAULT;
>> +    }
>> +
>> +    if (ccw->count > PONG_BUF_SIZE) {
>> +        len = PONG_BUF_SIZE;
>> +        ccw_dev->sch->curr_status.scsw.count = ccw->count - PONG_BUF_SIZE;
>> +    } else {
>> +        len = ccw->count;
>> +        ccw_dev->sch->curr_status.scsw.count = 0;
>> +    }
>> +
>> +    return pong_rw(ccw, buf, len, 0);
> Can you please use the dstream infrastructure for read/write handling?
>
> You also seem to miss some basic checks e.g. for short reads/writes
> with and without SLI set.

OK,


>
>> +}
>> +
>> +static int pong_ccw_cb(SubchDev *sch, CCW1 ccw)
>> +{
>> +    int rc = 0;
>> +    CcwPONGDevice *dev = sch->driver_data;
>> +
>> +    switch (ccw.cmd_code) {
>> +    case PONG_WRITE:
>> +        rc = handle_payload_write(dev, &ccw);
>> +        break;
>> +    case PONG_READ:
>> +        rc = handle_payload_read(dev, &ccw);
>> +        break;
>> +    default:
>> +        rc = -ENOSYS;
>> +        break;
>> +    }
>> +
>> +    if (rc == -EIO) {
>> +        /* I/O error, specific devices generate specific conditions */
>> +        SCHIB *schib = &sch->curr_status;
>> +
>> +        sch->curr_status.scsw.dstat = SCSW_DSTAT_UNIT_CHECK;
>> +        sch->sense_data[0] = 0x40;    /* intervention-req */
> This is really odd. If it succeeds, you generate a unit check with
> intervention required? Confused. At the very least, this requires some
> description as to how this device is supposed to interact with the
> driver.


The unit check is only done in case of I/O error.

I thought it was right, since it should never happen.

Yes it needs some documentation.


>
>> +        schib->scsw.ctrl &= ~SCSW_ACTL_START_PEND;
>> +        schib->scsw.ctrl &= ~SCSW_CTRL_MASK_STCTL;
>> +        schib->scsw.ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
>> +                   SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>> +    }
>> +    return rc;
>> +}
>> +
>> +static void pong_ccw_realize(DeviceState *ds, Error **errp)
>> +{
>> +    uint16_t chpid;
>> +    CcwPONGDevice *dev = CCW_PONG(ds);
>> +    CcwDevice *cdev = CCW_DEVICE(ds);
>> +    CCWDeviceClass *cdk = CCW_DEVICE_GET_CLASS(cdev);
>> +    SubchDev *sch;
>> +    Error *err = NULL;
>> +
>> +    sch = css_create_sch(cdev->devno, errp);
>> +    if (!sch) {
>> +        return;
>> +    }
>> +
>> +    sch->driver_data = dev;
>> +    cdev->sch = sch;
>> +    chpid = css_find_free_chpid(sch->cssid);
>> +
>> +    if (chpid > MAX_CHPID) {
>> +        error_setg(&err, "No available chpid to use.");
>> +        goto out_err;
>> +    }
>> +
>> +    sch->id.reserved = 0xff;
>> +    sch->id.cu_type = CCW_PONG_CU_TYPE;
>> +    css_sch_build_virtual_schib(sch, (uint8_t)chpid,
>> +                                CCW_PONG_CHPID_TYPE);
>> +    sch->do_subchannel_work = do_subchannel_work_virtual;
>> +    sch->ccw_cb = pong_ccw_cb;
>> +
>> +    cdk->realize(cdev, &err);
>> +    if (err) {
>> +        goto out_err;
>> +    }
>> +
>> +    css_reset_sch(sch);
>> +    return;
>> +
>> +out_err:
>> +    error_propagate(errp, err);
>> +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
>> +    cdev->sch = NULL;
>> +    g_free(sch);
>> +}
>> +
>> +static Property pong_ccw_properties[] = {
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pong_ccw_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->props = pong_ccw_properties;
>> +    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
>> +    dc->realize = pong_ccw_realize;
>> +    dc->hotpluggable = false;
>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> Huh? misc seems like a better idea for this :)


Sure.


>
>> +}
>> +
>> +static const TypeInfo pong_ccw_info = {
>> +    .name = TYPE_CCW_PONG,
>> +    .parent = TYPE_CCW_DEVICE,
>> +    .instance_size = sizeof(CcwPONGDevice),
>> +    .class_init = pong_ccw_class_init,
>> +    .class_size = sizeof(CcwPONGClass),
>> +};
>> +
>> +static void pong_ccw_register(void)
>> +{
>> +    type_register_static(&pong_ccw_info);
>> +}
>> +
>> +type_init(pong_ccw_register)
> Some questions regarding this device and its intended usage:
>
> - What are you trying to test? Basic ccw processing, or something more
>    specific?

The original purpose is to serve as a device for the kv-unit-test 
development.

Testing the QEMU CCW from inside Secure Execution (next step).

>   Is there any way you can use the kvm-unit-test
>    infrastructure to test basic processing with an existing device?

At first we will use it inside SE so that real devices will not be the 
purpose.

The goal of the css test in the kvm-unit-test development for SE is to 
test I/O through VIRTIO-CCW


> - Who is instantiating this device? Only the kvm-unit-test?

yes.


> - Can you instantiate multiple instances?
Not yet
>   Does that make sense?
Probably not
>   If yes,
>    it should probably not request a new chpid every time :)
Yes, the development was quick.
> - What happens if someone instantiates this by hand?
this needs some work.
>   The only drawback
>    is that it uses up a subchannel and a chpid, right?


The development was very quick, I re-used something I developped 4 years 
ago.

It definitively needs more thinking.


> - Do you plan to make this hotpluggable later?

No, unless there is a good reason to.


Thanks a lot for the comments.

Regards,

Pierre


>
>
-- 
Pierre Morel
IBM Lab Boeblingen


