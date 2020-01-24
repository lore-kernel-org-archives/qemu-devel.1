Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAF22070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmW/bUbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAF22070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwV8-00033W-M7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuwTu-0002Wc-Qe
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuwTs-0001sH-Co
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:46:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuwTs-0001qF-7i
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579862787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inv4frxtO2Cm3gVW+0Ou36I2QKkZpA0nVjyxE4Akqcc=;
 b=fmW/bUbxLBF5OXs9j6qzDQbSdJTZFCvTZ9dpjr5yTuM3cDWgI88sMvekBdLLS2kTYgF46H
 RRs+EC0cNMyGroyUS9PK6UZZ2JSH2yC12MbTybNbkn/gAvTMqm040R25jDH5Jpo/u1mpEx
 md+TY6kc6NRfCI9A5GyyG0jee1c+fR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-BzbvlieaOuenGYrZ9ylm4A-1; Fri, 24 Jan 2020 05:46:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 306E5DB60
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:46:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 063865C298;
 Fri, 24 Jan 2020 10:46:07 +0000 (UTC)
Date: Fri, 24 Jan 2020 11:46:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH 1/2] qdev: Introduce qdev_get_bus_device
Message-ID: <20200124114606.3f564b83@redhat.com>
In-Reply-To: <20200115224025.538368-2-jusual@redhat.com>
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-2-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BzbvlieaOuenGYrZ9ylm4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 23:40:24 +0100
Julia Suvorova <jusual@redhat.com> wrote:

I's add () at the end of SUJ so it would be obvious that's a function

> For bus devices, it is useful to be able to handle the parent device.
maybe something like that would be more clear:

Add a wrapper qdev_get_bus_device() to replace dev->parent_bus->parent,
(add why here)

> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/core/qdev.c                      |  5 +++++
>  hw/pci-bridge/pci_expander_bridge.c |  4 +++-
>  hw/scsi/scsi-bus.c                  |  4 +++-
>  hw/usb/bus.c                        |  4 +++-
>  hw/usb/dev-smartcard-reader.c       | 32 +++++++++++++++++++++--------
>  hw/virtio/virtio-pci.c              | 16 +++++++++++++--
>  include/hw/qdev-core.h              |  2 ++
>  7 files changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 9f1753f5cf..ad8226e240 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -114,6 +114,11 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>      }
>  }
>  
> +DeviceState *qdev_get_bus_device(const DeviceState *dev)
> +{
> +    return dev->parent_bus ? dev->parent_bus->parent : NULL;

Does any caller expect to get NULL?
If not I'd move asserts you introduce below to this place only
and drop condition.

> +}
> +
>  /* Create a new device.  This only initializes the device state
>     structure and allows properties to be set.  The device still needs
>     to be realized.  See qdev-core.h.  */
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0592818447..63a6c07406 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -125,9 +125,11 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>      assert(position >= 0);
>  
>      pxb_dev_base = DEVICE(pxb_dev);
> -    main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
> +    main_host = PCI_HOST_BRIDGE(qdev_get_bus_device(pxb_dev_base));
>      main_host_sbd = SYS_BUS_DEVICE(main_host);
>  
> +    g_assert(main_host);
> +
>      if (main_host_sbd->num_mmio > 0) {
>          return g_strdup_printf(TARGET_FMT_plx ",%x",
>                                 main_host_sbd->mmio[0].addr, position + 1);
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index ad0e7f6d88..3d9497882b 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1558,10 +1558,12 @@ void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
>  static char *scsibus_get_dev_path(DeviceState *dev)
>  {
>      SCSIDevice *d = SCSI_DEVICE(dev);
> -    DeviceState *hba = dev->parent_bus->parent;
> +    DeviceState *hba = qdev_get_bus_device(dev);
>      char *id;
>      char *path;
>  
> +    g_assert(hba);
> +
>      id = qdev_get_dev_path(hba);
>      if (id) {
>          path = g_strdup_printf("%s/%d:%d:%d", id, d->channel, d->id, d->lun);
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index a6522f5429..26bf794315 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -587,9 +587,11 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
>  static char *usb_get_dev_path(DeviceState *qdev)
>  {
>      USBDevice *dev = USB_DEVICE(qdev);
> -    DeviceState *hcd = qdev->parent_bus->parent;
> +    DeviceState *hcd = qdev_get_bus_device(qdev);
>      char *id = NULL;
>  
> +    g_assert(hcd);
> +
>      if (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH)) {
>          id = qdev_get_dev_path(hcd);
>      }
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 4568db2568..fbb3599ddd 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1185,10 +1185,12 @@ void ccid_card_send_apdu_to_guest(CCIDCardState *card,
>                                    uint8_t *apdu, uint32_t len)
>  {
>      DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>      Answer *answer;
>  
> +    g_assert(dev);
> +
>      if (!ccid_has_pending_answers(s)) {
>          DPRINTF(s, 1, "CCID ERROR: got an APDU without pending answers\n");
>          return;
> @@ -1208,9 +1210,11 @@ void ccid_card_send_apdu_to_guest(CCIDCardState *card,
>  void ccid_card_card_removed(CCIDCardState *card)
>  {
>      DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>  
> +    g_assert(dev);
> +
>      ccid_on_slot_change(s, false);
>      ccid_flush_pending_answers(s);
>      ccid_reset(s);
> @@ -1219,9 +1223,11 @@ void ccid_card_card_removed(CCIDCardState *card)
>  int ccid_card_ccid_attach(CCIDCardState *card)
>  {
>      DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>  
> +    g_assert(dev);
> +
>      DPRINTF(s, 1, "CCID Attach\n");
>      return 0;
>  }
> @@ -1229,9 +1235,11 @@ int ccid_card_ccid_attach(CCIDCardState *card)
>  void ccid_card_ccid_detach(CCIDCardState *card)
>  {
>      DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>  
> +    g_assert(dev);
> +
>      DPRINTF(s, 1, "CCID Detach\n");
>      if (ccid_card_inserted(s)) {
>          ccid_on_slot_change(s, false);
> @@ -1242,9 +1250,11 @@ void ccid_card_ccid_detach(CCIDCardState *card)
>  void ccid_card_card_error(CCIDCardState *card, uint64_t error)
>  {
>      DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>  
> +    g_assert(dev);
> +
>      s->bmCommandStatus = COMMAND_STATUS_FAILED;
>      s->last_answer_error = error;
>      DPRINTF(s, 1, "VSC_Error: %" PRIX64 "\n", s->last_answer_error);
> @@ -1261,9 +1271,11 @@ void ccid_card_card_error(CCIDCardState *card, uint64_t error)
>  void ccid_card_card_inserted(CCIDCardState *card)
>  {
>      DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>  
> +    g_assert(dev);
> +
>      s->bmCommandStatus = COMMAND_STATUS_NO_ERROR;
>      ccid_flush_pending_answers(s);
>      ccid_on_slot_change(s, true);
> @@ -1273,10 +1285,12 @@ static void ccid_card_unrealize(DeviceState *qdev, Error **errp)
>  {
>      CCIDCardState *card = CCID_CARD(qdev);
>      CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>      Error *local_err = NULL;
>  
> +    g_assert(dev);
> +
>      if (ccid_card_inserted(s)) {
>          ccid_card_card_removed(card);
>      }
> @@ -1294,10 +1308,12 @@ static void ccid_card_realize(DeviceState *qdev, Error **errp)
>  {
>      CCIDCardState *card = CCID_CARD(qdev);
>      CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>      USBCCIDState *s = USB_CCID_DEV(dev);
>      Error *local_err = NULL;
>  
> +    g_assert(dev);
> +
>      if (card->slot != 0) {
>          error_setg(errp, "usb-ccid supports one slot, can't add %d",
>                     card->slot);
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f723b9f631..8ce9269aab 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1317,9 +1317,21 @@ static uint64_t virtio_pci_notify_read(void *opaque, hwaddr addr,
>  static void virtio_pci_notify_write(void *opaque, hwaddr addr,
>                                      uint64_t val, unsigned size)
>  {
> +    DeviceState *dev = DEVICE(opaque);
>      VirtIODevice *vdev = opaque;
> -    VirtIOPCIProxy *proxy = VIRTIO_PCI(DEVICE(vdev)->parent_bus->parent);
> -    unsigned queue = addr / virtio_pci_queue_mem_mult(proxy);
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev_get_bus_device(dev));


> +    unsigned queue;
> +
> +    /*
> +     * During unplug virtio device may have
> +     * already been disconnected from the bus
> +     */
> +    if (!proxy) {
> +        warn_report("Device %s doesn't have parent bus", vdev->name);
> +        return;
> +    }
> +
> +    queue = addr / virtio_pci_queue_mem_mult(proxy);

modulo qdev_get_bus_device() change, the rest of this hunk looks
to unrelated to this patch.
I'd split it out into separate patch with proper commit message.


>      if (queue < VIRTIO_QUEUE_MAX) {
>          virtio_queue_notify(vdev, queue);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1518495b1e..05d68f0f1a 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -452,6 +452,8 @@ Object *qdev_get_machine(void);
>  /* FIXME: make this a link<> */
>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
>  
> +DeviceState *qdev_get_bus_device(const DeviceState *dev);
> +
>  extern bool qdev_hotplug;
>  extern bool qdev_hot_removed;
>  


