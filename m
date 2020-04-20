Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A10C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DFE2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ek8gpbx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DFE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSVU-0008P7-7O
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSUg-0007Zr-Tg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:13:35 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSUf-0000h6-RP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:13:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQSUf-0000fx-9p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587374011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubY2bmJgYQHcHmLxkew7vio3GmuwAAUYMniriQOb0x4=;
 b=ek8gpbx6JTFd6aCclqOMHnES+L+FDOKil0oq2fEu728kw5XfRPC6++B3xa1mw6HWaca5cT
 8NVU3DjW5z6W58+jIMBfMIv2+BVixJTSvA9JG4yqEIjneit3XYdCY+qAokQLZHJFvcFvhz
 f38iObHzoxm5lZfHrHwS1KK85GrWxM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-N5R3RApaMUCxNCsTiWId8w-1; Mon, 20 Apr 2020 05:13:27 -0400
X-MC-Unique: N5R3RApaMUCxNCsTiWId8w-1
Received: by mail-wm1-f70.google.com with SMTP id f128so3939888wmf.8
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ubY2bmJgYQHcHmLxkew7vio3GmuwAAUYMniriQOb0x4=;
 b=nP/Dek8O5YI21au8EqxPZe1v7ipb0I/XOtYJkPi+5nLgZ0QEtV3bm9lKXGeSl4F6s/
 uN+mZIxUFzgT6YAl0M1JEdp0D8ZdUWxsyCwOlv+06GVjduSXDKt+b6ilobsJH1jWOR93
 j1tLlmlkisTJlyJatxGLzCsE/ToXwxkM778jHicyNWOIQEBxf2hDXhNTYx9D6Qlz0nXe
 w1HqHs2FfKbXKsKwHwOp/6sY0TPAseFNi1HDEVhp3nLKQltnrts0PFFr1K5Lzgvbg2DP
 Y/8nL4jE9xcSlTMwnj4SbGEraqwom0ZcLkjiekIjXWQODR+Mmchln+wKNNsX6k/4vYVs
 a79g==
X-Gm-Message-State: AGi0PubWdz+O4kRrU/kWMkd47UuIFq/l++7UtJ7Lf4Pd7lkQyY91gnT7
 mbRJi2cj+fyACZQQBheQ2Ustw0/h1n7tDJNbMo1jncdaB2qHDcpUWrCqhSrUuXB0nE9Wlv0Ojsz
 E66xTrV1ygGZWJHo=
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr16825341wme.139.1587374005646; 
 Mon, 20 Apr 2020 02:13:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypLA5NHB9taU1vEcsSDxeATyJTJmGQc2TyjxdNTcpZsxVZkLIcLISYM+TgC0aYzssdBeSONA4w==
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr16825318wme.139.1587374005398; 
 Mon, 20 Apr 2020 02:13:25 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t2sm538057wmt.15.2020.04.20.02.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 02:13:24 -0700 (PDT)
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
To: Simran Singhal <singhalsimran0@gmail.com>, qemu-devel@nongnu.org
References: <20200402065035.GA15477@simran-Inspiron-5558>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ad94cef-d17b-8dde-c127-3be8e34508de@redhat.com>
Date: Mon, 20 Apr 2020 11:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402065035.GA15477@simran-Inspiron-5558>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 8:50 AM, Simran Singhal wrote:
> Replace manual lock()/unlock() calls with lock guard macros
> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---

You can give a hint to reviewers by adding:

This patch is based on:
"Replace locks with lock guard macros"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg694412.html

Similar hint to build bots:
Based-on: <20200404042108.389635-1-dnbrdsky@gmail.com>

You should Cc Paolo Bonzini on your v3, since he'll likely queue the 
base series.

Patch looks good otherwise.

> Changes in v2:
>          -Drop changes in file hw/rdma/rdma_utils.c
> 
>   hw/hyperv/hyperv.c     | 15 ++++++-------
>   hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>   hw/rdma/rdma_rm.c      |  3 +--
>   3 files changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 8ca3706f5b..4ddafe1de1 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -15,6 +15,7 @@
>   #include "sysemu/kvm.h"
>   #include "qemu/bitops.h"
>   #include "qemu/error-report.h"
> +#include "qemu/lockable.h"
>   #include "qemu/queue.h"
>   #include "qemu/rcu.h"
>   #include "qemu/rcu_queue.h"
> @@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>       int ret;
>       MsgHandler *mh;
>   
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>       QLIST_FOREACH(mh, &msg_handlers, link) {
>           if (mh->conn_id == conn_id) {
>               if (handler) {
> @@ -501,7 +502,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>                   g_free_rcu(mh, rcu);
>                   ret = 0;
>               }
> -            goto unlock;
> +            return ret;
>           }
>       }
>   
> @@ -515,8 +516,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>       } else {
>           ret = -ENOENT;
>       }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>       return ret;
>   }
>   
> @@ -565,7 +565,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>       int ret;
>       EventFlagHandler *handler;
>   
> -    qemu_mutex_lock(&handlers_mutex);
> +    QEMU_LOCK_GUARD(&handlers_mutex);
>       QLIST_FOREACH(handler, &event_flag_handlers, link) {
>           if (handler->conn_id == conn_id) {
>               if (notifier) {
> @@ -575,7 +575,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>                   g_free_rcu(handler, rcu);
>                   ret = 0;
>               }
> -            goto unlock;
> +            return ret;
>           }
>       }
>   
> @@ -588,8 +588,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>       } else {
>           ret = -ENOENT;
>       }
> -unlock:
> -    qemu_mutex_unlock(&handlers_mutex);
> +
>       return ret;
>   }
>   
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 3dd39fe1a7..db7e5c8be5 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -95,36 +95,36 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>       struct ibv_wc wc[2];
>       RdmaProtectedGSList *cqe_ctx_list;
>   
> -    qemu_mutex_lock(&rdma_dev_res->lock);
> -    do {
> -        ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
> +    WITH_QEMU_LOCK_GUARD(&rdma_dev_res->lock) {
> +        do {
> +            ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
>   
> -        trace_rdma_poll_cq(ne, ibcq);
> +            trace_rdma_poll_cq(ne, ibcq);
>   
> -        for (i = 0; i < ne; i++) {
> -            bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> -            if (unlikely(!bctx)) {
> -                rdma_error_report("No matching ctx for req %"PRId64,
> -                                  wc[i].wr_id);
> -                continue;
> -            }
> +            for (i = 0; i < ne; i++) {
> +                bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +                if (unlikely(!bctx)) {
> +                    rdma_error_report("No matching ctx for req %"PRId64,
> +                                      wc[i].wr_id);
> +                    continue;
> +                }
>   
> -            comp_handler(bctx->up_ctx, &wc[i]);
> +                comp_handler(bctx->up_ctx, &wc[i]);
>   
> -            if (bctx->backend_qp) {
> -                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
> -            } else {
> -                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
> -            }
> +                if (bctx->backend_qp) {
> +                    cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
> +                } else {
> +                    cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
> +                }
>   
> -            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
> -            rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> -            g_free(bctx);
> -        }
> -        total_ne += ne;
> -    } while (ne > 0);
> -    atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
> -    qemu_mutex_unlock(&rdma_dev_res->lock);
> +                rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
> +                rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> +                g_free(bctx);
> +            }
> +            total_ne += ne;
> +        } while (ne > 0);
> +        atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
> +    }
>   
>       if (ne < 0) {
>           rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 7e9ea283c9..60957f88db 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -147,14 +147,13 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
>   {
>       trace_rdma_res_tbl_dealloc(tbl->name, handle);
>   
> -    qemu_mutex_lock(&tbl->lock);
> +    QEMU_LOCK_GUARD(&tbl->lock);
>   
>       if (handle < tbl->tbl_sz) {
>           clear_bit(handle, tbl->bitmap);
>           tbl->used--;
>       }
>   
> -    qemu_mutex_unlock(&tbl->lock);
>   }
>   
>   int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
> 


