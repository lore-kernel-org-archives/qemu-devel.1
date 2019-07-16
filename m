Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE50C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E9B2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E9B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHVr-0004bJ-SU
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnHVf-00048S-4r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnHVc-0005Ib-Ug
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:04:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnHVc-0005IB-O4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:04:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so19694505wru.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gn57iEhU6jJTpDT745AoeykH0/RgdSScQSuAEf5rmnc=;
 b=fb9Qvn6Hp0I8pp+aUku1Ez+J3GpBvWC2IT9v4P72RgBAadi4dMYjFe2hgzKGEi308O
 SiViZQyZLt1Xuno43TDdhCI22Tu2XkHOILytjQsAGeLhowowM/LQ1GgSfgFYwsIrJzdA
 ap+ddyFxIVclsl0qwbM5wOx2dJgR1rVkZk0BDoWfhAP2jLe23fNivL3iPonixvSzOvtj
 gIh+22awySvTQCn5nDQOVTUMcZf/rr9MZIoDH7t2Hk8KFPYXubb9pre9KwugtDZqC0Oc
 /N+6rLbUIrg9Xii+NpKk7HOhGg+SlY3c5ef0WWIcU1qdS2OXGlkjM2YysouFEO4kVAo9
 bCMg==
X-Gm-Message-State: APjAAAX5dXvTOSPwpU1BXWB6LBwzVVHFqULiBTg0YE+u92ZwXAUNnRMv
 6qbnFGYl0BhYs6DxmItQVFGv+A==
X-Google-Smtp-Source: APXvYqwU7tKzCj95FhDoWXqDFljV1REfQs/07H/52vmwGQqgj1/xZzomdTLiEwOcrCocoaluQwrgpA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr32893145wrn.257.1563260659774; 
 Tue, 16 Jul 2019 00:04:19 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id i66sm33588648wmi.11.2019.07.16.00.04.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 00:04:19 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190715201950.9444-1-stefanha@redhat.com>
 <20190715201950.9444-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c8abb738-fff2-6fb8-c14e-a6afc48d20e9@redhat.com>
Date: Tue, 16 Jul 2019 09:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715201950.9444-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 1/3] block/io_uring: add submission and
 completion trace events
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
> It is useful to follow individual requests as they are submitted.  Add
> trace events that show details of each request.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  block/io_uring.c   | 5 +++++
>  block/trace-events | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/block/io_uring.c b/block/io_uring.c
> index 22e8d3d9ca..19919da4c9 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -128,6 +128,8 @@ static void luring_process_completions(LuringState *s)
>          LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
>          ret = cqes->res;
>  
> +        trace_luring_process_completion(s, luringcb, ret);
> +
>          if (ret == luringcb->qiov->size) {
>              ret = 0;
>          } else if (ret >= 0) {
> @@ -233,6 +235,7 @@ static int ioq_submit(LuringState *s)
>              QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
>          }
>          ret = io_uring_submit(&s->ring);
> +        trace_luring_io_uring_submit(s, ret);
>          /* Prevent infinite loop if submission is refused */
>          if (ret <= 0) {
>              if (ret == -EAGAIN) {
> @@ -339,6 +342,8 @@ int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
>          .is_read    = (type == QEMU_AIO_READ),
>      };
>  
> +    trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->size : 0, type);
> +
>      ret = luring_do_submit(fd, &luringcb, s, offset, type);
>      if (ret < 0) {
>          return ret;
> diff --git a/block/trace-events b/block/trace-events
> index 069779773b..02952fe4cb 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -67,6 +67,9 @@ luring_io_plug(void *s) "LuringState %p plug"
>  luring_io_unplug(void *s, int blocked, int plugged, int queued, int inflight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
>  luring_do_submit(void *s, int blocked, int plugged, int queued, int inflight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
>  luring_do_submit_done(void *s, int ret) "LuringState %p submitted to kernel %d"
> +luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t offset, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRId64 " nbytes %zd type %d"
> +luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p luringcb %p ret %d"
> +luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
>  
>  # qcow2.c
>  qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
> 

