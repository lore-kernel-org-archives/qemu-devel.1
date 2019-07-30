Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D133AC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9679220665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9679220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsNby-00032B-Pd
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 04:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsNb2-0002IA-V7
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsNb0-0002bi-Ss
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:35:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsNb0-0002bU-Lu
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:34:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id r4so45907863qkm.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 01:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mA8gAhw1CHn+4KHxWdQZvdg+A5bq56mx8/ZI3L+U+3o=;
 b=FWcXPC0d0/6u03opVDCbwmbaXRwEAW0xYQeCBOdEu+ZO4Gf9wxkCYV0PsUI94UmRWU
 rZXtnd5gpMF9SwCR3vu+SibtN8e618QDx8TKLTSzzihiYcFis7mhqKfn5uYbbJ3FJO0T
 m0L20SlzriACAos81KvZNMUIQDv4oD1xt5DZ1/O7YlNt2E31G0kftJIVGcJCj0TUwAt2
 epNxEZIK5J6HSvXlmQjj7DBg0qK1U7gdjX1AfwEjdr3H2z1vlxa/7UeVatYnnxn8dZTd
 7eCKWeuGGhB/H7Sk5faavj1P7EdAJqf8sxKvytW4QpYFA2ZPITF3JDYLAdx4NBFyPqKY
 oImg==
X-Gm-Message-State: APjAAAVfNso1jS2AXRSrO4TAVas5T/aTZUsJ2ENtIZvqD2lqr/hvIkCj
 28SBqLCqj8wQgyUPa2OuOEVdVA==
X-Google-Smtp-Source: APXvYqwauh9safqVDdBOb+ShqVwzrYJLX7YfjG4RYzNfR7lmDbLdWh8zfzIUOO88PWkUW6Q5LHxdsQ==
X-Received: by 2002:a37:9fd6:: with SMTP id
 i205mr77721823qke.130.1564475698067; 
 Tue, 30 Jul 2019 01:34:58 -0700 (PDT)
Received: from redhat.com ([147.234.38.1])
 by smtp.gmail.com with ESMTPSA id m19sm27654244qkk.29.2019.07.30.01.34.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 01:34:57 -0700 (PDT)
Date: Tue, 30 Jul 2019 04:34:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190730042004-mutt-send-email-mst@kernel.org>
References: <20190729125755.45008-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729125755.45008-1-slp@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 02:57:55PM +0200, Sergio Lopez wrote:
> Implement the modern (v2) personality, according to the VirtIO 1.0
> specification.
> 
> Support for v2 among guests is not as widespread as it'd be
> desirable. While the Linux driver has had it for a while, support is
> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.

The fact that there was no open source hypervisor implementation has
probably contributed to this :)

> For this reason, the v2 personality is disabled, keeping the legacy
> behavior as default.

I agree it's a good default for existing machine types.

> Machine types willing to use v2, can enable it
> using MachineClass's compat_props.

Hmm. Are compat_props really the recommended mechanism to
tweak defaults? I was under the impression it's
only for compatibility with old machine types.
Eduardo, any opinion on this?

> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Endian-ness seems to be wrong:

static const MemoryRegionOps virtio_mem_ops = {
    .read = virtio_mmio_read,
    .write = virtio_mmio_write,
    .endianness = DEVICE_NATIVE_ENDIAN,
};

you will see this if you test a big endian guest.


