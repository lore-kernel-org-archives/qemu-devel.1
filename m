Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A646C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F153C2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F153C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ine-0005B1-Op
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ikH-0001dx-Rm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ikG-00046T-Qu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7ikE-000436-CJ; Tue, 10 Sep 2019 12:11:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB618300DA2C;
 Tue, 10 Sep 2019 16:11:53 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A81C1001948;
 Tue, 10 Sep 2019 16:11:52 +0000 (UTC)
Message-ID: <781db018f83aa375b9a7476028c7ef8c4c24d848.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:11:51 +0300
In-Reply-To: <20190910124136.10565-4-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-4-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 10 Sep 2019 16:11:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/7] curl: Check completion
 in curl_multi_do()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-09-10 at 14:41 +0200, Max Reitz wrote:
> While it is more likely that transfers complete after some file
> descriptor has data ready to read, we probably should not rely on it.
> Better be safe than sorry and call curl_multi_check_completion() in
> curl_multi_do(), too, just like it is done in curl_multi_read().
> 
> With this change, curl_multi_do() and curl_multi_read() are actually the
> same, so drop curl_multi_read() and use curl_multi_do() as the sole FD
> handler.

I understand the reasoning, but I still a bit worry that this
could paper over some bug/race in the future.
If curl asks us only to deal with write, that would mean
that it doesn't expect any data to be received.

Do you by a chance have an example, of this patch
affecting the code? Maybe when a unexpected error reply
is received from the server?

I don't really know the CURL library, so I probably missed
something important.

Other than that,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky


> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 95d7b77dc0..5838afef99 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -139,7 +139,6 @@ typedef struct BDRVCURLState {
>  
>  static void curl_clean_state(CURLState *s);
>  static void curl_multi_do(void *arg);
> -static void curl_multi_read(void *arg);
>  
>  #ifdef NEED_CURL_TIMER_CALLBACK
>  /* Called from curl_multi_do_locked, with s->mutex held.  */
> @@ -186,7 +185,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>      switch (action) {
>          case CURL_POLL_IN:
>              aio_set_fd_handler(s->aio_context, fd, false,
> -                               curl_multi_read, NULL, NULL, state);
> +                               curl_multi_do, NULL, NULL, state);
>              break;
>          case CURL_POLL_OUT:
>              aio_set_fd_handler(s->aio_context, fd, false,
> @@ -194,7 +193,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>              break;
>          case CURL_POLL_INOUT:
>              aio_set_fd_handler(s->aio_context, fd, false,
> -                               curl_multi_read, curl_multi_do, NULL, state);
> +                               curl_multi_do, curl_multi_do, NULL, state);
>              break;
>          case CURL_POLL_REMOVE:
>              aio_set_fd_handler(s->aio_context, fd, false,
> @@ -416,15 +415,6 @@ static void curl_multi_do(void *arg)
>  {
>      CURLState *s = (CURLState *)arg;
>  
> -    qemu_mutex_lock(&s->s->mutex);
> -    curl_multi_do_locked(s);
> -    qemu_mutex_unlock(&s->s->mutex);
> -}
> -
> -static void curl_multi_read(void *arg)
> -{
> -    CURLState *s = (CURLState *)arg;
> -
>      qemu_mutex_lock(&s->s->mutex);
>      curl_multi_do_locked(s);
>      curl_multi_check_completion(s->s);



