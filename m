Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C1C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2C1205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2C1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahYI-0000GG-TT
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hah8l-0003vB-Vm
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hah8k-0004Dh-GQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:48:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hah8i-0004BN-GW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:48:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 318F82F8BC4;
 Tue, 11 Jun 2019 13:48:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0767C5D704;
 Tue, 11 Jun 2019 13:48:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E4E111386A0; Tue, 11 Jun 2019 15:48:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190610160957.46809-1-vsementsov@virtuozzo.com>
Date: Tue, 11 Jun 2019 15:48:18 +0200
In-Reply-To: <20190610160957.46809-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 10 Jun 2019 19:09:57 +0300")
Message-ID: <8736kg2py5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 11 Jun 2019 13:48:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qapi: InitSocketAddress: add keepalive
 option
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
Cc: den@openvz.org, berrange@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You misspelled InetSocketAddress and keep-alive in the subject.  Suggest

    qapi: Add InetSocketAddress member keep-alive

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> It's needed to provide keepalive for nbd client to track server
> availability.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> v2: [by Markus's comments]
>  - improve commit message
>  - s/keepalive/keep-alive
>  - update inet_parse()
>
>
>  qapi/sockets.json   |  5 ++++-
>  util/qemu-sockets.c | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..13a2627e1d 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -53,6 +53,8 @@
>  #
>  # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and IPv6
>  #
> +# @keep-alive: enable keep-alive when connecting to this socket (Since 4.1)
> +#
>  # Since: 1.3
>  ##
>  { 'struct': 'InetSocketAddress',

Please document that @keep-alive is silently ignored for passive
sockets.

Even better would be rejecting it then, of course.

> @@ -61,7 +63,8 @@
>      '*numeric':  'bool',
>      '*to': 'uint16',
>      '*ipv4': 'bool',
> -    '*ipv6': 'bool' } }
> +    '*ipv6': 'bool',
> +    '*keep-alive': 'bool' } }
>  
>  ##
>  # @UnixSocketAddress:
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 8850a280a8..9c842c4a93 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -457,6 +457,19 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
>      }
>  
>      freeaddrinfo(res);
> +
> +    if (saddr->keep_alive) {
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
>  
> @@ -652,6 +665,15 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
>          }
>          addr->has_ipv6 = true;
>      }
> +    begin = strstr(optstr, ",keep-alive");
> +    if (begin) {
> +        if (inet_parse_flag("keep-alive", begin + strlen("keep-alive="),

Shouldn't you use strlen(",keep-alive")?

> +                            &addr->keep_alive, errp) < 0)
> +        {
> +            return -1;
> +        }
> +        addr->has_keep_alive = true;
> +    }
>      return 0;
>  }

