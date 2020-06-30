Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93074C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE9E20780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE9E20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDuM-00008U-KW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqDtd-0007gF-Ni; Tue, 30 Jun 2020 06:53:49 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqDtb-0004kA-PA; Tue, 30 Jun 2020 06:53:49 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 09220BF676;
 Tue, 30 Jun 2020 10:53:46 +0000 (UTC)
Date: Tue, 30 Jun 2020 12:53:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/4] hw/block/nvme: Use QEMU_PACKED on hardware/packet
 structures
Message-ID: <20200630105342.ag5jikawtrbnhauz@apples.localdomain>
References: <20200630103739.9715-1-philmd@redhat.com>
 <20200630103739.9715-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630103739.9715-3-philmd@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 30 12:37, Philippe Mathieu-Daudé wrote:
> These structures either describe hardware registers, or
> commands ('packets') to send to the hardware. To forbid
> the compiler to optimize and change fields alignment,
> mark the structures as packed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  include/block/nvme.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 1720ee1d51..71c5681912 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1,7 +1,7 @@
>  #ifndef BLOCK_NVME_H
>  #define BLOCK_NVME_H
>  
> -typedef struct NvmeBar {
> +typedef struct QEMU_PACKED NvmeBar {
>      uint64_t    cap;
>      uint32_t    vs;
>      uint32_t    intms;
> @@ -377,7 +377,7 @@ enum NvmePmrmscMask {
>  #define NVME_PMRMSC_SET_CBA(pmrmsc, val)   \
>      (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
>  
> -typedef struct NvmeCmd {
> +typedef struct QEMU_PACKED NvmeCmd {
>      uint8_t     opcode;
>      uint8_t     fuse;
>      uint16_t    cid;
> @@ -422,7 +422,7 @@ enum NvmeIoCommands {
>      NVME_CMD_DSM                = 0x09,
>  };
>  
> -typedef struct NvmeDeleteQ {
> +typedef struct QEMU_PACKED NvmeDeleteQ {
>      uint8_t     opcode;
>      uint8_t     flags;
>      uint16_t    cid;
> @@ -432,7 +432,7 @@ typedef struct NvmeDeleteQ {
>      uint32_t    rsvd11[5];
>  } NvmeDeleteQ;
>  
> -typedef struct NvmeCreateCq {
> +typedef struct QEMU_PACKED NvmeCreateCq {
>      uint8_t     opcode;
>      uint8_t     flags;
>      uint16_t    cid;
> @@ -449,7 +449,7 @@ typedef struct NvmeCreateCq {
>  #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
>  #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
>  
> -typedef struct NvmeCreateSq {
> +typedef struct QEMU_PACKED NvmeCreateSq {
>      uint8_t     opcode;
>      uint8_t     flags;
>      uint16_t    cid;
> @@ -474,7 +474,7 @@ enum NvmeQueueFlags {
>      NVME_Q_PRIO_LOW     = 3,
>  };
>  
> -typedef struct NvmeIdentify {
> +typedef struct QEMU_PACKED NvmeIdentify {
>      uint8_t     opcode;
>      uint8_t     flags;
>      uint16_t    cid;
> @@ -486,7 +486,7 @@ typedef struct NvmeIdentify {
>      uint32_t    rsvd11[5];
>  } NvmeIdentify;
>  
> -typedef struct NvmeRwCmd {
> +typedef struct QEMU_PACKED NvmeRwCmd {
>      uint8_t     opcode;
>      uint8_t     flags;
>      uint16_t    cid;
> @@ -528,7 +528,7 @@ enum {
>      NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
>  };
>  
> -typedef struct NvmeDsmCmd {
> +typedef struct QEMU_PACKED NvmeDsmCmd {
>      uint8_t     opcode;
>      uint8_t     flags;
>      uint16_t    cid;
> @@ -547,7 +547,7 @@ enum {
>      NVME_DSMGMT_AD  = 1 << 2,
>  };
>  
> -typedef struct NvmeDsmRange {
> +typedef struct QEMU_PACKED NvmeDsmRange {
>      uint32_t    cattr;
>      uint32_t    nlb;
>      uint64_t    slba;
> @@ -569,14 +569,14 @@ enum NvmeAsyncEventRequest {
>      NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
>  };
>  
> -typedef struct NvmeAerResult {
> +typedef struct QEMU_PACKED NvmeAerResult {
>      uint8_t event_type;
>      uint8_t event_info;
>      uint8_t log_page;
>      uint8_t resv;
>  } NvmeAerResult;
>  
> -typedef struct NvmeCqe {
> +typedef struct QEMU_PACKED NvmeCqe {
>      uint32_t    result;
>      uint32_t    rsvd;
>      uint16_t    sq_head;
> @@ -634,7 +634,7 @@ enum NvmeStatusCodes {
>      NVME_NO_COMPLETE            = 0xffff,
>  };
>  
> -typedef struct NvmeFwSlotInfoLog {
> +typedef struct QEMU_PACKED NvmeFwSlotInfoLog {
>      uint8_t     afi;
>      uint8_t     reserved1[7];
>      uint8_t     frs1[8];
> @@ -647,7 +647,7 @@ typedef struct NvmeFwSlotInfoLog {
>      uint8_t     reserved2[448];
>  } NvmeFwSlotInfoLog;
>  
> -typedef struct NvmeErrorLog {
> +typedef struct QEMU_PACKED NvmeErrorLog {
>      uint64_t    error_count;
>      uint16_t    sqid;
>      uint16_t    cid;
> @@ -659,7 +659,7 @@ typedef struct NvmeErrorLog {
>      uint8_t     resv[35];
>  } NvmeErrorLog;
>  
> -typedef struct NvmeSmartLog {
> +typedef struct QEMU_PACKED NvmeSmartLog {
>      uint8_t     critical_warning;
>      uint8_t     temperature[2];
>      uint8_t     available_spare;
> @@ -693,7 +693,7 @@ enum LogIdentifier {
>      NVME_LOG_FW_SLOT_INFO   = 0x03,
>  };
>  
> -typedef struct NvmePSD {
> +typedef struct QEMU_PACKED NvmePSD {
>      uint16_t    mp;
>      uint16_t    reserved;
>      uint32_t    enlat;
> @@ -713,7 +713,7 @@ enum {
>      NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
>  };
>  
> -typedef struct NvmeIdCtrl {
> +typedef struct QEMU_PACKED NvmeIdCtrl {
>      uint16_t    vid;
>      uint16_t    ssvid;
>      uint8_t     sn[20];
> @@ -807,7 +807,7 @@ enum NvmeFeatureIds {
>      NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
>  };
>  
> -typedef struct NvmeRangeType {
> +typedef struct QEMU_PACKED NvmeRangeType {
>      uint8_t     type;
>      uint8_t     attributes;
>      uint8_t     rsvd2[14];
> @@ -817,13 +817,13 @@ typedef struct NvmeRangeType {
>      uint8_t     rsvd48[16];
>  } NvmeRangeType;
>  
> -typedef struct NvmeLBAF {
> +typedef struct QEMU_PACKED NvmeLBAF {
>      uint16_t    ms;
>      uint8_t     ds;
>      uint8_t     rp;
>  } NvmeLBAF;
>  
> -typedef struct NvmeIdNs {
> +typedef struct QEMU_PACKED NvmeIdNs {
>      uint64_t    nsze;
>      uint64_t    ncap;
>      uint64_t    nuse;
> -- 
> 2.21.3
> 
> 

