Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DADC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D1420880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D1420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHgD-00016x-Qy
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnHg1-0000dG-Cr
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnHfz-0004Dc-Vf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:15:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnHfz-0004C7-Po
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:15:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so7117828wmc.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l8+mVCaD5gL2fPAONOkZPMRmql+fdDsXZHSZZN0FC9c=;
 b=lbjHR4ftv5wYsDgH3PPNbbX5eihs4tRCC3W5EvddLKQL+IuKR9kQHvBxwGYde5yORc
 qwHxv4PgPGE6pWagJ6sg4N4aUdDIOXJisHUpRlRzYKGMmwrVIbXSXl3yw+i9rvEXQyOc
 voqZ5UK/qrVkE0Oo5GmfRz+IwR9CtUw6x5Mgt0IKUkvDM+3PeGChgLsP8p2gEVU2P+Xv
 Rmvf1xecHJFYJ/IIvmXOZwaTMqmlgDEpJ7JJm9zumQXbx15BnrvzWI17uUDGRvHTpX0c
 nP+vRZ0rKmxykvAqjdVSaVQMnPzspK/I8M73UDkz4MlN3nQIyvJ20ZMLEOec3lQYa3/i
 7E7w==
X-Gm-Message-State: APjAAAV7Lu2g/zO9MtQ/hkxwds8Q4CJkFWS4r2AA65+dCgJHDgCVdvKp
 M7WaCX1qhPkkk9PFrGAUTyLvqA==
X-Google-Smtp-Source: APXvYqxAbrCVGI/wgpz6ytiBLUR7ph6vVPq28aCLOvdbb4FeO9pYOiFnI9HSuzSNVybbQXECmETZTQ==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr27513004wma.23.1563261302067; 
 Tue, 16 Jul 2019 00:15:02 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id e3sm17839484wrs.37.2019.07.16.00.15.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 00:15:01 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190715201950.9444-1-stefanha@redhat.com>
 <20190715201950.9444-4-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <acff5baf-ddbf-ff4d-2188-4aff9c539211@redhat.com>
