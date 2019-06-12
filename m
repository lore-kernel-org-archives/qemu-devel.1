Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60051C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B68F207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B68F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayJf-0006F6-CQ
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50106)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hayHf-0004JT-Iq
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hayG0-0003ZO-NB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hayG0-0003Yv-Eh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:05:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AEE80308330B;
 Wed, 12 Jun 2019 08:05:19 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C2BC7D5CF;
 Wed, 12 Jun 2019 08:05:15 +0000 (UTC)
To: Alex Williamson <alex.williamson@redhat.com>
References: <20190611154725.5343-1-eric.auger@redhat.com>
 <20190611134847.63c52afb@x1.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <941eb731-6d85-458c-0468-c7a5b6003ca9@redhat.com>
Date: Wed, 12 Jun 2019 10:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190611134847.63c52afb@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 08:05:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: cohuck@redhat.com, qemu-devel@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 6/11/19 9:48 PM, Alex Williamson wrote:
> On Tue, 11 Jun 2019 17:47:25 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> The code used to assign an interrupt index/subindex to an
>> eventfd is duplicated many times. Let's introduce an helper that
>> allows to set/unset the signaling for an ACTION_TRIGGER,
>> ACTION_MASK or ACTION_UNMASK action.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - irq_to_str() simply outputs the IRQ index if the VFIO device is
>>   not of PCI type
>> - removed "vfio: failed to start eventfd signaling ../.." in vfio_platform
>>
>> v1 -> v2:
>> - don't call GET_IRQ_INFO in vfio_set_irq_signaling()
>>   and restore quiet check in vfio_register_req_notifier.
>>   Nicer display of the IRQ name.
>>
>> This is a follow-up to
>> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
>> It looks to me that introducing vfio_set_irq_signaling() has more
>> benefits in term of code reduction and the helper abstraction
>> looks cleaner.
>> ---
>>  hw/vfio/common.c              |  83 +++++++++++++
>>  hw/vfio/pci.c                 | 217 ++++++++--------------------------
>>  hw/vfio/platform.c            |  62 ++++------
>>  include/hw/vfio/vfio-common.h |   2 +
>>  4 files changed, 156 insertions(+), 208 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 4374cc6176..4b8acd556f 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -95,6 +95,89 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
>>      ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
>>  }
>>  
>> +static inline const char *action_to_str(int action)
>> +{
>> +    switch (action) {
>> +    case VFIO_IRQ_SET_ACTION_MASK:
>> +        return "MASK";
>> +    case VFIO_IRQ_SET_ACTION_UNMASK:
>> +        return "UNMASK";
>> +    case VFIO_IRQ_SET_ACTION_TRIGGER:
>> +        return "TRIGGER";
>> +    default:
>> +        return "UNKNOWN ACTION";
>> +    }
>> +}
>> +
>> +static char *irq_to_str(VFIODevice *vbasedev, int index, int subindex)
>> +{
>> +    char *str;
>> +
>> +    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>> +        str = g_strdup_printf("index %d", index);
> 
> "index %d-%d", index, subindex?
> 
> If this is our generic name, let's not assume subindex doesn't matter.
My bad, I understood from your v2 comment you just wanted to print the
index.
> 
>> +        return str;
>> +    }
>> +
>> +    switch (index) {
>> +    case VFIO_PCI_INTX_IRQ_INDEX:
>> +        str = g_strdup_printf("INTX-%d", subindex);
>> +        break;
>> +    case VFIO_PCI_MSI_IRQ_INDEX:
>> +        str = g_strdup_printf("MSI-%d", subindex);
>> +        break;
>> +    case VFIO_PCI_MSIX_IRQ_INDEX:
>> +        str = g_strdup_printf("MSIX-%d", subindex);
>> +        break;
>> +    case VFIO_PCI_ERR_IRQ_INDEX:
>> +        str = g_strdup_printf("ERR-%d", subindex);
>> +        break;
>> +    case VFIO_PCI_REQ_IRQ_INDEX:
>> +        str = g_strdup_printf("REQ-%d", subindex);
>> +        break;
>> +    default:
>> +        str = g_strdup_printf("index %d (unknown)", index);
> 
> Let's just make this the same as non-PCI, adding "unknown" here implies
> we need to extend this for every interrupt type rather than just naming
> some of them for convenience.  When we add device specific interrupts
> the ROI to generate names might not be worthwhile.
done
> 
>> +        break;
>> +    }
>> +    return str;
>> +}
>> +
>> +int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>> +                           int action, int fd, Error **errp)
>> +{
>> +    struct vfio_irq_set *irq_set;
>> +    int argsz, ret = 0;
>> +    int32_t *pfd;
>> +    char *irq_name;
>> +
>> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> +
>> +    irq_set = g_malloc0(argsz);
>> +    irq_set->argsz = argsz;
>> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | action;
>> +    irq_set->index = index;
>> +    irq_set->start = subindex;
>> +    irq_set->count = 1;
>> +    pfd = (int32_t *)&irq_set->data;
>> +    *pfd = fd;
>> +
>> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> +
>> +    g_free(irq_set);
>> +
>> +    if (!ret) {
>> +        return 0;
>> +    }
>> +
>> +    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
>> +    irq_name = irq_to_str(vbasedev, index, subindex);
>> +    error_prepend(errp,
>> +                  "Failed to %s %s eventfd signaling for interrupt %s: ",
>> +                  fd < 0 ? "tear down" : "set up", action_to_str(action),
>> +                  irq_name);
> 
> Can't we repeatedly call error_prepend to avoid needing to allocate
> irq_name?  ex:
> 
> name = irq_to_str(vbasedev, index); // "INTx", "MSI", "MSIX", ...
> error_prepend(errp, "Failed to %s %s eventfd signaling for interrupt "
>               fd < 0 ? "tear down" : "set up", action_to_str(action));
> if (name) {
>     error_prepend(errp, "%s-%d:", name, subindex);
> } else {
>     error_prepend(errp, "index %d-%d:", index, subindex);
> }
done (in the opposite order).

Thanks

Eric
> 
> Thanks,
> Alex
> 
> 
>> +    g_free(irq_name);
>> +    return ret;
>> +}
>> +
>>  /*
>>   * IO Port/MMIO - Beware of the endians, VFIO is always little endian
>>   */
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 2a4091d216..65c2e17028 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -113,9 +113,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>          .gsi = vdev->intx.route.irq,
>>          .flags = KVM_IRQFD_FLAG_RESAMPLE,
>>      };
>> -    struct vfio_irq_set *irq_set;
>> -    int ret, argsz;
>> -    int32_t *pfd;
>> +    Error *err = NULL;
>>  
>>      if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
>>          vdev->intx.route.mode != PCI_INTX_ENABLED ||
>> @@ -143,22 +141,10 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>          goto fail_irqfd;
>>      }
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK;
>> -    irq_set->index = VFIO_PCI_INTX_IRQ_INDEX;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -
>> -    *pfd = irqfd.resamplefd;
>> -
>> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -    g_free(irq_set);
>> -    if (ret) {
>> -        error_setg_errno(errp, -ret, "failed to setup INTx unmask fd");
>> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>> +                               VFIO_IRQ_SET_ACTION_UNMASK,
>> +                               irqfd.resamplefd, &err)) {
>> +        error_propagate(errp, err);
>>          goto fail_vfio;
>>      }
>>  
>> @@ -262,10 +248,10 @@ static void vfio_intx_update(PCIDevice *pdev)
>>  static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>  {
>>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>> -    int ret, argsz, retval = 0;
>> -    struct vfio_irq_set *irq_set;
>> -    int32_t *pfd;
>>      Error *err = NULL;
>> +    int32_t fd;
>> +    int ret;
>> +
>>  
>>      if (!pin) {
>>          return 0;
>> @@ -292,27 +278,15 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>          error_setg_errno(errp, -ret, "event_notifier_init failed");
>>          return ret;
>>      }
>> +    fd = event_notifier_get_fd(&vdev->intx.interrupt);
>> +    qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
>> -    irq_set->index = VFIO_PCI_INTX_IRQ_INDEX;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -
>> -    *pfd = event_notifier_get_fd(&vdev->intx.interrupt);
>> -    qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
>> -
>> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -    if (ret) {
>> -        error_setg_errno(errp, -ret, "failed to setup INTx fd");
>> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
>> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>> +        error_propagate(errp, err);
>> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>>          event_notifier_cleanup(&vdev->intx.interrupt);
>> -        retval = -errno;
>> -        goto cleanup;
>> +        return -errno;
>>      }
>>  
>>      vfio_intx_enable_kvm(vdev, &err);
>> @@ -323,11 +297,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>      vdev->interrupt = VFIO_INT_INTx;
>>  
>>      trace_vfio_intx_enable(vdev->vbasedev.name);
>> -
>> -cleanup:
>> -    g_free(irq_set);
>> -
>> -    return retval;
>> +    return 0;
>>  }
>>  
>>  static void vfio_intx_disable(VFIOPCIDevice *vdev)
>> @@ -530,31 +500,19 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>              error_report("vfio: failed to enable vectors, %d", ret);
>>          }
>>      } else {
>> -        int argsz;
>> -        struct vfio_irq_set *irq_set;
>> -        int32_t *pfd;
>> -
>> -        argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -        irq_set = g_malloc0(argsz);
>> -        irq_set->argsz = argsz;
>> -        irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                         VFIO_IRQ_SET_ACTION_TRIGGER;
>> -        irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
>> -        irq_set->start = nr;
>> -        irq_set->count = 1;
>> -        pfd = (int32_t *)&irq_set->data;
>> +        Error *err = NULL;
>> +        int32_t fd;
>>  
>>          if (vector->virq >= 0) {
>> -            *pfd = event_notifier_get_fd(&vector->kvm_interrupt);
>> +            fd = event_notifier_get_fd(&vector->kvm_interrupt);
>>          } else {
>> -            *pfd = event_notifier_get_fd(&vector->interrupt);
>> +            fd = event_notifier_get_fd(&vector->interrupt);
>>          }
>>  
>> -        ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -        g_free(irq_set);
>> -        if (ret) {
>> -            error_report("vfio: failed to modify vector, %d", ret);
>> +        if (vfio_set_irq_signaling(&vdev->vbasedev,
>> +                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
>> +                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>> +            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>          }
>>      }
>>  
>> @@ -591,26 +549,10 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>       * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
>>       */
>>      if (vector->virq >= 0) {
>> -        int argsz;
>> -        struct vfio_irq_set *irq_set;
>> -        int32_t *pfd;
>> +        int32_t fd = event_notifier_get_fd(&vector->interrupt);
>>  
>> -        argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -        irq_set = g_malloc0(argsz);
>> -        irq_set->argsz = argsz;
>> -        irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                         VFIO_IRQ_SET_ACTION_TRIGGER;
>> -        irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
>> -        irq_set->start = nr;
>> -        irq_set->count = 1;
>> -        pfd = (int32_t *)&irq_set->data;
>> -
>> -        *pfd = event_notifier_get_fd(&vector->interrupt);
>> -
>> -        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -
>> -        g_free(irq_set);
>> +        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);
>>      }
>>  }
>>  
>> @@ -2636,10 +2578,8 @@ static void vfio_err_notifier_handler(void *opaque)
>>   */
>>  static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>  {
>> -    int ret;
>> -    int argsz;
>> -    struct vfio_irq_set *irq_set;
>> -    int32_t *pfd;
>> +    Error *err = NULL;
>> +    int32_t fd;
>>  
>>      if (!vdev->pci_aer) {
>>          return;
>> @@ -2651,58 +2591,30 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>          return;
>>      }
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> +    fd = event_notifier_get_fd(&vdev->err_notifier);
>> +    qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>>  
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
>> -    irq_set->index = VFIO_PCI_ERR_IRQ_INDEX;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -
>> -    *pfd = event_notifier_get_fd(&vdev->err_notifier);
>> -    qemu_set_fd_handler(*pfd, vfio_err_notifier_handler, NULL, vdev);
>> -
>> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -    if (ret) {
>> -        error_report("vfio: Failed to set up error notification");
>> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
>> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>>          event_notifier_cleanup(&vdev->err_notifier);
>>          vdev->pci_aer = false;
>>      }
>> -    g_free(irq_set);
>>  }
>>  
>>  static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>>  {
>> -    int argsz;
>> -    struct vfio_irq_set *irq_set;
>> -    int32_t *pfd;
>> -    int ret;
>> +    Error *err = NULL;
>>  
>>      if (!vdev->pci_aer) {
>>          return;
>>      }
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
>> -    irq_set->index = VFIO_PCI_ERR_IRQ_INDEX;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -    *pfd = -1;
>> -
>> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -    if (ret) {
>> -        error_report("vfio: Failed to de-assign error fd: %m");
>> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>      }
>> -    g_free(irq_set);
>>      qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
>>                          NULL, NULL, vdev);
>>      event_notifier_cleanup(&vdev->err_notifier);
>> @@ -2727,9 +2639,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>  {
>>      struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
>>                                        .index = VFIO_PCI_REQ_IRQ_INDEX };
>> -    int argsz;
>> -    struct vfio_irq_set *irq_set;
>> -    int32_t *pfd;
>> +    Error *err = NULL;
>> +    int32_t fd;
>>  
>>      if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
>>          return;
>> @@ -2745,57 +2656,31 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>          return;
>>      }
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> +    fd = event_notifier_get_fd(&vdev->req_notifier);
>> +    qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>>  
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
>> -    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -
>> -    *pfd = event_notifier_get_fd(&vdev->req_notifier);
>> -    qemu_set_fd_handler(*pfd, vfio_req_notifier_handler, NULL, vdev);
>> -
>> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
>> -        error_report("vfio: Failed to set up device request notification");
>> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
>> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>> +                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>>          event_notifier_cleanup(&vdev->req_notifier);
>>      } else {
>>          vdev->req_enabled = true;
>>      }
>> -
>> -    g_free(irq_set);
>>  }
>>  
>>  static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>>  {
>> -    int argsz;
>> -    struct vfio_irq_set *irq_set;
>> -    int32_t *pfd;
>> +    Error *err = NULL;
>>  
>>      if (!vdev->req_enabled) {
>>          return;
>>      }
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
>> -    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -    *pfd = -1;
>> -
>> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
>> -        error_report("vfio: Failed to de-assign device request fd: %m");
>> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>      }
>> -    g_free(irq_set);
>>      qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
>>                          NULL, NULL, vdev);
>>      event_notifier_cleanup(&vdev->req_notifier);
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index d52d6552e0..8d6012857e 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -106,26 +106,19 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
>>                                      eventfd_user_side_handler_t handler)
>>  {
>>      VFIODevice *vbasedev = &intp->vdev->vbasedev;
>> -    struct vfio_irq_set *irq_set;
>> -    int argsz, ret;
>> -    int32_t *pfd;
>> +    int32_t fd = event_notifier_get_fd(intp->interrupt);
>> +    Error *err = NULL;
>> +    int ret;
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
>> -    irq_set->index = intp->pin;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -    *pfd = event_notifier_get_fd(intp->interrupt);
>> -    qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
>> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -    if (ret < 0) {
>> -        error_report("vfio: Failed to set trigger eventfd: %m");
>> -        qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
>> +    qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
>> +
>> +    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
>> +                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err);
>> +    if (ret) {
>> +        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
>> +        qemu_set_fd_handler(fd, NULL, NULL, NULL);
>>      }
>> -    g_free(irq_set);
>> +
>>      return ret;
>>  }
>>  
>> @@ -330,7 +323,6 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
>>  
>>  static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
>>  {
>> -    int ret;
>>      VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
>>      VFIOINTp *intp;
>>  
>> @@ -341,10 +333,7 @@ static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
>>      }
>>      assert(intp);
>>  
>> -    ret = vfio_set_trigger_eventfd(intp, vfio_intp_interrupt);
>> -    if (ret) {
>> -        error_report("vfio: failed to start eventfd signaling for IRQ %d: %m",
>> -                     intp->pin);
>> +    if (vfio_set_trigger_eventfd(intp, vfio_intp_interrupt)) {
>>          abort();
>>      }
>>  }
>> @@ -361,25 +350,16 @@ static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
>>   */
>>  static int vfio_set_resample_eventfd(VFIOINTp *intp)
>>  {
>> +    int32_t fd = event_notifier_get_fd(intp->unmask);
>>      VFIODevice *vbasedev = &intp->vdev->vbasedev;
>> -    struct vfio_irq_set *irq_set;
>> -    int argsz, ret;
>> -    int32_t *pfd;
>> +    Error *err = NULL;
>> +    int ret;
>>  
>> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -    irq_set = g_malloc0(argsz);
>> -    irq_set->argsz = argsz;
>> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK;
>> -    irq_set->index = intp->pin;
>> -    irq_set->start = 0;
>> -    irq_set->count = 1;
>> -    pfd = (int32_t *)&irq_set->data;
>> -    *pfd = event_notifier_get_fd(intp->unmask);
>> -    qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
>> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -    g_free(irq_set);
>> -    if (ret < 0) {
>> -        error_report("vfio: Failed to set resample eventfd: %m");
>> +    qemu_set_fd_handler(fd, NULL, NULL, NULL);
>> +    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
>> +                                 VFIO_IRQ_SET_ACTION_UNMASK, fd, &err);
>> +    if (ret) {
>> +        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
>>      }
>>      return ret;
>>  }
>> @@ -435,8 +415,6 @@ static void vfio_start_irqfd_injection(SysBusDevice *sbdev, qemu_irq irq)
>>      return;
>>  fail_vfio:
>>      kvm_irqchip_remove_irqfd_notifier(kvm_state, intp->interrupt, irq);
>> -    error_report("vfio: failed to start eventfd signaling for IRQ %d: %m",
>> -                 intp->pin);
>>      abort();
>>  fail_irqfd:
>>      vfio_start_eventfd_injection(sbdev, irq);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1155b79678..686d99ff8c 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -167,6 +167,8 @@ void vfio_put_base_device(VFIODevice *vbasedev);
>>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>> +int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>> +                           int action, int fd, Error **errp);
>>  void vfio_region_write(void *opaque, hwaddr addr,
>>                             uint64_t data, unsigned size);
>>  uint64_t vfio_region_read(void *opaque,
> 

