Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70AAC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67ABD206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ABD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMUGv-0008Pt-Lb
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:14:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMUFQ-0006gP-Ea
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMUFM-0001XT-Kl
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMUFK-0001Uu-QP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so6869951wrq.10
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cvPtOPw9YxktAJUOL2BVkA8tFegrY7sfIT9D/4XFm90=;
	b=Dj80D/QyAYib72zOO7+VloaMIn5Be4MLdqj322+AKyEb1IjxA26HFnfbVW4b7sivtF
	DGXdLK4SLmLNRDCYs02kGaYwdTSUJvIM8EmdUXgkssUiPAd68dqzfpDTIz6Fu6OguiiR
	87uL0zuNL5gnRSHX4ozSqKqtriOmTfwpaVmJVgKPoSIP9DppOSDhfVncyWuFzrtZm1gU
	8aWXgsc1w2UEp5g1+t/ztHCccwyrDeYypmAT1DQ0yk+XEZ0qJMZrE9E7vFXjmBpzBCdb
	ogHlsI8Kefl8mKAwXFdipZ8XgqryKp57dTO1jJ+ny6ZZi3fpGu+IMuFEMaA5YPpt/Xa0
	yX0Q==
X-Gm-Message-State: APjAAAU/myq6Vp7R+2/HEUfYxtX920GMstCRv7nw2YBAlThN7XOdl0xJ
	RYL9g6loomX9cFPyh92mE+AaBQ==
X-Google-Smtp-Source: APXvYqxLOYkzTmnXanhtyQ4AIxt5YP7duEMqil/UVEVKXBQU+9sIqLc3CYXecUCD3XvGgUSJM5RAHg==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr6541357wrt.112.1556874765019; 
	Fri, 03 May 2019 02:12:45 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	l127sm1883211wml.40.2019.05.03.02.12.44
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 02:12:44 -0700 (PDT)
To: Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
References: <20190503084654.18413-1-liboxuan@connect.hku.hk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0f731e62-b716-8f90-4505-019f731bd072@redhat.com>
Date: Fri, 3 May 2019 11:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503084654.18413-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
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
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org, yuval.shaia@oracle.com,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503091243.PEQt5DTTZxbbMmhdxwc2SXxA45p_-RFDUTu1JNKhd1M@z>

Hi Li,

On 5/3/19 10:46 AM, Boxuan Li wrote:
> Use traces for debug message and qemu_log_mask for errors.
> 
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> v1: https://patchew.org/QEMU/20190428110258.86681-1-liboxuan@connect.hku.hk/
> v2: https://patchew.org/QEMU/20190501081039.58938-1-liboxuan@connect.hku.hk/
> v3: Use qemu_log_mask for errors
> ---
>  hw/virtio/trace-events  |  7 +++++++
>  hw/virtio/virtio-mmio.c | 44 +++++++++++++++++++++-----------------------
>  2 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 60c649c4bc..81cbe1c4b2 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -46,3 +46,10 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
>  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
>  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
>  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
> +
> +# virtio-mmio.c
> +virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
> +virtio_mmio_write_offset(int offset, uint64_t value) "virtio_mmio_write offset 0x%x value 0x%" PRIx64

If possible, use uint64_t/PRIx64 for offset (to avoid casting to int).

> +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
> +virtio_mmio_queue_write(int value, int max_size) "mmio_queue write %d max %d"
> +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..c8a9d974b3 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -27,16 +27,8 @@
>  #include "sysemu/kvm.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "qemu/error-report.h"
> -
> -/* #define DEBUG_VIRTIO_MMIO */
> -
> -#ifdef DEBUG_VIRTIO_MMIO
> -
> -#define DPRINTF(fmt, ...) \
> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
> +#include "qemu/log.h"
> +#include "trace.h"
>  
>  /* QOM macros */
>  /* virtio-mmio-bus */
> @@ -107,7 +99,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
> +    trace_virtio_mmio_read((int)offset);
>  
>      if (!vdev) {
>          /* If no backend is present, we treat most registers as
> @@ -144,7 +136,9 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>          }
>      }
>      if (size != 4) {
> -        DPRINTF("wrong size access to register!\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: wrong size access to register!\n",
> +                __func__);

QEMU codying style is to indent the arguments aligned, after the caller
parenthesis:

        qemu_log_mask(LOG_GUEST_ERROR,
                      "%s: wrong size access to register!\n",
                      __func__);

That said:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks for the cleanup!

>          return 0;
>      }
>      switch (offset) {
> @@ -182,10 +176,12 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>      case VIRTIO_MMIO_QUEUE_ALIGN:
>      case VIRTIO_MMIO_QUEUE_NOTIFY:
>      case VIRTIO_MMIO_INTERRUPT_ACK:
> -        DPRINTF("read of write-only register\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: read of write-only register\n",
> +                __func__);
>          return 0;
>      default:
> -        DPRINTF("bad register offset\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
>          return 0;
>      }
>      return 0;
> @@ -197,8 +193,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
> -            (int)offset, value);
> +    trace_virtio_mmio_write_offset((int)offset, value);
>  
>      if (!vdev) {
>          /* If no backend is present, we just make all registers
> @@ -226,7 +221,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          return;
>      }
>      if (size != 4) {
> -        DPRINTF("wrong size access to register!\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: wrong size access to register!\n",
> +                __func__);
>          return;
>      }
>      switch (offset) {
> @@ -246,8 +243,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          if (proxy->guest_page_shift > 31) {
>              proxy->guest_page_shift = 0;
>          }
> -        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
> -                proxy->guest_page_shift);
> +        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
>          break;
>      case VIRTIO_MMIO_QUEUE_SEL:
>          if (value < VIRTIO_QUEUE_MAX) {
> @@ -255,7 +251,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>          }
>          break;
>      case VIRTIO_MMIO_QUEUE_NUM:
> -        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
> +        trace_virtio_mmio_queue_write((int)value, VIRTQUEUE_MAX_SIZE);
>          virtio_queue_set_num(vdev, vdev->queue_sel, value);
>          /* Note: only call this function for legacy devices */
>          virtio_queue_update_rings(vdev, vdev->queue_sel);
> @@ -303,11 +299,13 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
>      case VIRTIO_MMIO_DEVICE_FEATURES:
>      case VIRTIO_MMIO_QUEUE_NUM_MAX:
>      case VIRTIO_MMIO_INTERRUPT_STATUS:
> -        DPRINTF("write to readonly register\n");
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: write to readonly register\n",
> +                __func__);
>          break;
>  
>      default:
> -        DPRINTF("bad register offset\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
>      }
>  }
>  
> @@ -327,7 +325,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
>          return;
>      }
>      level = (atomic_read(&vdev->isr) != 0);
> -    DPRINTF("virtio_mmio setting IRQ %d\n", level);
> +    trace_virtio_mmio_setting_irq(level);
>      qemu_set_irq(proxy->irq, level);
>  }
>  
> 

