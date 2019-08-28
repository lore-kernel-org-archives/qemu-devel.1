Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A2FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BCA214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BCA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ttv-0006j7-Il
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2trb-0004pq-Pc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2tra-0007MP-EJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2trX-0007K5-GV; Wed, 28 Aug 2019 05:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF84E308123B;
 Wed, 28 Aug 2019 09:03:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0356860BEC;
 Wed, 28 Aug 2019 09:03:26 +0000 (UTC)
Message-ID: <798ede8632285382a9d54dc9e3a75be046387b7d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:25 +0300
In-Reply-To: <0618bc5b-6c0b-d154-dc7c-77398a7eb031@redhat.com>
References: <20190825071541.10389-1-mlevitsk@redhat.com>
 <20190825071541.10389-3-mlevitsk@redhat.com>
 <0618bc5b-6c0b-d154-dc7c-77398a7eb031@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 28 Aug 2019 09:03:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nvme: add support for discard
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-27 at 18:29 -0400, John Snow wrote:
> 
> On 8/25/19 3:15 AM, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/nvme.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++++
> >  block/trace-events |  2 ++
> >  2 files changed, 85 insertions(+)
> > 
> > diff --git a/block/nvme.c b/block/nvme.c
> > index f8bd11e19a..dd041f39c9 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -112,6 +112,7 @@ typedef struct {
> >      bool plugged;
> >  
> >      bool supports_write_zeros;
> > +    bool supports_discard;
> >  
> >      CoMutex dma_map_lock;
> >      CoQueue dma_flush_queue;
> > @@ -463,6 +464,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> >  
> >      oncs = le16_to_cpu(idctrl->oncs);
> >      s->supports_write_zeros = (oncs & NVME_ONCS_WRITE_ZEROS) != 0;
> > +    s->supports_discard = (oncs & NVME_ONCS_DSM) != 0;
> 
> Same comment -- checking !!(register & FIELD) is nicer than the
> negative. (I'm actually not sure even the !! is needed, but it seems to
> be a QEMU-ism and I've caught myself using it...)

All right, no problem to use !!

> 
> Rest looks good to me on a skim, but I'm not very well-versed in NVME.
Thanks!


> 
> >  
> >      memset(resp, 0, 4096);
> >  
> > @@ -1153,6 +1155,86 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
> >  }
> >  
> >  
> > +static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
> > +                                         int64_t offset,
> > +                                         int bytes)
> > +{
> > +    BDRVNVMeState *s = bs->opaque;
> > +    NVMeQueuePair *ioq = s->queues[1];
> > +    NVMeRequest *req;
> > +    NvmeDsmRange *buf;
> > +    QEMUIOVector local_qiov;
> > +    int ret;
> > +
> > +    NvmeCmd cmd = {
> > +        .opcode = NVME_CMD_DSM,
> > +        .nsid = cpu_to_le32(s->nsid),
> > +        .cdw10 = cpu_to_le32(0), /*number of ranges - 0 based*/
> > +        .cdw11 = cpu_to_le32(1 << 2), /*deallocate bit*/
> > +    };
> > +
> > +    NVMeCoData data = {
> > +        .ctx = bdrv_get_aio_context(bs),
> > +        .ret = -EINPROGRESS,
> > +    };
> > +
> > +    if (!s->supports_discard) {
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    assert(s->nr_queues > 1);
> > +
> > +    buf = qemu_try_blockalign0(bs, s->page_size);
> > +    if (!buf) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    buf->nlb = cpu_to_le32(bytes >> s->blkshift);
> > +    buf->slba = cpu_to_le64(offset >> s->blkshift);
> > +    buf->cattr = 0;
> > +
> > +    qemu_iovec_init(&local_qiov, 1);
> > +    qemu_iovec_add(&local_qiov, buf, 4096);
> > +
> > +    req = nvme_get_free_req(ioq);
> > +    assert(req);
> > +
> > +    qemu_co_mutex_lock(&s->dma_map_lock);
> > +    ret = nvme_cmd_map_qiov(bs, &cmd, req, &local_qiov);
> > +    qemu_co_mutex_unlock(&s->dma_map_lock);
> > +
> > +    if (ret) {
> > +        req->busy = false;
> > +        goto out;
> > +    }
> > +
> > +    trace_nvme_dsm(s, offset, bytes);
> > +
> > +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> > +
> > +    data.co = qemu_coroutine_self();
> > +    while (data.ret == -EINPROGRESS) {
> > +        qemu_coroutine_yield();
> > +    }
> > +
> > +    qemu_co_mutex_lock(&s->dma_map_lock);
> > +    ret = nvme_cmd_unmap_qiov(bs, &local_qiov);
> > +    qemu_co_mutex_unlock(&s->dma_map_lock);
> > +
> > +    if (ret) {
> > +        goto out;
> > +    }
> > +
> > +    ret = data.ret;
> > +    trace_nvme_dsm_done(s, offset, bytes, ret);
> > +out:
> > +    qemu_iovec_destroy(&local_qiov);
> > +    qemu_vfree(buf);
> > +    return ret;
> > +
> > +}
> > +
> > +
> >  static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
> >                                 BlockReopenQueue *queue, Error **errp)
> >  {
> > @@ -1259,6 +1341,7 @@ static BlockDriver bdrv_nvme = {
> >      .bdrv_co_pwritev          = nvme_co_pwritev,
> >  
> >      .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
> > +    .bdrv_co_pdiscard         = nvme_co_pdiscard,
> >  
> >      .bdrv_co_flush_to_disk    = nvme_co_flush,
> >      .bdrv_reopen_prepare      = nvme_reopen_prepare,
> > diff --git a/block/trace-events b/block/trace-events
> > index 8209fbd0c7..7d1d48b502 100644
> > --- a/block/trace-events
> > +++ b/block/trace-events
> > @@ -153,6 +153,8 @@ nvme_write_zeros(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offs
> >  nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
> >  nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
> >  nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
> > +nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" bytes %"PRId64""
> > +nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset %"PRId64" bytes %"PRId64" ret %d"
> >  nvme_dma_map_flush(void *s) "s %p"
> >  nvme_free_req_queue_wait(void *q) "q %p"
> >  nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
> > 


Best regards,
	Maxim Levitsky


