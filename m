Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7037DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EACA206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFcwhkCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EACA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3iG-0004qx-BZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3XY-0000FO-O2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3XW-0004wI-VY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:45:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3XW-0004w7-S1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMntJ5gtsfcj6upOK3X9Rn6AEU7l0562symB1vlfgDk=;
 b=CFcwhkCuvpd8PSWlrWJp3qc077bE+2BFhtgS8pbieppHhES79y8aEDJ0VKNzhvOIym/k2L
 DXZQTr0wUzv2T1Qsgqqz37WKl78/ytlHLLUir/I+GBwmHl9uQrbPDV9KdijY6RdUsnB4u/
 1A8cPNWjZPrB+UqGyhXRd/wzQhBEYWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-8BX8iqYEOnqa5hswtqAaDQ-1; Wed, 25 Mar 2020 06:45:34 -0400
X-MC-Unique: 8BX8iqYEOnqa5hswtqAaDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4159FA1366;
 Wed, 25 Mar 2020 10:45:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 222C05D9C5;
 Wed, 25 Mar 2020 10:45:30 +0000 (UTC)
Message-ID: <165e03c021e92f475dc1037b9421d3588d07799b.camel@redhat.com>
Subject: Re: [PATCH v6 23/42] nvme: add mapping helpers
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:45:30 +0200
In-Reply-To: <20200316142928.153431-24-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-24-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
> Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
> use them in nvme_map_prp.
> 
> This fixes a bug where in the case of a CMB transfer, the device would
> map to the buffer with a wrong length.
> 
> Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 97 +++++++++++++++++++++++++++++++++++--------
>  hw/block/trace-events |  1 +
>  2 files changed, 81 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 08267e847671..187c816eb6ad 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -59,6 +59,11 @@
>  
>  static void nvme_process_sq(void *opaque);
>  
> +static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
> +{
> +    return &n->cmbuf[addr - n->ctrl_mem.addr];
> +}
> +
>  static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  {
>      hwaddr low = n->ctrl_mem.addr;
> @@ -70,7 +75,7 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
>      if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
> -        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> +        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
>          return;
>      }
>  
> @@ -153,29 +158,79 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
>      }
>  }
>  
> +static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> +                                  size_t len)
> +{
> +    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) {
> +        return NVME_DATA_TRAS_ERROR;
> +    }

I just noticed that
in theory (not that it really matters) but addr+len refers to the byte which is already 
not the part of the transfer.


> +
> +    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
Also intersting is we can add 0 sized iovec.


> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +                              hwaddr addr, size_t len)
> +{
> +    if (nvme_addr_is_cmb(n, addr)) {
> +        if (qsg && qsg->sg) {
> +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +        }
> +
> +        assert(iov);
> +
> +        if (!iov->iov) {
> +            qemu_iovec_init(iov, 1);
> +        }
> +
> +        return nvme_map_addr_cmb(n, iov, addr, len);
> +    }
> +
> +    if (iov && iov->iov) {
> +        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +    }
> +
> +    assert(qsg);
> +
> +    if (!qsg->sg) {
> +        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> +    }
> +
> +    qemu_sglist_add(qsg, addr, len);
> +
> +    return NVME_SUCCESS;
> +}
Looks very good.

> +
>  static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                               uint64_t prp2, uint32_t len, NvmeCtrl *n)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
> +    uint16_t status;
>  
>      if (unlikely(!prp1)) {
>          trace_nvme_dev_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
> -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> -        qsg->nsg = 0;
> +    }
> +
> +    if (nvme_addr_is_cmb(n, prp1)) {
>          qemu_iovec_init(iov, num_prps);
> -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
>      } else {
>          pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> -        qemu_sglist_add(qsg, prp1, trans_len);
>      }
> +
> +    status = nvme_map_addr(n, qsg, iov, prp1, trans_len);
> +    if (status) {
> +        goto unmap;
> +    }
> +
>      len -= trans_len;
>      if (len) {
>          if (unlikely(!prp2)) {
>              trace_nvme_dev_err_invalid_prp2_missing();
> +            status = NVME_INVALID_FIELD | NVME_DNR;
>              goto unmap;
>          }
>          if (len > n->page_size) {
> @@ -192,6 +247,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
>                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                          trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
> +                        status = NVME_INVALID_FIELD | NVME_DNR;
>                          goto unmap;
>                      }
>  
> @@ -205,14 +261,14 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>  
>                  if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                      trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
> +                    status = NVME_INVALID_FIELD | NVME_DNR;
>                      goto unmap;
>                  }
>  
>                  trans_len = MIN(len, n->page_size);
> -                if (qsg->nsg){
> -                    qemu_sglist_add(qsg, prp_ent, trans_len);
> -                } else {
> -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
> +                status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
> +                if (status) {
> +                    goto unmap;
>                  }
>                  len -= trans_len;
>                  i++;
> @@ -220,20 +276,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>          } else {
>              if (unlikely(prp2 & (n->page_size - 1))) {
>                  trace_nvme_dev_err_invalid_prp2_align(prp2);
> +                status = NVME_INVALID_FIELD | NVME_DNR;
>                  goto unmap;
>              }
> -            if (qsg->nsg) {
> -                qemu_sglist_add(qsg, prp2, len);
> -            } else {
> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> +            status = nvme_map_addr(n, qsg, iov, prp2, len);
> +            if (status) {
> +                goto unmap;
>              }
>          }
>      }
>      return NVME_SUCCESS;
>  
> - unmap:
> -    qemu_sglist_destroy(qsg);
> -    return NVME_INVALID_FIELD | NVME_DNR;
> +unmap:
> +    if (iov && iov->iov) {
> +        qemu_iovec_destroy(iov);
> +    }
> +
> +    if (qsg && qsg->sg) {
> +        qemu_sglist_destroy(qsg);
> +    }
> +
> +    return status;
>  }
>  
>  static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 4cde0844ef64..adf11313f956 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -33,6 +33,7 @@ nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  nvme_dev_irq_pin(void) "pulsing IRQ pin"
>  nvme_dev_irq_masked(void) "IRQ is masked"
>  nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> +nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1
> 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
>  nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
>  nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16",
> qflags=%"PRIu16""
>  nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16",
> qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"


Looks very good overall,

Best regards,
	Maxim Levitsky