> ---
>  hw/virtio/virtio-mmio.c | 264 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 254 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 97b7f35496..1da841336f 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -47,14 +47,24 @@
>          OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
>  
>  #define VIRT_MAGIC 0x74726976 /* 'virt' */
> -#define VIRT_VERSION 1
> +#define VIRT_VERSION_LEGACY 1
> +#define VIRT_VERSION_MODERN 2
>  #define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
>  
> +typedef struct VirtIOMMIOQueue {
> +    uint16_t num;
> +    bool enabled;
> +    uint32_t desc[2];
> +    uint32_t avail[2];
> +    uint32_t used[2];
> +} VirtIOMMIOQueue;
> +
>  typedef struct {
>      /* Generic */
>      SysBusDevice parent_obj;
>      MemoryRegion iomem;
>      qemu_irq irq;
> +    bool modern;
>      /* Guest accessible state needing migration and reset */
>      uint32_t host_features_sel;
>      uint32_t guest_features_sel;
> @@ -62,6 +72,9 @@ typedef struct {
>      /* virtio-bus */
>      VirtioBusState bus;
>      bool format_transport_address;
> +    /* Fields only used for v2 (modern) devices */
> +    uint32_t guest_features[2];
> +    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
>  } VirtIOMMIOProxy;
>  
>  static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
> @@ -115,7 +128,11 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>          case VIRTIO_MMIO_MAGIC_VALUE:
>              return VIRT_MAGIC;
>          case VIRTIO_MMIO_VERSION:
> -            return VIRT_VERSION;
> +            if (proxy->modern) {
> +                return VIRT_VERSION_MODERN;
> +            } else {
> +                return VIRT_VERSION_LEGACY;
> +            }
>          case VIRTIO_MMIO_VENDOR_ID:
>              return VIRT_VENDOR;
>          default:
> @@ -146,14 +163,18 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      case VIRTIO_MMIO_MAGIC_VALUE:
>          return VIRT_MAGIC;
>      case VIRTIO_MMIO_VERSION:
> -        return VIRT_VERSION;
> +        if (proxy->modern) {
> +            return VIRT_VERSION_MODERN;
> +        } else {
> +            return VIRT_VERSION_LEGACY;
> +        }
>      case VIRTIO_MMIO_DEVICE_ID:
>          return vdev->device_id;
>      case VIRTIO_MMIO_VENDOR_ID:
>          return VIRT_VENDOR;
>      case VIRTIO_MMIO_DEVICE_FEATURES:
>          if (proxy->host_features_sel) {
> -            return 0;
> +            return vdev->host_features >> 32;

I'd do vdev->host_features >> (32 * proxy->host_features_sel);

>          }
>          return vdev->host_features;
>      case VIRTIO_MMIO_QUEUE_NUM_MAX:
> @@ -162,12 +183,34 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>          }
>          return VIRTQUEUE_MAX_SIZE;
>      case VIRTIO_MMIO_QUEUE_PFN:
> +        if (proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: read from legacy register in modern mode\n",
> +                          __func__);
> +            return 0;
> +        }
>          return virtio_queue_get_addr(vdev, vdev->queue_sel)
>              >> proxy->guest_page_shift;
> +    case VIRTIO_MMIO_QUEUE_READY:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: read from modern register in legacy mode\n",
> +                          __func__);
> +            return 0;
> +        }
> +        return proxy->vqs[vdev->queue_sel].enabled;
>      case VIRTIO_MMIO_INTERRUPT_STATUS:
>          return atomic_read(&vdev->isr);
>      case VIRTIO_MMIO_STATUS:
>          return vdev->status;
> +    case VIRTIO_MMIO_CONFIG_GENERATION:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: read from modern register in legacy mode\n",
> +                          __func__);
> +            return 0;
> +        }
> +        return vdev->generation;
>      case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
>      case VIRTIO_MMIO_DRIVER_FEATURES:
>      case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
> @@ -177,6 +220,12 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      case VIRTIO_MMIO_QUEUE_ALIGN:
>      case VIRTIO_MMIO_QUEUE_NOTIFY:
>      case VIRTIO_MMIO_INTERRUPT_ACK:
> +    case VIRTIO_MMIO_QUEUE_DESC_LOW:
> +    case VIRTIO_MMIO_QUEUE_DESC_HIGH:
> +    case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
> +    case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
> +    case VIRTIO_MMIO_QUEUE_USED_LOW:
> +    case VIRTIO_MMIO_QUEUE_USED_HIGH:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: read of write-only register\n",
>                        __func__);
> @@ -232,14 +281,26 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          proxy->host_features_sel = value;
>          break;
>      case VIRTIO_MMIO_DRIVER_FEATURES:
> -        if (!proxy->guest_features_sel) {
> +        if (proxy->modern) {
> +            proxy->guest_features[proxy->guest_features_sel] = value;
> +        } else if (!proxy->guest_features_sel) {
>              virtio_set_features(vdev, value);
>          }
>          break;
>      case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
> -        proxy->guest_features_sel = value;
> +        if (value) {
> +            proxy->guest_features_sel = 1;
> +        } else {
> +            proxy->guest_features_sel = 0;
> +        }
>          break;
>      case VIRTIO_MMIO_GUEST_PAGE_SIZE:
> +        if (proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
>          proxy->guest_page_shift = ctz32(value);
>          if (proxy->guest_page_shift > 31) {
>              proxy->guest_page_shift = 0;
> @@ -253,15 +314,29 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          break;
>      case VIRTIO_MMIO_QUEUE_NUM:
>          trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
> -        virtio_queue_set_num(vdev, vdev->queue_sel, value);
> -        /* Note: only call this function for legacy devices */
> -        virtio_queue_update_rings(vdev, vdev->queue_sel);
> +        if (proxy->modern) {
> +            proxy->vqs[vdev->queue_sel].num = value;
> +        } else {
> +            virtio_queue_set_num(vdev, vdev->queue_sel, value);
> +            virtio_queue_update_rings(vdev, vdev->queue_sel);
> +        }
>          break;
>      case VIRTIO_MMIO_QUEUE_ALIGN:
> -        /* Note: this is only valid for legacy devices */
> +        if (proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
>          virtio_queue_set_align(vdev, vdev->queue_sel, value);
>          break;
>      case VIRTIO_MMIO_QUEUE_PFN:
> +        if (proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
>          if (value == 0) {
>              virtio_reset(vdev);
>          } else {
> @@ -269,6 +344,24 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>                                    value << proxy->guest_page_shift);
>          }
>          break;
> +    case VIRTIO_MMIO_QUEUE_READY:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to modern register in legacy mode\n",
> +                          __func__);
> +            return;
> +        }
> +        virtio_queue_set_num(vdev, vdev->queue_sel,
> +                             proxy->vqs[vdev->queue_sel].num);
> +        virtio_queue_set_rings(vdev, vdev->queue_sel,
> +                       ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
> +                       proxy->vqs[vdev->queue_sel].desc[0],
> +                       ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
> +                       proxy->vqs[vdev->queue_sel].avail[0],
> +                       ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
> +                       proxy->vqs[vdev->queue_sel].used[0]);
> +        proxy->vqs[vdev->queue_sel].enabled = 1;
> +        break;

This one seems out of spec.
In this respect virtio mmio is more advanced that virtio pci:
it allows setting the ready status to 0.



>      case VIRTIO_MMIO_QUEUE_NOTIFY:
>          if (value < VIRTIO_QUEUE_MAX) {
>              virtio_queue_notify(vdev, value);
> @@ -283,6 +376,12 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>              virtio_mmio_stop_ioeventfd(proxy);
>          }
>  
> +        if (proxy->modern && (value & VIRTIO_CONFIG_S_FEATURES_OK)) {
> +            virtio_set_features(vdev,
> +                                ((uint64_t)proxy->guest_features[1]) << 32 |
> +                                proxy->guest_features[0]);
> +        }
> +
>          virtio_set_status(vdev, value & 0xff);
>  
>          if (value & VIRTIO_CONFIG_S_DRIVER_OK) {
> @@ -293,6 +392,60 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>              virtio_reset(vdev);
>          }
>          break;
> +    case VIRTIO_MMIO_QUEUE_DESC_LOW:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
> +        proxy->vqs[vdev->queue_sel].desc[0] = value;
> +        break;
> +    case VIRTIO_MMIO_QUEUE_DESC_HIGH:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
> +        proxy->vqs[vdev->queue_sel].desc[1] = value;
> +        break;
> +    case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
> +        proxy->vqs[vdev->queue_sel].avail[0] = value;
> +        break;
> +    case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
> +        proxy->vqs[vdev->queue_sel].avail[1] = value;
> +        break;
> +    case VIRTIO_MMIO_QUEUE_USED_LOW:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
> +        proxy->vqs[vdev->queue_sel].used[0] = value;
> +        break;
> +    case VIRTIO_MMIO_QUEUE_USED_HIGH:
> +        if (!proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: write to legacy register in modern mode\n",
> +                          __func__);
> +            return;
> +        }
> +        proxy->vqs[vdev->queue_sel].used[1] = value;
> +        break;
>      case VIRTIO_MMIO_MAGIC_VALUE:
>      case VIRTIO_MMIO_VERSION:
>      case VIRTIO_MMIO_DEVICE_ID:
> @@ -300,6 +453,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      case VIRTIO_MMIO_DEVICE_FEATURES:
>      case VIRTIO_MMIO_QUEUE_NUM_MAX:
>      case VIRTIO_MMIO_INTERRUPT_STATUS:
> +    case VIRTIO_MMIO_CONFIG_GENERATION:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: write to readonly register\n",
>                        __func__);
> @@ -349,15 +503,90 @@ static void virtio_mmio_save_config(DeviceState *opaque, QEMUFile *f)
>      qemu_put_be32(f, proxy->guest_page_shift);
>  }
>  
> +static const VMStateDescription vmstate_virtio_mmio_modern_queue_state = {
> +    .name = "virtio_mmio/modern_queue_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16(num, VirtIOMMIOQueue),
> +        VMSTATE_BOOL(enabled, VirtIOMMIOQueue),
> +        VMSTATE_UINT32_ARRAY(desc, VirtIOMMIOQueue, 2),
> +        VMSTATE_UINT32_ARRAY(avail, VirtIOMMIOQueue, 2),
> +        VMSTATE_UINT32_ARRAY(used, VirtIOMMIOQueue, 2),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_virtio_mmio_modern_state_sub = {
> +    .name = "virtio_mmio/modern_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(guest_features, VirtIOMMIOProxy, 2),
> +        VMSTATE_STRUCT_ARRAY(vqs, VirtIOMMIOProxy, VIRTIO_QUEUE_MAX, 0,
> +                             vmstate_virtio_mmio_modern_queue_state,
> +                             VirtIOMMIOQueue),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_virtio_mmio = {
> +    .name = "virtio_mmio",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .minimum_version_id_old = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription*[]) {
> +        &vmstate_virtio_mmio_modern_state_sub,
> +        NULL
> +    }
> +};
> +
> +static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
> +{
> +    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> +
> +    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
> +}
> +
> +static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
> +{
> +    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> +
> +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> +}
> +
> +static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> +{
> +    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> +
> +    return proxy->modern;
> +}
> +
>  static void virtio_mmio_reset(DeviceState *d)
>  {
>      VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
> +    int i;
>  
>      virtio_mmio_stop_ioeventfd(proxy);
>      virtio_bus_reset(&proxy->bus);
>      proxy->host_features_sel = 0;
>      proxy->guest_features_sel = 0;
>      proxy->guest_page_shift = 0;
> +
> +    if (proxy->modern) {
> +        proxy->guest_features[0] = proxy->guest_features[1] = 0;
> +
> +        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +            proxy->vqs[i].enabled = 0;
> +            proxy->vqs[i].num = 0;
> +            proxy->vqs[i].desc[0] = proxy->vqs[i].desc[1] = 0;
> +            proxy->vqs[i].avail[0] = proxy->vqs[i].avail[1] = 0;
> +            proxy->vqs[i].used[0] = proxy->vqs[i].used[1] = 0;
> +        }
> +    }
>  }
>  
>  static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
> @@ -420,11 +649,22 @@ assign_error:
>      return r;
>  }
>  
> +static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
> +{
> +    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
> +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> +
> +    if (proxy->modern) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> +    }
> +}
> +
>  /* virtio-mmio device */
>  
>  static Property virtio_mmio_properties[] = {
>      DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
>                       format_transport_address, true),
> +    DEFINE_PROP_BOOL("modern", VirtIOMMIOProxy, modern, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -508,9 +748,13 @@ static void virtio_mmio_bus_class_init(ObjectClass *klass, void *data)
>      k->notify = virtio_mmio_update_irq;
>      k->save_config = virtio_mmio_save_config;
>      k->load_config = virtio_mmio_load_config;
> +    k->save_extra_state = virtio_mmio_save_extra_state;
> +    k->load_extra_state = virtio_mmio_load_extra_state;
> +    k->has_extra_state = virtio_mmio_has_extra_state;
>      k->set_guest_notifiers = virtio_mmio_set_guest_notifiers;
>      k->ioeventfd_enabled = virtio_mmio_ioeventfd_enabled;
>      k->ioeventfd_assign = virtio_mmio_ioeventfd_assign;
> +    k->pre_plugged = virtio_mmio_pre_plugged;
>      k->has_variable_vring_alignment = true;
>      bus_class->max_dev = 1;
>      bus_class->get_dev_path = virtio_mmio_bus_get_dev_path;
> -- 
> 2.21.0

