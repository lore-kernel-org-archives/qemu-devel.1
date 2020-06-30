Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D1720722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D1720722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq7jq-0001tm-Kq
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7gW-0000kP-26; Tue, 30 Jun 2020 00:15:52 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7gU-0002Ed-17; Tue, 30 Jun 2020 00:15:51 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id CED40BF717;
 Tue, 30 Jun 2020 04:15:46 +0000 (UTC)
Date: Tue, 30 Jun 2020 06:15:43 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 02/18] hw/block/nvme: Define 64 bit cqe.result
Message-ID: <20200630041543.pqr52rivjr5rrq6n@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-3-dmitry.fomichev@wdc.com>
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

On Jun 18 06:33, Dmitry Fomichev wrote:
> From: Ajay Joshi <ajay.joshi@wdc.com>
> 
> A new write command, Zone Append, is added as a part of Zoned
> Namespace Command Set. Upon successful completion of this command,
> the controller returns the start LBA of the performed write operation
> in cqe.result field. Therefore, the maximum size of this variable
> needs to be changed from 32 to 64 bit, consuming the reserved 32 bit
> field that follows the result in CQE struct. Since the existing
> commands are expected to return a 32 bit LE value, two separate
> variables, result32 and result64, are now kept in a union.
> 
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  block/nvme.c         | 2 +-
>  block/trace-events   | 2 +-
>  hw/block/nvme.c      | 6 +++---
>  include/block/nvme.h | 6 ++++--
>  4 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index eb2f54dd9d..ca245ec574 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -287,7 +287,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
>  {
>      uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
>      if (status) {
> -        trace_nvme_error(le32_to_cpu(c->result),
> +        trace_nvme_error(le64_to_cpu(c->result64),
>                           le16_to_cpu(c->sq_head),
>                           le16_to_cpu(c->sq_id),
>                           le16_to_cpu(c->cid),
> diff --git a/block/trace-events b/block/trace-events
> index 29dff8881c..05c1393943 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -156,7 +156,7 @@ vxhs_get_creds(const char *cacert, const char *client_key, const char *client_ce
>  # nvme.c
>  nvme_kick(void *s, int queue) "s %p queue %d"
>  nvme_dma_flush_queue_wait(void *s) "s %p"
> -nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
> +nvme_error(uint64_t cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %ld sq_head %d sqid %d cid %d status 0x%x"
>  nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
>  nvme_process_completion_queue_busy(void *s, int index) "s %p queue %d"
>  nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3ed9f3d321..a1bbc9acde 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -823,7 +823,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    req->cqe.result = result;
> +    req->cqe.result32 = result;
>      return NVME_SUCCESS;
>  }
>  
> @@ -859,8 +859,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>                                      ((dw11 >> 16) & 0xFFFF) + 1,
>                                      n->params.max_ioqpairs,
>                                      n->params.max_ioqpairs);
> -        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
> -                                      ((n->params.max_ioqpairs - 1) << 16));
> +        req->cqe.result32 = cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                                        ((n->params.max_ioqpairs - 1) << 16));
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 1720ee1d51..9c3a04dcd7 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -577,8 +577,10 @@ typedef struct NvmeAerResult {
>  } NvmeAerResult;
>  
>  typedef struct NvmeCqe {
> -    uint32_t    result;
> -    uint32_t    rsvd;
> +    union {
> +        uint64_t     result64;
> +        uint32_t     result32;
> +    };
>      uint16_t    sq_head;
>      uint16_t    sq_id;
>      uint16_t    cid;
> -- 
> 2.21.0
> 
> 

