Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC1FC46470
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6893E20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6893E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqRa-0002kj-Da
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:20:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYqP7-0001Eu-FS
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYqP6-00025M-7N
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYqP6-00023s-0n
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E567E882FD;
	Thu,  6 Jun 2019 11:17:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F2DC66079;
	Thu,  6 Jun 2019 11:17:28 +0000 (UTC)
Date: Thu, 6 Jun 2019 12:17:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190606111725.GH14300@redhat.com>
References: <20190606101533.20228-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606101533.20228-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 06 Jun 2019 11:17:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: InitSocketAddress: add keepalive
 option
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: den@openvz.org, kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 06, 2019 at 01:15:33PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Hi all!
> 
> This is a continuation of "[PATCH v2 0/2] nbd: enable keepalive", but
> it's a try from another side, so almost nothing common with v2.
> 
> 
>  qapi/sockets.json   |  5 ++++-
>  util/qemu-sockets.c | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..aefa024051 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -53,6 +53,8 @@
>  #
>  # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and IPv6
>  #
> +# @keepalive: enable keepalive when connecting to this socket (Since 4.1)
> +#
>  # Since: 1.3
>  ##
>  { 'struct': 'InetSocketAddress',
> @@ -61,7 +63,8 @@
>      '*numeric':  'bool',
>      '*to': 'uint16',
>      '*ipv4': 'bool',
> -    '*ipv6': 'bool' } }
> +    '*ipv6': 'bool',
> +    '*keepalive': 'bool' } }
>  
>  ##
>  # @UnixSocketAddress:
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 8850a280a8..d2cd2a9d4f 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -457,6 +457,19 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
>      }
>  
>      freeaddrinfo(res);
> +
> +    if (saddr->keepalive) {

IIUC, best practice is to use 'saddr->has_keepalive && saddr->keepalive'

> +        int val = 1;
> +        int ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> +                                  &val, sizeof(val));
> +
> +        if (ret < 0) {
> +            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> +            close(sock);
> +            return -1;
> +        }
> +    }
> +
>      return sock;
>  }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

