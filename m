Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0475CC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54EA20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="LJMSRRgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54EA20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hag2y-0003rP-50
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fam@euphon.net>) id 1hafB1-0007N4-Bn
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fam@euphon.net>) id 1haf5H-0007Uy-Hc
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:37:01 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17730
 helo=sender1.zoho.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fam@euphon.net>)
 id 1haf5H-0007P6-6Z; Tue, 11 Jun 2019 07:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560252896; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=dxJSID7knp9U3eBWYQH17q954kEGkmICJjXbGBZ4TYgmMAria4hCqWykKKFKykIPacYqOgNUyTtJ15JnhRRfjjxujuyit6OyGhTuCdk2nnIUciloNH9MvxF8lEj0Afhg+4ycIaXpEf/GFnHYIKwvzw26zIcsVCWIRpjwpnjSl9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1560252896;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
 bh=x7XCjUnc7dQw9dAYIhA37DqnVnAWh9N0bJfkGXFsKiA=; 
 b=R3QhdYgBrTexxxfJeHsYBJNWg3ow2xMMGTXbzYx3WJbVOaiDL+hQziWR/M8ayiyPYv2g6Rqby1Y9YQkEtYiQ0E8ObdH4PEsPXZZubY3wfsJMm1NJyvoKDmO+sf0FqjPbIBDPGbaAf5MNiInnTE1AmWNzmJvcZGBLlA8It3HBX5s=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1560252896; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 l=3627; bh=x7XCjUnc7dQw9dAYIhA37DqnVnAWh9N0bJfkGXFsKiA=;
 b=LJMSRRgtjx17bh0AiJam1Ab993/RqGucGbE5TJf5gmMcogn6llLQglzVuvxA+c1D
 4RgTJgO3zl7PBixonnNARVyJWIfTcmHYP4nOWHV3WGHxC5n6f3ghvcihK6kiWNDQZGE
 daaBDkJ2YBzeEcfiKjEZJfzPNJvAKDjKywxVekao=
Received: from localhost (120.52.147.40 [120.52.147.40]) by mx.zoho.com.cn
 with SMTPS id 1560252894071543.9879006207103;
 Tue, 11 Jun 2019 19:34:54 +0800 (CST)
Date: Tue, 11 Jun 2019 19:34:52 +0800
From: Fam Zheng <fam@euphon.net>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611113452.v6frbexgoyfjzjh7@debian>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-10-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-10-mehta.aaru20@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.53.93.243
Subject: Re: [Qemu-devel] [PATCH v5 09/12] block: add trace events for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06/10 19:19, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  block/io_uring.c   | 14 ++++++++++++--
>  block/trace-events |  8 ++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io_uring.c b/block/io_uring.c
> index f327c7ef96..47e027364a 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -17,6 +17,7 @@
>  #include "block/raw-aio.h"
>  #include "qemu/coroutine.h"
>  #include "qapi/error.h"
> +#include "trace.h"
>  
>  #define MAX_EVENTS 128
>  
> @@ -191,12 +192,15 @@ static int ioq_submit(LuringState *s)
>  
>  void luring_io_plug(BlockDriverState *bs, LuringState *s)
>  {
> +    trace_luring_io_plug();
>      s->io_q.plugged++;
>  }
>  
>  void luring_io_unplug(BlockDriverState *bs, LuringState *s)
>  {
>      assert(s->io_q.plugged);
> +    trace_luring_io_unplug(s->io_q.blocked, s->io_q.plugged,
> +                                 s->io_q.in_queue, s->io_q.in_flight);
>      if (--s->io_q.plugged == 0 &&
>          !s->io_q.blocked && s->io_q.in_queue > 0) {
>          ioq_submit(s);
> @@ -217,6 +221,7 @@ void luring_io_unplug(BlockDriverState *bs, LuringState *s)
>  static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
>                              uint64_t offset, int type)
>  {
> +    int ret;
>      struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
>      if (!sqes) {
>          sqes = &luringcb->sqeq;
> @@ -242,11 +247,14 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
>      }
>      io_uring_sqe_set_data(sqes, luringcb);
>      s->io_q.in_queue++;
> -
> +    trace_luring_do_submit(s->io_q.blocked, s->io_q.plugged,
> +                           s->io_q.in_queue, s->io_q.in_flight);
>      if (!s->io_q.blocked &&
>          (!s->io_q.plugged ||
>           s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
> -        return ioq_submit(s);
> +        ret = ioq_submit(s);
> +        trace_luring_do_submit_done(ret);
> +        return ret;
>      }
>      return 0;
>  }
> @@ -294,6 +302,7 @@ LuringState *luring_init(Error **errp)
>      int rc;
>      LuringState *s;
>      s = g_malloc0(sizeof(*s));
> +    trace_luring_init_state((void *)s, sizeof(*s));

The pointer type cast is unnecessary.

>      struct io_uring *ring = &s->ring;
>      rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
>      if (rc < 0) {
> @@ -311,4 +320,5 @@ void luring_cleanup(LuringState *s)
>  {
>      io_uring_queue_exit(&s->ring);
>      g_free(s);
> +    trace_luring_cleanup_state();

Pass @s?

>  }
> diff --git a/block/trace-events b/block/trace-events
> index eab51497fc..c4564dcd96 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -60,6 +60,14 @@ qmp_block_stream(void *bs, void *job) "bs %p job %p"
>  file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
>  file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
>  
> +#io_uring.c
> +luring_init_state(void *s, size_t size) "s %p size %zu"
> +luring_cleanup_state(void) "s freed"
> +disable luring_io_plug(void) "plug"
> +disable luring_io_unplug(int blocked, int plugged, int queued, int inflight) "blocked %d plugged %d queued %d inflight %d"
> +disable luring_do_submit(int blocked, int plugged, int queued, int inflight) "blocked %d plugged %d queued %d inflight %d"
> +disable luring_do_submit_done(int ret) "submitted to kernel %d"
> +
>  # qcow2.c
>  qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
>  qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
> -- 
> 2.17.1
> 

Fam


