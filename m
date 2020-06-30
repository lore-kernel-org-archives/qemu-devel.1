Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD0EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C2A20768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C2A20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq85C-0004Ts-BV
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq84I-0003t0-7R; Tue, 30 Jun 2020 00:40:26 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq84F-0005x7-TV; Tue, 30 Jun 2020 00:40:25 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 907D3BF670;
 Tue, 30 Jun 2020 04:40:21 +0000 (UTC)
Date: Tue, 30 Jun 2020 06:40:17 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 03/18] hw/block/nvme: Clean up unused AER definitions
Message-ID: <20200630044017.tdndzfeg5xmsdstk@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-4-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-4-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:09:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
> Removed unused struct NvmeAerResult and SMART-related async event
> codes. All other event codes are now categorized by their type.
> This avoids having to define the same values in a single enum,
> NvmeAsyncEventRequest, that is now removed.
> 
> Later commits in this series will define additional values in some
> of these enums. No functional change.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.h      |  1 -
>  include/block/nvme.h | 43 ++++++++++++++++++++++---------------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 0460cc0e62..4f0dac39ae 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -13,7 +13,6 @@ typedef struct NvmeParams {
>  
>  typedef struct NvmeAsyncEvent {
>      QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
> -    NvmeAerResult result;
>  } NvmeAsyncEvent;
>  
>  enum NvmeRequestFlags {
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 9c3a04dcd7..3099df99eb 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -553,28 +553,30 @@ typedef struct NvmeDsmRange {
>      uint64_t    slba;
>  } NvmeDsmRange;
>  
> -enum NvmeAsyncEventRequest {
> -    NVME_AER_TYPE_ERROR                     = 0,
> -    NVME_AER_TYPE_SMART                     = 1,
> -    NVME_AER_TYPE_IO_SPECIFIC               = 6,
> -    NVME_AER_TYPE_VENDOR_SPECIFIC           = 7,
> -    NVME_AER_INFO_ERR_INVALID_SQ            = 0,
> -    NVME_AER_INFO_ERR_INVALID_DB            = 1,
> -    NVME_AER_INFO_ERR_DIAG_FAIL             = 2,
> -    NVME_AER_INFO_ERR_PERS_INTERNAL_ERR     = 3,
> -    NVME_AER_INFO_ERR_TRANS_INTERNAL_ERR    = 4,
> -    NVME_AER_INFO_ERR_FW_IMG_LOAD_ERR       = 5,
> -    NVME_AER_INFO_SMART_RELIABILITY         = 0,
> -    NVME_AER_INFO_SMART_TEMP_THRESH         = 1,
> -    NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
> +enum NvmeAsyncEventType {
> +    NVME_AER_TYPE_ERROR                     = 0x00,
> +    NVME_AER_TYPE_SMART                     = 0x01,
> +    NVME_AER_TYPE_NOTICE                    = 0x02,
> +    NVME_AER_TYPE_CMDSET_SPECIFIC           = 0x06,
> +    NVME_AER_TYPE_VENDOR_SPECIFIC           = 0x07,
>  };
>  
> -typedef struct NvmeAerResult {
> -    uint8_t event_type;
> -    uint8_t event_info;
> -    uint8_t log_page;
> -    uint8_t resv;
> -} NvmeAerResult;
> +enum NvmeAsyncErrorInfo {
> +    NVME_AER_ERR_INVALID_SQ                 = 0x00,
> +    NVME_AER_ERR_INVALID_DB                 = 0x01,

Since we are moving this around, can we change it to
NVME_AER_INVALID_DB_REGISTER and NVME_AER_INVALID_DB_VALUE instead? I
believe those are the terms used in the spec.

Otherwise,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> +    NVME_AER_ERR_DIAG_FAIL                  = 0x02,
> +    NVME_AER_ERR_PERS_INTERNAL_ERR          = 0x03,
> +    NVME_AER_ERR_TRANS_INTERNAL_ERR         = 0x04,
> +    NVME_AER_ERR_FW_IMG_LOAD_ERR            = 0x05,
> +};
> +
> +enum NvmeAsyncNoticeInfo {
> +    NVME_AER_NOTICE_NS_CHANGED              = 0x00,
> +};
> +
> +enum NvmeAsyncEventCfg {
> +    NVME_AEN_CFG_NS_ATTR                    = 1 << 8,
> +};
>  
>  typedef struct NvmeCqe {
>      union {
> @@ -881,7 +883,6 @@ enum NvmeIdNsDps {
>  
>  static inline void _nvme_check_size(void)
>  {
> -    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
> -- 
> 2.21.0
> 
> 

