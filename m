Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B648C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B0D2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B0D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ilr-0002w1-2d
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ijw-00018C-Kz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ijv-0003vc-Lf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7ijt-0003uU-K2; Tue, 10 Sep 2019 12:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0BB48980F1;
 Tue, 10 Sep 2019 16:11:32 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4785D6C8;
 Tue, 10 Sep 2019 16:11:31 +0000 (UTC)
Message-ID: <d8567e84432ee8346788a8eaf38020408e7a9fcf.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:11:30 +0300
In-Reply-To: <20190910124136.10565-3-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-3-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 10 Sep 2019 16:11:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/7] curl: Keep *socket
 until the end of curl_sock_cb()
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
> This does not really change anything, but it makes the code a bit easier
> to follow once we use @socket as the opaque pointer for
> aio_set_fd_handler().
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 92dc2f630e..95d7b77dc0 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -172,10 +172,6 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>  
>      QLIST_FOREACH(socket, &state->sockets, next) {
>          if (socket->fd == fd) {
> -            if (action == CURL_POLL_REMOVE) {
> -                QLIST_REMOVE(socket, next);
> -                g_free(socket);
> -            }
>              break;
>          }
>      }
> @@ -185,7 +181,6 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>          socket->state = state;
>          QLIST_INSERT_HEAD(&state->sockets, socket, next);
>      }
> -    socket = NULL;
>  
>      trace_curl_sock_cb(action, (int)fd);
>      switch (action) {
> @@ -207,6 +202,11 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>              break;
>      }
>  
> +    if (action == CURL_POLL_REMOVE) {
> +        QLIST_REMOVE(socket, next);
> +        g_free(socket);
> +    }
> +
>      return 0;
>  }
>  
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