Date: Tue, 16 Jul 2019 09:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715201950.9444-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 3/3] block/io_uring: resubmit short
 buffered reads
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
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefan@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 10:19 PM, Stefan Hajnoczi wrote:
> The io_uring API had unusual read behavior up until recently, where
> short reads could occur when the start of the file range was in the page
> cache and a later portion was not in the page cache.  Normally read(2)
> does not expose this detail to applications and this behavior has been
> fixed in Linux commit 9d93a3f5a0c ("io_uring: punt short reads to async
> * context").
> 
> In the meantime Linux distros have shipped kernels where io_uring
> exhibits the old behavior and there is no simple way to detect it.
> 
> Add a slow path for resubmitting short read requests.  The idea is
> simple: shorten the iovecs and increment the file offset each time a
> short read occurs and then resubmit the request.  The implementation
> requires adding additional fields to LuringAIOCB to keep track of where
> we were.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/io_uring.c   | 75 +++++++++++++++++++++++++++++++++++++++-------
>  block/trace-events |  3 +-
>  2 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/block/io_uring.c b/block/io_uring.c
> index 97e4f876d7..12cef71175 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -28,6 +28,12 @@ typedef struct LuringAIOCB {
>      QEMUIOVector *qiov;
>      bool is_read;
>      QSIMPLEQ_ENTRY(LuringAIOCB) next;
> +
> +    /* Buffered reads may require resubmission, see
> +     * luring_resubmit_short_read().
> +     */
> +    int total_read;
> +    QEMUIOVector resubmit_qiov;
>  } LuringAIOCB;
>  
>  typedef struct LuringQueue {
> @@ -99,6 +105,43 @@ static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
>      s->io_q.in_queue++;
>  }
>  
> +/* Before Linux commit 9d93a3f5a0c ("io_uring: punt short reads to async
> + * context") a buffered I/O request with the start of the file range in the
> + * page cache could result in a short read.  Applications need to resubmit the
> + * remaining read request.
> + *
> + * This is a slow path but recent kernels never take it.
> + */
> +static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luringcb,
> +                                       int nread)
> +{
> +    QEMUIOVector *resubmit_qiov;
> +    size_t remaining;
> +
> +    trace_luring_resubmit_short_read(s, luringcb, nread);
> +
> +    /* Update read position */
> +    luringcb->total_read += nread;
> +    remaining = luringcb->qiov->size - luringcb->total_read;
> +
> +    /* Shorten qiov */
> +    resubmit_qiov = &luringcb->resubmit_qiov;
> +    if (resubmit_qiov->iov == NULL) {
> +        qemu_iovec_init(resubmit_qiov, luringcb->qiov->niov);
> +    } else {
> +        qemu_iovec_reset(resubmit_qiov);
> +    }
> +    qemu_iovec_concat(resubmit_qiov, luringcb->qiov, luringcb->total_read,
> +                      remaining);
> +
> +    /* Update sqe */
> +    luringcb->sqeq.off += nread;
> +    luringcb->sqeq.addr = (__u64)(uintptr_t)luringcb->resubmit_qiov.iov;
> +    luringcb->sqeq.len = luringcb->resubmit_qiov.niov;
> +
> +    luring_resubmit(s, luringcb);
> +}
> +
>  /**
>   * luring_process_completions:
>   * @s: AIO state
> @@ -135,6 +178,7 @@ static void luring_process_completions(LuringState *s)
>      while (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
>          LuringAIOCB *luringcb;
>          int ret;
> +        int total_bytes;
>  
>          if (!cqes) {
>              break;
> @@ -150,25 +194,36 @@ static void luring_process_completions(LuringState *s)
>  
>          trace_luring_process_completion(s, luringcb, ret);
>  
> -        if (ret == luringcb->qiov->size) {
> +        /* total_read is non-zero only for resubmitted read requests */
> +        total_bytes = ret + luringcb->total_read;
> +
> +        if (ret < 0) {
> +            if (ret == -EINTR) {
> +                luring_resubmit(s, luringcb);
> +                continue;
> +            }

Else fail with ret = -errno. OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        } else if (total_bytes == luringcb->qiov->size) {
>              ret = 0;
> -        } else if (ret >= 0) {
> +        } else {
>              /* Short Read/Write */
>              if (luringcb->is_read) {
> -                /* Read, pad with zeroes */
> -                qemu_iovec_memset(luringcb->qiov, ret, 0,
> -                luringcb->qiov->size - ret);
> -                ret = 0;
> +                if (ret > 0) {
> +                    luring_resubmit_short_read(s, luringcb, ret);
> +                    continue;
> +                } else {
> +                    /* Pad with zeroes */
> +                    qemu_iovec_memset(luringcb->qiov, total_bytes, 0,
> +                                      luringcb->qiov->size - total_bytes);
> +                    ret = 0;
> +                }
>              } else {
>                  ret = -ENOSPC;;
>              }
> -        /* Add to overflow queue to be resubmitted later */
> -        } else if (ret == -EINTR) {
> -            luring_resubmit(s, luringcb);
> -            continue;
>          }
>          luringcb->ret = ret;
>  
> +        qemu_iovec_destroy(&luringcb->resubmit_qiov);
> +
>          /*
>           * If the coroutine is already entered it must be in ioq_submit()
>           * and will notice luringcb->ret has been filled in when it
> diff --git a/block/trace-events b/block/trace-events
> index 02952fe4cb..f434cac634 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -60,7 +60,7 @@ qmp_block_stream(void *bs) "bs %p"
>  file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
>  file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
>  
> -#io_uring.c
> +# io_uring.c

(left over from patch #1)

>  luring_init_state(void *s, size_t size) "s %p size %zu"
>  luring_cleanup_state(void *s) "%p freed"
>  luring_io_plug(void *s) "LuringState %p plug"
> @@ -70,6 +70,7 @@ luring_do_submit_done(void *s, int ret) "LuringState %p submitted to kernel %d"
>  luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t offset, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRId64 " nbytes %zd type %d"
>  luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p luringcb %p ret %d"
>  luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
> +luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringState %p luringcb %p nread %d"
>  
>  # qcow2.c
>  qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
> 

