Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6A4C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 19:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14A02086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 19:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14A02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hamYZ-0001J5-VY
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 15:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alifm@linux.ibm.com>) id 1hamX9-0000pK-SS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 15:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alifm@linux.ibm.com>) id 1hamX8-0004Bq-5s
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 15:34:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hamX7-0004AH-PJ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 15:34:14 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5BJWvOH133736
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:34:06 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t2h5guq79-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:34:06 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
 Tue, 11 Jun 2019 20:34:05 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Jun 2019 20:34:02 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5BJY0ZD19399162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 19:34:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7ADB78060;
 Tue, 11 Jun 2019 19:34:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 527847805E;
 Tue, 11 Jun 2019 19:34:00 +0000 (GMT)
Received: from [9.56.58.18] (unknown [9.56.58.18])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 11 Jun 2019 19:34:00 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20190607145353.2052-1-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 11 Jun 2019 15:33:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190607145353.2052-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061119-0016-0000-0000-000009C17419
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216563; UDB=6.00639665; IPR=6.00997663; 
 MB=3.00027268; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 19:34:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061119-0017-0000-0000-0000439D5D7B
Message-Id: <e07bf42d-2b8a-382c-85c8-520985ddfe8a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-11_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110125
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06/07/2019 10:53 AM, Cornelia Huck wrote:
> A vfio-ccw device may provide an async command subregion for
> issuing halt/clear subchannel requests. If it is present, use
> it for sending halt/clear request to the device; if not, fall
> back to emulation (as done today).
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v4->v5:
> - It seems we need to take the indirection via the class for the
>    callbacks after all :(
> - Dropped Eric's R-b: for that reason
> 
> ---
>   hw/s390x/css.c              |  27 +++++++--
>   hw/s390x/s390-ccw.c         |  20 +++++++
>   hw/vfio/ccw.c               | 112 +++++++++++++++++++++++++++++++++++-
>   include/hw/s390x/css.h      |   3 +
>   include/hw/s390x/s390-ccw.h |   2 +
>   5 files changed, 158 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index ad310b9f94bc..b92395f165e6 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -22,6 +22,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390_flic.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/s390x/s390-ccw.h"
>   
>   typedef struct CrwContainer {
>       CRW crw;
> @@ -1205,6 +1206,26 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>   
>   }
>   
> +static void sch_handle_halt_func_passthrough(SubchDev *sch)
> +{
> +    int ret;
> +
> +    ret = s390_ccw_halt(sch);
> +    if (ret == -ENOSYS) {
> +        sch_handle_halt_func(sch);
> +    }
> +}
> +
> +static void sch_handle_clear_func_passthrough(SubchDev *sch)
> +{
> +    int ret;
> +
> +    ret = s390_ccw_clear(sch);
> +    if (ret == -ENOSYS) {
> +        sch_handle_clear_func(sch);
> +    }
> +}
> +
>   static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>   {
>       SCHIB *schib = &sch->curr_status;
> @@ -1244,11 +1265,9 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
>       SCHIB *schib = &sch->curr_status;
>   
>       if (schib->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
> -        /* TODO: Clear handling */
> -        sch_handle_clear_func(sch);
> +        sch_handle_clear_func_passthrough(sch);
>       } else if (schib->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
> -        /* TODO: Halt handling */
> -        sch_handle_halt_func(sch);
> +        sch_handle_halt_func_passthrough(sch);
>       } else if (schib->scsw.ctrl & SCSW_FCTL_START_FUNC) {
>           return sch_handle_start_func_passthrough(sch);
>       }
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index f5f025d1b6ca..951be5ab0245 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -29,6 +29,26 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
>       return cdc->handle_request(sch);
>   }
>   
> +int s390_ccw_halt(SubchDev *sch)
> +{
> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
> +
> +    if (!cdc->handle_halt) {
> +        return -ENOSYS;
> +    }
> +    return cdc->handle_halt(sch);
> +}
> +
> +int s390_ccw_clear(SubchDev *sch)
> +{
> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
> +
> +    if (!cdc->handle_clear) {
> +        return -ENOSYS;
> +    }
> +    return cdc->handle_clear(sch);
> +}
> +
>   static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>                                     char *sysfsdev,
>                                     Error **errp)
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index d9e39552e237..c9d1c76b4d04 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -2,9 +2,12 @@
>    * vfio based subchannel assignment support
>    *
>    * Copyright 2017 IBM Corp.
> + * Copyright 2019 Red Hat, Inc.
> + *
>    * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>    *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>    *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> + *            Cornelia Huck <cohuck@redhat.com>
>    *
>    * This work is licensed under the terms of the GNU GPL, version 2 or (at
>    * your option) any later version. See the COPYING file in the top-level
> @@ -32,6 +35,9 @@ struct VFIOCCWDevice {
>       uint64_t io_region_size;
>       uint64_t io_region_offset;
>       struct ccw_io_region *io_region;
> +    uint64_t async_cmd_region_size;
> +    uint64_t async_cmd_region_offset;
> +    struct ccw_cmd_region *async_cmd_region;
>       EventNotifier io_notifier;
>       bool force_orb_pfch;
>       bool warned_orb_pfch;
> @@ -114,6 +120,87 @@ again:
>       }
>   }
>   
> +static int vfio_ccw_handle_clear(SubchDev *sch)
> +{
> +    S390CCWDevice *cdev = sch->driver_data;
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +    struct ccw_cmd_region *region = vcdev->async_cmd_region;
> +    int ret;
> +
> +    if (!vcdev->async_cmd_region) {
> +        /* Async command region not available, fall back to emulation */
> +        return -ENOSYS;
> +    }
> +
> +    memset(region, 0, sizeof(*region));
> +    region->command = VFIO_CCW_ASYNC_CMD_CSCH;
> +
> +again:
> +    ret = pwrite(vcdev->vdev.fd, region,
> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
> +    if (ret != vcdev->async_cmd_region_size) {
> +        if (errno == EAGAIN) {
> +            goto again;
> +        }
> +        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
> +        ret = -errno;
> +    } else {
> +        ret = region->ret_code;
> +    }
> +    switch (ret) {
> +    case 0:
> +    case -ENODEV:
> +    case -EACCES:
> +        return 0;
> +    case -EFAULT:
> +    default:
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return 0;
> +    }
> +}
> +
> +static int vfio_ccw_handle_halt(SubchDev *sch)
> +{
> +    S390CCWDevice *cdev = sch->driver_data;
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +    struct ccw_cmd_region *region = vcdev->async_cmd_region;
> +    int ret;
> +
> +    if (!vcdev->async_cmd_region) {
> +        /* Async command region not available, fall back to emulation */
> +        return -ENOSYS;
> +    }
> +
> +    memset(region, 0, sizeof(*region));
> +    region->command = VFIO_CCW_ASYNC_CMD_HSCH;
> +
> +again:
> +    ret = pwrite(vcdev->vdev.fd, region,
> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
> +    if (ret != vcdev->async_cmd_region_size) {
> +        if (errno == EAGAIN) {
> +            goto again;
> +        }
> +        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
> +        ret = -errno;
> +    } else {
> +        ret = region->ret_code;
> +    }
> +    switch (ret) {
> +    case 0:
> +    case -EBUSY:
> +    case -ENODEV:
> +    case -EACCES:
> +        return 0;
> +    case -EFAULT:
> +    default:
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return 0;
> +    }
> +}
> +
>   static void vfio_ccw_reset(DeviceState *dev)
>   {
>       CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> @@ -287,9 +374,13 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           return;
>       }
>   
> +    /*
> +     * We always expect at least the I/O region to be present. We also
> +     * may have a variable number of regions governed by capabilities.
> +     */
>       if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
> -        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
> -                   vdev->num_regions);
> +        error_setg(errp, "vfio: too few regions (%u), expected at least %u",
> +                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
>           return;
>       }
>   
> @@ -309,11 +400,26 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>       vcdev->io_region_offset = info->offset;
>       vcdev->io_region = g_malloc0(info->size);
>   
> +    /* check for the optional async command region */
> +    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
> +                                   VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &info);
> +    if (!ret) {
> +        vcdev->async_cmd_region_size = info->size;
> +        if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
> +            error_setg(errp, "vfio: Unexpected size of the async cmd region");
> +            g_free(info);
> +            return;
> +        }
> +        vcdev->async_cmd_region_offset = info->offset;
> +        vcdev->async_cmd_region = g_malloc0(info->size);
> +    }
> +
>       g_free(info);
>   }
>   
>   static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>   {
> +    g_free(vcdev->async_cmd_region);
>       g_free(vcdev->io_region);
>   }

I think we can have a memory leak given how the code is currently 
structured and how we call vfio_ccw_get_region.

vfio_ccw_get_region is called in vfio_ccw_realize. So if we return an 
error from vfio_ccw_get_region, we would jump to out_region_err in 
vfio_ccw_realize which would call vfio_ccw_put_device.

Now we can also return an error from vfio_ccw_get_region for the async 
region, and so we might never end up freeing the io_region for which we 
allocated memory successfully.

I think we would also need to change vfio_ccw_realize, no?

Thanks
Farhan

>   
> @@ -486,6 +592,8 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>       dc->reset = vfio_ccw_reset;
>   
>       cdc->handle_request = vfio_ccw_handle_request;
> +    cdc->handle_halt = vfio_ccw_handle_halt;
> +    cdc->handle_clear = vfio_ccw_handle_clear;
>   }
>   
>   static const TypeInfo vfio_ccw_info = {
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 7cc183ef4366..d033387fba8a 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -215,6 +215,9 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch);
>   IOInstEnding do_subchannel_work_virtual(SubchDev *sub);
>   IOInstEnding do_subchannel_work_passthrough(SubchDev *sub);
>   
> +int s390_ccw_halt(SubchDev *sch);
> +int s390_ccw_clear(SubchDev *sch);
> +
>   typedef enum {
>       CSS_IO_ADAPTER_VIRTIO = 0,
>       CSS_IO_ADAPTER_PCI = 1,
> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
> index 901d805d79a3..fffb54562f6d 100644
> --- a/include/hw/s390x/s390-ccw.h
> +++ b/include/hw/s390x/s390-ccw.h
> @@ -35,6 +35,8 @@ typedef struct S390CCWDeviceClass {
>       void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
>       void (*unrealize)(S390CCWDevice *dev, Error **errp);
>       IOInstEnding (*handle_request) (SubchDev *sch);
> +    int (*handle_halt) (SubchDev *sch);
> +    int (*handle_clear) (SubchDev *sch);
>   } S390CCWDeviceClass;
>   
>   #endif
> 


