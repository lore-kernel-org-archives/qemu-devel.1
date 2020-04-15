Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410BC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E58206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMrtJIeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E58206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcdm-0004PI-Md
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcd4-0003tJ-Bp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcd0-0002Zb-V2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:38:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcd0-0002ZO-Po
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LSFL4tSe8EaPFFyG9ykzeMJktsxwly8+fJSjPrzcs4=;
 b=cMrtJIeAoX3EH69agSm1uphOHDh8da35Z+dKLwxR4NyDlfboduoXWOc/SfZ8oHSltx+cjb
 ErXwsZ4x6eqVn6TD8QMQiZnmf45lpQFbgCRntgAXvaL2Y1TlqpFvumd/s7F4ZKmfhCv+rZ
 1nOiNPH5WPLmoFYWVdeffVs+V+mgY2U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-Hk-1WpsRMqK_I9dFHOAzvQ-1; Wed, 15 Apr 2020 03:38:29 -0400
X-MC-Unique: Hk-1WpsRMqK_I9dFHOAzvQ-1
Received: by mail-ed1-f70.google.com with SMTP id i61so2208621edc.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+LSFL4tSe8EaPFFyG9ykzeMJktsxwly8+fJSjPrzcs4=;
 b=VpmpgwRCP4+PlXNJcsLQNfTghmVZ7yH5Pw0TDlI6VihjnQBM7SDNJcIWUqNbmlx02d
 z/8eJkq0nJD0wvZART7Lfd+GODxLR75FUu6VrxLkUFmJAyWAKAKD1rcoKAUIx6DjcQtZ
 WlF3h1MpDDpPAqqznrRjY/AS6P7dUx09yi9UOvjQjVNxfwUnZ4H9RSvaodT4TjhP4+ab
 JN7xycXM2EUdrW2OZ/yCAhGtMuiBAogP2zcruTglzf9QoNfL8mBXXCRmibMIJ4xjZQPW
 BuAhmDEaAtSX5kwEsCx9fS/dyOyZHxVcHs7M7fFVDDto+M6DtfddIA2fpvyiUPVXF6KJ
 tYuQ==
X-Gm-Message-State: AGi0PuYFT3sY6Pda2FZmIYJRu8/qC9WQqv0RHZSqAkxDpFvGeIifR1N1
 kVOMXHngA/HOxsUVkJeTtp7X1CWBhervoPfuUEf9phpidJv39uCAOVwReSuoujJVvWwRIvJ2pFF
 +frg3OhP/XS4GLjU=
X-Received: by 2002:aa7:cf16:: with SMTP id a22mr12882412edy.77.1586936306049; 
 Wed, 15 Apr 2020 00:38:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcjec5AE2un1o/3U1yF17EQ9utUK78/MNxnVrteqYEtmQj/XX3q49U8oPGOk20Ab0iuXJ1lA==
X-Received: by 2002:aa7:cf16:: with SMTP id a22mr12882387edy.77.1586936305489; 
 Wed, 15 Apr 2020 00:38:25 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h9sm2577530ejb.47.2020.04.15.00.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:38:24 -0700 (PDT)
Subject: Re: [PATCH v7 45/48] nvme: support multiple namespaces
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-46-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dbde592f-1205-a483-c03e-62153ad348d8@redhat.com>
Date: Wed, 15 Apr 2020 09:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-46-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 7:51 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This adds support for multiple namespaces by introducing a new 'nvme-ns'
> device model. The nvme device creates a bus named from the device name
> ('id'). The nvme-ns devices then connect to this and registers
> themselves with the nvme device.
> 
> This changes how an nvme device is created. Example with two namespaces:
> 
>    -drive file=nvme0n1.img,if=none,id=disk1
>    -drive file=nvme0n2.img,if=none,id=disk2
>    -device nvme,serial=deadbeef,id=nvme0
>    -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>    -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> 
> The drive property is kept on the nvme device to keep the change
> backward compatible, but the property is now optional. Specifying a
> drive for the nvme device will always create the namespace with nsid 1.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   hw/block/Makefile.objs |   2 +-
>   hw/block/nvme-ns.c     | 157 +++++++++++++++++++++++++++
>   hw/block/nvme-ns.h     |  60 +++++++++++
>   hw/block/nvme.c        | 233 +++++++++++++++++++++++++++--------------
>   hw/block/nvme.h        |  47 ++++-----
>   hw/block/trace-events  |   8 +-
>   6 files changed, 396 insertions(+), 111 deletions(-)
>   create mode 100644 hw/block/nvme-ns.c
>   create mode 100644 hw/block/nvme-ns.h
> 
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index 4b4a2b338dc4..d9141d6a4b9b 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -7,7 +7,7 @@ common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
>   common-obj-$(CONFIG_XEN) += xen-block.o
>   common-obj-$(CONFIG_ECC) += ecc.o
>   common-obj-$(CONFIG_ONENAND) += onenand.o
> -common-obj-$(CONFIG_NVME_PCI) += nvme.o
> +common-obj-$(CONFIG_NVME_PCI) += nvme.o nvme-ns.o
>   common-obj-$(CONFIG_SWIM) += swim.o
>   
>   common-obj-$(CONFIG_SH4) += tc58128.o
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> new file mode 100644
> index 000000000000..bd64d4a94632
> --- /dev/null
> +++ b/hw/block/nvme-ns.c
> @@ -0,0 +1,157 @@

Missing copyright + license.

> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +#include "hw/block/block.h"
> +#include "hw/pci/pci.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/block-backend.h"
> +#include "qapi/error.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-core.h"
> +
> +#include "nvme.h"
> +#include "nvme-ns.h"
> +
> +static int nvme_ns_init(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +
> +    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> +    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
> +
> +    /* no thin provisioning */
> +    id_ns->ncap = id_ns->nsze;
> +    id_ns->nuse = id_ns->ncap;
> +
> +    return 0;
> +}
> +
> +static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, NvmeIdCtrl *id,
> +                            Error **errp)
> +{
> +    uint64_t perm, shared_perm;
> +
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
> +    shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
> +        BLK_PERM_GRAPH_MOD;
> +
> +    ret = blk_set_perm(ns->blk, perm, shared_perm, &local_err);
> +    if (ret) {
> +        error_propagate_prepend(errp, local_err,
> +                                "could not set block permissions: ");
> +        return ret;
> +    }
> +
> +    ns->size = blk_getlength(ns->blk);
> +    if (ns->size < 0) {
> +        error_setg_errno(errp, -ns->size, "could not get blockdev size");
> +        return -1;
> +    }
> +
> +    switch (n->conf.wce) {
> +    case ON_OFF_AUTO_ON:
> +        n->features.volatile_wc = 1;
> +        break;
> +    case ON_OFF_AUTO_OFF:
> +        n->features.volatile_wc = 0;

Missing 'break'?

> +    case ON_OFF_AUTO_AUTO:
> +        n->features.volatile_wc = blk_enable_write_cache(ns->blk);
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    blk_set_enable_write_cache(ns->blk, n->features.volatile_wc);
> +
> +    return 0;
> +}
> +
> +static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
> +{
> +    if (!ns->blk) {
> +        error_setg(errp, "block backend not configured");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +{
> +    if (nvme_ns_check_constraints(ns, errp)) {
> +        return -1;
> +    }
> +
> +    if (nvme_ns_init_blk(n, ns, &n->id_ctrl, errp)) {
> +        return -1;
> +    }
> +
> +    nvme_ns_init(ns);
> +    if (nvme_register_namespace(n, ns, errp)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void nvme_ns_realize(DeviceState *dev, Error **errp)
> +{
> +    NvmeNamespace *ns = NVME_NS(dev);
> +    BusState *s = qdev_get_parent_bus(dev);
> +    NvmeCtrl *n = NVME(s->parent);
> +    Error *local_err = NULL;
> +
> +    if (nvme_ns_setup(n, ns, &local_err)) {
> +        error_propagate_prepend(errp, local_err,
> +                                "could not setup namespace: ");
> +        return;
> +    }
> +}
> +
> +static Property nvme_ns_props[] = {
> +    DEFINE_NVME_NS_PROPERTIES(NvmeNamespace, params),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void nvme_ns_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +
> +    dc->bus_type = TYPE_NVME_BUS;
> +    dc->realize = nvme_ns_realize;
> +    device_class_set_props(dc, nvme_ns_props);
> +    dc->desc = "virtual nvme namespace";

"Virtual NVMe namespace"?

> +}
> +
> +static void nvme_ns_instance_init(Object *obj)
> +{
> +    NvmeNamespace *ns = NVME_NS(obj);
> +    char *bootindex = g_strdup_printf("/namespace@%d,0", ns->params.nsid);
> +
> +    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
> +                                  bootindex, DEVICE(obj), &error_abort);
> +
> +    g_free(bootindex);
> +}
> +
> +static const TypeInfo nvme_ns_info = {
> +    .name = TYPE_NVME_NS,
> +    .parent = TYPE_DEVICE,
> +    .class_init = nvme_ns_class_init,
> +    .instance_size = sizeof(NvmeNamespace),
> +    .instance_init = nvme_ns_instance_init,
> +};
> +
> +static void nvme_ns_register_types(void)
> +{
> +    type_register_static(&nvme_ns_info);
> +}
> +
> +type_init(nvme_ns_register_types)
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> new file mode 100644
> index 000000000000..3c3651d485d0
> --- /dev/null
> +++ b/hw/block/nvme-ns.h
> @@ -0,0 +1,60 @@

Missing copyright + license.

> +#ifndef NVME_NS_H
> +#define NVME_NS_H
> +
> +#define TYPE_NVME_NS "nvme-ns"
> +#define NVME_NS(obj) \
> +    OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
> +
> +#define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
> +    DEFINE_PROP_DRIVE("drive", _state, blk), \
> +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> +
> +typedef struct NvmeNamespaceParams {
> +    uint32_t nsid;
> +} NvmeNamespaceParams;
> +
> +typedef struct NvmeNamespace {
> +    DeviceState  parent_obj;
> +    BlockBackend *blk;
> +    int32_t      bootindex;
> +    int64_t      size;
> +
> +    NvmeIdNs            id_ns;
> +    NvmeNamespaceParams params;
> +} NvmeNamespace;
> +
> +static inline uint32_t nvme_nsid(NvmeNamespace *ns)
> +{
> +    if (ns) {
> +        return ns->params.nsid;
> +    }
> +
> +    return -1;

This case doesn't seem possible.

Maybe:

       assert(ns);
       return ns->params.nsid;

> +}
> +
> +static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> +}
> +
> +static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> +{
> +    return nvme_ns_lbaf(ns)->ds;
> +}
> +
> +static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> +{
> +    return 1 << nvme_ns_lbads(ns);
> +}
> +
> +static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
> +{
> +    return ns->size >> nvme_ns_lbads(ns);
> +}
> +
> +typedef struct NvmeCtrl NvmeCtrl;
> +
> +int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
> +
> +#endif /* NVME_NS_H */
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 05a6fa334a70..e338d0893a70 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -17,10 +17,11 @@
>   /**
>    * Usage: add options:
>    *      -drive file=<file>,if=none,id=<drive_id>
> - *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
> + *      -device nvme,serial=<serial>,id=<bus_name>, \
>    *              cmb_size_mb=<cmb_size_mb[optional]>, \
>    *              max_ioqpairs=<N[optional]>, \
>    *              mdts=<mdts[optional]>
> + *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=1
>    *
>    * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>    * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> @@ -44,6 +45,7 @@
>   #include "qemu/cutils.h"
>   #include "trace.h"
>   #include "nvme.h"
> +#include "nvme-ns.h"
>   
>   #define NVME_SPEC_VER 0x00010300
>   #define NVME_CMB_BIR 2
> @@ -89,6 +91,11 @@ static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>       return pci_dma_read(&n->parent_obj, addr, buf, size);
>   }
>   
> +static uint16_t nvme_nsid_valid(NvmeCtrl *n, uint32_t nsid)
> +{
> +    return nsid && nsid <= n->num_namespaces;
> +}
> +
>   static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
>   {
>       return sqid < n->params.max_ioqpairs + 1 && n->sq[sqid] != NULL ? 0 : -1;
> @@ -949,11 +956,12 @@ static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
>   
>   static void nvme_rw_cb(NvmeRequest *req, void *opaque)
>   {
> +    NvmeNamespace *ns = req->ns;
>       NvmeSQueue *sq = req->sq;
>       NvmeCtrl *n = sq->ctrl;
>       NvmeCQueue *cq = n->cq[sq->cqid];
>   
> -    trace_nvme_dev_rw_cb(nvme_cid(req));
> +    trace_nvme_dev_rw_cb(nvme_cid(req), nvme_nsid(ns));
>   
>       nvme_enqueue_req_completion(cq, req);
>   }
> @@ -1036,10 +1044,11 @@ static void nvme_aio_cb(void *opaque, int ret)
>   
>   static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
>   {
> +    NvmeNamespace *ns = req->ns;
>       NvmeAIO *aio = g_new0(NvmeAIO, 1);
>   
>       *aio = (NvmeAIO) {
> -        .blk = n->conf.blk,
> +        .blk = ns->blk,
>           .req = req,
>       };
>   
> @@ -1063,11 +1072,12 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
>       req->slba = le64_to_cpu(rw->slba);
>       req->nlb  = le16_to_cpu(rw->nlb) + 1;
>   
> -    trace_nvme_dev_write_zeroes(nvme_cid(req), req->slba, req->nlb);
> +    trace_nvme_dev_write_zeroes(nvme_cid(req), nvme_nsid(ns), req->slba,
> +                                req->nlb);
>   
>       status = nvme_check_bounds(n, req->slba, req->nlb, req);
>       if (status) {
> -        return status;
> +        goto invalid;
>       }
>   
>       offset = req->slba << nvme_ns_lbads(ns);
> @@ -1076,7 +1086,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
>       aio = g_new0(NvmeAIO, 1);
>   
>       *aio = (NvmeAIO) {
> -        .blk = n->conf.blk,
> +        .blk = ns->blk,
>           .offset = offset,
>           .len = count,
>           .req = req,
> @@ -1086,6 +1096,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
>       nvme_submit_aio(aio);
>   
>       return NVME_NO_COMPLETE;
> +
> +invalid:
> +    block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
> +    return status;
>   }
>   
>   static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
> @@ -1100,11 +1114,11 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
>   
>       req->nlb  = le16_to_cpu(rw->nlb) + 1;
>       req->slba = le64_to_cpu(rw->slba);
> -
>       len = req->nlb << nvme_ns_lbads(ns);
>   
> -    trace_nvme_dev_rw(nvme_req_is_write(req) ? "write" : "read", req->nlb,
> -                      req->nlb << nvme_ns_lbads(req->ns), req->slba);
> +    trace_nvme_dev_rw(nvme_cid(req), nvme_req_is_write(req) ? "write" : "read",
> +                      nvme_nsid(ns), req->nlb, req->nlb << nvme_ns_lbads(ns),
> +                      req->slba);
>   
>       status = nvme_check_rw(n, req);
>       if (status) {
> @@ -1116,13 +1130,13 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
>           goto invalid;
>       }
>   
> -    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), req);
> +    nvme_rw_aio(ns->blk, req->slba << nvme_ns_lbads(ns), req);
>       nvme_req_set_cb(req, nvme_rw_cb, NULL);
>   
>       return NVME_NO_COMPLETE;
>   
>   invalid:
> -    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> +    block_acct_invalid(blk_get_stats(ns->blk), acct);
>       return status;
>   }
>   
> @@ -1133,12 +1147,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
>       trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid),
>                             req->cmd.opcode);
>   
> -    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> -        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> +    if (!nvme_nsid_valid(n, nsid)) {
>           return NVME_INVALID_NSID | NVME_DNR;
>       }
>   
> -    req->ns = &n->namespaces[nsid - 1];
> +    req->ns = nvme_ns(n, nsid);
> +    if (unlikely(!req->ns)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
>       switch (req->cmd.opcode) {
>       case NVME_CMD_FLUSH:
>           return nvme_flush(n, req);
> @@ -1283,18 +1300,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
>       uint64_t units_read = 0, units_written = 0;
>       uint64_t read_commands = 0, write_commands = 0;
>       NvmeSmartLog smart;
> -    BlockAcctStats *s;
>   
>       if (nsid && nsid != 0xffffffff) {
>           return NVME_INVALID_FIELD | NVME_DNR;
>       }
>   
> -    s = blk_get_stats(n->conf.blk);
> +    for (int i = 1; i <= n->num_namespaces; i++) {
> +        NvmeNamespace *ns = nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
>   
> -    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> -    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> -    read_commands = s->nr_ops[BLOCK_ACCT_READ];
> -    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
> +        BlockAcctStats *s = blk_get_stats(ns->blk);
> +
> +        units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> +        units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> +        read_commands += s->nr_ops[BLOCK_ACCT_READ];
> +        write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
> +    }
>   
>       if (off > sizeof(smart)) {
>           return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1527,18 +1550,23 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
>   {
>       NvmeNamespace *ns;
>       NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
> +    NvmeIdNs *id_ns, inactive = { 0 };
>       uint32_t nsid = le32_to_cpu(c->nsid);
>   
>       trace_nvme_dev_identify_ns(nsid);
>   
> -    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> -        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> +    if (!nvme_nsid_valid(n, nsid)) {
>           return NVME_INVALID_NSID | NVME_DNR;
>       }
>   
> -    ns = &n->namespaces[nsid - 1];
> +    ns = nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        id_ns = &inactive;
> +    } else {
> +        id_ns = &ns->id_ns;
> +    }
>   
> -    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> +    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
>                       DMA_DIRECTION_FROM_DEVICE, req);
>   }
>   
> @@ -1555,7 +1583,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
>   
>       list = g_malloc0(data_len);
>       for (int i = 1; i <= n->num_namespaces; i++) {
> -        if (i <= min_nsid) {
> +        if (i <= min_nsid || !nvme_ns(n, i)) {
>               continue;
>           }
>           list[j++] = cpu_to_le32(i);
> @@ -1573,7 +1601,6 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
>   {
>       NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
>       uint32_t nsid = le32_to_cpu(c->nsid);
> -
>       uint8_t list[NVME_IDENTIFY_DATA_SIZE];
>   
>       struct data {
> @@ -1587,11 +1614,14 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
>   
>       trace_nvme_dev_identify_ns_descr_list(nsid);
>   
> -    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> -        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> +    if (!nvme_nsid_valid(n, nsid)) {
>           return NVME_INVALID_NSID | NVME_DNR;
>       }
>   
> +    if (unlikely(!nvme_ns(n, nsid))) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
>       /*
>        * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
>        * structure, a Namespace UUID (nidt = 0x3) must be reported in the
> @@ -1726,7 +1756,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
>           result = cpu_to_le32(n->features.err_rec);
>           break;
>       case NVME_VOLATILE_WRITE_CACHE:
> -        result = cpu_to_le32(blk_enable_write_cache(n->conf.blk));
> +        result = cpu_to_le32(n->features.volatile_wc);
>           trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
>           break;
>       case NVME_NUMBER_OF_QUEUES:
> @@ -1779,6 +1809,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
>   
>   static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>   {
> +    NvmeNamespace *ns;
> +
>       NvmeCmd *cmd = &req->cmd;
>       uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>       uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> @@ -1812,12 +1844,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>   
>           break;
>       case NVME_VOLATILE_WRITE_CACHE:
> -        if (blk_enable_write_cache(n->conf.blk)) {
> -            blk_flush(n->conf.blk);
> +        n->features.volatile_wc = dw11;
> +
> +        for (int i = 1; i <= n->num_namespaces; i++) {
> +            ns = nvme_ns(n, i);
> +            if (!ns) {
> +                continue;
> +            }
> +
> +            if (blk_enable_write_cache(ns->blk)) {
> +                blk_flush(ns->blk);
> +            }
> +
> +            blk_set_enable_write_cache(ns->blk, dw11 & 1);
>           }
>   
> -        blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>           break;
> +
>       case NVME_NUMBER_OF_QUEUES:
>           if (n->qs_created) {
>               return NVME_CMD_SEQ_ERROR | NVME_DNR;
> @@ -1946,9 +1989,17 @@ static void nvme_process_sq(void *opaque)
>   
>   static void nvme_clear_ctrl(NvmeCtrl *n)
>   {
> +    NvmeNamespace *ns;
>       int i;
>   
> -    blk_drain(n->conf.blk);
> +    for (i = 1; i <= n->num_namespaces; i++) {
> +        ns = nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +
> +        blk_drain(ns->blk);
> +    }
>   
>       for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
>           if (n->sq[i] != NULL) {
> @@ -1971,7 +2022,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>       n->outstanding_aers = 0;
>       n->qs_created = false;
>   
> -    blk_flush(n->conf.blk);
> +    for (i = 1; i <= n->num_namespaces; i++) {
> +        ns = nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +
> +        blk_flush(ns->blk);
> +    }
> +
>       n->bar.cc = 0;
>   }
>   
> @@ -2406,6 +2465,11 @@ static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
>           params->max_ioqpairs = params->num_queues - 1;
>       }
>   
> +    if (n->namespace.blk) {
> +        warn_report("nvme: drive is deprecated; please use an nvme-ns device "
> +                    "instead");
> +    }
> +
>       if (params->max_ioqpairs < 1 ||
>           params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
>           error_setg(errp, "nvme: max_ioqpairs must be between 1 and %d",
> @@ -2413,11 +2477,6 @@ static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
>           return -1;
>       }
>   
> -    if (!n->conf.blk) {
> -        error_setg(errp, "nvme: block backend not configured");
> -        return -1;
> -    }
> -
>       if (!params->serial) {
>           error_setg(errp, "nvme: serial not configured");
>           return -1;
> @@ -2426,22 +2485,10 @@ static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
>       return 0;
>   }
>   
> -static int nvme_init_blk(NvmeCtrl *n, Error **errp)
> -{
> -    blkconf_blocksizes(&n->conf);
> -    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
> -                                       false, errp)) {
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>   static void nvme_init_state(NvmeCtrl *n)
>   {
> -    n->num_namespaces = 1;
> +    n->num_namespaces = NVME_MAX_NAMESPACES;
>       n->reg_size = pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
> -    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>       n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>       n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
>       n->temperature = NVME_TEMPERATURE;
> @@ -2557,6 +2604,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>       id->nn = cpu_to_le32(n->num_namespaces);
>       id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP);
>   
> +    id->vwc = 0x1;
>       id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT |
>                              NVME_CTRL_SGLS_BITBUCKET);
>   
> @@ -2566,9 +2614,6 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>       id->psd[0].mp = cpu_to_le16(0x9c4);
>       id->psd[0].enlat = cpu_to_le32(0x10);
>       id->psd[0].exlat = cpu_to_le32(0x4);
> -    if (blk_enable_write_cache(n->conf.blk)) {
> -        id->vwc = 1;
> -    }
>   
>       n->bar.cap = 0;
>       NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
> @@ -2581,25 +2626,39 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>       n->bar.intmc = n->bar.intms = 0;
>   }
>   
> -static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>   {
> -    int64_t bs_size;
> -    NvmeIdNs *id_ns = &ns->id_ns;
> +    uint32_t nsid = nvme_nsid(ns);
>   
> -    bs_size = blk_getlength(n->conf.blk);
> -    if (bs_size < 0) {
> -        error_setg_errno(errp, -bs_size, "blk_getlength");
> +    if (nsid > NVME_MAX_NAMESPACES) {
> +        error_setg(errp, "invalid namespace id (must be between 0 and %d)",
> +                   NVME_MAX_NAMESPACES);
>           return -1;
>       }
>   
> -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> -    n->ns_size = bs_size;
> +    if (!nsid) {
> +        for (int i = 1; i <= n->num_namespaces; i++) {
> +            NvmeNamespace *ns = nvme_ns(n, i);
> +            if (!ns) {
> +                nsid = i;
> +                break;
> +            }
> +        }
>   
> -    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
> +        if (!nsid) {
> +            error_setg(errp, "no free namespace id");
> +            return -1;
> +        }
> +    } else {
> +        if (n->namespaces[nsid - 1]) {
> +            error_setg(errp, "namespace id '%d' is already in use", nsid);
> +            return -1;
> +        }
> +    }
>   
> -    /* no thin provisioning */
> -    id_ns->ncap = id_ns->nsze;
> -    id_ns->nuse = id_ns->ncap;
> +    trace_nvme_dev_register_namespace(nsid);
> +
> +    n->namespaces[nsid - 1] = ns;
>   
>       return 0;
>   }
> @@ -2607,26 +2666,28 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n = NVME(pci_dev);
> -    int i;
> +    NvmeNamespace *ns;
>   
>       if (nvme_check_constraints(n, errp)) {
>           return;
>       }
>   
> +    qbus_create_inplace(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS,
> +                        &pci_dev->qdev, n->parent_obj.qdev.id);
> +
>       nvme_init_state(n);
> +    nvme_init_pci(n, pci_dev);
> +    nvme_init_ctrl(n);

Argh you move these functions again... Why not put them in the correct 
place when you refactor nvme_realize()?

>   
> -    if (nvme_init_blk(n, errp)) {
> -        return;
> -    }
> +    /* setup a namespace if the controller drive property was given */
> +    if (n->namespace.blk) {
> +        ns = &n->namespace;
> +        ns->params.nsid = 1;
>   
> -    for (i = 0; i < n->num_namespaces; i++) {
> -        if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
> +        if (nvme_ns_setup(n, ns, errp)) {
>               return;
>           }
>       }
> -
> -    nvme_init_pci(n, pci_dev);
> -    nvme_init_ctrl(n);
>   }
>   
>   static void nvme_exit(PCIDevice *pci_dev)
> @@ -2647,7 +2708,8 @@ static void nvme_exit(PCIDevice *pci_dev)
>   }
>   
>   static Property nvme_props[] = {
> -    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
> +    DEFINE_BLOCK_PROPERTIES_BASE(NvmeCtrl, conf), \
> +    DEFINE_PROP_DRIVE("drive", NvmeCtrl, namespace.blk), \
>       DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> @@ -2679,26 +2741,35 @@ static void nvme_instance_init(Object *obj)
>   {
>       NvmeCtrl *s = NVME(obj);
>   
> -    device_add_bootindex_property(obj, &s->conf.bootindex,
> -                                  "bootindex", "/namespace@1,0",
> -                                  DEVICE(obj), &error_abort);
> +    if (s->namespace.blk) {
> +        device_add_bootindex_property(obj, &s->conf.bootindex,
> +                                      "bootindex", "/namespace@1,0",
> +                                      DEVICE(obj), &error_abort);
> +    }
>   }
>   
>   static const TypeInfo nvme_info = {
>       .name          = TYPE_NVME,
>       .parent        = TYPE_PCI_DEVICE,
>       .instance_size = sizeof(NvmeCtrl),
> -    .class_init    = nvme_class_init,
>       .instance_init = nvme_instance_init,
> +    .class_init    = nvme_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { INTERFACE_PCIE_DEVICE },
>           { }
>       },
>   };
>   
> +static const TypeInfo nvme_bus_info = {
> +    .name = TYPE_NVME_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = sizeof(NvmeBus),
> +};
> +
>   static void nvme_register_types(void)
>   {
>       type_register_static(&nvme_info);
> +    type_register_static(&nvme_bus_info);
>   }
>   
>   type_init(nvme_register_types)
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index ed4a5ce4121d..f42c17651b7b 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -2,6 +2,9 @@
>   #define HW_NVME_H
>   
>   #include "block/nvme.h"
> +#include "nvme-ns.h"
> +
> +#define NVME_MAX_NAMESPACES 256
>   
>   #define DEFINE_NVME_PROPERTIES(_state, _props) \
>       DEFINE_PROP_STRING("serial", _state, _props.serial), \
> @@ -93,26 +96,6 @@ typedef struct NvmeCQueue {
>       QTAILQ_HEAD(, NvmeRequest) req_list;
>   } NvmeCQueue;
>   
> -typedef struct NvmeNamespace {
> -    NvmeIdNs        id_ns;
> -} NvmeNamespace;
> -
> -static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> -{
> -    NvmeIdNs *id_ns = &ns->id_ns;
> -    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> -}
> -
> -static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> -{
> -    return nvme_ns_lbaf(ns)->ds;
> -}
> -
> -static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> -{
> -    return 1 << nvme_ns_lbads(ns);
> -}
> -
>   typedef enum NvmeAIOOp {
>       NVME_AIO_OPC_NONE         = 0x0,
>       NVME_AIO_OPC_FLUSH        = 0x1,
> @@ -167,6 +150,13 @@ static inline bool nvme_req_is_write(NvmeRequest *req)
>       }
>   }
>   
> +#define TYPE_NVME_BUS "nvme-bus"
> +#define NVME_BUS(obj) OBJECT_CHECK(NvmeBus, (obj), TYPE_NVME_BUS)
> +
> +typedef struct NvmeBus {
> +    BusState parent_bus;
> +} NvmeBus;
> +
>   #define TYPE_NVME "nvme"
>   #define NVME(obj) \
>           OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -176,8 +166,9 @@ typedef struct NvmeCtrl {
>       MemoryRegion iomem;
>       MemoryRegion ctrl_mem;
>       NvmeBar      bar;
> -    BlockConf    conf;
>       NvmeParams   params;
> +    NvmeBus      bus;
> +    BlockConf    conf;
>   
>       bool        qs_created;
>       uint32_t    page_size;
> @@ -188,7 +179,6 @@ typedef struct NvmeCtrl {
>       uint32_t    reg_size;
>       uint32_t    num_namespaces;
>       uint32_t    max_q_ents;
> -    uint64_t    ns_size;
>       uint8_t     outstanding_aers;
>       uint8_t     *cmbuf;
>       uint64_t    irq_status;
> @@ -202,7 +192,8 @@ typedef struct NvmeCtrl {
>       QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
>       int         aer_queued;
>   
> -    NvmeNamespace   *namespaces;
> +    NvmeNamespace   namespace;
> +    NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
>       NvmeSQueue      **sq;
>       NvmeCQueue      **cq;
>       NvmeSQueue      admin_sq;
> @@ -211,9 +202,13 @@ typedef struct NvmeCtrl {
>       NvmeFeatureVal  features;
>   } NvmeCtrl;
>   
> -static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +static inline NvmeNamespace *nvme_ns(NvmeCtrl *n, uint32_t nsid)
>   {
> -    return n->ns_size >> nvme_ns_lbads(ns);
> +    if (!nsid || nsid > n->num_namespaces) {
> +        return NULL;
> +    }
> +
> +    return n->namespaces[nsid - 1];
>   }
>   
>   static inline uint16_t nvme_cid(NvmeRequest *req)
> @@ -225,4 +220,6 @@ static inline uint16_t nvme_cid(NvmeRequest *req)
>       return 0xffff;
>   }
>   
> +int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
> +
>   #endif /* HW_NVME_H */
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index accbb04fe396..8fec87260555 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -29,6 +29,7 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int t
>   
>   # nvme.c
>   # nvme traces for successful events
> +nvme_dev_register_namespace(uint32_t nsid) "nsid %"PRIu32""
>   nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>   nvme_dev_irq_pin(void) "pulsing IRQ pin"
>   nvme_dev_irq_masked(void) "IRQ is masked"
> @@ -39,9 +40,9 @@ nvme_dev_req_add_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offs
>   nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
>   nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
>   nvme_dev_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
> -nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> -nvme_dev_rw_cb(uint16_t cid) "cid %"PRIu16""
> -nvme_dev_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
> +nvme_dev_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
> +nvme_dev_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
> +nvme_dev_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
>   nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
>   nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
>   nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
> @@ -98,7 +99,6 @@ nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or no
>   nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
>   nvme_dev_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
>   nvme_dev_err_invalid_prp(void) "invalid PRP"
> -nvme_dev_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not within 1-%u"
>   nvme_dev_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
>   nvme_dev_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
>   nvme_dev_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
> 


