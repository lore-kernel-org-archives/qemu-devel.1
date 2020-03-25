Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F15C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6104120722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ekh0rOW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6104120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3cH-00060u-Hy
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3U5-0003HL-TB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3U3-0002uz-BW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3U2-0002tM-MS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUIRTYHp3NtWlAF1IdXgU8BvL1fDXok238wD+IFcoTA=;
 b=Ekh0rOW2AGhiEgpXUsqPidHoDNkafP99xy9547+GkTa9ylhPGiW5vD00mzhMCmSieLPBiA
 5nGGw0Lj2gjUXxOMjqy5NbrVmNRm0I+h1XUPZ314sQ/M8M+1kVaMqhpeotD75nmBnmegS6
 5JuoKxy6la1ijmgB624oFZKX8uAF+Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-yQ41QqjfNtS0y-126gy1Ww-1; Wed, 25 Mar 2020 06:41:57 -0400
X-MC-Unique: yQ41QqjfNtS0y-126gy1Ww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59D59107ACC4;
 Wed, 25 Mar 2020 10:41:56 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBBD10027A4;
 Wed, 25 Mar 2020 10:41:54 +0000 (UTC)
Message-ID: <e589c8897067d387cae4b03dece27c60fa33041c.camel@redhat.com>
Subject: Re: [PATCH v6 14/42] nvme: add missing mandatory features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:41:53 +0200
In-Reply-To: <20200316142928.153431-15-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-15-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
> Add support for returning a resonable response to Get/Set Features of
> mandatory features.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c       | 60 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/block/trace-events |  2 ++
>  include/block/nvme.h  |  6 ++++-
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ff8975cd6667..eb9c722df968 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1025,7 +1025,15 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>      uint32_t result;
>  
> +    trace_nvme_dev_getfeat(nvme_cid(req), dw10);
> +
>      switch (dw10) {
> +    case NVME_ARBITRATION:
> +        result = cpu_to_le32(n->features.arbitration);
> +        break;
> +    case NVME_POWER_MANAGEMENT:
> +        result = cpu_to_le32(n->features.power_mgmt);
> +        break;
>      case NVME_TEMPERATURE_THRESHOLD:
>          result = 0;
>  
> @@ -1046,9 +1054,12 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              break;
>          }
>  
> +        break;
> +    case NVME_ERROR_RECOVERY:
> +        result = cpu_to_le32(n->features.err_rec);
>          break;
>      case NVME_VOLATILE_WRITE_CACHE:
> -        result = blk_enable_write_cache(n->conf.blk);
> +        result = cpu_to_le32(blk_enable_write_cache(n->conf.blk));
>          trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> @@ -1058,6 +1069,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
> +    case NVME_INTERRUPT_COALESCING:
> +        result = cpu_to_le32(n->features.int_coalescing);
> +        break;
> +    case NVME_INTERRUPT_VECTOR_CONF:
> +        if ((dw11 & 0xffff) > n->params.max_ioqpairs + 1) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
I still think that this should be >= since the interrupt vector is not zero based.
So if we have for example 3 IO queues, then we have 4 queues in total
which translates to irq numbers 0..3.

BTW the user of the device doesn't have to have 1:1 mapping between qid and msi interrupt index,
in fact when MSI is not used, all the queues will map to the same vector, which will be interrupt 0
from point of view of the device IMHO.
So it kind of makes sense IMHO to have num_irqs or something, even if it technically equals to number of queues.


> +
> +        result = cpu_to_le32(n->features.int_vector_config[dw11 & 0xffff]);
> +        break;
> +    case NVME_WRITE_ATOMICITY:
> +        result = cpu_to_le32(n->features.write_atomicity);
> +        break;
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          result = cpu_to_le32(n->features.async_config);
>          break;
> @@ -1093,6 +1117,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>  
> +    trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
> +
>      switch (dw10) {
>      case NVME_TEMPERATURE_THRESHOLD:
>          if (NVME_TEMP_TMPSEL(dw11)) {
> @@ -1120,6 +1146,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>          break;
>      case NVME_VOLATILE_WRITE_CACHE:
> +        if (blk_enable_write_cache(n->conf.blk)) {
> +            blk_flush(n->conf.blk);
> +        }

(not your fault) but the blk_enable_write_cache function name is highly misleading,
since it doesn't enable anything but just gets the flag if the write cache is enabled.
It really should be called blk_get_enable_write_cache.

> +
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> @@ -1135,6 +1165,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          n->features.async_config = dw11;
>          break;
> +    case NVME_ARBITRATION:
> +    case NVME_POWER_MANAGEMENT:
> +    case NVME_ERROR_RECOVERY:
> +    case NVME_INTERRUPT_COALESCING:
> +    case NVME_INTERRUPT_VECTOR_CONF:
> +    case NVME_WRITE_ATOMICITY:
> +        return NVME_FEAT_NOT_CHANGABLE | NVME_DNR;
>      default:
>          trace_nvme_dev_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1716,6 +1753,25 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->temperature = NVME_TEMPERATURE;
>      n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>      n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +
> +    /*
> +     * There is no limit on the number of commands that the controller may
> +     * launch at one time from a particular Submission Queue.
> +     */
> +    n->features.arbitration = NVME_ARB_AB_NOLIMIT;
> +
> +    n->features.int_vector_config = g_malloc0_n(n->params.max_ioqpairs + 1,
> +        sizeof(*n->features.int_vector_config));
> +
> +    for (int i = 0; i < n->params.max_ioqpairs + 1; i++) {
> +        n->features.int_vector_config[i] = i;
> +
> +        /* interrupt coalescing is not supported for the admin queue */
> +        if (i == 0) {
> +            n->features.int_vector_config[i] |= NVME_INTVC_NOCOALESCING;
> +        }
> +    }
> +
>      n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
>  }
>  
> @@ -1804,6 +1860,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
> +
Unrelated whitespace change
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> @@ -1879,6 +1936,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->cq);
>      g_free(n->sq);
>      g_free(n->aer_reqs);
> +    g_free(n->features.int_vector_config);
>  
>      if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 3952c36774cf..4cf39961989d 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -41,6 +41,8 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
>  nvme_dev_identify_ctrl(void) "identify controller"
>  nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
>  nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx32""
> +nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16" fid 0x%"PRIx32" val 0x%"PRIx32""
>  nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  nvme_dev_getfeat_numq(int result) "get feature number of queues, result=%d"
>  nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index f2a8b07c0f2f..ecc02fbe8bb8 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -490,7 +490,8 @@ enum NvmeStatusCodes {
>      NVME_FW_REQ_RESET           = 0x010b,
>      NVME_INVALID_QUEUE_DEL      = 0x010c,
>      NVME_FID_NOT_SAVEABLE       = 0x010d,
> -    NVME_FID_NOT_NSID_SPEC      = 0x010f,
> +    NVME_FEAT_NOT_CHANGABLE     = 0x010e,
> +    NVME_FEAT_NOT_NS_SPEC       = 0x010f,
>      NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
>      NVME_CONFLICTING_ATTRS      = 0x0180,
>      NVME_INVALID_PROT_INFO      = 0x0181,
> @@ -706,6 +707,7 @@ typedef struct NvmeFeatureVal {
>  } NvmeFeatureVal;
>  
>  #define NVME_ARB_AB(arb)    (arb & 0x7)
> +#define NVME_ARB_AB_NOLIMIT 0x7
>  #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
>  #define NVME_ARB_MPW(arb)   ((arb >> 16) & 0xff)
>  #define NVME_ARB_HPW(arb)   ((arb >> 24) & 0xff)
> @@ -713,6 +715,8 @@ typedef struct NvmeFeatureVal {
>  #define NVME_INTC_THR(intc)     (intc & 0xff)
>  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
>  
> +#define NVME_INTVC_NOCOALESCING (0x1 << 16)
> +
>  #define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
>  #define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
>  #define NVME_TEMP_TMPTH(temp)  ((temp >>  0) & 0xffff)


Best regards,
	Maxim Levitsky




