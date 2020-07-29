Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F185C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D272074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQoxWMQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D272074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kKJ-0001cT-HF
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0kJN-0000P0-VT
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:31:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0kJL-0002IT-Ny
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596022311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3HKS4wQxEzNi6cueZOydztwi0QEThTOEKlHf+chcP8=;
 b=TQoxWMQ2H8nhWFPFCChArQuZSIeZjcDf5r4sJ7rmyB6oeWj0RK3prNeD2fbVG+3Zm26cLF
 dn0XkntcExiKegX5zlaSEf++GYdbA0zUtm3MX/jXyef931yJLsWIimRWgyYcuSqst4N1ZC
 Y9X4o6FC5Z/Pg+R6xYG2MTqEmDGMTAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Yw6ikybHNNC8RUoTmWb4wA-1; Wed, 29 Jul 2020 07:31:49 -0400
X-MC-Unique: Yw6ikybHNNC8RUoTmWb4wA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C9001B18BC1;
 Wed, 29 Jul 2020 11:31:47 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2B7C5C5B7;
 Wed, 29 Jul 2020 11:31:44 +0000 (UTC)
Message-ID: <672b824e393957b71e2e7cbe38ae86a1c45eb153.camel@redhat.com>
Subject: Re: [PATCH v3 11/18] hw/block/nvme: add remaining mandatory
 controller parameters
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 29 Jul 2020 14:31:43 +0300
In-Reply-To: <20200706061303.246057-12-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-12-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
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
> Add support for any remaining mandatory controller operating parameters
> (features).
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c       | 56 ++++++++++++++++++++++++++++++++++++++-----
>  hw/block/trace-events |  2 ++
>  include/block/nvme.h  | 10 +++++++-
>  3 files changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 8fce2ebf69e7..2d85e853403f 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -71,6 +71,20 @@
>              " in %s: " fmt "\n", __func__, ## __VA_ARGS__); \
>      } while (0)
>  
> +static const bool nvme_feature_support[NVME_FID_MAX] = {
> +    [NVME_ARBITRATION]              = true,
> +    [NVME_POWER_MANAGEMENT]         = true,
> +    [NVME_TEMPERATURE_THRESHOLD]    = true,
> +    [NVME_ERROR_RECOVERY]           = true,
> +    [NVME_VOLATILE_WRITE_CACHE]     = true,
> +    [NVME_NUMBER_OF_QUEUES]         = true,
> +    [NVME_INTERRUPT_COALESCING]     = true,
> +    [NVME_INTERRUPT_VECTOR_CONF]    = true,
> +    [NVME_WRITE_ATOMICITY]          = true,
> +    [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
> +    [NVME_TIMESTAMP]                = true,
I checked the spec and mandatory features are all here.

> +};
> +
>  static void nvme_process_sq(void *opaque);
>  
>  static uint16_t nvme_cid(NvmeRequest *req)
> @@ -1070,8 +1084,20 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>      uint32_t result;
> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
> +    uint16_t iv;
>  
> -    switch (dw10) {
> +    static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
> +        [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
> +    };
Nice idea!

> +
> +    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
> +
> +    if (!nvme_feature_support[fid]) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    switch (fid) {
>      case NVME_TEMPERATURE_THRESHOLD:
>          result = 0;
>  
> @@ -1101,6 +1127,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          result = (n->params.max_ioqpairs - 1) |
>              ((n->params.max_ioqpairs - 1) << 16);
>          trace_pci_nvme_getfeat_numq(result);
> +        break;
> +    case NVME_INTERRUPT_VECTOR_CONF:
> +        iv = dw11 & 0xffff;
> +        if (iv >= n->params.max_ioqpairs + 1) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        result = iv;
> +        if (iv == n->admin_cq.vector) {
> +            result |= NVME_INTVC_NOCOALESCING;
> +        }
I wonder if this is needed, but it doesn't hurt to have this.
Spec is not clear about this.

> +
>          break;
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          result = n->features.async_config;
> @@ -1108,8 +1146,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
>      default:
> -        trace_pci_nvme_err_invalid_getfeat(dw10);
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +        result = nvme_feature_default[fid];
> +        break;
>      }
>  
>      req->cqe.result = cpu_to_le32(result);
> @@ -1138,8 +1176,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
>  
> -    switch (dw10) {
> +    trace_pci_nvme_setfeat(nvme_cid(req), fid, dw11);
> +
> +    if (!nvme_feature_support[fid]) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    switch (fid) {
>      case NVME_TEMPERATURE_THRESHOLD:
>          if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
>              break;
> @@ -1186,8 +1231,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
>      default:
> -        trace_pci_nvme_err_invalid_setfeat(dw10);
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +        return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>      }
>      return NVME_SUCCESS;
>  }
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 091af16ca7d7..42e62f4649f8 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -46,6 +46,8 @@ pci_nvme_identify_ctrl(void) "identify controller"
>  pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> +pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" cdw11 0x%"PRIx32""
> +pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" cdw11 0x%"PRIx32""
>  pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 0dce15af6bcf..cd396111b2f5 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -662,6 +662,7 @@ enum NvmeStatusCodes {
>      NVME_FW_REQ_RESET           = 0x010b,
>      NVME_INVALID_QUEUE_DEL      = 0x010c,
>      NVME_FID_NOT_SAVEABLE       = 0x010d,
> +    NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
>      NVME_FID_NOT_NSID_SPEC      = 0x010f,
>      NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
>      NVME_CONFLICTING_ATTRS      = 0x0180,
> @@ -866,6 +867,7 @@ enum NvmeIdCtrlLpa {
>  #define NVME_CTRL_SGLS_ADDR_OFFSET         (0x1 << 20)
>  
>  #define NVME_ARB_AB(arb)    (arb & 0x7)
> +#define NVME_ARB_AB_NOLIMIT 0x7
>  #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
>  #define NVME_ARB_MPW(arb)   ((arb >> 16) & 0xff)
>  #define NVME_ARB_HPW(arb)   ((arb >> 24) & 0xff)
> @@ -873,6 +875,8 @@ enum NvmeIdCtrlLpa {
>  #define NVME_INTC_THR(intc)     (intc & 0xff)
>  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
>  
> +#define NVME_INTVC_NOCOALESCING (0x1 << 16)
> +
>  #define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
>  #define NVME_TEMP_THSEL_OVER   0x0
>  #define NVME_TEMP_THSEL_UNDER  0x1
> @@ -899,9 +903,13 @@ enum NvmeFeatureIds {
>      NVME_WRITE_ATOMICITY            = 0xa,
>      NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
>      NVME_TIMESTAMP                  = 0xe,
> -    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
> +    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
> +    NVME_FID_MAX                    = 0x100,
>  };
>  
> +#define NVME_GETSETFEAT_FID_MASK 0xff
> +#define NVME_GETSETFEAT_FID(dw10) (dw10 & NVME_GETSETFEAT_FID_MASK)
> +
>  typedef struct NvmeRangeType {
>      uint8_t     type;
>      uint8_t     attributes;
Looks good,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky


