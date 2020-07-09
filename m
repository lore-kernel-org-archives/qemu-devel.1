Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1EC2076A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRzsXl73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1EC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtRxP-0004IC-KE
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtRwW-0003Oq-Pg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:30:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtRwU-0008Af-7V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594283404;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OF1EmsRNpFf8YfEColzaZAya3nk/R5BNnKhMx7BEZn8=;
 b=bRzsXl73fQ5n+3Bm148S8KXutMqDxpbL1yHP8Y6q5ey7gObWHo6UfW4k3Sti7dpDZicm6G
 WbI8dY3YBNP1i4nLpKsHSblU0Z6niPwPqk9WnXWd2zrKEb0WWg5R9UNBUdeGkwOAQx0PW5
 khcoDzPozpzoIISuSmY1pP1ahF3t1Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-QtVTxnrpNBqN9WegqOe2-A-1; Thu, 09 Jul 2020 04:30:03 -0400
X-MC-Unique: QtVTxnrpNBqN9WegqOe2-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29281087;
 Thu,  9 Jul 2020 08:30:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E40079814;
 Thu,  9 Jul 2020 08:29:57 +0000 (UTC)
Date: Thu, 9 Jul 2020 09:29:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/2] util/qemu-sockets: make keep-alive enabled by default
Message-ID: <20200709082954.GD3753300@redhat.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200708191540.28455-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200708191540.28455-3-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: den@openvz.org, kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 10:15:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Keep-alive won't hurt, let's try to enable it even if not requested by
> user.

Keep-alive intentionally breaks TCP connections earlier than normal
in face of transient networking problems.

The question is more about which type of pain is more desirable. A
stall in the network connection (for a potentially very long time),
or an intentionally broken socket.

I'm not at all convinced it is a good idea to intentionally break
/all/ QEMU sockets in the face of transient problems, even if the
problems last for 2 hours or more. 

I could see keep-alives being ok on some QEMU socket. For example
VNC/SPICE clients, as there is no downside to proactively culling
them as they can trivially reconnect. Migration too is quite
reasonable to use keep alives, as you generally want migration to
run to completion in a short amount of time, and aborting migration
needs to be safe no matter what.

Breaking chardevs or block devices or network devices that use
QEMU sockets though will be disruptive. The only solution once
those backends have a dead socket is going to be to kill QEMU
and cold-boot the VM again.


> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  util/qemu-sockets.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index b961963472..f6851376f5 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -438,7 +438,8 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
>   *
>   * Handle keep_alive settings. If user specified settings explicitly, fail if
>   * can't set the settings. If user just enabled keep-alive, not specifying the
> - * settings, try to set defaults but ignore failures.
> + * settings, try to set defaults but ignore failures. If keep-alive option is
> + * not specified, try to set it but ignore failures.
>   */
>  static int inet_set_keepalive(int sock, bool has_keep_alive,
>                                KeepAliveField *keep_alive, Error **errp)
> @@ -447,8 +448,8 @@ static int inet_set_keepalive(int sock, bool has_keep_alive,
>      int val;
>      bool has_settings = has_keep_alive &&  keep_alive->type == QTYPE_QDICT;
>  
> -    if (!has_keep_alive || (keep_alive->type == QTYPE_QBOOL &&
> -                            !keep_alive->u.enabled))
> +    if (has_keep_alive &&
> +        keep_alive->type == QTYPE_QBOOL && !keep_alive->u.enabled)
>      {
>          return 0;
>      }
> @@ -456,8 +457,12 @@ static int inet_set_keepalive(int sock, bool has_keep_alive,
>      val = 1;
>      ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &val, sizeof(val));
>      if (ret < 0) {
> -        error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> -        return -1;
> +        if (has_keep_alive) {
> +            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> +            return -1;
> +        } else {
> +            return 0;
> +        }
>      }
>  
>      val = has_settings ? keep_alive->u.settings.idle : 30;
> -- 
> 2.21.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


