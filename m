Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C3C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A902073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmQroF/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A902073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjEM-0007Qb-LL
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTjDN-0006dX-FJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTjDL-0001zZ-V9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:41:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTjDL-0001z4-7T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588153270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSugY5cWsrvp/VJN+561Ge1CCP3V5OLNIIMCSssd0pQ=;
 b=DmQroF/UkSdu4E0FzaHLU0hLdT/gWje0ELihRbGWZBP7kmBLSt/RxGK33gw7iNBLevPgGN
 nG7bGrjYERAi6JCEKm3Vnx97NB7d8R7hJ5TXM8RhBuzYReO4Ma3QmbCr7yIcbE/E4+4gCj
 3bqqGROy+H+NtXnSwnNOl4Fgmx76vQ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-xaQQugXdNFmUgVfmYEKE8Q-1; Wed, 29 Apr 2020 05:41:08 -0400
X-MC-Unique: xaQQugXdNFmUgVfmYEKE8Q-1
Received: by mail-wr1-f71.google.com with SMTP id f4so1445360wrp.14
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VSugY5cWsrvp/VJN+561Ge1CCP3V5OLNIIMCSssd0pQ=;
 b=RA+CRgYDp94NGbR6QpU2ySDissJ7oD6duffwJrIwenq33fgh7yg4gyQoZXp2WnVXbG
 ywv6ek3j+TJBgkmxOjyLnF+ZPo8bHdl36xZLbmDHmOugcGdy0sHonPS9qoWtW+tdcnG3
 loYDpiZFXyfHcjy0jYD4ESlXG1oghmPh3riJsvjKLNTGYIxRC/GDLgYUQEdiUOwuHdMu
 K4bcsL/pWo41+c6YUo5ajLaQKsN2uPwRkPhlGGeupQYkD3y8YagTmJt9fq0KpDoNQRN/
 NUNVRCkB2NEqf5j+2KO9bDuWtMWe1RPshYGyDAGFMaCUGXK5j4d7LDQwutvFjVgmfRFW
 WONQ==
X-Gm-Message-State: AGi0PuaJSTzI2wYmDQpZoEwp+9SCGc5HnXX04Y7dDelyMkzJgJlYWOkQ
 /VXmTV9awfdWCgG0NLR4vwRZ5uy88N91x5XqcWZxHTsaQpEscjGl2K87HFLpEHa7jRxbCoMD4Te
 VVj+VWUP3bYgqzPI=
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr2407952wmk.73.1588153267178; 
 Wed, 29 Apr 2020 02:41:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIX07DOzcZLl2SriLWlEywHxSROyg+oQll3rej0Qgf/yFhuHA7Q4fxvM+6+/CkIUcB3+9Xx/Q==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr2407925wmk.73.1588153266901; 
 Wed, 29 Apr 2020 02:41:06 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id v1sm30064128wrv.19.2020.04.29.02.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 02:41:06 -0700 (PDT)
Subject: Re: [PATCH v3] block: make BlockConf.*_size properties 32-bit
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
References: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f80b44cf-5fe3-8e10-b928-b61f7940d3cf@redhat.com>
Date: Wed, 29 Apr 2020 11:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin\"" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing virtio-blk and scsi maintainers.

On 4/29/20 11:18 AM, Roman Kagan wrote:
> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> 32-bit for logical_block_size, physical_block_size, and min_io_size.
> However, the properties in BlockConf are defined as uint16_t limiting
> the values to 32768.
> 
> This appears unnecessary tight, and we've seen bigger block sizes handy
> at times.
> 
> Make them 32 bit instead and lift the limitation up to 2 MiB which
> appears to be good enough for everybody, and matches the qcow2 cluster
> size limit.
> 
> As the values can now be fairly big and awkward to type, make the
> property setter accept common size suffixes (k, m).
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v2 -> v3:
> - mention qcow2 cluster size limit in the log and comment [Eric]
> 
> v1 -> v2:
> - cap the property at 2 MiB [Eric]
> - accept size suffixes
> 
>   include/hw/block/block.h     |  8 ++++----
>   include/hw/qdev-properties.h |  2 +-
>   hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
>   3 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index d7246f3862..9dd6bba56a 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -18,9 +18,9 @@
>   
>   typedef struct BlockConf {
>       BlockBackend *blk;
> -    uint16_t physical_block_size;
> -    uint16_t logical_block_size;
> -    uint16_t min_io_size;
> +    uint32_t physical_block_size;
> +    uint32_t logical_block_size;
> +    uint32_t min_io_size;
>       uint32_t opt_io_size;
>       int32_t bootindex;
>       uint32_t discard_granularity;
> @@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
>                             _conf.logical_block_size),                    \
>       DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
>                             _conf.physical_block_size),                   \
> -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
> +    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    \
>       DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
>       DEFINE_PROP_UINT32("discard_granularity", _state,                   \
>                          _conf.discard_granularity, -1),                  \
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index f161604fb6..f9e0f8c041 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>   #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
>   #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
>   #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>       DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
>   #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 2047114fca..e673f3c43f 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -14,6 +14,7 @@
>   #include "qapi/visitor.h"
>   #include "chardev/char.h"
>   #include "qemu/uuid.h"
> +#include "qemu/units.h"
>   
>   void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                     Error **errp)
> @@ -729,30 +730,42 @@ const PropertyInfo qdev_prop_pci_devfn = {
>   
>   /* --- blocksize --- */
>   
> +/* lower limit is sector size */
> +#define MIN_BLOCK_SIZE          512
> +#define MIN_BLOCK_SIZE_STR      "512 B"
> +/*
> + * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
> + * matches qcow2 cluster size limit
> + */
> +#define MAX_BLOCK_SIZE          (2 * MiB)
> +#define MAX_BLOCK_SIZE_STR      "2 MiB"
> +
>   static void set_blocksize(Object *obj, Visitor *v, const char *name,
>                             void *opaque, Error **errp)
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint64_t value;
>       Error *local_err = NULL;
> -    const int64_t min = 512;
> -    const int64_t max = 32768;
>   
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
>           return;
>       }
>   
> -    visit_type_uint16(v, name, &value, &local_err);
> +    visit_type_size(v, name, &value, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
>       }
>       /* value of 0 means "unset" */
> -    if (value && (value < min || value > max)) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
> -                   dev->id ? : "", name, (int64_t)value, min, max);
> +    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
> +        error_setg(errp,
> +                   "Property %s.%s doesn't take value %" PRIu64
> +                   " (minimum: " MIN_BLOCK_SIZE_STR
> +                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
> +                   dev->id ? : "", name, value);
>           return;
>       }
>   
> @@ -768,9 +781,10 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
>   }
>   
>   const PropertyInfo qdev_prop_blocksize = {
> -    .name  = "uint16",
> -    .description = "A power of two between 512 and 32768",
> -    .get   = get_uint16,
> +    .name  = "size",
> +    .description = "A power of two between " MIN_BLOCK_SIZE_STR
> +                   " and " MAX_BLOCK_SIZE_STR,
> +    .get   = get_uint32,
>       .set   = set_blocksize,
>       .set_default_value = set_default_value_uint,
>   };
> 

1/ Don't you need to update SCSIBlockLimits too?

2/ It seems hw/block/virtio-blk.c can get underflow now.

Maybe you miss this change:

-- >8 --
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -917,7 +917,7 @@ static void virtio_blk_update_config(VirtIODevice 
*vdev, uint8_t *config)
                   s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 
- 2);
      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
-    virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
+    virtio_stl_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
      virtio_stw_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
      blkcfg.geometry.heads = conf->heads;
      /*
---


