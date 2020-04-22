Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517A3C5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FF4206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvUzpaQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FF4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAMz-0001E1-Cz
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRALq-0000Vf-8E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRALo-0006kZ-M3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:03:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRALo-0006jT-7C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587542598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbeLO7xToUV+4ME2k2pNcCVSQvMF/dKjIIt/3j+sKDI=;
 b=KvUzpaQBXrfz+a5R4ubuUhtkGcD13C5EQ2nxvjRcTOhSUjGNu6VaYKj4STmzwtrdBnb0N3
 Shg7qqMH+UNvUpsmKf/DkGywr2P1VfXgVDgtmoFvvKpJqxOpQU9B11Dny4oVnwxqomwgVP
 IlqLqFn72tht97/jdfROoCh6hkft9gg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-Nfy3H3aoNcyv2bZVdqnifw-1; Wed, 22 Apr 2020 04:03:16 -0400
X-MC-Unique: Nfy3H3aoNcyv2bZVdqnifw-1
Received: by mail-wr1-f71.google.com with SMTP id q10so663086wrv.10
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 01:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4co0pJPV0oQ2Ays/k+TjO5TD8g71/hCEOiDcnLa02W8=;
 b=BDaszY9yCUinCSwINrH72ttMnn3ZKwc5+oiaIdZBayQMQ5TLBzQDiv5ef0wVgmjhz9
 U+M7fudVnBarM+z5/9FsyOfLKwPf3SqQgcOoChc8dBc+nXCsHCJN+/vezJR2rA/G1lPb
 BBsdUoNWjcRg4eI6Gds+0bnPB0KwlK9AD/dFkGOmNpcnzAJs1vhDa42jgC25p38wstiE
 p6FbIOnWUMT9/WeI9DvAnMPJm8cJ/8tRQwiYwq6QFoIHJRT/4Xfe/B7YRmvXWJxeDXeh
 TCK2csCeSLiegbG1VHIRdODuBusMkrL6/jDWDePbwqQifLVGCTciM1GnHNdQzMzLvV4q
 oBlg==
X-Gm-Message-State: AGi0Pua03o92T6ISGa//yhJZ4h6R0HMmrB5IvbIokB//uSV5kkeKy7rh
 sPJCjYhBNCd2IyMOehUbR8+7caqt4gJE8lQBBXCLWmL6gDoGGB/GRRIfvs5gaMDf2W7NiwQE/ik
 I08Li2BwK3W2I2s8=
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr29499582wrj.114.1587542594998; 
 Wed, 22 Apr 2020 01:03:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJc9Wz4CCgRWOFyEXYC+wVKw6ivN5lXvyTsGNr4yHyQVqYDClmsyHTiGUNkOyOV/F4+uDt2yA==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr29499545wrj.114.1587542594584; 
 Wed, 22 Apr 2020 01:03:14 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p6sm7086085wrt.3.2020.04.22.01.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 01:03:14 -0700 (PDT)
Subject: Re: [PATCH v3 04/16] nvme: move device parameters to separate struct
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200422070927.373048-1-its@irrelevant.dk>
 <20200422070927.373048-5-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cdb307a0-4902-4e57-7aee-0fcc00bbe039@redhat.com>
Date: Wed, 22 Apr 2020 10:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422070927.373048-5-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

