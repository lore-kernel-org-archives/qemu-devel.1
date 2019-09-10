Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC7C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6AA2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6AA2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7imN-0003gn-2W
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ikt-0002EX-GD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7iks-0004O9-Ft
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:12:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7ikq-0004Mc-5M; Tue, 10 Sep 2019 12:12:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75745356CE;
 Tue, 10 Sep 2019 16:12:31 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04C7E608C2;
 Tue, 10 Sep 2019 16:12:29 +0000 (UTC)
Message-ID: <05d1d6011313548d8444426168aafad82f8b835a.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:12:29 +0300
In-Reply-To: <20190910124136.10565-6-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-6-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 10 Sep 2019 16:12:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 5/7] curl: Report only
 ready sockets
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
> Instead of reporting all sockets to cURL, only report the one that has
> caused curl_multi_do_locked() to be called.  This lets us get rid of the
> QLIST_FOREACH_SAFE() list, which was actually wrong: SAFE foreaches are
> only safe when the current element is removed in each iteration.  If it
> possible for the list to be concurrently modified, we cannot guarantee
> that only the current element will be removed.  Therefore, we must not
> use QLIST_FOREACH_SAFE() here.
> 
> Fixes: ff5ca1664af85b24a4180d595ea6873fd3deac57
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index cf2686218d..fd70f1ebc4 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -392,24 +392,19 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>  }
>  
>  /* Called with s->mutex held.  */
> -static void curl_multi_do_locked(CURLSocket *ready_socket)
> +static void curl_multi_do_locked(CURLSocket *socket)
Here you revert the variable name change you had in previous commit

>  {
> -    CURLSocket *socket, *next_socket;
> -    CURLState *s = ready_socket->state;
> +    BDRVCURLState *s = socket->state->s;
>      int running;
>      int r;
>  
> -    if (!s->s->multi) {
> +    if (!s->multi) {
>          return;
>      }
>  
> -    /* Need to use _SAFE because curl_multi_socket_action() may trigger
> -     * curl_sock_cb() which might modify this list */
> -    QLIST_FOREACH_SAFE(socket, &s->sockets, next, next_socket) {
> -        do {
> -            r = curl_multi_socket_action(s->s->multi, socket->fd, 0, &running);
> -        } while (r == CURLM_CALL_MULTI_PERFORM);
> -    }
> +    do {
> +        r = curl_multi_socket_action(s->multi, socket->fd, 0, &running);
> +    } while (r == CURLM_CALL_MULTI_PERFORM);
>  }
>  
>  static void curl_multi_do(void *arg)

Other than that nitpick,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


