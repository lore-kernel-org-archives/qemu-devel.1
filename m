Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C643C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643A0206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVV0RZy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643A0206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcS3-0006qT-KT
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcRJ-0005wc-US
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcRI-0004PA-Do
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:26:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcRI-0004Ot-Ai
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586935588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUv5nCtnVWpzNVkkiR3RKo01lgmg6KRSaBf4u49Wfws=;
 b=GVV0RZy0hCdTw/ZAxQ8Pdb513vRyCTunTjzD/U22vvkmU+XKc0pfyDeBKHggGl4ENXoBVM
 3FuU65sW8d5hu1vkhlnB56MhSbc8G+Te+Hx2uFX8g83lBFEVhjOmBtkZIDM11RTSCfPNsz
 KaVpARDZSQ5WvOhVsij+rBURGWE2fno=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-7Aktg8DJN0C6If_B5F5dBQ-1; Wed, 15 Apr 2020 03:26:26 -0400
X-MC-Unique: 7Aktg8DJN0C6If_B5F5dBQ-1
Received: by mail-ed1-f69.google.com with SMTP id f25so2133498edt.23
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SUv5nCtnVWpzNVkkiR3RKo01lgmg6KRSaBf4u49Wfws=;
 b=g2MhFAZbug0/EEDx3fSl900JyEdS6LewVMOcUyJo8uhxifjFlwMisckhgaZTFpddBD
 dAzP0be/lve/DJQw4x5M1h7lkdJNldr0RKFxd4jth0ZJ6PWPLAKpGDQD9RMnm9woW/nc
 +/mW3x2GtCfNiFqdl8xpfMrmW3fxaMAK/tYdIGEFciPUVjUYuo6+Qe7G7Cu6LG/3VI6x
 G+sRv2SXt29NqloYcVTYS7bgE8shnof5HjOdSVFyrduvuIyaCKc+N3MOn8GeoKIqK8kb
 HzmGF14ZwJi+6ZnMOtdnfZJ8WiUkMfRS9ofKZbsy+H6PQf5h77u/lHQ7lHg7zzKiIcbO
 icyw==
X-Gm-Message-State: AGi0Puaf9HsX1635c75FsOSnGFi9P/U4eo/jW5L4ioPKqIbPy3frIujY
 FAkhVD9YvXr6zXM2jnKsbrFptUpeYbLwRLncZgxZBoWgNNG5MvCqiJb5zKcvFjswCsvf/TgNsvJ
 UDTqziHR+NZ0VWQ4=
X-Received: by 2002:aa7:d794:: with SMTP id s20mr11308754edq.141.1586935584037; 
 Wed, 15 Apr 2020 00:26:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypLCkcGadZunRpKZls6OUtisP/NdBL/UT2uG2AbodCyp1eqMgJDFoyLJmL8knm2Wy6jUqjqSAw==
X-Received: by 2002:aa7:d794:: with SMTP id s20mr11308737edq.141.1586935583806; 
 Wed, 15 Apr 2020 00:26:23 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d6sm2081678edt.63.2020.04.15.00.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:26:23 -0700 (PDT)
Subject: Re: [PATCH v7 40/48] nvme: handle dma errors
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-41-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c62b43f4-e84f-61b5-3fd6-ddcee69abb8e@redhat.com>
Date: Wed, 15 Apr 2020 09:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-41-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Handling DMA errors gracefully is required for the device to pass the
> block/011 test ("disable PCI device while doing I/O") in the blktests
> suite.
> 
> With this patch the device passes the test by retrying "critical"
> transfers (posting of completion entries and processing of submission
> queue entries).
> 
> If DMA errors occur at any other point in the execution of the command
> (say, while mapping the PRPs), the command is aborted with a Data
> Transfer Error status code.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c       | 45 ++++++++++++++++++++++++++++++++-----------
>   hw/block/trace-events |  2 ++
>   include/block/nvme.h  |  2 +-
>   3 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index eb15a0bd3cf9..6dcd9c4b4cd0 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -74,14 +74,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>       return addr >= low && addr < hi;
>   }
>   
> -static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> +static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>   {
>       if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
>           memcpy(buf, nvme_addr_to_cmb(n, addr), size);
> -        return;
> +        return 0;
>       }
>   
> -    pci_dma_read(&n->parent_obj, addr, buf, size);
> +    return pci_dma_read(&n->parent_obj, addr, buf, size);
>   }
>   
>   static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> @@ -185,7 +185,7 @@ static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
>       }
>   
>       if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - 1)) {
> -        return NVME_DATA_TRAS_ERROR;
> +        return NVME_DATA_TRANSFER_ERROR;
>       }
>   
>       qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> @@ -238,6 +238,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>       int num_prps = (len >> n->page_bits) + 1;
>       uint16_t status;
>       bool prp_list_in_cmb = false;
> +    int ret;
>   
>       trace_nvme_dev_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
>                              num_prps);
> @@ -277,7 +278,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>   
>               nents = (len + n->page_size - 1) >> n->page_bits;
>               prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> +            ret = nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> +            if (ret) {
> +                trace_nvme_dev_err_addr_read(prp2);
> +                status = NVME_DATA_TRANSFER_ERROR;
> +                goto unmap;
> +            }
>               while (len != 0) {
>                   uint64_t prp_ent = le64_to_cpu(prp_list[i]);
>   
> @@ -296,8 +302,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>                       i = 0;
>                       nents = (len + n->page_size - 1) >> n->page_bits;
>                       prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -                    nvme_addr_read(n, prp_ent, (void *)prp_list,
> -                        prp_trans);
> +                    ret = nvme_addr_read(n, prp_ent, (void *)prp_list,
> +                                         prp_trans);
> +                    if (ret) {
> +                        trace_nvme_dev_err_addr_read(prp_ent);
> +                        status = NVME_DATA_TRANSFER_ERROR;
> +                        goto unmap;
> +                    }
>                       prp_ent = le64_to_cpu(prp_list[i]);
>                   }
>   
> @@ -502,6 +513,7 @@ static void nvme_post_cqes(void *opaque)
>       NvmeCQueue *cq = opaque;
>       NvmeCtrl *n = cq->ctrl;
>       NvmeRequest *req, *next;
> +    int ret;
>   
>       QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
>           NvmeSQueue *sq;
> @@ -511,15 +523,21 @@ static void nvme_post_cqes(void *opaque)
>               break;
>           }
>   
> -        QTAILQ_REMOVE(&cq->req_list, req, entry);
>           sq = req->sq;
>           req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
>           req->cqe.sq_id = cpu_to_le16(sq->sqid);
>           req->cqe.sq_head = cpu_to_le16(sq->head);
>           addr = cq->dma_addr + cq->tail * n->cqe_size;
> +        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> +                            sizeof(req->cqe));
> +        if (ret) {
> +            trace_nvme_dev_err_addr_write(addr);
> +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      500 * SCALE_MS);

Could you refactor the timer_mod() calls into a better named helper?

> +            break;
> +        }
> +        QTAILQ_REMOVE(&cq->req_list, req, entry);
>           nvme_inc_cq_tail(cq);
> -        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> -            sizeof(req->cqe));
>           nvme_req_clear(req);
>           QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>       }
> @@ -1664,7 +1682,12 @@ static void nvme_process_sq(void *opaque)
>   
>       while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
>           addr = sq->dma_addr + sq->head * n->sqe_size;
> -        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
> +        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
> +            trace_nvme_dev_err_addr_read(addr);
> +            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      500 * SCALE_MS);

Ditto.

> +            break;
> +        }
>           nvme_inc_sq_head(sq);
>   
>           req = QTAILQ_FIRST(&sq->req_list);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 7c277a2999c0..75bde5e676a5 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -87,6 +87,8 @@ nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_
>   # nvme traces for error conditions
>   nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
>   nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
> +nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
> +nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
>   nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>   nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>   nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index c4c669e32fc4..03bee32c27c4 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -457,7 +457,7 @@ enum NvmeStatusCodes {
>       NVME_INVALID_OPCODE         = 0x0001,
>       NVME_INVALID_FIELD          = 0x0002,
>       NVME_CID_CONFLICT           = 0x0003,
> -    NVME_DATA_TRAS_ERROR        = 0x0004,
> +    NVME_DATA_TRANSFER_ERROR    = 0x0004,
>       NVME_POWER_LOSS_ABORT       = 0x0005,
>       NVME_INTERNAL_DEV_ERROR     = 0x0006,
>       NVME_CMD_ABORT_REQ          = 0x0007,
> 


