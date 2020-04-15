Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A8CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C251A206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Faq2aKOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C251A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOc1G-0004HB-1J
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOc0f-0003eP-3R
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOc0d-00023q-IT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:58:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOc0d-00023f-F4
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586933934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbAdjTBq8lS1RTWwLXfVdlSnsfohPq0sEb3X0LVyaVM=;
 b=Faq2aKOGC9shlhO+6nMeqTPVSz0DNTmhQEhutc/EJGgP4SkBev57YRWQGde2loSS9/jIdd
 KatPRtX9fBYG8nr/hJHlCIERp5ilACGF1RpqUWWIYDFQXl4g8hrhptHr+ATPMyZ49VIScK
 SgBYqn8qnx5r7RgsfzLX7hFM11dlitQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-ORSlLfAEP-CJJLwKAA5_kQ-1; Wed, 15 Apr 2020 02:58:51 -0400
X-MC-Unique: ORSlLfAEP-CJJLwKAA5_kQ-1
Received: by mail-ed1-f71.google.com with SMTP id d1so2106310edq.11
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 23:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lYJhGR/3fGBF1QexVulBJKmyRW7HRLjMGg0OYYDApwM=;
 b=syXiTOGGmKzFdK9D+EhQedKLG/gZFk49dctpOm4VPr7Qczow2veY8lrgl9dWIPgFzx
 YNka3Ff8Rtfp1E6BUmqR469rFAgeOfHreZODdOelOq/im54ML9+ACKV3ebYvXrvzEVu8
 yrV4TJ0pCRzyHeYv8AY9xY2GfJU5dfgpiIdx7KMn0pP3gK30Ywh/4XPojJZN5Eqqj83i
 VWNHOL4zubkwfXBnvU47lWljvL3x5+Jm4Y2534URaSeqAwSvW24DdblmALs1WmxvZpa5
 9oNWMoNMSfdC8G8jA7ojPiyIINYN4mx/GpE+FVsQi28227DCnDACOMiVUTIZycK0tM+3
 p4iw==
X-Gm-Message-State: AGi0PubmRZqPK76akiS2i3OxonAlsYaIuAi7klt4O1L1Hmm2qllGcciu
 1kuUQnZ6Yr/Ky+0h46ATTiWkBhpvE5lviNx1/pExsA0jEH7omFreueNYv8wKGASSims96523Jej
 ElE8vtyjeL9FaqOc=
X-Received: by 2002:a17:906:76cc:: with SMTP id
 q12mr3745498ejn.107.1586933929877; 
 Tue, 14 Apr 2020 23:58:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLFyfC4fuxjAVTg/7WjrrXBZSLxNOwUbsW/3OQMeNt3YoL3m0/kUjapYrOOAN+GUniVMiqSLA==
X-Received: by 2002:a17:906:76cc:: with SMTP id
 q12mr3745479ejn.107.1586933929638; 
 Tue, 14 Apr 2020 23:58:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id gg24sm370086ejb.66.2020.04.14.23.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 23:58:48 -0700 (PDT)
