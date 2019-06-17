Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9906C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A052089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A052089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrDp-0007mv-29
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcrCT-0007E4-6Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcrCS-0003M5-2q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcrCO-0003HA-IU; Mon, 17 Jun 2019 08:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3CFD356CA;
 Mon, 17 Jun 2019 12:57:12 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1423D39BE;
 Mon, 17 Jun 2019 12:56:56 +0000 (UTC)
Message-ID: <ce44f970d1ee2db407ab46a031e464ef44fd2d86.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:56:55 +0300
In-Reply-To: <20190610134905.22294-7-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-7-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 17 Jun 2019 12:57:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 06/12] util/async: add aio interfaces
 for io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/async.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/util/async.c b/util/async.c
> index c10642a385..2709f0edc3 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -277,6 +277,14 @@ aio_ctx_finalize(GSource     *source)
>      }
>  #endif
>  
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (ctx->linux_io_uring) {
> +        luring_detach_aio_context(ctx->linux_io_uring, ctx);
> +        luring_cleanup(ctx->linux_io_uring);
> +        ctx->linux_io_uring = NULL;
> +    }
> +#endif
> +
>      assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
>      qemu_bh_delete(ctx->co_schedule_bh);
>  
> @@ -341,6 +349,29 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>  }
>  #endif
>  
> +#ifdef CONFIG_LINUX_IO_URING
> +LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp)
> +{
> +    if (ctx->linux_io_uring) {
> +        return ctx->linux_io_uring;
> +    }
> +
> +    ctx->linux_io_uring = luring_init(errp);
> +    if (!ctx->linux_io_uring) {
> +        return NULL;
> +    }
> +
> +    luring_attach_aio_context(ctx->linux_io_uring, ctx);
> +    return ctx->linux_io_uring;
> +}
> +
> +LuringState *aio_get_linux_io_uring(AioContext *ctx)
> +{
> +    assert(ctx->linux_io_uring);
> +    return ctx->linux_io_uring;
> +}
> +#endif
> +
>  void aio_notify(AioContext *ctx)
>  {

Minor nitpick. Maybe we can memset all the private area of the AioContext to 0, 
and then setup the stuff that is not zero? That would remove most of the code below.
This is an old habit from the kernel code.

(I assume that g_source_new doesn't do this)


>      /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> @@ -432,6 +463,11 @@ AioContext *aio_context_new(Error **errp)
>  #ifdef CONFIG_LINUX_AIO
>      ctx->linux_aio = NULL;
>  #endif
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    ctx->linux_io_uring = NULL;
> +#endif
> +
>      ctx->thread_pool = NULL;
>      qemu_rec_mutex_init(&ctx->lock);
>      timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