On 4/22/20 9:09 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Move device configuration parameters to separate struct to make it
> explicit what is configurable and what is set internally.
>=20
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 49 ++++++++++++++++++++++++-------------------------
>   hw/block/nvme.h | 18 +++++++++++++++---
>   2 files changed, 39 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f67499d85f3a..382275e466fe 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -78,12 +78,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
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
> @@ -645,7 +645,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
>           trace_pci_nvme_err_invalid_create_cq_addr(prp1);
>           return NVME_INVALID_FIELD | NVME_DNR;
>       }
> -    if (unlikely(vector > n->num_queues)) {
> +    if (unlikely(vector > n->params.num_queues)) {
>           trace_pci_nvme_err_invalid_create_cq_vector(vector);
>           return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>       }
> @@ -797,7 +797,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
>           trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled")=
;
>           break;
>       case NVME_NUMBER_OF_QUEUES:
> -        result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
> +        result =3D cpu_to_le32((n->params.num_queues - 2) |
> +                             ((n->params.num_queues - 2) << 16));
>           trace_pci_nvme_getfeat_numq(result);
>           break;
>       case NVME_TIMESTAMP:
> @@ -841,9 +842,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
>       case NVME_NUMBER_OF_QUEUES:
>           trace_pci_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
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
> @@ -914,12 +916,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
> @@ -1350,7 +1352,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       int64_t bs_size;
>       uint8_t *pci_conf;
>  =20
> -    if (!n->num_queues) {
> +    if (!n->params.num_queues) {
>           error_setg(errp, "num_queues can't be zero");
>           return;
>       }
> @@ -1366,12 +1368,12 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>           return;
>       }
>  =20
> -    if (!n->serial) {
> +    if (!n->params.serial) {
>           error_setg(errp, "serial property not set");
>           return;
>       }
>  =20
> -    if (!n->cmb_size_mb && n->pmrdev) {
> +    if (!n->params.cmb_size_mb && n->pmrdev) {
>           if (host_memory_backend_is_mapped(n->pmrdev)) {
>               char *path =3D object_get_canonical_path_component(OBJECT(n=
->pmrdev));
>               error_setg(errp, "can't use already busy memdev: %s", path)=
;
> @@ -1402,25 +1404,26 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>       n->num_namespaces =3D 1;
>  =20
>       /* num_queues is really number of pairs, so each has two doorbells =
*/
> -    n->reg_size =3D pow2ceil(NVME_REG_SIZE + 2 * n->num_queues * NVME_DB=
_SIZE);
> +    n->reg_size =3D pow2ceil(NVME_REG_SIZE +
> +                           2 * n->params.num_queues * NVME_DB_SIZE);
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
> @@ -1449,7 +1452,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       n->bar.vs =3D 0x00010200;
>       n->bar.intmc =3D n->bar.intms =3D 0;
>  =20
> -    if (n->cmb_size_mb) {
> +    if (n->params.cmb_size_mb) {
>  =20
>           NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
>           NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> @@ -1460,7 +1463,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>           NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>           NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
> +        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
>  =20
>           n->cmbloc =3D n->bar.cmbloc;
>           n->cmbsz =3D n->bar.cmbsz;
> @@ -1544,7 +1547,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>       g_free(n->cq);
>       g_free(n->sq);
>  =20
> -    if (n->cmb_size_mb) {
> +    if (n->params.cmb_size_mb) {
>           g_free(n->cmbuf);
>       }
>  =20
> @@ -1556,11 +1559,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>  =20
>   static Property nvme_props[] =3D {
>       DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
> -    DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmrdev, TYPE_MEMORY_BACKEND,
> -                     HostMemoryBackend *),
> -    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
> -    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
> -    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
> +    DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 6520a9f0bead..7cb1d5e31870 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -1,7 +1,21 @@
>   #ifndef HW_NVME_H
>   #define HW_NVME_H
> +
>   #include "block/nvme.h"
>  =20
> +#define DEFINE_NVME_PROPERTIES(_state, _props) \
> +    DEFINE_PROP_STRING("serial", _state, _props.serial), \
> +    DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
> +    DEFINE_PROP_LINK("pmrdev", _state, pmrdev, TYPE_MEMORY_BACKEND, \
> +                     HostMemoryBackend *)

Is the DEFINE_NVME_PROPERTIES() macro necessary? Are you going to reuse=20
it in various devices? I'd rather keep this inlined in nvme_props[] in=20
nvme.c.

Otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
> @@ -63,6 +77,7 @@ typedef struct NvmeCtrl {
>       MemoryRegion ctrl_mem;
>       NvmeBar      bar;
>       BlockConf    conf;
> +    NvmeParams   params;
>  =20
>       uint32_t    page_size;
>       uint16_t    page_bits;
> @@ -71,10 +86,8 @@ typedef struct NvmeCtrl {
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
> @@ -82,7 +95,6 @@ typedef struct NvmeCtrl {
>       uint64_t    host_timestamp;                 /* Timestamp sent by th=
e host */
>       uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
>  =20
> -    char            *serial;
>       HostMemoryBackend *pmrdev;
>  =20
>       NvmeNamespace   *namespaces;
>=20


