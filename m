Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27EFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83434206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83434206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGNe-00070Y-Oo
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqGMl-0006SV-IG; Tue, 30 Jun 2020 09:32:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqGMg-0005HW-Gs; Tue, 30 Jun 2020 09:32:02 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2FD3FBF676;
 Tue, 30 Jun 2020 13:31:54 +0000 (UTC)
Date: Tue, 30 Jun 2020 15:31:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 10/18] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200630133151.5wyojlv2l6h2skjd@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-11-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-11-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 06:34, Dmitry Fomichev wrote:
> The driver has been changed to advertise NVM Command Set when "zoned"
> driver property is not set (default) and Zoned Namespace Command Set
> otherwise.
> 
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
> 
> Driver initialization code has been extended to create a proper
> configuration for zoned operation using driver properties.
> 
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Read Zeroes

s/Read Zeroes/Write Zeroes

> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
> 
> The code to support for Zone Descriptor Extensions is not included in
> this commit and the driver always reports ZDES 0. A later commit in
> this series will add ZDE support.
> 
> This commit doesn't yet include checks for active and open zone
> limits. It is assumed that there are no limits on either active or
> open zones.
> 

And s/driver/device ;)

> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 963 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 933 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 453f4747a5..2e03b0b6ed 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -37,6 +37,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> +#include "crypto/random.h"
>  #include "hw/block/block.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci.h"
> @@ -69,6 +70,98 @@
>  
>  static void nvme_process_sq(void *opaque);
>  
> +/*
> + * Add a zone to the tail of a zone list.
> + */
> +static void nvme_add_zone_tail(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
> +    NvmeZone *zone)
> +{
> +    uint32_t idx = (uint32_t)(zone - ns->zone_array);
> +
> +    assert(nvme_zone_not_in_list(zone));
> +
> +    if (!zl->size) {
> +        zl->head = zl->tail = idx;
> +        zone->next = zone->prev = NVME_ZONE_LIST_NIL;
> +    } else {
> +        ns->zone_array[zl->tail].next = idx;
> +        zone->prev = zl->tail;
> +        zone->next = NVME_ZONE_LIST_NIL;
> +        zl->tail = idx;
> +    }
> +    zl->size++;
> +}
> +
> +/*
> + * Remove a zone from a zone list. The zone must be linked in the list.
> + */
> +static void nvme_remove_zone(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
> +    NvmeZone *zone)
> +{
> +    uint32_t idx = (uint32_t)(zone - ns->zone_array);
> +
> +    assert(!nvme_zone_not_in_list(zone));
> +
> +    --zl->size;
> +    if (zl->size == 0) {
> +        zl->head = NVME_ZONE_LIST_NIL;
> +        zl->tail = NVME_ZONE_LIST_NIL;
> +    } else if (idx == zl->head) {
> +        zl->head = zone->next;
> +        ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
> +    } else if (idx == zl->tail) {
> +        zl->tail = zone->prev;
> +        ns->zone_array[zl->tail].next = NVME_ZONE_LIST_NIL;
> +    } else {
> +        ns->zone_array[zone->next].prev = zone->prev;
> +        ns->zone_array[zone->prev].next = zone->next;
> +    }
> +
> +    zone->prev = zone->next = 0;
> +}
> +
> +static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state)
> +{
> +    if (!nvme_zone_not_in_list(zone)) {
> +        switch (nvme_get_zone_state(zone)) {
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +            nvme_remove_zone(n, ns, ns->exp_open_zones, zone);
> +            break;
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +            nvme_remove_zone(n, ns, ns->imp_open_zones, zone);
> +            break;
> +        case NVME_ZONE_STATE_CLOSED:
> +            nvme_remove_zone(n, ns, ns->closed_zones, zone);
> +            break;
> +        case NVME_ZONE_STATE_FULL:
> +            nvme_remove_zone(n, ns, ns->full_zones, zone);
> +        }
> +   }
> +
> +    nvme_set_zone_state(zone, state);
> +
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        nvme_add_zone_tail(n, ns, ns->exp_open_zones, zone);
> +        break;
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        nvme_add_zone_tail(n, ns, ns->imp_open_zones, zone);
> +        break;
> +    case NVME_ZONE_STATE_CLOSED:
> +        nvme_add_zone_tail(n, ns, ns->closed_zones, zone);
> +        break;
> +    case NVME_ZONE_STATE_FULL:
> +        nvme_add_zone_tail(n, ns, ns->full_zones, zone);
> +        break;
> +    default:
> +        zone->d.za = 0;
> +        /* fall through */
> +    case NVME_ZONE_STATE_READ_ONLY:
> +        zone->tstamp = 0;
> +    }
> +}
> +
>  static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  {
>      hwaddr low = n->ctrl_mem.addr;
> @@ -314,6 +407,7 @@ static void nvme_post_cqes(void *opaque)
>  
>          QTAILQ_REMOVE(&cq->req_list, req, entry);
>          sq = req->sq;
> +

Spurious newline.

>          req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
>          req->cqe.sq_id = cpu_to_le16(sq->sqid);
>          req->cqe.sq_head = cpu_to_le16(sq->head);
> @@ -328,6 +422,30 @@ static void nvme_post_cqes(void *opaque)
>      }
>  }
>  
> +static void nvme_fill_data(QEMUSGList *qsg, QEMUIOVector *iov,
> +    uint64_t offset, uint8_t pattern)
> +{
> +    ScatterGatherEntry *entry;
> +    uint32_t len, ent_len;
> +
> +    if (qsg->nsg > 0) {
> +        entry = qsg->sg;
> +        for (len = qsg->size; len > 0; len -= ent_len) {
> +            ent_len = MIN(len, entry->len);
> +            if (offset > ent_len) {
> +                offset -= ent_len;
> +            } else if (offset != 0) {
> +                dma_memory_set(qsg->as, entry->base + offset,
> +                               pattern, ent_len - offset);
> +                offset = 0;
> +            } else {
> +                dma_memory_set(qsg->as, entry->base, pattern, ent_len);
> +            }
> +            entry++;
> +        }
> +    }
> +}
> +
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> @@ -336,6 +454,114 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>  }
>  
> +static uint16_t nvme_check_zone_write(NvmeZone *zone, uint64_t slba,
> +    uint32_t nlb)
> +{
> +    uint16_t status;
> +
> +    if (unlikely((slba + nlb) > nvme_zone_wr_boundary(zone))) {
> +        return NVME_ZONE_BOUNDARY_ERROR;
> +    }
> +
> +    switch (nvme_get_zone_state(zone)) {
> +    case NVME_ZONE_STATE_EMPTY:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_CLOSED:
> +        status = NVME_SUCCESS;
> +        break;
> +    case NVME_ZONE_STATE_FULL:
> +        status = NVME_ZONE_FULL;
> +        break;
> +    case NVME_ZONE_STATE_OFFLINE:
> +        status = NVME_ZONE_OFFLINE;
> +        break;
> +    case NVME_ZONE_STATE_READ_ONLY:
> +        status = NVME_ZONE_READ_ONLY;
> +        break;
> +    default:
> +        assert(false);
> +    }
> +    return status;
> +}
> +
> +static uint16_t nvme_check_zone_read(NvmeCtrl *n, NvmeZone *zone, uint64_t slba,
> +    uint32_t nlb, bool zone_x_ok)
> +{
> +    uint64_t lba = slba, count;
> +    uint16_t status;
> +    uint8_t zs;
> +
> +    do {
> +        if (!zone_x_ok && (lba + nlb > nvme_zone_rd_boundary(n, zone))) {
> +            return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
> +        }
> +
> +        zs = nvme_get_zone_state(zone);
> +        switch (zs) {
> +        case NVME_ZONE_STATE_EMPTY:
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_FULL:
> +        case NVME_ZONE_STATE_CLOSED:
> +        case NVME_ZONE_STATE_READ_ONLY:
> +            status = NVME_SUCCESS;
> +            break;
> +        case NVME_ZONE_STATE_OFFLINE:
> +            status = NVME_ZONE_OFFLINE | NVME_DNR;
> +            break;
> +        default:
> +            assert(false);
> +        }
> +        if (status != NVME_SUCCESS) {
> +            break;
> +        }
> +
> +        if (lba + nlb > nvme_zone_rd_boundary(n, zone)) {
> +            count = nvme_zone_rd_boundary(n, zone) - lba;
> +        } else {
> +            count = nlb;
> +        }
> +
> +        lba += count;
> +        nlb -= count;
> +        zone++;
> +    } while (nlb);
> +
> +    return status;
> +}
> +
> +static uint64_t nvme_finalize_zone_write(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint32_t nlb)
> +{
> +    uint64_t result = cpu_to_le64(zone->d.wp);
> +    uint8_t zs = nvme_get_zone_state(zone);
> +
> +    zone->d.wp += nlb;
> +
> +    if (zone->d.wp == nvme_zone_wr_boundary(zone)) {
> +        switch (zs) {
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_CLOSED:
> +        case NVME_ZONE_STATE_EMPTY:
> +            break;
> +        default:
> +            assert(false);
> +        }
> +        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
> +    } else {
> +        switch (zs) {
> +        case NVME_ZONE_STATE_EMPTY:
> +        case NVME_ZONE_STATE_CLOSED:
> +            nvme_assign_zone_state(n, ns, zone,
> +                                   NVME_ZONE_STATE_IMPLICITLY_OPEN);
> +        }
> +    }
> +
> +    return result;
> +}
> +
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req = opaque;
> @@ -344,6 +570,10 @@ static void nvme_rw_cb(void *opaque, int ret)
>      NvmeCQueue *cq = n->cq[sq->cqid];
>  
>      if (!ret) {
> +        if (req->flags & NVME_REQ_FLG_FILL) {
> +            nvme_fill_data(&req->qsg, &req->iov, req->fill_ofs,
> +                           n->params.fill_pattern);
> +        }
>          block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_SUCCESS;
>      } else {
> @@ -370,22 +600,53 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> +    NvmeZone *zone = NULL;
>      const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
>      uint64_t slba = le64_to_cpu(rw->slba);
>      uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
> +    uint64_t zone_idx;
>      uint64_t offset = slba << data_shift;
>      uint32_t count = nlb << data_shift;
> +    uint16_t status;
>  
>      if (unlikely(slba + nlb > ns->id_ns.nsze)) {
>          trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> +    if (n->params.zoned) {
> +        zone_idx = slba / n->params.zone_size;
> +        if (unlikely(zone_idx >= n->num_zones)) {
> +            trace_pci_nvme_err_capacity_exceeded(zone_idx, n->num_zones);
> +            return NVME_CAP_EXCEEDED | NVME_DNR;
> +        }

Cpacity Exceeded happens when the NUSE exceeds NCAP; shouldn't this be
LBA Out of Range? But this shouldn't happen since it would be caught by
the regular bounds check (exceeding NSZE).

> +
> +        zone = &ns->zone_array[zone_idx];
> +
> +        status = nvme_check_zone_write(zone, slba, nlb);
> +        if (status != NVME_SUCCESS) {
> +            trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
> +            return status | NVME_DNR;
> +        }
> +
> +        assert(nvme_wp_is_valid(zone));
> +        if (unlikely(slba != zone->d.wp)) {
> +            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
> +                                               zone->d.wp);
> +            return NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +        }
> +    }
> +
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>                       BLOCK_ACCT_WRITE);
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
>                                          BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
> +
> +    if (n->params.zoned) {
> +        req->cqe.result64 = nvme_finalize_zone_write(n, ns, zone, nlb);
> +    }
> +
>      return NVME_NO_COMPLETE;
>  }
>  
> @@ -393,16 +654,19 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> +    NvmeZone *zone = NULL;
>      uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
>      uint64_t prp1 = le64_to_cpu(rw->prp1);
>      uint64_t prp2 = le64_to_cpu(rw->prp2);
> -
> +    uint64_t zone_idx = 0;
> +    uint16_t status;
>      uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
>      uint64_t data_size = (uint64_t)nlb << data_shift;
> -    uint64_t data_offset = slba << data_shift;
> -    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
> +    uint64_t data_offset;
> +    bool is_write = rw->opcode == NVME_CMD_WRITE ||
> +                    (req->flags & NVME_REQ_FLG_APPEND);
>      enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
>  
>      trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
> @@ -413,11 +677,79 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> +    if (n->params.zoned) {
> +        zone_idx = slba / n->params.zone_size;
> +        if (unlikely(zone_idx >= n->num_zones)) {
> +            trace_pci_nvme_err_capacity_exceeded(zone_idx, n->num_zones);
> +            return NVME_CAP_EXCEEDED | NVME_DNR;
> +        }
> +
> +        zone = &ns->zone_array[zone_idx];
> +
> +        if (is_write) {
> +            status = nvme_check_zone_write(zone, slba, nlb);
> +            if (status != NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
> +                return status | NVME_DNR;
> +            }
> +
> +            assert(nvme_wp_is_valid(zone));
> +            if (req->flags & NVME_REQ_FLG_APPEND) {
> +                if (unlikely(slba != zone->d.zslba)) {
> +                    trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
> +                    return NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +                }
> +                if (data_size > (n->page_size << n->zamds)) {
> +                    trace_pci_nvme_err_append_too_large(slba, nlb, n->zamds);
> +                    return NVME_INVALID_FIELD | NVME_DNR;
> +                }
> +                slba = zone->d.wp;
> +            } else if (unlikely(slba != zone->d.wp)) {
> +                trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
> +                                                   zone->d.wp);
> +                return NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +            }
> +        } else {
> +            status = nvme_check_zone_read(n, zone, slba, nlb,
> +                                          n->params.cross_zone_read);
> +            if (status != NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
> +                return status | NVME_DNR;
> +            }
> +
> +            if (slba + nlb > zone->d.wp) {
> +                /*
> +                 * All or some data is read above the WP. Need to
> +                 * fill out the buffer area that has no backing data
> +                 * with a predefined data pattern (zeros by default)
> +                 */
> +                req->flags |= NVME_REQ_FLG_FILL;
> +                if (slba >= zone->d.wp) {
> +                    req->fill_ofs = 0;
> +                } else {
> +                    req->fill_ofs = ((zone->d.wp - slba) << data_shift);
> +                }
> +            }
> +        }
> +    } else if (req->flags & NVME_REQ_FLG_APPEND) {
> +        trace_pci_nvme_err_invalid_opc(cmd->opcode);
> +        return NVME_INVALID_OPCODE | NVME_DNR;
> +    }
> +
>      if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> +    if (unlikely(!is_write && (req->flags & NVME_REQ_FLG_FILL) &&
> +                 (req->fill_ofs == 0))) {
> +        /* No backend I/O necessary, only need to fill the buffer */
> +        nvme_fill_data(&req->qsg, &req->iov, 0, n->params.fill_pattern);
> +        req->status = NVME_SUCCESS;
> +        return NVME_SUCCESS;
> +    }
> +
> +    data_offset = slba << data_shift;
>      dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
>      if (req->qsg.nsg > 0) {
>          req->flags |= NVME_REQ_FLG_HAS_SG;
> @@ -434,9 +766,383 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>                             req);
>      }
>  
> +    if (is_write && n->params.zoned) {
> +        req->cqe.result64 = nvme_finalize_zone_write(n, ns, zone, nlb);
> +    }
> +
>      return NVME_NO_COMPLETE;
>  }
>  
> +static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeCmd *c, uint64_t *slba, uint64_t *zone_idx)
> +{
> +    uint32_t dw10 = le32_to_cpu(c->cdw10);
> +    uint32_t dw11 = le32_to_cpu(c->cdw11);
> +
> +    if (!n->params.zoned) {
> +        trace_pci_nvme_err_invalid_opc(c->opcode);
> +        return NVME_INVALID_OPCODE | NVME_DNR;
> +    }
> +
> +    *slba = ((uint64_t)dw11) << 32 | dw10;
> +    if (unlikely(*slba >= ns->id_ns.nsze)) {
> +        trace_pci_nvme_err_invalid_lba_range(*slba, 0, ns->id_ns.nsze);
> +        *slba = 0;
> +        return NVME_LBA_RANGE | NVME_DNR;
> +    }
> +
> +    *zone_idx = *slba / n->params.zone_size;
> +    if (unlikely(*zone_idx >= n->num_zones)) {
> +        trace_pci_nvme_err_capacity_exceeded(*zone_idx, n->num_zones);
> +        *zone_idx = 0;
> +        return NVME_CAP_EXCEEDED | NVME_DNR;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_open_zone(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EMPTY:
> +    case NVME_ZONE_STATE_CLOSED:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
> +        /* fall through */
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_open_all(uint8_t state)
> +{
> +    return state == NVME_ZONE_STATE_CLOSED;
> +}
> +
> +static uint16_t nvme_close_zone(NvmeCtrl *n,  NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
> +        /* fall through */
> +    case NVME_ZONE_STATE_CLOSED:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_close_all(uint8_t state)
> +{
> +    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
> +           state == NVME_ZONE_STATE_EXPLICITLY_OPEN;
> +}
> +
> +static uint16_t nvme_finish_zone(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_CLOSED:
> +    case NVME_ZONE_STATE_EMPTY:
> +        zone->d.wp = nvme_zone_wr_boundary(zone);
> +        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
> +        /* fall through */
> +    case NVME_ZONE_STATE_FULL:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_finish_all(uint8_t state)
> +{
> +    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
> +           state == NVME_ZONE_STATE_EXPLICITLY_OPEN ||
> +           state == NVME_ZONE_STATE_CLOSED;
> +}
> +
> +static uint16_t nvme_reset_zone(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_CLOSED:
> +    case NVME_ZONE_STATE_FULL:
> +        zone->d.wp = zone->d.zslba;
> +        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EMPTY);
> +        /* fall through */
> +    case NVME_ZONE_STATE_EMPTY:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_reset_all(uint8_t state)
> +{
> +    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
> +           state == NVME_ZONE_STATE_EXPLICITLY_OPEN ||
> +           state == NVME_ZONE_STATE_CLOSED ||
> +           state == NVME_ZONE_STATE_FULL;
> +}
> +
> +static uint16_t nvme_offline_zone(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_READ_ONLY:
> +        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_OFFLINE);
> +        /* fall through */
> +    case NVME_ZONE_STATE_OFFLINE:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_offline_all(uint8_t state)
> +{
> +    return state == NVME_ZONE_STATE_READ_ONLY;
> +}
> +
> +static uint16_t name_do_zone_op(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, uint8_t state, bool all,
> +    uint16_t (*op_hndlr)(NvmeCtrl *, NvmeNamespace *, NvmeZone *,
> +                         uint8_t), bool (*proc_zone)(uint8_t))
> +{
> +    int i;
> +    uint16_t status = 0;
> +
> +    if (!all) {
> +        status = op_hndlr(n, ns, zone, state);
> +    } else {
> +        for (i = 0; i < n->num_zones; i++, zone++) {
> +            state = nvme_get_zone_state(zone);
> +            if (proc_zone(state)) {
> +                status = op_hndlr(n, ns, zone, state);
> +                if (status != NVME_SUCCESS) {
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +
> +    return status;
> +}

This is actually pretty neat :)

> +
> +static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> +    uint64_t slba = 0;
> +    uint64_t zone_idx = 0;
> +    uint16_t status;
> +    uint8_t action, state;
> +    bool all;
> +    NvmeZone *zone;
> +
> +    action = dw13 & 0xff;
> +    all = dw13 & 0x100;
> +
> +    req->status = NVME_SUCCESS;
> +
> +    if (!all) {
> +        status = nvme_get_mgmt_zone_slba_idx(n, ns, cmd, &slba, &zone_idx);
> +        if (status) {
> +            return status;
> +        }
> +    }
> +
> +    zone = &ns->zone_array[zone_idx];
> +    if (slba != zone->d.zslba) {
> +        trace_pci_nvme_err_unaligned_zone_cmd(action, slba, zone->d.zslba);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +    state = nvme_get_zone_state(zone);
> +
> +    switch (action) {
> +
> +    case NVME_ZONE_ACTION_OPEN:
> +        trace_pci_nvme_open_zone(slba, zone_idx, all);
> +        status = name_do_zone_op(n, ns, zone, state, all,
> +                                 nvme_open_zone, nvme_cond_open_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_CLOSE:
> +        trace_pci_nvme_close_zone(slba, zone_idx, all);
> +        status = name_do_zone_op(n, ns, zone, state, all,
> +                                 nvme_close_zone, nvme_cond_close_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_FINISH:
> +        trace_pci_nvme_finish_zone(slba, zone_idx, all);
> +        status = name_do_zone_op(n, ns, zone, state, all,
> +                                 nvme_finish_zone, nvme_cond_finish_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_RESET:
> +        trace_pci_nvme_reset_zone(slba, zone_idx, all);
> +        status = name_do_zone_op(n, ns, zone, state, all,
> +                                 nvme_reset_zone, nvme_cond_reset_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_OFFLINE:
> +        trace_pci_nvme_offline_zone(slba, zone_idx, all);
> +        status = name_do_zone_op(n, ns, zone, state, all,
> +                                 nvme_offline_zone, nvme_cond_offline_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_SET_ZD_EXT:
> +        trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +        break;
> +
> +    default:
> +        trace_pci_nvme_err_invalid_mgmt_action(action);
> +        status = NVME_INVALID_FIELD;
> +    }
> +
> +    if (status == NVME_ZONE_INVAL_TRANSITION) {
> +        trace_pci_nvme_err_invalid_zone_state_transition(state, action, slba,
> +                                                         zone->d.za);
> +    }
> +    if (status) {
> +        status |= NVME_DNR;
> +    }
> +
> +    return status;
> +}
> +
> +static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
> +{
> +    int zs = nvme_get_zone_state(zl);
> +
> +    switch (zafs) {
> +    case NVME_ZONE_REPORT_ALL:
> +        return true;
> +    case NVME_ZONE_REPORT_EMPTY:
> +        return (zs == NVME_ZONE_STATE_EMPTY);
> +    case NVME_ZONE_REPORT_IMPLICITLY_OPEN:
> +        return (zs == NVME_ZONE_STATE_IMPLICITLY_OPEN);
> +    case NVME_ZONE_REPORT_EXPLICITLY_OPEN:
> +        return (zs == NVME_ZONE_STATE_EXPLICITLY_OPEN);
> +    case NVME_ZONE_REPORT_CLOSED:
> +        return (zs == NVME_ZONE_STATE_CLOSED);
> +    case NVME_ZONE_REPORT_FULL:
> +        return (zs == NVME_ZONE_STATE_FULL);
> +    case NVME_ZONE_REPORT_READ_ONLY:
> +        return (zs == NVME_ZONE_STATE_READ_ONLY);
> +    case NVME_ZONE_REPORT_OFFLINE:
> +        return (zs == NVME_ZONE_STATE_OFFLINE);
> +    default:
> +        return false;
> +    }
> +}
> +
> +static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    /* cdw12 is zero-based number of dwords to return. Convert to bytes */
> +    uint32_t len = (le32_to_cpu(cmd->cdw12) + 1) << 2;
> +    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> +    uint32_t zra, zrasf, partial;
> +    uint64_t max_zones, zone_index, nr_zones = 0;
> +    uint16_t ret;
> +    uint64_t slba;
> +    NvmeZoneDescr *z;
> +    NvmeZone *zs;
> +    NvmeZoneReportHeader *header;
> +    void *buf, *buf_p;
> +    size_t zone_entry_sz;
> +
> +    req->status = NVME_SUCCESS;
> +
> +    ret = nvme_get_mgmt_zone_slba_idx(n, ns, cmd, &slba, &zone_index);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (len < sizeof(NvmeZoneReportHeader)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    zra = dw13 & 0xff;
> +    if (!(zra == NVME_ZONE_REPORT || zra == NVME_ZONE_REPORT_EXTENDED)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    if (zra == NVME_ZONE_REPORT_EXTENDED) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    zrasf = (dw13 >> 8) & 0xff;
> +    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    partial = (dw13 >> 16) & 0x01;
> +
> +    zone_entry_sz = sizeof(NvmeZoneDescr);
> +
> +    max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
> +    buf = g_malloc0(len);
> +
> +    header = (NvmeZoneReportHeader *)buf;
> +    buf_p = buf + sizeof(NvmeZoneReportHeader);
> +
> +    while (zone_index < n->num_zones && nr_zones < max_zones) {
> +        zs = &ns->zone_array[zone_index];
> +
> +        if (!nvme_zone_matches_filter(zrasf, zs)) {
> +            zone_index++;
> +            continue;
> +        }
> +
> +        z = (NvmeZoneDescr *)buf_p;
> +        buf_p += sizeof(NvmeZoneDescr);
> +        nr_zones++;
> +
> +        z->zt = zs->d.zt;
> +        z->zs = zs->d.zs;
> +        z->zcap = cpu_to_le64(zs->d.zcap);
> +        z->zslba = cpu_to_le64(zs->d.zslba);
> +        z->za = zs->d.za;
> +
> +        if (nvme_wp_is_valid(zs)) {
> +            z->wp = cpu_to_le64(zs->d.wp);
> +        } else {
> +            z->wp = cpu_to_le64(~0ULL);
> +        }
> +
> +        zone_index++;
> +    }
> +
> +    if (!partial) {
> +        for (; zone_index < n->num_zones; zone_index++) {
> +            zs = &ns->zone_array[zone_index];
> +            if (nvme_zone_matches_filter(zrasf, zs)) {
> +                nr_zones++;
> +            }
> +        }
> +    }
> +    header->nr_zones = cpu_to_le64(nr_zones);
> +
> +    ret = nvme_dma_read_prp(n, (uint8_t *)buf, len, prp1, prp2);
> +    g_free(buf);
> +
> +    return ret;
> +}
> +
>  static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
> @@ -453,9 +1159,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_flush(n, ns, cmd, req);
>      case NVME_CMD_WRITE_ZEROS:
>          return nvme_write_zeros(n, ns, cmd, req);
> +    case NVME_CMD_ZONE_APND:
> +        req->flags |= NVME_REQ_FLG_APPEND;
> +        /* fall through */
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
>          return nvme_rw(n, ns, cmd, req);
> +    case NVME_CMD_ZONE_MGMT_SEND:
> +        return nvme_zone_mgmt_send(n, ns, cmd, req);
> +    case NVME_CMD_ZONE_MGMT_RECV:
> +        return nvme_zone_mgmt_recv(n, ns, cmd, req);
>      default:
>          trace_pci_nvme_err_invalid_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -675,6 +1388,16 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>  
> +static inline bool nvme_csi_has_nvm_support(NvmeNamespace *ns)
> +{
> +    switch (ns->csi) {
> +    case NVME_CSI_NVM:
> +    case NVME_CSI_ZONED:
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
>  {
>      uint64_t prp1 = le64_to_cpu(c->prp1);
> @@ -701,6 +1424,12 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeIdentify *c)
>          ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
>          g_free(list);
>          return ret;
> +    } else if (c->csi == NVME_CSI_ZONED && n->params.zoned) {
> +        NvmeIdCtrlZoned *id = g_malloc0(sizeof(*id));
> +        id->zamds = n->zamds;
> +        ret = nvme_dma_read_prp(n, (uint8_t *)id, sizeof(*id), prp1, prp2);
> +        g_free(id);
> +        return ret;
>      } else {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> @@ -723,8 +1452,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>      ns = &n->namespaces[nsid - 1];
>      assert(nsid == ns->nsid);
>  
> -    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> -        prp1, prp2);
> +    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
> +        return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> +            prp1, prp2);
> +    }
> +
> +    return NVME_INVALID_CMD_SET | NVME_DNR;
>  }
>  
>  static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeIdentify *c)
> @@ -747,14 +1480,17 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeIdentify *c)
>      ns = &n->namespaces[nsid - 1];
>      assert(nsid == ns->nsid);
>  
> -    if (c->csi == NVME_CSI_NVM) {
> +    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
>          list = g_malloc0(data_len);
>          ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
>          g_free(list);
>          return ret;
> -    } else {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    } else if (c->csi == NVME_CSI_ZONED && ns->csi == NVME_CSI_ZONED) {
> +        return nvme_dma_read_prp(n, (uint8_t *)ns->id_ns_zoned,
> +                                 sizeof(*ns->id_ns_zoned), prp1, prp2);
>      }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
>  }
>  
>  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
> @@ -796,13 +1532,13 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeIdentify *c)
>  
>      trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
>  
> -    if (c->csi != NVME_CSI_NVM) {
> +    if (c->csi != NVME_CSI_NVM && c->csi != NVME_CSI_ZONED) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
>      list = g_malloc0(data_len);
>      for (i = 0; i < n->num_namespaces; i++) {
> -        if (i < min_nsid) {
> +        if (i < min_nsid || c->csi != n->namespaces[i].csi) {
>              continue;
>          }
>          list[j++] = cpu_to_le32(i + 1);
> @@ -851,7 +1587,7 @@ static uint16_t nvme_list_ns_descriptors(NvmeCtrl *n, NvmeIdentify *c)
>      desc->nidt = NVME_NIDT_CSI;
>      desc->nidl = NVME_NIDL_CSI;
>      buf_ptr += sizeof(*desc);
> -    *(uint8_t *)buf_ptr = NVME_CSI_NVM;
> +    *(uint8_t *)buf_ptr = ns->csi;
>  
>      status = nvme_dma_read_prp(n, buf, data_len, prp1, prp2);
>      g_free(buf);
> @@ -872,6 +1608,9 @@ static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeIdentify *c)
>      list = g_malloc0(data_len);
>      ptr = (uint8_t *)list;
>      NVME_SET_CSI(*ptr, NVME_CSI_NVM);
> +    if (n->params.zoned) {
> +        NVME_SET_CSI(*ptr, NVME_CSI_ZONED);
> +    }
>      status = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
>      g_free(list);
>      return status;
> @@ -1038,7 +1777,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  }
>  
>  static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
> -    uint64_t prp1, uint64_t prp2, uint64_t ofs, uint32_t len)
> +    uint64_t prp1, uint64_t prp2, uint64_t ofs, uint32_t len, uint8_t csi)
>  {
>     NvmeEffectsLog cmd_eff_log = {};
>     uint32_t *iocs = cmd_eff_log.iocs;
> @@ -1063,11 +1802,19 @@ static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
>      iocs[NVME_ADM_CMD_GET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
>      iocs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;
>  
> -    iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> -    iocs[NVME_CMD_WRITE_ZEROS] = NVME_CMD_EFFECTS_CSUPP |
> -                                 NVME_CMD_EFFECTS_LBCC;
> -    iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> -    iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
> +    if (NVME_CC_CSS(n->bar.cc) != CSS_ADMIN_ONLY) {
> +        iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_WRITE_ZEROS] = NVME_CMD_EFFECTS_CSUPP |
> +                                     NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
> +    }
> +    if (csi == NVME_CSI_ZONED && NVME_CC_CSS(n->bar.cc) == CSS_ALL_NSTYPES) {
> +        iocs[NVME_CMD_ZONE_APND] = NVME_CMD_EFFECTS_CSUPP |
> +                                   NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_ZONE_MGMT_SEND] = NVME_CMD_EFFECTS_CSUPP;
> +        iocs[NVME_CMD_ZONE_MGMT_RECV] = NVME_CMD_EFFECTS_CSUPP;
> +    }
>  
>      return nvme_dma_read_prp(n, (uint8_t *)&cmd_eff_log, len, prp1, prp2);
>  }
> @@ -1083,6 +1830,7 @@ static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
>      uint64_t ofs = (dw13 << 32) | dw12;
>      uint32_t numdl, numdu, len;
>      uint16_t lid = dw10 & 0xff;
> +    uint8_t csi = le32_to_cpu(cmd->cdw14) >> 24;
>  
>      numdl = dw10 >> 16;
>      numdu = dw11 & 0xffff;
> @@ -1090,8 +1838,8 @@ static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
>  
>      switch (lid) {
>      case NVME_LOG_CMD_EFFECTS:
> -        return nvme_handle_cmd_effects(n, cmd, prp1, prp2, ofs, len);
> -    }
> +        return nvme_handle_cmd_effects(n, cmd, prp1, prp2, ofs, len, csi);
> +     }
>  
>      trace_pci_nvme_unsupported_log_page(lid);
>      return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1255,6 +2003,14 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>          return -1;
>      }
>  
> +    if (n->params.zoned) {
> +        if (!n->params.zamds_bs) {
> +            n->params.zamds_bs = NVME_DEFAULT_MAX_ZA_SIZE;
> +        }

0 is a valid value for zasl (means same as mdts).

> +        n->params.zamds_bs *= KiB;
> +        n->zamds = nvme_ilog2(n->params.zamds_bs / page_size);
> +    }
> +
>      n->page_bits = page_bits;
>      n->page_size = page_size;
>      n->max_prp_ents = n->page_size / sizeof(uint64_t);
> @@ -1324,6 +2080,11 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
>              }
>              switch (NVME_CC_CSS(data)) {
>              case CSS_NVM_ONLY:
> +                if (n->params.zoned) {
> +                    NVME_GUEST_ERR(pci_nvme_err_only_zoned_cmd_set_avail,
> +                                   "only NVM+ZONED command set can be selected");
> +                    break;
> +                }
>                  trace_pci_nvme_css_nvm_cset_selected_by_host(data & 0xffffffff);
>                  break;
>              case CSS_ALL_NSTYPES:

Actually I think this whole switch is wrong, I don't see why the
controller has to validate anything here. It should be removed from the
NST patch as well.

The TP is a little unclear on the behavior, but I think the only
reasonable behavior would be similar to what applies for the "Admin
Command Set only" (111b), that is - for any I/O command submitted, just
return Invalid Command Opcode.

For the zoned namespace there is nothing that prevents a host to
interact with it "blindly" through the NVM command set (the zoned
command set includes it). Even though the host has no means of getting a
report etc, but it can still read and write.

> @@ -1609,6 +2370,120 @@ static const MemoryRegionOps nvme_cmb_ops = {
>      },
>  };
>  
> +static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
> +    uint64_t capacity)
> +{
> +    NvmeZone *zone;
> +    uint64_t start = 0, zone_size = n->params.zone_size;
> +    int i;
> +
> +    ns->zone_array = g_malloc0(n->zone_array_size);
> +    ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
> +    ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
> +    ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
> +    ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
> +    zone = ns->zone_array;
> +
> +    nvme_init_zone_list(ns->exp_open_zones);
> +    nvme_init_zone_list(ns->imp_open_zones);
> +    nvme_init_zone_list(ns->closed_zones);
> +    nvme_init_zone_list(ns->full_zones);
> +
> +    for (i = 0; i < n->num_zones; i++, zone++) {
> +        if (start + zone_size > capacity) {
> +            zone_size = capacity - start;
> +        }
> +        zone->d.zt = NVME_ZONE_TYPE_SEQ_WRITE;
> +        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
> +        zone->d.za = 0;
> +        zone->d.zcap = n->params.zone_capacity;
> +        zone->d.zslba = start;
> +        zone->d.wp = start;
> +        zone->prev = 0;
> +        zone->next = 0;
> +        start += zone_size;
> +    }
> +
> +    return 0;
> +}
> +

The following function is super confusing. Bear with me ;)

> +static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
> +{
> +    uint64_t zone_size = 0, capacity;
> +    uint32_t nz;
> +
> +    if (n->params.zone_size) {
> +        zone_size = n->params.zone_size;
> +    } else {
> +        zone_size = NVME_DEFAULT_ZONE_SIZE;
> +    }

So zone_size is in MiB's.

> +    if (!n->params.zone_capacity) {
> +        n->params.zone_capacity = zone_size;
> +    }

OK, default the zone_capacity parameter to zone_size (in MiB's).

> +    n->zone_size_bs = zone_size * MiB;

OK, this is in bytes.

> +    n->params.zone_size = n->zone_size_bs / n->conf.logical_block_size;

Now the zone_size parameter is in terms of LBAs?

> +    capacity = n->params.zone_capacity * MiB;

OK, this is in bytes.

> +    n->params.zone_capacity = capacity / n->conf.logical_block_size;

And now this parameter is also in terms of LBAs.

> +    if (n->params.zone_capacity > n->params.zone_size) {
> +        error_setg(errp, "zone capacity exceeds zone size");
> +        return;
> +    }
> +    zone_size = n->params.zone_size;

And now zone_size is in LBAs.

> +
> +    capacity = n->ns_size / n->conf.logical_block_size;

And now overwrite capacity to be in LBAs as well. Wait what was capacity
previously? And what was params.zone_capacity? Madness!

> +    nz = DIV_ROUND_UP(capacity, zone_size);
> +    n->num_zones = nz;
> +    n->zone_array_size = sizeof(NvmeZone) * nz;
> +
> +    return;
> +}
> +
> +static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
> +    Error **errp)
> +{
> +    int ret;
> +
> +    ret = nvme_init_zone_meta(n, ns, n->num_zones * n->params.zone_size);
> +    if (ret) {
> +        error_setg(errp, "could not init zone metadata");
> +        return -1;
> +    }
> +
> +    ns->id_ns_zoned = g_malloc0(sizeof(*ns->id_ns_zoned));
> +
> +    /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
> +    ns->id_ns_zoned->mar = 0xffffffff;
> +    ns->id_ns_zoned->mor = 0xffffffff;
> +    ns->id_ns_zoned->zoc = 0;
> +    ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
> +
> +    ns->id_ns_zoned->lbafe[lba_index].zsze = cpu_to_le64(n->params.zone_size);
> +    ns->id_ns_zoned->lbafe[lba_index].zdes = 0;
> +
> +    if (n->params.fill_pattern == 0) {
> +        ns->id_ns.dlfeat = 0x01;
> +    } else if (n->params.fill_pattern == 0xff) {
> +        ns->id_ns.dlfeat = 0x02;
> +    }
> +
> +    return 0;
> +}
> +
> +static void nvme_zoned_clear(NvmeCtrl *n)
> +{
> +    int i;
> +
> +    for (i = 0; i < n->num_namespaces; i++) {
> +        NvmeNamespace *ns = &n->namespaces[i];
> +        g_free(ns->id_ns_zoned);
> +        g_free(ns->zone_array);
> +        g_free(ns->exp_open_zones);
> +        g_free(ns->imp_open_zones);
> +        g_free(ns->closed_zones);
> +        g_free(ns->full_zones);
> +    }
> +}
> +
>  static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>  {
>      NvmeParams *params = &n->params;
> @@ -1674,18 +2549,13 @@ static void nvme_init_state(NvmeCtrl *n)
>  
>  static void nvme_init_blk(NvmeCtrl *n, Error **errp)
>  {
> +    int64_t bs_size;
> +
>      if (!blkconf_blocksizes(&n->conf, errp)) {
>          return;
>      }
>      blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                    false, errp);
> -}
> -
> -static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> -{
> -    int64_t bs_size;
> -    NvmeIdNs *id_ns = &ns->id_ns;
> -    int lba_index;
>  
>      bs_size = blk_getlength(n->conf.blk);
>      if (bs_size < 0) {
> @@ -1694,6 +2564,12 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>      }
>  
>      n->ns_size = bs_size;
> +}
> +
> +static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +{
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +    int lba_index;
>  
>      ns->csi = NVME_CSI_NVM;
>      qemu_uuid_generate(&ns->uuid); /* TODO make UUIDs persistent */
> @@ -1701,8 +2577,18 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>      id_ns->lbaf[lba_index].ds = nvme_ilog2(n->conf.logical_block_size);
>      id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
>  
> +    if (n->params.zoned) {
> +        ns->csi = NVME_CSI_ZONED;
> +        id_ns->ncap = cpu_to_le64(n->params.zone_capacity * n->num_zones);

Ah yes, right. It is in MiB's when the user specifies it, but now its in
LBAs so this is correct. Please, in general, do not overwrite the device
parameters, it's super confusing ;)

> +        if (nvme_zoned_init_ns(n, ns, lba_index, errp) != 0) {
> +            return;
> +        }
> +    } else {
> +        ns->csi = NVME_CSI_NVM;
> +        id_ns->ncap = id_ns->nsze;
> +    }
> +
>      /* no thin provisioning */
> -    id_ns->ncap = id_ns->nsze;
>      id_ns->nuse = id_ns->ncap;
>  }
>  
> @@ -1817,7 +2703,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->ieee[2] = 0xb3;
>      id->oacs = cpu_to_le16(0);
>      id->frmw = 7 << 1;
> -    id->lpa = 1 << 0;
> +    id->lpa = 1 << 1;

This probably belongs in the CSE patch.

>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> @@ -1834,8 +2720,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
>      /*
> -     * The driver now always supports NS Types, but all commands that
> -     * support CSI field will only handle NVM Command Set.
> +     * The driver now always supports NS Types, even when "zoned" property
> +     * is set to zero. If this is the case, all commands that support CSI field
> +     * only handle NVM Command Set.
>       */
>      NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> @@ -1871,6 +2758,13 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> +    if (n->params.zoned) {
> +        nvme_zoned_init_ctrl(n, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);

I don't think the propagate is needed if you are not doing anything with
the error, you can use errp directly. I think.

> +            return;
> +        }
> +    }
>      nvme_init_ctrl(n, pci_dev);
>  
>      ns = n->namespaces;
> @@ -1889,6 +2783,9 @@ static void nvme_exit(PCIDevice *pci_dev)
>      NvmeCtrl *n = NVME(pci_dev);
>  
>      nvme_clear_ctrl(n);
> +    if (n->params.zoned) {
> +        nvme_zoned_clear(n);
> +    }
>      g_free(n->namespaces);
>      g_free(n->cq);
>      g_free(n->sq);
> @@ -1912,6 +2809,12 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
>      DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
>      DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
> +    DEFINE_PROP_BOOL("zoned", NvmeCtrl, params.zoned, false),
> +    DEFINE_PROP_UINT64("zone_size", NvmeCtrl, params.zone_size, 512),
> +    DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity, 512),

There is a wierd mismatch between the parameter default and the
NVME_DEFAULT_ZONE_SIZE - should probably use the macro here.

In nvme_zoned_init_ctrl a default is set if the user specifically
specifies 0. I think that is very surprising behavior and surprised me
when I configured it. If the user specifies zero, then error out - the
property already sets a default. This goes for zone_capacity as well.

> +    DEFINE_PROP_UINT32("zone_append_max_size", NvmeCtrl, params.zamds_bs, 0),

Same, use macro here, but I actually think that 0 is a reasonable
default.

> +    DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
> +    DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.21.0
> 
> 

