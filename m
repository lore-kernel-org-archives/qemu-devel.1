Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B44CC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC4E2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2vT9JAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC4E2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1pGq-0008DW-0M
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 05:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1pGD-0007b5-Rt
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1pGC-0001NF-K9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:28:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1pGC-0001Mh-G6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 05:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581503328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktHbARu1xKk2h7Uay+tFXVd2iWL1MU9ypXK2UGfO0y8=;
 b=f2vT9JAo1TNobE0O8nJLoFuC6Yob/S/pN+4y7zTgEB6fnLG6yWlnWHkPtSOI658F4OBPbs
 OpWwrYZ1Xj+xb4o/GM/B1KGIvoktbsr7VXhyNrJvM4/0J+xG9yT8kBnO7V89ltU4bzhMoG
 pFXDzDlS+0oAsyDxw+BHYAjzhgdnNvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-yFfXifQGPP24PKUtbtxRfA-1; Wed, 12 Feb 2020 05:28:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F8C107ACCC;
 Wed, 12 Feb 2020 10:28:42 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 654121000325;
 Wed, 12 Feb 2020 10:28:40 +0000 (UTC)
Message-ID: <4aa15bb73441c50168bce32ee259889c07e92fbf.camel@redhat.com>
Subject: Re: [PATCH v5 13/26] nvme: additional tracing
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 12:28:29 +0200
In-Reply-To: <20200204095208.269131-14-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095223eucas1p2b24d674e4b201c13a5fffc6853520d9b@eucas1p2.samsung.com>
 <20200204095208.269131-14-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yFfXifQGPP24PKUtbtxRfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> Add a trace call for nvme_enqueue_req_completion.
> 
> Also, streamline nvme_identify_ns and nvme_identify_ns_list. They do not
> need to repeat the command, it is already in the trace name.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 8 +++++---
>  hw/block/trace-events | 5 +++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3267ee2de47a..30c5b3e7a67d 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -320,6 +320,8 @@ static void nvme_post_cqes(void *opaque)
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> +    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
> +        req->status);
Split line alignment on that '('

>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> @@ -895,7 +897,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>          prp1, prp2);
>  }
>  
> -static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
>  {
>      static const int data_len = 4 * KiB;
>      uint32_t min_nsid = le32_to_cpu(c->nsid);
> @@ -905,7 +907,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      uint16_t ret;
>      int i, j = 0;
>  
> -    trace_nvme_dev_identify_nslist(min_nsid);
> +    trace_nvme_dev_identify_ns_list(min_nsid);
>  
>      list = g_malloc0(data_len);
>      for (i = 0; i < n->num_namespaces; i++) {
> @@ -932,7 +934,7 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      case 0x01:
>          return nvme_identify_ctrl(n, c);
>      case 0x02:
> -        return nvme_identify_nslist(n, c);
> +        return nvme_identify_ns_list(n, c);
>      default:
>          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 4cf39961989d..f982ec1a3221 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -39,8 +39,8 @@ nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
>  nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
>  nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
>  nvme_dev_identify_ctrl(void) "identify controller"
> -nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
> -nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
> +nvme_dev_identify_ns_list(uint32_t ns) "nsid %"PRIu32""
>  nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx32""
>  nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16" fid 0x%"PRIx32" val 0x%"PRIx32""
>  nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
> @@ -54,6 +54,7 @@ nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
>  nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
>  nvme_dev_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
>  nvme_dev_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
> +nvme_dev_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
>  nvme_dev_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
>  nvme_dev_enqueue_event_noqueue(int queued) "queued %d"
>  nvme_dev_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""

With alignment fixed:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