Subject: Re: [PATCH v7 03/48] nvme: move device parameters to separate struct
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-4-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9d7ffeb-6eac-5e49-30b1-c8d89e176b90@redhat.com>
Date: Wed, 15 Apr 2020 08:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-4-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 4/15/20 7:50 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Move device configuration parameters to separate struct to make it
> explicit what is configurable and what is set internally.
>=20
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c | 44 ++++++++++++++++++++++----------------------
>   hw/block/nvme.h | 16 +++++++++++++---
>   2 files changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index da0e8af42823..249f759f076e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -64,12 +64,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
>  =20
>   static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
>   {
> -    return sqid < n->num_queues && n->sq[sqid] !=3D NULL ? 0 : -1;
> +    return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
>   }
>  =20
>   static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
>   {
> -    return cqid < n->num_queues && n->cq[cqid] !=3D NULL ? 0 : -1;
> +    return cqid < n->params.num_queues && n->cq[cqid] !=3D NULL ? 0 : -1=
;
>   }
>  =20
>   static void nvme_inc_cq_tail(NvmeCQueue *cq)
> @@ -631,7 +631,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
>           trace_nvme_dev_err_invalid_create_cq_addr(prp1);
>           return NVME_INVALID_FIELD | NVME_DNR;
>       }
> -    if (unlikely(vector > n->num_queues)) {
> +    if (unlikely(vector > n->params.num_queues)) {
>           trace_nvme_dev_err_invalid_create_cq_vector(vector);
>           return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>       }
> @@ -783,7 +783,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
>           trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled")=
;
>           break;
>       case NVME_NUMBER_OF_QUEUES:
> -        result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
> +        result =3D cpu_to_le32((n->params.num_queues - 2) |
> +                             ((n->params.num_queues - 2) << 16));
>           trace_nvme_dev_getfeat_numq(result);
>           break;
>       case NVME_TIMESTAMP:
> @@ -827,9 +828,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
>       case NVME_NUMBER_OF_QUEUES:
>           trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
>                                       ((dw11 >> 16) & 0xFFFF) + 1,
> -                                    n->num_queues - 1, n->num_queues - 1=
);
> -        req->cqe.result =3D
> -            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
> +                                    n->params.num_queues - 1,
> +                                    n->params.num_queues - 1);
> +        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
> +                                      ((n->params.num_queues - 2) << 16)=
);
>           break;
>       case NVME_TIMESTAMP:
>           return nvme_set_feature_timestamp(n, cmd);
> @@ -900,12 +902,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>  =20
>       blk_drain(n->conf.blk);
>  =20
> -    for (i =3D 0; i < n->num_queues; i++) {
> +    for (i =3D 0; i < n->params.num_queues; i++) {
>           if (n->sq[i] !=3D NULL) {
>               nvme_free_sq(n->sq[i], n);
>           }
>       }
> -    for (i =3D 0; i < n->num_queues; i++) {
> +    for (i =3D 0; i < n->params.num_queues; i++) {
>           if (n->cq[i] !=3D NULL) {
>               nvme_free_cq(n->cq[i], n);
>           }
> @@ -1306,7 +1308,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       int64_t bs_size;
>       uint8_t *pci_conf;
>  =20
> -    if (!n->num_queues) {
> +    if (!n->params.num_queues) {
>           error_setg(errp, "num_queues can't be zero");
>           return;
>       }
> @@ -1322,7 +1324,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           return;
>       }
>  =20
> -    if (!n->serial) {
> +    if (!n->params.serial) {
>           error_setg(errp, "serial property not set");
>           return;
>       }
> @@ -1339,25 +1341,25 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>  =20
>       n->num_namespaces =3D 1;
> -    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
> +    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
>       n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>  =20
>       n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
> -    n->sq =3D g_new0(NvmeSQueue *, n->num_queues);
> -    n->cq =3D g_new0(NvmeCQueue *, n->num_queues);
> +    n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
> +    n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
>  =20
>       memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                             "nvme", n->reg_size);
>       pci_register_bar(pci_dev, 0,
>           PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>           &n->iomem);
> -    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
> +    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
>  =20
>       id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>       id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEN=
DOR_ID));
>       strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
>       strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
> -    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
> +    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
>       id->rab =3D 6;
>       id->ieee[0] =3D 0x00;
>       id->ieee[1] =3D 0x02;
> @@ -1386,7 +1388,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       n->bar.vs =3D 0x00010200;
>       n->bar.intmc =3D n->bar.intms =3D 0;
>  =20
> -    if (n->cmb_size_mb) {
> +    if (n->params.cmb_size_mb) {
>  =20
>           NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
>           NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> @@ -1397,7 +1399,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>           NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>           NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
> +        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
>  =20
>           n->cmbloc =3D n->bar.cmbloc;
>           n->cmbsz =3D n->bar.cmbsz;
> @@ -1436,7 +1438,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>       g_free(n->cq);
>       g_free(n->sq);
>  =20
> -    if (n->cmb_size_mb) {
> +    if (n->params.cmb_size_mb) {
>           g_free(n->cmbuf);
>       }
>       msix_uninit_exclusive_bar(pci_dev);
> @@ -1444,9 +1446,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>  =20
>   static Property nvme_props[] =3D {
>       DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
> -    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
> -    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
> -    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
> +    DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 557194ee1954..9957c4a200e2 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -1,7 +1,19 @@
>   #ifndef HW_NVME_H
>   #define HW_NVME_H
> +
>   #include "block/nvme.h"
>  =20
> +#define DEFINE_NVME_PROPERTIES(_state, _props) \
> +    DEFINE_PROP_STRING("serial", _state, _props.serial), \
> +    DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
> +
> +typedef struct NvmeParams {
> +    char     *serial;
> +    uint32_t num_queues;
> +    uint32_t cmb_size_mb;
> +} NvmeParams;
> +
>   typedef struct NvmeAsyncEvent {
>       QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
>       NvmeAerResult result;
> @@ -63,6 +75,7 @@ typedef struct NvmeCtrl {
>       MemoryRegion ctrl_mem;
>       NvmeBar      bar;
>       BlockConf    conf;
> +    NvmeParams   params;
>  =20
>       uint32_t    page_size;
>       uint16_t    page_bits;
> @@ -71,10 +84,8 @@ typedef struct NvmeCtrl {
>       uint16_t    sqe_size;
>       uint32_t    reg_size;
>       uint32_t    num_namespaces;
> -    uint32_t    num_queues;
>       uint32_t    max_q_ents;
>       uint64_t    ns_size;
> -    uint32_t    cmb_size_mb;
>       uint32_t    cmbsz;
>       uint32_t    cmbloc;
>       uint8_t     *cmbuf;
> @@ -82,7 +93,6 @@ typedef struct NvmeCtrl {
>       uint64_t    host_timestamp;                 /* Timestamp sent by th=
e host */
>       uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
>  =20
> -    char            *serial;
>       NvmeNamespace   *namespaces;
>       NvmeSQueue      **sq;
>       NvmeCQueue      **cq;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


