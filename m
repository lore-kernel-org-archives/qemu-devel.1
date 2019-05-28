Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AEDC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 06:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FDF206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 06:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FDF206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57835 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVVSc-0006GM-Vo
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 02:19:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hVVRf-0005uB-DY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hVVRd-0000Iw-Ts
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:18:47 -0400
Received: from charlie.dont.surf ([128.199.63.193]:44018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hVVRZ-0000GL-FE; Tue, 28 May 2019 02:18:42 -0400
Received: from apples.localdomain (soho-cph.cust-cnex.dsd101.net
	[194.62.216.132])
	by charlie.dont.surf (Postfix) with ESMTPSA id C06CBBFD16;
	Tue, 28 May 2019 06:18:37 +0000 (UTC)
Date: Tue, 28 May 2019 08:18:36 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Kenneth Heitke <kenneth.heitke@intel.com>
Message-ID: <20190528061836.GB32236@apples.localdomain>
Mail-Followup-To: Kenneth Heitke <kenneth.heitke@intel.com>,
	kwolf@redhat.com, mreitz@redhat.com, keith.busch@intel.com,
	qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org
References: <20190520174030.1647-1-kenneth.heitke@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520174030.1647-1-kenneth.heitke@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [PATCH v2] nvme: add Get/Set Feature Timestamp
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com, keith.busch@intel.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 11:40:30AM -0600, Kenneth Heitke wrote:
> Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
> ---
>  hw/block/nvme.c       | 106 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   3 ++
>  hw/block/trace-events |   2 +
>  include/block/nvme.h  |   2 +
>  4 files changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7caf92532a..67372e0cd1 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -219,6 +219,30 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>      return NVME_INVALID_FIELD | NVME_DNR;
>  }
>  
> +static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> +                                   uint64_t prp1, uint64_t prp2)
> +{
> +    QEMUSGList qsg;
> +    QEMUIOVector iov;
> +    uint16_t status = NVME_SUCCESS;
> +
> +    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +    if (qsg.nsg > 0) {
> +        if (dma_buf_write(ptr, len, &qsg)) {
> +            status = NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        qemu_sglist_destroy(&qsg);
> +    } else {
> +        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
> +            status = NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        qemu_iovec_destroy(&iov);
> +    }
> +    return status;
> +}
> +
>  static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      uint64_t prp1, uint64_t prp2)
>  {
> @@ -678,7 +702,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      return ret;
>  }
>  
> -
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
> @@ -696,6 +719,57 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      }
>  }
>  
> +static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
> +{
> +    trace_nvme_setfeat_timestamp(ts);
> +
> +    n->host_timestamp = le64_to_cpu(ts);
> +    n->timestamp_set_qemu_clock_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +}
> +
> +static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
> +{
> +    uint64_t current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    uint64_t elapsed_time = current_time - n->timestamp_set_qemu_clock_ms;
> +
> +    union nvme_timestamp {
> +        struct {
> +            uint64_t timestamp:48;
> +            uint64_t sync:1;
> +            uint64_t origin:3;
> +            uint64_t rsvd1:12;
> +        };
> +        uint64_t all;
> +    };
> +
> +    union nvme_timestamp ts;
> +    ts.all = 0;
> +
> +    /*
> +     * If the sum of the Timestamp value set by the host and the elapsed
> +     * time exceeds 2^48, the value returned should be reduced modulo 2^48.
> +     */
> +    ts.timestamp = (n->host_timestamp + elapsed_time) & 0xffffffffffff;
> +
> +    /* If the host timestamp is non-zero, set the timestamp origin */
> +    ts.origin = n->host_timestamp ? 0x01 : 0x00;
> +
> +    trace_nvme_getfeat_timestamp(ts.all);
> +
> +    return cpu_to_le64(ts.all);
> +}
> +
> +static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +
> +    uint64_t timestamp = nvme_get_timestamp(n);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
> +                                 sizeof(timestamp), prp1, prp2);
> +}
> +
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> @@ -710,6 +784,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
>          trace_nvme_getfeat_numq(result);
>          break;
> +    case NVME_TIMESTAMP:
> +        return nvme_get_feature_timestamp(n, cmd);
> +        break;
>      default:
>          trace_nvme_err_invalid_getfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -719,6 +796,24 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +{
> +    uint16_t ret;
> +    uint64_t timestamp;
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +
> +    ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
> +                                sizeof(timestamp), prp1, prp2);
> +    if (ret != NVME_SUCCESS) {
> +        return ret;
> +    }
> +
> +    nvme_set_timestamp(n, timestamp);
> +
> +    return NVME_SUCCESS;
> +}
> +
>  static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> @@ -735,6 +830,11 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          req->cqe.result =
>              cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
>          break;
> +
> +    case NVME_TIMESTAMP:
> +        return nvme_set_feature_timestamp(n, cmd);
> +        break;
> +
>      default:
>          trace_nvme_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -907,6 +1007,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>      nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
>          NVME_AQA_ASQS(n->bar.aqa) + 1);
>  
> +    nvme_set_timestamp(n, 0ULL);
> +
>      return 0;
>  }
>  
> @@ -1270,7 +1372,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> -    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS);
> +    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 56c9d4b4b1..d7277e72b7 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -69,6 +69,7 @@ typedef struct NvmeCtrl {
>      uint16_t    max_prp_ents;
>      uint16_t    cqe_size;
>      uint16_t    sqe_size;
> +    uint16_t    oncs;

Looks like this unused member snuck its way into the patch. But I see no
harm in it being there.

>      uint32_t    reg_size;
>      uint32_t    num_namespaces;
>      uint32_t    num_queues;
> @@ -79,6 +80,8 @@ typedef struct NvmeCtrl {
>      uint32_t    cmbloc;
>      uint8_t     *cmbuf;
>      uint64_t    irq_status;
> +    uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> +    uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
>  
>      char            *serial;
>      NvmeNamespace   *namespaces;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index b92039a573..97a17838ed 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -46,6 +46,8 @@ nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
>  nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> +nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
> +nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
>  nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 849a6f3fa3..3ec8efcc43 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -581,6 +581,7 @@ enum NvmeIdCtrlOncs {
>      NVME_ONCS_WRITE_ZEROS   = 1 << 3,
>      NVME_ONCS_FEATURES      = 1 << 4,
>      NVME_ONCS_RESRVATIONS   = 1 << 5,
> +    NVME_ONCS_TIMESTAMP     = 1 << 6,
>  };
>  
>  #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
> @@ -622,6 +623,7 @@ enum NvmeFeatureIds {
>      NVME_INTERRUPT_VECTOR_CONF      = 0x9,
>      NVME_WRITE_ATOMICITY            = 0xa,
>      NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
> +    NVME_TIMESTAMP                  = 0xe,
>      NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
>  };
>  
> -- 
> 2.17.1
> 

Reviewed-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>

