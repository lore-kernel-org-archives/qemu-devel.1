Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B719FC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741D42067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cua0qWLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741D42067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXmn-0004gY-Cb
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXjC-0000HH-Ox
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXj6-0004Y6-Sq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:10 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iUXj6-0004Xd-HT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:05:04 -0500
Received: by mail-io1-xd42.google.com with SMTP id s3so19059886ioe.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XavaeodK6IClI7AtRaq1QaMjZq6DSCYcLARqHgoB6wg=;
 b=cua0qWLVkv6JOSvgRIf3oTodCQZZt6Jdzn+oK7rPBfZwcrpljsBfZjUr4VKJeegzPZ
 Ok4Bvh+fqp0sxTgNqmwJRj1/dBAjHJ5WKPtMXeoSg+/M6UJSYaUop4mQrVg+8UA7NEAr
 1F/YXoA+A3XIrKUgh6OFTxBHxYSTF5E3/nFvBQoLH17GF+h5P7l7+9x8DMzDXXdqL8Gb
 A8AI4Wjg7tNcDZ5+0Tr9oO6EWOrFY9S2oss3+ww6O+Zhu5J7bsm6Y4L8vRY44iienxrp
 quP7zs9npB2ilGve5XDFk18Ex29LmfXlZgjK7WYBnW1F7w5K3G6exgPMl5ZH7eZeb4Qr
 qLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XavaeodK6IClI7AtRaq1QaMjZq6DSCYcLARqHgoB6wg=;
 b=HX+KJ9Q5riTmvCpFF5XWKyAVWMsDaGZ5uNPrWEibgIf5ZPDEwejC50B/78bADLNXT8
 StBMTfb8mS+9s0F6nfCsLbDWPLgI/J6n2ucZvhyEJDJomLdFmAMu4D++eterDX5gxl/h
 JaCDgurvvc+waRIUn/f2WTEiReU7k6C1ChTAG1ir48al0MytucUNAdQf56Zy0vGqB7go
 KPMZFOUQMQ1y5JQWvGy6p6+cfWZ9/1R2oU+gxjZ6DzLJemH4E1HY/4/afGHdyqc7vMoA
 2XLHSCRNFA+0NaM2IpMXKAqNgJ9jUMqj3kRDGVPbtUTDy/6Q//wakHLKQJQmo69MKaHq
 spvA==
X-Gm-Message-State: APjAAAXvFGeSXVCO/nAZa+OTUc91n9NVvTiyQwRm3aUEue7i6fRA0WEX
 oCObZ1//8T/n4Jn0BP6kIpxsXGEIauzElkvTYlasLA==
X-Google-Smtp-Source: APXvYqz0vqA3kyodVENKcIHZltK975jVxGg05r/ayF1l39yUMWnN0uhcAUcbpPKxPU6b7WFHzlFKuTJfSiN9mk1P56w=
X-Received: by 2002:a6b:b453:: with SMTP id d80mr29050565iof.307.1573571103729; 
 Tue, 12 Nov 2019 07:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-9-its@irrelevant.dk>
In-Reply-To: <20191015103900.313928-9-its@irrelevant.dk>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 12 Nov 2019 15:04:52 +0000
Message-ID: <CADSWDzsrzrnrLfowsdgZobtVgsga1oGXGpo0HyTUsKPVNzhx9w@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] nvme: add support for the get log page command
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,


On Tue, 15 Oct 2019 at 11:45, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Add support for the Get Log Page command and basic implementations
> of the mandatory Error Information, SMART/Health Information and
> Firmware Slot Information log pages.
>
> In violation of the specification, the SMART/Health Information log page
> does not persist information over the lifetime of the controller because
> the device has no place to store such persistent state.
>
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.10 ("Get Log Page command").
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c       | 150 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   9 ++-
>  hw/block/trace-events |   2 +
>  include/block/nvme.h  |   2 +-
>  4 files changed, 160 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 1fdb3b8655ed..4412a3bea3bc 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -44,6 +44,7 @@
>  #include "nvme.h"
>
>  #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
> +#define NVME_TEMPERATURE 0x143
>
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
> @@ -577,6 +578,137 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>
> +static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd,
> +    uint32_t buf_len, uint64_t off, NvmeRequest *req)
> +{
> +    uint32_t trans_len;
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +
> +    if (off > sizeof(*n->elpes) * (n->params.elpe + 1)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trans_len = MIN(sizeof(*n->elpes) * (n->params.elpe + 1) - off, buf_len);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, prp1,
> +        prp2);
> +}
> +
> +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +    uint64_t off, NvmeRequest *req)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +
> +    uint32_t trans_len;
> +    time_t current_ms;
> +    uint64_t units_read = 0, units_written = 0, read_commands = 0,
> +        write_commands = 0;
> +    NvmeSmartLog smart;
> +    BlockAcctStats *s;
> +
> +    if (!nsid || (nsid != 0xffffffff && nsid > n->num_namespaces)) {
> +        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
The LAP '0' bit is cleared now - which means there is no support
for per-namespace data. So in theory, if that was the aim, this condition
should check for the values different than 0x0 and 0xFFFFFFFF and either
abort the command or treat that as request for controller specific data.

> +    s = blk_get_stats(n->conf.blk);
> +
> +    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> +    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> +    read_commands = s->nr_ops[BLOCK_ACCT_READ];
> +    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
> +
> +    if (off > sizeof(smart)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trans_len = MIN(sizeof(smart) - off, buf_len);
> +
> +    memset(&smart, 0x0, sizeof(smart));
> +
> +    smart.data_units_read[0] = cpu_to_le64(units_read / 1000);
> +    smart.data_units_written[0] = cpu_to_le64(units_written / 1000);
> +    smart.host_read_commands[0] = cpu_to_le64(read_commands);
> +    smart.host_write_commands[0] = cpu_to_le64(write_commands);
> +
> +    smart.number_of_error_log_entries[0] = cpu_to_le64(0);
> +    smart.temperature[0] = n->temperature & 0xff;
> +    smart.temperature[1] = (n->temperature >> 8) & 0xff;
> +
> +    if (n->features.temp_thresh <= n->temperature) {
> +        smart.critical_warning |= NVME_SMART_TEMPERATURE;
> +    }
> +
> +    current_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    smart.power_on_hours[0] = cpu_to_le64(
> +        (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> +        prp2);
> +}
> +
> +static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +    uint64_t off, NvmeRequest *req)
> +{
> +    uint32_t trans_len;
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    NvmeFwSlotInfoLog fw_log;
> +
> +    if (off > sizeof(fw_log)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    memset(&fw_log, 0, sizeof(NvmeFwSlotInfoLog));
> +
> +    trans_len = MIN(sizeof(fw_log) - off, buf_len);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> +        prp2);
> +}
> +
> +static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint32_t dw12 = le32_to_cpu(cmd->cdw12);
> +    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> +    uint16_t lid = dw10 & 0xff;
> +    uint8_t  rae = (dw10 >> 15) & 0x1;
> +    uint32_t numdl, numdu;
> +    uint64_t off, lpol, lpou;
> +    size_t   len;
> +
> +    numdl = (dw10 >> 16);
> +    numdu = (dw11 & 0xffff);
> +    lpol = dw12;
> +    lpou = dw13;
> +
> +    len = (((numdu << 16) | numdl) + 1) << 2;
> +    off = (lpou << 32ULL) | lpol;
> +
> +    if (off & 0x3) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trace_nvme_get_log(req->cid, lid, rae, len, off);
> +
> +    switch (lid) {
> +    case NVME_LOG_ERROR_INFO:
> +        return nvme_error_info(n, cmd, len, off, req);
> +    case NVME_LOG_SMART_INFO:
> +        return nvme_smart_info(n, cmd, len, off, req);
> +    case NVME_LOG_FW_SLOT_INFO:
> +        return nvme_fw_log_info(n, cmd, len, off, req);
> +    default:
> +        trace_nvme_err_invalid_log_page(req->cid, lid);
> +        return NVME_INVALID_LOG_ID | NVME_DNR;

The spec mentions the Invalid Field in Command  case processing
command with an unsupported log id.

> +    }
> +}
> +
>  static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
>  {
>      n->cq[cq->cqid] = NULL;
> @@ -812,6 +944,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t result;
>
>      switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        result = cpu_to_le32(n->features.temp_thresh);
> +        break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          result = blk_enable_write_cache(n->conf.blk);
>          trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
> @@ -856,6 +991,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>
>      switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        n->features.temp_thresh = dw11;
> +        break;
> +
>      case NVME_VOLATILE_WRITE_CACHE:
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
> @@ -884,6 +1023,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_del_sq(n, cmd);
>      case NVME_ADM_CMD_CREATE_SQ:
>          return nvme_create_sq(n, cmd);
> +    case NVME_ADM_CMD_GET_LOG_PAGE:
> +        return nvme_get_log(n, cmd, req);
>      case NVME_ADM_CMD_DELETE_CQ:
>          return nvme_del_cq(n, cmd);
>      case NVME_ADM_CMD_CREATE_CQ:
> @@ -923,6 +1064,7 @@ static void nvme_process_sq(void *opaque)
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
>          memset(&req->cqe, 0, sizeof(req->cqe));
>          req->cqe.cid = cmd.cid;
> +        req->cid = le16_to_cpu(cmd.cid);

If I haven't missed anything this is being used only in one place
for tracing - is it really worth to duplicate the cid here ?

>
>          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
>              nvme_admin_cmd(n, &cmd, req);
> @@ -1378,6 +1520,10 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>      n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
>      n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
> +    n->elpes = g_new0(NvmeErrorLog, n->params.elpe + 1);
> +    n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    n->temperature = NVME_TEMPERATURE;
> +    n->features.temp_thresh = 0x14d;
>  }
>
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1446,7 +1592,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->oacs = cpu_to_le16(0);
>      id->acl = 3;
>      id->frmw = 7 << 1;
> -    id->lpa = 1 << 0;
> +    id->lpa = 1 << 2;

This sets the bit that states support for GLP command but clears the one
that states support for per-namespace SMART/Heatld data - is that expected ?

BR

Beata
> +    id->elpe = n->params.elpe;
>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> @@ -1530,6 +1677,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->namespaces);
>      g_free(n->cq);
>      g_free(n->sq);
> +    g_free(n->elpes);
>
>      if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 7c3c07bde887..fcfd504e3f9f 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -6,12 +6,14 @@
>  #define DEFINE_NVME_PROPERTIES(_state, _props) \
>      DEFINE_PROP_STRING("serial", _state, _props.serial), \
>      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> -    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
> +    DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24)
>
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues;
>      uint32_t cmb_size_mb;
> +    uint8_t  elpe;
>  } NvmeParams;
>
>  typedef struct NvmeAsyncEvent {
> @@ -23,6 +25,7 @@ typedef struct NvmeRequest {
>      struct NvmeSQueue       *sq;
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
> +    uint16_t                cid;
>      bool                    has_sg;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
> @@ -92,12 +95,16 @@ typedef struct NvmeCtrl {
>      uint64_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
>      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> +    uint64_t    starttime_ms;
> +    uint16_t    temperature;
>
>      NvmeNamespace   *namespaces;
>      NvmeSQueue      **sq;
>      NvmeCQueue      **cq;
>      NvmeSQueue      admin_sq;
>      NvmeCQueue      admin_cq;
> +    NvmeFeatureVal  features;
> +    NvmeErrorLog    *elpes;
>      NvmeIdCtrl      id_ctrl;
>  } NvmeCtrl;
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 13d1b21dd4e4..a2c7919c861e 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -46,6 +46,7 @@ nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> +nvme_get_log(uint16_t cid, uint16_t lid, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx16" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
>  nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> @@ -85,6 +86,7 @@ nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating completion q
>  nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx16""
>  nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
>  nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
> +nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
>  nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
>  nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
>  nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 1b0accd4fe2b..a088ec7d4e38 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -515,7 +515,7 @@ enum NvmeSmartWarn {
>      NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
>  };
>
> -enum LogIdentifier {
> +enum NvmeLogIdentifier {
>      NVME_LOG_ERROR_INFO     = 0x01,
>      NVME_LOG_SMART_INFO     = 0x02,
>      NVME_LOG_FW_SLOT_INFO   = 0x03,
> --
> 2.23.0
>
>

