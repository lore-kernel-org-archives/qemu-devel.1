Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BBCC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B91220866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B91220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnmb-0004F7-US
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <farman@linux.ibm.com>) id 1hbnER-0004Yz-A3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1hbnEN-00023P-Ou
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47094
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1hbnEN-0001tc-FS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5EEHQSo059180
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:30:50 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t4cggtqdc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:30:49 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 14 Jun 2019 15:30:48 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Jun 2019 15:30:46 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5EEUjjO36503966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 14:30:45 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E99AE060;
 Fri, 14 Jun 2019 14:30:45 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70741AE068;
 Fri, 14 Jun 2019 14:30:45 +0000 (GMT)
Received: from [9.85.188.22] (unknown [9.85.188.22])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2019 14:30:45 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20190614092705.11025-1-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 14 Jun 2019 10:30:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614092705.11025-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061414-0052-0000-0000-000003D11258
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011260; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217877; UDB=6.00640468; IPR=6.00998998; 
 MB=3.00027308; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-14 14:30:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061414-0053-0000-0000-000061538409
Message-Id: <790578fe-9d90-bfa1-a540-f7f054d8293f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=864 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: use vfio_set_irq_signaling
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/14/19 5:27 AM, Cornelia Huck wrote:
> Use the new helper.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/vfio/ccw.c | 68 +++++++++++----------------------------------------
>  1 file changed, 14 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 03a2becb3ec9..3dc08721a3db 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -197,10 +197,7 @@ read_err:
>  static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>  {
>      VFIODevice *vdev = &vcdev->vdev;
> -    struct vfio_irq_info *irq_info;
> -    struct vfio_irq_set *irq_set;
> -    size_t argsz;
> -    int32_t *pfd;
> +    int fd;
>  
>      if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
>          error_setg(errp, "vfio: unexpected number of io irqs %u",
> @@ -208,72 +205,35 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
>          return;
>      }
>  
> -    argsz = sizeof(*irq_info);
> -    irq_info = g_malloc0(argsz);
> -    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> -    irq_info->argsz = argsz;
> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> -              irq_info) < 0 || irq_info->count < 1) {
> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> -        goto out_free_info;
> -    }
> -

Don't we still need this hunk?  (And the out_free_info label stuff that
cleans it up.)  I don't see vfio_set_irq_signaling() covering it.

>      if (event_notifier_init(&vcdev->io_notifier, 0)) {
>          error_setg_errno(errp, errno,
>                           "vfio: Unable to init event notifier for IO");
> -        goto out_free_info;
> +        return;
>      }
>  
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *) &irq_set->data;
> -
> -    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> -    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_setg(errp, "vfio: Failed to set up io notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
> +    fd = event_notifier_get_fd(&vcdev->io_notifier);
> +    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> +
> +    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
> +        qemu_set_fd_handler(fd, NULL, NULL, vcdev);

This sure looks nice though.  :)

>          event_notifier_cleanup(&vcdev->io_notifier);
>      }
> -
> -    g_free(irq_set);
> -
> -out_free_info:
> -    g_free(irq_info);
>  }
>  
>  static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
>  {
> -    struct vfio_irq_set *irq_set;
> -    size_t argsz;
> -    int32_t *pfd;
> -
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *) &irq_set->data;
> -    *pfd = -1;
> -
> -    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to de-assign device io fd: %m");
> +    Error *err = NULL;
> +
> +    vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                           VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err);
> +    if (err) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>      }
>  
>      qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
>                          NULL, NULL, vcdev);
>      event_notifier_cleanup(&vcdev->io_notifier);
> -
> -    g_free(irq_set);
>  }
>  
>  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> 


