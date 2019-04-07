Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F6C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 08:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C54213F2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh/1QqrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C54213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD2wQ-0008Ra-4l
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 04:14:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hD2vc-00088n-PR
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hD2vb-0003CJ-70
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:13:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1hD2vZ-00032d-44
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:13:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id k17so12649223wrx.10
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 01:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WDcVPn0rL4jXQhf5zsKQY+JMHL4DVAOK/vTKS7GEZxw=;
	b=vh/1QqrULW0oAp5u90FyzVGLTsNr9Xi5NNp9ncfTSlerhb40lTBkmGs950fYFOXXuZ
	HXp9yKYOGZoMlsbhy+HtKQ2MiqXrHGQJJTeXXMcDwMmEFDTojtxu9SOYf3egjN2GOTH4
	wRoITJuvfTIrU+LDU/RK1pP2wdXfGC2RSYN5Z1i3uord4S1Lr2JGdtP1ygRhOHDL/Nya
	OqEXNZutOlgNptbP5fwtymy2FYpE/Ahcjt1czeUCBDLeWqdm0itWdeF3gOMYwItLuqp3
	JcL/1CVL5nCp0IKrFrlNVgV58DL/n3MVN+sX1OLdf1ifbUqtYyX1iNO04a/ku/JipQhl
	3U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WDcVPn0rL4jXQhf5zsKQY+JMHL4DVAOK/vTKS7GEZxw=;
	b=MtGi4OzesjUDo0zQN+iWCGREFKq+QGvsA11d0cYksG+xvULLLpxb0flF/mzIooVt4/
	oEsf5dFmBd4s+U9VrwQzALiSELpK9zGtlwDpcijIXu6Nz7EPZEWrv3CBenoA63wYStO0
	z2Fegero0uEwecma41Od4x0QDd3fKtaaqQ16bciYqvgQiS6a6urM7ul7NJV/+ZWrE3hz
	8QZRDoDdDM4CjP5Sj+aaoBp2afAjX+Qu0PwARc849o8NaxdDGbJymDBmyCKy+sV+a09N
	8LZi6iQ++i4dyz7UEGRZWLCx+i6XNRrFJMK7d1F44BFqlPL8/mNOI5nChJO+lwYQF/+b
	kgwA==
X-Gm-Message-State: APjAAAX2s1BCyqL5flZ3Cnud9y5OGtFIwvWf4W0NUxn1rO7r2kZkITaY
	todLzxBeCFY34TEKMKXtUira7oxG
X-Google-Smtp-Source: APXvYqy+iD8SNsnJ7Hu37Q6WNTS6NRNZ7uDYXSWz2w4An0imOwSYf1DBJxySRUohklVJIeqw/rB2nA==
X-Received: by 2002:adf:fe41:: with SMTP id m1mr14650148wrs.220.1554624797935; 
	Sun, 07 Apr 2019 01:13:17 -0700 (PDT)
Received: from [192.168.1.29] ([192.116.94.220])
	by smtp.gmail.com with ESMTPSA id
	b10sm41331981wrt.86.2019.04.07.01.13.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 Apr 2019 01:13:17 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>
References: <20190403113343.26384-1-kamalheib1@gmail.com>
	<20190403113343.26384-2-kamalheib1@gmail.com>
	<20190403180522.GA3446@lap1>
From: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <7acea8a2-36a1-c9aa-1467-2be7a2f5f3f0@gmail.com>
Date: Sun, 7 Apr 2019 11:13:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403180522.GA3446@lap1>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/rdma: Add SRQ support to backend
 layer
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407081315.na7s3Qqw7HyNNQ6BjZpAc6no6Uu7HyJI1TrXIptsZLM@z>



On 4/3/19 9:05 PM, Yuval Shaia wrote:
> On Wed, Apr 03, 2019 at 02:33:40PM +0300, Kamal Heib wrote:
>> Add the required functions and definitions to support shared receive
>> queues (SRQs) in the backend layer.
>>
>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> ---
>>  hw/rdma/rdma_backend.c      | 116 +++++++++++++++++++++++++++++++++++-
>>  hw/rdma/rdma_backend.h      |  12 ++++
>>  hw/rdma/rdma_backend_defs.h |   5 ++
>>  hw/rdma/rdma_rm.c           |   2 +
>>  hw/rdma/rdma_rm_defs.h      |   1 +
>>  5 files changed, 134 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index d1660b6474fa..04dfd63a573b 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -40,6 +40,7 @@ typedef struct BackendCtx {
>>      void *up_ctx;
>>      struct ibv_sge sge; /* Used to save MAD recv buffer */
>>      RdmaBackendQP *backend_qp; /* To maintain recv buffers */
>> +    RdmaBackendSRQ *backend_srq;
>>  } BackendCtx;
>>  
>>  struct backend_umad {
>> @@ -99,6 +100,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>>      int i, ne, total_ne = 0;
>>      BackendCtx *bctx;
>>      struct ibv_wc wc[2];
>> +    RdmaProtectedGSList *cqe_ctx_list;
>>  
>>      qemu_mutex_lock(&rdma_dev_res->lock);
>>      do {
>> @@ -116,8 +118,13 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>>  
>>              comp_handler(bctx->up_ctx, &wc[i]);
>>  
>> -            rdma_protected_gslist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
>> -                                               wc[i].wr_id);
>> +            if (bctx->backend_qp) {
>> +                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
>> +            } else {
>> +                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
>> +            }
>> +
>> +            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
>>              rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
>>              g_free(bctx);
>>          }
>> @@ -662,6 +669,60 @@ err_free_bctx:
>>      g_free(bctx);
>>  }
>>  
>> +void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>> +                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
>> +                                uint32_t num_sge, void *ctx)
>> +{
>> +    BackendCtx *bctx;
>> +    struct ibv_sge new_sge[MAX_SGE];
>> +    uint32_t bctx_id;
>> +    int rc;
>> +    struct ibv_recv_wr wr = {}, *bad_wr;
>> +
>> +    bctx = g_malloc0(sizeof(*bctx));
>> +    bctx->up_ctx = ctx;
>> +    bctx->backend_srq = srq;
>> +
>> +    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
>> +    if (unlikely(rc)) {
>> +        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
>> +        goto err_free_bctx;
>> +    }
>> +
>> +    rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
>> +
>> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
>> +                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>> +    if (rc) {
>> +        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
>> +        goto err_dealloc_cqe_ctx;
>> +    }
>> +
>> +    wr.num_sge = num_sge;
>> +    wr.sg_list = new_sge;
>> +    wr.wr_id = bctx_id;
>> +    rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
>> +    if (rc) {
>> +        rdma_error_report("ibv_post_srq_recv fail, srqn=0x%x, rc=%d, errno=%d",
>> +                          srq->ibsrq->handle, rc, errno);
>> +        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
>> +        goto err_dealloc_cqe_ctx;
>> +    }
>> +
>> +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
>> +    backend_dev->rdma_dev_res->stats.rx_bufs++;
>> +    backend_dev->rdma_dev_res->stats.rx_srq++;
> 
> You should update function rdma_dump_device_counters with this new
> counter.
> 
>> +
>> +    return;
>> +
>> +err_dealloc_cqe_ctx:
>> +    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
>> +    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
>> +
>> +err_free_bctx:
>> +    g_free(bctx);
>> +}
>> +
>>  int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
>>  {
>>      pd->ibpd = ibv_alloc_pd(backend_dev->context);
>> @@ -938,6 +999,55 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
>>      rdma_protected_gslist_destroy(&qp->cqe_ctx_list);
>>  }
>>  
>> +int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
>> +                            uint32_t max_wr, uint32_t max_sge,
>> +                            uint32_t srq_limit)
>> +{
>> +    struct ibv_srq_init_attr srq_init_attr = {};
>> +
>> +    srq_init_attr.attr.max_wr = max_wr;
>> +    srq_init_attr.attr.max_sge = max_sge;
>> +    srq_init_attr.attr.srq_limit = srq_limit;
>> +
>> +    srq->ibsrq = ibv_create_srq(pd->ibpd, &srq_init_attr);
>> +    if (!srq->ibsrq) {
>> +        rdma_error_report("ibv_create_srq failed, errno=%d", errno);
>> +        return -EIO;
>> +    }
>> +
>> +    rdma_protected_gslist_init(&srq->cqe_ctx_list);
>> +
>> +    return 0;
>> +}
>> +
>> +int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr)
>> +{
>> +    if (!srq->ibsrq) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ibv_query_srq(srq->ibsrq, srq_attr);
>> +}
>> +
>> +int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
>> +                int srq_attr_mask)
>> +{
>> +    if (!srq->ibsrq) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ibv_modify_srq(srq->ibsrq, srq_attr, srq_attr_mask);
>> +}
>> +
>> +void rdma_backend_destroy_srq(RdmaBackendSRQ *srq, RdmaDeviceResources *dev_res)
>> +{
>> +    if (srq->ibsrq) {
>> +        ibv_destroy_srq(srq->ibsrq);
>> +    }
>> +    g_slist_foreach(srq->cqe_ctx_list.list, free_cqe_ctx, dev_res);
>> +    rdma_protected_gslist_destroy(&srq->cqe_ctx_list);
>> +}
>> +
>>  #define CHK_ATTR(req, dev, member, fmt) ({ \
>>      trace_rdma_check_dev_attr(#member, dev.member, req->member); \
>>      if (req->member > dev.member) { \
>> @@ -960,6 +1070,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
>>      }
>>  
>>      dev_attr->max_sge = MAX_SGE;
>> +    dev_attr->max_srq_sge = MAX_SGE;
>>  
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
>> @@ -970,6 +1081,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
>>      CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
>> +    CHK_ATTR(dev_attr, bk_dev_attr, max_srq, "%d");
>>  
>>      return 0;
>>  }
>> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
>> index 38056d97c7fc..cad7956d98e8 100644
>> --- a/hw/rdma/rdma_backend.h
>> +++ b/hw/rdma/rdma_backend.h
>> @@ -114,4 +114,16 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>>                              RdmaBackendQP *qp, uint8_t qp_type,
>>                              struct ibv_sge *sge, uint32_t num_sge, void *ctx);
>>  
>> +int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
>> +                            uint32_t max_wr, uint32_t max_sge,
>> +                            uint32_t srq_limit);
>> +int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr);
>> +int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
>> +                            int srq_attr_mask);
>> +void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,
>> +                              RdmaDeviceResources *dev_res);
>> +void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
>> +                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
>> +                                uint32_t num_sge, void *ctx);
>> +
>>  #endif
>> diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
>> index 817153dc8cf4..0b55be35038d 100644
>> --- a/hw/rdma/rdma_backend_defs.h
>> +++ b/hw/rdma/rdma_backend_defs.h
>> @@ -68,4 +68,9 @@ typedef struct RdmaBackendQP {
>>      RdmaProtectedGSList cqe_ctx_list;
>>  } RdmaBackendQP;
>>  
>> +typedef struct RdmaBackendSRQ {
>> +    struct ibv_srq *ibsrq;
>> +    RdmaProtectedGSList cqe_ctx_list;
>> +} RdmaBackendSRQ;
>> +
>>  #endif
>> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
>> index bac3b2f4a6c3..b683506b8616 100644
>> --- a/hw/rdma/rdma_rm.c
>> +++ b/hw/rdma/rdma_rm.c
>> @@ -37,6 +37,8 @@ void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res)
>>                     dev_res->stats.tx_err);
>>      monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
>>                     dev_res->stats.rx_bufs);
>> +    monitor_printf(mon, "\trx_srq           : %" PRId64 "\n",
>> +                   dev_res->stats.rx_srq);
>>      monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
>>                     dev_res->stats.rx_bufs_len);
>>      monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
>> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
>> index c200d311de37..e774af528022 100644
>> --- a/hw/rdma/rdma_rm_defs.h
>> +++ b/hw/rdma/rdma_rm_defs.h
>> @@ -106,6 +106,7 @@ typedef struct RdmaRmStats {
>>      uint64_t rx_bufs;
>>      uint64_t rx_bufs_len;
>>      uint64_t rx_bufs_err;
>> +    uint64_t rx_srq;
>>      uint64_t completions;
>>      uint64_t mad_tx;
>>      uint64_t mad_tx_err;
> 
> Please make a separate patch to update the function
> rdma_dump_device_counters.
> 

You mean a separate patch for introducing the "rx_srq" counter & update the
function rdma_dump_device_counters()?

> Besides that patch lgtm.
> 
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> 
>> -- 
>> 2.20.1
>>
>>

