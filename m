Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC25C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EF520732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSkdr+P8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EF520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93jY-0003Yq-Ra
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93ir-00035P-Ro
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93io-000693-WD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598003549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sj2X0T1Q2DLtofOBAiTG3jpb08TyXFjT3RXZvrQ4FPY=;
 b=RSkdr+P8QmxgnKEZPQUBIZzC5ukUhERXC+5CYFMSPadLkBXj++yKQOqG4iN4h6DD2XREdy
 4mwzveUUKlG96POVyoSxjh8dtymtv5iDtH4MAtuJMDsaa8z2glp5VRulFOgIyz3s7uQGIp
 eRfGgnkC+o0yQrosxlk+mbYhFC+/qfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-x59uAYwvO-6LpQSPJ94iOA-1; Fri, 21 Aug 2020 05:52:27 -0400
X-MC-Unique: x59uAYwvO-6LpQSPJ94iOA-1
Received: by mail-wm1-f70.google.com with SMTP id a5so618303wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eL3CyHmsDyTBZ015AEjz637z7eIEicQtkRAHQPTSaVg=;
 b=aM96c4vWmsZnyDuJdH/gw3P0fGltf0s4oRW5CqnBTZ8au7LagrImgLM5+jOl0SAKpx
 uuRrapZ6TRun+8vaHxc0G36SmoQQjT2YVWxZP4XexLkMYRegfvMhUaVy1uEs5gFyjlTR
 fGt033NnHaXzewiu6V7Msic1pGB88xHf3MyURcvBahMePiw/bYqskaKTleePEksj/9Xs
 PeJTZYkUx+sebR65QoaM7GtpCv8qoI+Lsm8ORysj5MRQQx64AaQqxItIDsl8HbXPF2N0
 m3Ox/X1ECmTs89Cmq3C/Y02GD2DAy2k/Yl6DjCMwWMV6HXp30jj4Int9CC7U0m1Zk1hr
 k54Q==
X-Gm-Message-State: AOAM530xMJc6KAF6EemAnSLiwi3hPlx4OKpHsN0H2QdPAVuW3n+TvRAA
 /cvxdVSyihFdBdzudwH5O53syVV+ribfxi+bESpSaapUhnvqqb0BnoVNTHtoFyIBfdNnyjY3VK6
 KMb9neQ/QFPKZQOI=
X-Received: by 2002:adf:d849:: with SMTP id k9mr2091838wrl.115.1598003546706; 
 Fri, 21 Aug 2020 02:52:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhb980psksfGoUJejPFfGBWTSskS6YGxBj2MynMvFDgbEPLBJgn1kepFJ86VrRtuVXLG8fZA==
X-Received: by 2002:adf:d849:: with SMTP id k9mr2091817wrl.115.1598003546433; 
 Fri, 21 Aug 2020 02:52:26 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id p14sm3685836wrg.96.2020.08.21.02.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 02:52:25 -0700 (PDT)
Date: Fri, 21 Aug 2020 11:52:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 04/15] block/nvme: Define INDEX macros to ease code
 review
Message-ID: <20200821095223.65ktc6e2eck3cu5d@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-5-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:50PM +0200, Philippe Mathieu-Daudé wrote:
> Use definitions instead of '0' or '1' indexes. Also this will
> be useful when using multi-queues later.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index e1893b4e792..003809fbd83 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -103,6 +103,9 @@ typedef volatile struct {
>  
>  QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
>  
> +#define INDEX_ADMIN     0
> +#define INDEX_IO(n)     (1 + n)
> +
>  struct BDRVNVMeState {
>      AioContext *aio_context;
>      QEMUVFIOState *vfio;
> @@ -531,7 +534,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>      }
>      cmd.prp1 = cpu_to_le64(iova);
>  
> -    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to identify controller");
>          goto out;
>      }
> @@ -555,7 +558,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>  
>      cmd.cdw10 = 0;
>      cmd.nsid = cpu_to_le32(namespace);
> -    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to identify namespace");
>          goto out;
>      }
> @@ -644,7 +647,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
>          .cdw11 = cpu_to_le32(0x3),
>      };
> -    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to create io queue [%d]", n);
>          nvme_free_queue_pair(q);
>          return false;
> @@ -655,7 +658,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
>          .cdw11 = cpu_to_le32(0x1 | (n << 16)),
>      };
> -    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
> +    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to create io queue [%d]", n);
>          nvme_free_queue_pair(q);
>          return false;
> @@ -739,16 +742,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>  
>      /* Set up admin queue. */
>      s->queues = g_new(NVMeQueuePair *, 1);
> -    s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
> -    if (!s->queues[0]) {
> +    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
> +                                                          NVME_QUEUE_SIZE,
> +                                                          errp);
> +    if (!s->queues[INDEX_ADMIN]) {
>          ret = -EINVAL;
>          goto out;
>      }
>      s->nr_queues = 1;
>      QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
>      s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
> -    s->regs->asq = cpu_to_le64(s->queues[0]->sq.iova);
> -    s->regs->acq = cpu_to_le64(s->queues[0]->cq.iova);
> +    s->regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
> +    s->regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
>  
>      /* After setting up all control registers we can enable device now. */
>      s->regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
> @@ -839,7 +844,7 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
>          .cdw11 = cpu_to_le32(enable ? 0x01 : 0x00),
>      };
>  
> -    ret = nvme_cmd_sync(bs, s->queues[0], &cmd);
> +    ret = nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd);
>      if (ret) {
>          error_setg(errp, "Failed to configure NVMe write cache");
>      }
> @@ -1056,7 +1061,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
>  {
>      int r;
>      BDRVNVMeState *s = bs->opaque;
> -    NVMeQueuePair *ioq = s->queues[1];
> +    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
>      NVMeRequest *req;
>  
>      uint32_t cdw12 = (((bytes >> s->blkshift) - 1) & 0xFFFF) |
> @@ -1171,7 +1176,7 @@ static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
>  static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
>  {
>      BDRVNVMeState *s = bs->opaque;
> -    NVMeQueuePair *ioq = s->queues[1];
> +    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
>      NVMeRequest *req;
>      NvmeCmd cmd = {
>          .opcode = NVME_CMD_FLUSH,
> @@ -1202,7 +1207,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
>                                                BdrvRequestFlags flags)
>  {
>      BDRVNVMeState *s = bs->opaque;
> -    NVMeQueuePair *ioq = s->queues[1];
> +    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
>      NVMeRequest *req;
>  
>      uint32_t cdw12 = ((bytes >> s->blkshift) - 1) & 0xFFFF;
> @@ -1255,7 +1260,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
>                                           int bytes)
>  {
>      BDRVNVMeState *s = bs->opaque;
> -    NVMeQueuePair *ioq = s->queues[1];
> +    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
>      NVMeRequest *req;
>      NvmeDsmRange *buf;
>      QEMUIOVector local_qiov;
> @@ -1398,7 +1403,7 @@ static void nvme_aio_unplug(BlockDriverState *bs)
>      BDRVNVMeState *s = bs->opaque;
>      assert(s->plugged);
>      s->plugged = false;
> -    for (i = 1; i < s->nr_queues; i++) {
> +    for (i = INDEX_IO(0); i < s->nr_queues; i++) {
>          NVMeQueuePair *q = s->queues[i];
>          qemu_mutex_lock(&q->lock);
>          nvme_kick(q);
> -- 
> 2.26.2
> 
> 


