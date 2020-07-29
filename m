Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1439DC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24382075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuQK0TSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24382075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0hqL-0002jD-5v
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0hpO-0002BL-SY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:52:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0hpN-00057j-1i
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596012764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFUoUlidg5NnCEBibKjimml/gUAz/wnuAYTesGoJFos=;
 b=FuQK0TSHAjmuXc/8o6mw5YbF7ASTeUJmS/IHJsbHJhIQcsfp5Y4Md6p1p9hsRgq36cpkwM
 YRJhslLi9BV9uArpQLFIQnvGjt43t01w2dhXgPjyMyNXF4GnDAWsDOD0xj8KP+g8djhfHU
 qP4/ewfaB1GaeSjYuHsRZx/DTKHuq/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-jzTQCTlHN52RCAF1HaLngA-1; Wed, 29 Jul 2020 04:52:40 -0400
X-MC-Unique: jzTQCTlHN52RCAF1HaLngA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C491005504;
 Wed, 29 Jul 2020 08:52:39 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 787C55DA75;
 Wed, 29 Jul 2020 08:52:36 +0000 (UTC)
Message-ID: <9a14f25fdcf8209d89643943f567c6184b1abf5e.camel@redhat.com>
Subject: Re: [PATCH v3 03/18] hw/block/nvme: additional tracing
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 29 Jul 2020 11:52:35 +0300
In-Reply-To: <20200706061303.246057-4-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-4-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.74; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:09:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add various additional tracing and streamline nvme_identify_ns and
> nvme_identify_nslist (they do not need to repeat the command, it is
> already in the trace name).
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 33 +++++++++++++++++++++++++++++++++
>  hw/block/trace-events | 13 +++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 766cd5b33bb1..09ef54d771c4 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -69,6 +69,20 @@
>  
>  static void nvme_process_sq(void *opaque);
>  
> +static uint16_t nvme_cid(NvmeRequest *req)
> +{
> +    if (!req) {
> +        return 0xffff;
> +    }
> +
> +    return le16_to_cpu(req->cqe.cid);
> +}
> +
> +static uint16_t nvme_sqid(NvmeRequest *req)
> +{
> +    return le16_to_cpu(req->sq->sqid);
> +}
> +
>  static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  {
>      hwaddr low = n->ctrl_mem.addr;
> @@ -331,6 +345,8 @@ static void nvme_post_cqes(void *opaque)
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> +    trace_pci_nvme_enqueue_req_completion(nvme_cid(req), cq->cqid,
> +                                          req->status);
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> @@ -343,6 +359,8 @@ static void nvme_rw_cb(void *opaque, int ret)
>      NvmeCtrl *n = sq->ctrl;
>      NvmeCQueue *cq = n->cq[sq->cqid];
>  
> +    trace_pci_nvme_rw_cb(nvme_cid(req));
> +
>      if (!ret) {
>          block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_SUCCESS;
> @@ -378,6 +396,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      uint64_t offset = slba << data_shift;
>      uint32_t count = nlb << data_shift;
>  
> +    trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
> +
>      if (unlikely(slba + nlb > ns->id_ns.nsze)) {
>          trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
>          return NVME_LBA_RANGE | NVME_DNR;
> @@ -445,6 +465,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(cmd->nsid);
>  
> +    trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req), cmd->opcode);
> +
>      if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
>          trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
>          return NVME_INVALID_NSID | NVME_DNR;
> @@ -876,6 +898,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> +    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), cmd->opcode);
> +
>      switch (cmd->opcode) {
>      case NVME_ADM_CMD_DELETE_SQ:
>          return nvme_del_sq(n, cmd);
> @@ -1204,6 +1228,8 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      uint8_t *ptr = (uint8_t *)&n->bar;
>      uint64_t val = 0;
>  
> +    trace_pci_nvme_mmio_read(addr);
> +
>      if (unlikely(addr & (sizeof(uint32_t) - 1))) {
>          NVME_GUEST_ERR(pci_nvme_ub_mmiord_misaligned32,
>                         "MMIO read not 32-bit aligned,"
> @@ -1273,6 +1299,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              return;
>          }
>  
> +        trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
> +
>          start_sqs = nvme_cq_full(cq) ? 1 : 0;
>          cq->head = new_head;
>          if (start_sqs) {
> @@ -1311,6 +1339,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              return;
>          }
>  
> +        trace_pci_nvme_mmio_doorbell_sq(sq->sqid, new_tail);
> +
>          sq->tail = new_tail;
>          timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>      }
> @@ -1320,6 +1350,9 @@ static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
>      unsigned size)
>  {
>      NvmeCtrl *n = (NvmeCtrl *)opaque;
> +
> +    trace_pci_nvme_mmio_write(addr, data);
> +
>      if (addr < sizeof(n->bar)) {
>          nvme_write_bar(n, addr, data, size);
>      } else if (addr >= 0x1000) {
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 958fcc5508d1..c40c0d2e4b28 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -33,19 +33,28 @@ pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  pci_nvme_irq_pin(void) "pulsing IRQ pin"
>  pci_nvme_irq_masked(void) "IRQ is masked"
>  pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> +pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> +pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
>  pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> +pci_nvme_rw_cb(uint16_t cid) "cid %"PRIu16""
> +pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
>  pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
>  pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
>  pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
>  pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
>  pci_nvme_identify_ctrl(void) "identify controller"
> -pci_nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
> -pci_nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
> +pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  pci_nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  pci_nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> +pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
> +pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
> +pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
> +pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
> +pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
>  pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


