Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617DCC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4AC206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/l7tb3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4AC206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Xi-0008Re-8G
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3UM-0003XX-1C
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3UK-00034c-KP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3UK-00034S-HU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmh9lLPsqg6s78lJPFSmRgaAWv7qbpaW2xczSPnTBco=;
 b=U/l7tb3rNEsbpzWOras3rKnjtcwuV7Ji7DzZiR31cgsBs/RAeId2gVOU7hQfwrBBU9dsjz
 dDxpf/18OFRhSRnZhKhEb4QRsBg+0ycxE0mwBeC1Y0wgTph0Lx/5m0g3L9OYOT1I1jBl2x
 RNmM/u4fc0UlMpPOJbGwSmWmJcAYdIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-px4iA0_TOjiBvGxHd4ZbpQ-1; Wed, 25 Mar 2020 06:42:16 -0400
X-MC-Unique: px4iA0_TOjiBvGxHd4ZbpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0C318FF660;
 Wed, 25 Mar 2020 10:42:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55E075C241;
 Wed, 25 Mar 2020 10:42:13 +0000 (UTC)
Message-ID: <ff6f0896cb7d5a91d495cb5bf5bdd8544a50be54.camel@redhat.com>
Subject: Re: [PATCH v6 15/42] nvme: additional tracing
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:42:12 +0200
In-Reply-To: <20200316142928.153431-16-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-16-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add additional trace calls for nvme_enqueue_req_completion, mmio and
> doorbell writes.
> 
> Also, streamline nvme_identify_ns and nvme_identify_ns_list. They do not
> need to repeat the command, it is already in the trace name.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c       | 10 ++++++++++
>  hw/block/trace-events |  9 +++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index eb9c722df968..85c7c86b35f0 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -320,6 +320,8 @@ static void nvme_post_cqes(void *opaque)
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> +    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
> +                                          req->status);
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> @@ -1527,6 +1529,8 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      uint8_t *ptr = (uint8_t *)&n->bar;
>      uint64_t val = 0;
>  
> +    trace_nvme_dev_mmio_read(addr);
> +
>      if (unlikely(addr & (sizeof(uint32_t) - 1))) {
>          NVME_GUEST_ERR(nvme_dev_ub_mmiord_misaligned32,
>                         "MMIO read not 32-bit aligned,"
> @@ -1601,6 +1605,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              return;
>          }
>  
> +        trace_nvme_dev_mmio_doorbell_cq(cq->cqid, new_head);
> +
>          start_sqs = nvme_cq_full(cq) ? 1 : 0;
>          cq->head = new_head;
>          if (start_sqs) {
> @@ -1653,6 +1659,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              return;
>          }
>  
> +        trace_nvme_dev_mmio_doorbell_sq(sq->sqid, new_tail);
> +
>          sq->tail = new_tail;
>          timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>      }
> @@ -1661,6 +1669,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>  static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
>      unsigned size)
>  {
> +    trace_nvme_dev_mmio_write(addr, data);
> +
>      NvmeCtrl *n = (NvmeCtrl *)opaque;
>      if (addr < sizeof(n->bar)) {
>          nvme_write_bar(n, addr, data, size);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 4cf39961989d..dde1d22bc39a 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -39,8 +39,8 @@ nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
>  nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
>  nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
>  nvme_dev_identify_ctrl(void) "identify controller"
> -nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
> -nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
> +nvme_dev_identify_nslist(uint32_t ns) "nsid %"PRIu32""
>  nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx32""
>  nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16" fid 0x%"PRIx32" val 0x%"PRIx32""
>  nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
> @@ -54,10 +54,13 @@ nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
>  nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
>  nvme_dev_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
>  nvme_dev_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_dev_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
>  nvme_dev_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
>  nvme_dev_enqueue_event_noqueue(int queued) "queued %d"
>  nvme_dev_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
>  nvme_dev_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
> +nvme_dev_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
> +nvme_dev_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
>  nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> @@ -70,6 +73,8 @@ nvme_dev_mmio_start_success(void) "setting controller enable bit succeeded"
>  nvme_dev_mmio_stopped(void) "cleared controller enable bit"
>  nvme_dev_mmio_shutdown_set(void) "shutdown bit set"
>  nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
> +nvme_dev_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
> +nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
>  
>  # nvme traces for error conditions
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
Looks good.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky




