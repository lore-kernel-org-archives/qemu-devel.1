Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA071C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20E920772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+S58/mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20E920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3VG-0004iD-PR
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Rs-0007Py-0q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Rq-0001VR-AG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:39:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Rq-0001V3-6V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p80QZ0mc4EqJz+/RfKWx+dEtX90r7XAmnZtEUYB3j6k=;
 b=W+S58/mRbbc1jlJjaXn3xDCYOj7vbxtpy1EtHCdz3QXvmvEVHPNMKNoraBUWuRPNokqLKq
 Li4tagcHA2KfRwQx7k0KtvJyKeA5c3e+DupIZe7cpPG6Pb9n1StNNONPaNFvhK4F0VhcTq
 ReSIPBW0LIFMnlscVNwCsiCmhGjLtzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-0NFnFYW5MvOuY2XlNzfkxQ-1; Wed, 25 Mar 2020 06:39:42 -0400
X-MC-Unique: 0NFnFYW5MvOuY2XlNzfkxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95924DBA7;
 Wed, 25 Mar 2020 10:39:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79D29A0A75;
 Wed, 25 Mar 2020 10:39:38 +0000 (UTC)
Message-ID: <aae04efeb49752c420e5ed2ba1ce3312909fbb0e.camel@redhat.com>
Subject: Re: [PATCH v6 09/42] nvme: add max_ioqpairs device parameter
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:39:37 +0200
In-Reply-To: <20200316142928.153431-10-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-10-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The num_queues device paramater has a slightly confusing meaning because
> it accounts for the admin queue pair which is not really optional.
> Secondly, it is really a maximum value of queues allowed.
> 
> Add a new max_ioqpairs parameter that only accounts for I/O queue pairs,
> but keep num_queues for compatibility.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 45 ++++++++++++++++++++++++++-------------------
>  hw/block/nvme.h |  4 +++-
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7cf7cf55143e..7dfd8a1a392d 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -19,7 +19,7 @@
>   *      -drive file=<file>,if=none,id=<drive_id>
>   *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
>   *              cmb_size_mb=<cmb_size_mb[optional]>, \
> - *              num_queues=<N[optional]>
> + *              max_ioqpairs=<N[optional]>
>   *
>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> @@ -27,6 +27,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/error-report.h"
>  #include "hw/block/block.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci.h"
> @@ -72,12 +73,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
>  {
> -    return sqid < n->params.num_queues && n->sq[sqid] != NULL ? 0 : -1;
> +    return sqid < n->params.max_ioqpairs + 1 && n->sq[sqid] != NULL ? 0 : -1;
>  }
>  
>  static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
>  {
> -    return cqid < n->params.num_queues && n->cq[cqid] != NULL ? 0 : -1;
> +    return cqid < n->params.max_ioqpairs + 1 && n->cq[cqid] != NULL ? 0 : -1;
>  }
>  
>  static void nvme_inc_cq_tail(NvmeCQueue *cq)
> @@ -639,7 +640,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>          trace_nvme_dev_err_invalid_create_cq_addr(prp1);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> -    if (unlikely(vector > n->params.num_queues)) {
> +    if (unlikely(vector > n->params.max_ioqpairs + 1)) {
>          trace_nvme_dev_err_invalid_create_cq_vector(vector);
>          return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>      }
> @@ -803,8 +804,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> -        result = cpu_to_le32((n->params.num_queues - 2) |
> -                             ((n->params.num_queues - 2) << 16));
> +        result = cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                             ((n->params.max_ioqpairs - 1) << 16));
>          trace_nvme_dev_getfeat_numq(result);
>          break;
>      case NVME_TIMESTAMP:
> @@ -848,10 +849,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_NUMBER_OF_QUEUES:
>          trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
>                                      ((dw11 >> 16) & 0xFFFF) + 1,
> -                                    n->params.num_queues - 1,
> -                                    n->params.num_queues - 1);
> -        req->cqe.result = cpu_to_le32((n->params.num_queues - 2) |
> -                                      ((n->params.num_queues - 2) << 16));
> +                                    n->params.max_ioqpairs,
> +                                    n->params.max_ioqpairs);
> +        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                                      ((n->params.max_ioqpairs - 1) << 16));
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> @@ -924,12 +925,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>  
>      blk_drain(n->conf.blk);
>  
> -    for (i = 0; i < n->params.num_queues; i++) {
> +    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
>          if (n->sq[i] != NULL) {
>              nvme_free_sq(n->sq[i], n);
>          }
>      }
> -    for (i = 0; i < n->params.num_queues; i++) {
> +    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
>          if (n->cq[i] != NULL) {
>              nvme_free_cq(n->cq[i], n);
>          }
> @@ -1332,9 +1333,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      int64_t bs_size;
>      uint8_t *pci_conf;
>  
> -    if (!n->params.num_queues) {
> -        error_setg(errp, "num_queues can't be zero");
> -        return;
> +    if (n->params.num_queues) {
> +        warn_report("nvme: num_queues is deprecated; please use max_ioqpairs "
> +                    "instead");
> +
> +        n->params.max_ioqpairs = n->params.num_queues - 1;
> +    }
> +
> +    if (!n->params.max_ioqpairs) {
> +        error_setg(errp, "max_ioqpairs can't be less than 1");
>      }
This is not even a nitpick, but just and idea.

It might be worth it to allow max_ioqpairs=0 to simulate a 'broken'
nvme controller. I know that kernel has special handling for such controllers,
which include only creation of the control character device (/dev/nvme*) through
which the user can submit commands to try and 'fix' the controller (by re-uploading firmware
maybe or something like that).


>  
>      if (!n->conf.blk) {
> @@ -1365,19 +1372,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>  
>      n->num_namespaces = 1;
> -    n->reg_size = pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4);
> +    n->reg_size = pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);

I hate to say it, but it looks like this thing (which I mentioned to you in V5)
was pre-existing bug, which is indeed fixed now.
In theory such fixes should go to separate patches, but in this case, I guess it would
be too much to ask for it.
Maybe mention this in the commit message instead, so that this fix doesn't stay hidden like that?


>      n->ns_size = bs_size / (uint64_t)n->num_namespaces;
>  
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
> -    n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
> -    n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
> +    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
> +    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
>  
>      memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                            "nvme", n->reg_size);
>      pci_register_bar(pci_dev, 0,
>          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>          &n->iomem);
> -    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
> +    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
>  
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 9957c4a200e2..98f5b9479244 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -6,11 +6,13 @@
>  #define DEFINE_NVME_PROPERTIES(_state, _props) \
>      DEFINE_PROP_STRING("serial", _state, _props.serial), \
>      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> -    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
> +    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64)
>  
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues;
> +    uint32_t max_ioqpairs;
>      uint32_t cmb_size_mb;
>  } NvmeParams;
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky







