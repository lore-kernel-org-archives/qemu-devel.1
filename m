Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C2C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C0F206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C0F206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzsm-0002Xx-DQ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIzfq-0004LP-B4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIzfn-0001va-Q5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iIzfn-0001ui-KE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57A0130715F9;
 Fri, 11 Oct 2019 18:29:54 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA2E25D6C8;
 Fri, 11 Oct 2019 18:29:53 +0000 (UTC)
Subject: Re: [RFC v5 003/126] error: rename errp to errp_in where it is
 IN-argument
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9f23dc4a-92e5-003e-ac3b-16a91df6df17@redhat.com>
Date: Fri, 11 Oct 2019 13:29:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 11 Oct 2019 18:29:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 11:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
> pointer to NULL-initialized pointer, or pointer to error_abort or
> error_fatal, for callee to report error.
> 
> But very few functions instead get Error **errp as IN-argument:
> it's assumed to be set (or, maybe, NULL), and callee should clean it,
> or add some information.
> 
> In such cases, rename errp to errp_in.
> 
> This patch updates only error API functions. There still a few
> functions with errp-in semantics, they will be updated in further
> commits.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/qapi/error.h |  8 ++++----
>   util/error.c         | 30 +++++++++++++++---------------
>   2 files changed, 19 insertions(+), 19 deletions(-)
> 

> +++ b/include/qapi/error.h
> @@ -233,13 +233,13 @@ void error_propagate_prepend(Error **dst_errp, Error *local_err,
>    * Prepend some text to @errp's human-readable error message.
>    * The text is made by formatting @fmt, @ap like vprintf().
>    */
> -void error_vprepend(Error **errp, const char *fmt, va_list ap);
> +void error_vprepend(Error **errp_in, const char *fmt, va_list ap);

Fails to update the comment.

>   
>   /*
>    * Prepend some text to @errp's human-readable error message.
>    * The text is made by formatting @fmt, ... like printf().
>    */
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error **errp_in, const char *fmt, ...)

and again

>       GCC_FMT_ATTR(2, 3);
>   
>   /*
> @@ -256,7 +256,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
>    * May be called multiple times.  The resulting hint should end with a
>    * newline.
>    */
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error **errp_in, const char *fmt, ...)
>       GCC_FMT_ATTR(2, 3);
>   
>   /*
> @@ -283,7 +283,7 @@ void error_free(Error *err);
>   /*
>    * Convenience function to assert that *@errp is set, then silently free it.
>    */
> -void error_free_or_abort(Error **errp);
> +void error_free_or_abort(Error **errp_in);

and again.

Otherwise makes sense; if matching comments are the only things changed,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

