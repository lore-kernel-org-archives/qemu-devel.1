Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B1FC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F2920872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F2920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7isO-0001lz-Ln
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ilq-0003QV-6h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ilp-0004uO-5y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7ilm-0004sy-UP; Tue, 10 Sep 2019 12:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 442B2A2666B;
 Tue, 10 Sep 2019 16:13:30 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C94A7608C2;
 Tue, 10 Sep 2019 16:13:28 +0000 (UTC)
Message-ID: <2950af747f11289fd4a36d2833c6abda6412db1e.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:13:27 +0300
In-Reply-To: <20190910124136.10565-8-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-8-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 10 Sep 2019 16:13:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/7] curl: Check
 curl_multi_add_handle()'s return code
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
> If we had done that all along, debugging would have been much simpler.
> (Also, I/O errors are better than hangs.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index c343c7ed3d..f86299378e 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -882,7 +882,13 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>      trace_curl_setup_preadv(acb->bytes, start, state->range);
>      curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
>  
> -    curl_multi_add_handle(s->multi, state->curl);
> +    if (curl_multi_add_handle(s->multi, state->curl) != CURLM_OK) {
> +        state->acb[0] = NULL;
> +        acb->ret = -EIO;
> +
> +        curl_clean_state(state);
> +        goto out;
> +    }
>  
>      /* Tell curl it needs to kick things off */
>      curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);

Checking the return values is always a very good idea.
I would myself make this patch #1 in the series, since it doesn't
depend on others and it itself a bugfix.
But this is my style, so I don't mind if you leave this as is.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


