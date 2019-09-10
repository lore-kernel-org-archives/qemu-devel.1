Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADE5C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4598206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4598206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ilG-0002GG-MC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ijp-0000zs-Hs
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ijo-0003sY-Jw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7ijl-0003qP-5t; Tue, 10 Sep 2019 12:11:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1C763084242;
 Tue, 10 Sep 2019 16:11:22 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC9460BE2;
 Tue, 10 Sep 2019 16:11:18 +0000 (UTC)
Message-ID: <76b59f1a8e843f33e5c8152958cb8d4376f14162.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:11:17 +0300
In-Reply-To: <20190910124136.10565-2-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-2-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 10 Sep 2019 16:11:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/7] curl: Keep pointer to
 the CURLState in CURLSocket
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
> A follow-up patch will make curl_multi_do() and curl_multi_read() take a
> CURLSocket instead of the CURLState.  They still need the latter,
> though, so add a pointer to it to the former.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/curl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/curl.c b/block/curl.c
> index d4c8e94f3e..92dc2f630e 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -80,6 +80,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
>  #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
>  
>  struct BDRVCURLState;
> +struct CURLState;
>  
>  static bool libcurl_initialized;
>  
> @@ -97,6 +98,7 @@ typedef struct CURLAIOCB {
>  
>  typedef struct CURLSocket {
>      int fd;
> +    struct CURLState *state;
>      QLIST_ENTRY(CURLSocket) next;
>  } CURLSocket;
>  
> @@ -180,6 +182,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
>      if (!socket) {
>          socket = g_new0(CURLSocket, 1);
>          socket->fd = fd;
> +        socket->state = state;
>          QLIST_INSERT_HEAD(&state->sockets, socket, next);
>      }
>      socket = NULL;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


