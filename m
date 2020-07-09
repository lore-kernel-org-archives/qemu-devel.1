Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE018C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9101B2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/okCyj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9101B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtS0L-00079U-Sr
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtRzj-0006jc-Fj
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:33:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtRzg-0000FP-PN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594283603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GH2dm/jqcXu2x1SLTHkNzIF77MKaTUN64DG+VLFwHs8=;
 b=T/okCyj2Vv/oF8XrTLGM7XNJ4N5Ez+uUCv4v4hmciFtVZROTt5LqIwqimOUSV/8+qCpvdK
 Cr/5WjZ0eazSDlNoSlaXKlA2SkeVtRWJVxLG7GSuL1iRtwdqfzDtCx1xJKsRK+0GgKR5k2
 WJx8tnnTo3WuDL8OUdvB/iBSxAr50tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-AlXC2T5jPdymqAJ-m7ZNJw-1; Thu, 09 Jul 2020 04:33:19 -0400
X-MC-Unique: AlXC2T5jPdymqAJ-m7ZNJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D916105250D;
 Thu,  9 Jul 2020 08:33:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21B177F8C1;
 Thu,  9 Jul 2020 08:33:12 +0000 (UTC)
Date: Thu, 9 Jul 2020 09:33:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/2] sockets: keep-alive settings
Message-ID: <20200709083309.GE3753300@redhat.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200708191540.28455-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200708191540.28455-2-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 08, 2020 at 10:15:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Introduce keep-alive settings (TCP_KEEPCNT, TCP_KEEPIDLE,
> TCP_KEEPINTVL) and chose some defaults.
> 
> The linux default of 2 hours for /proc/tcp_keepalive_time
> (corresponding to TCP_KEEPIDLE) makes keep-alive option almost
> superfluous. Let's add a possibility to set the options by hand
> and specify some defaults resulting in smaller total time to terminate
> idle connection.

As you say, 2 hours just a default. The sysadmin can override that
as they wish to change the behaviour globally on the system, so using
the global settings is quite reasonable IMHO.

> Do not document the default values in QAPI as they may be altered in
> future (careful user will use explicit values).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Suggested default numbers are RFC, any better suggestion is welcome.
> I just looked at /etc/libvirt/qemu.conf in my system and take values of
> keepalive_interval and keepalive_count.
> The only thing I'm sure in is that 2 hours is too long.
> 
>  qapi/sockets.json   | 33 +++++++++++++++++++-
>  util/qemu-sockets.c | 76 ++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 97 insertions(+), 12 deletions(-)
> 
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index cbd6ef35d0..73ff66a5d5 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -37,6 +37,37 @@
>      'host': 'str',
>      'port': 'str' } }
>  
> +##
> +# @KeepAliveSettings:
> +#
> +# @idle: The time (in seconds) the connection needs to remain idle
> +#        before TCP starts sending keepalive probes (sets TCP_KEEPIDLE).
> +# @interval: The time (in seconds) between individual keepalive probes
> +#            (sets TCP_KEEPINTVL).
> +# @count: The maximum number of keepalive probes TCP should send before
> +#         dropping the connection (sets TCP_KEEPCNT).
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'KeepAliveSettings',
> +  'data': {
> +    'idle': 'int',
> +    'interval': 'int',
> +    'count': 'int' } }
> +
> +##
> +# @KeepAliveField:
> +#
> +# @enabled: If true, enable keep-alive with some default settings
> +# @settings: Enable keep-alive and use explicit settings
> +#
> +# Since: 5.2
> +##
> +{ 'alternate': 'KeepAliveField',
> +  'data': {
> +    'enabled': 'bool',
> +    'settings': 'KeepAliveSettings' } }
> +
>  ##
>  # @InetSocketAddress:
>  #
> @@ -65,7 +96,7 @@
>      '*to': 'uint16',
>      '*ipv4': 'bool',
>      '*ipv6': 'bool',
> -    '*keep-alive': 'bool' } }
> +    '*keep-alive': 'KeepAliveField' } }
>  
>  ##
>  # @UnixSocketAddress:
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index b37d288866..b961963472 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -433,6 +433,57 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
>      return res;
>  }
>  
> +/*
> + * inet_set_keepalive
> + *
> + * Handle keep_alive settings. If user specified settings explicitly, fail if
> + * can't set the settings. If user just enabled keep-alive, not specifying the
> + * settings, try to set defaults but ignore failures.
> + */
> +static int inet_set_keepalive(int sock, bool has_keep_alive,
> +                              KeepAliveField *keep_alive, Error **errp)
> +{
> +    int ret;
> +    int val;
> +    bool has_settings = has_keep_alive &&  keep_alive->type == QTYPE_QDICT;
> +
> +    if (!has_keep_alive || (keep_alive->type == QTYPE_QBOOL &&
> +                            !keep_alive->u.enabled))
> +    {
> +        return 0;
> +    }
> +
> +    val = 1;
> +    ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &val, sizeof(val));
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> +        return -1;
> +    }
> +
> +    val = has_settings ? keep_alive->u.settings.idle : 30;
> +    ret = qemu_setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &val, sizeof(val));
> +    if (has_settings && ret < 0) {
> +        error_setg_errno(errp, errno, "Unable to set TCP_KEEPIDLE");
> +        return -1;
> +    }
> +
> +    val = has_settings ? keep_alive->u.settings.interval : 30;
> +    ret = qemu_setsockopt(sock, IPPROTO_TCP, TCP_KEEPINTVL, &val, sizeof(val));
> +    if (has_settings && ret < 0) {
> +        error_setg_errno(errp, errno, "Unable to set TCP_KEEPINTVL");
> +        return -1;
> +    }
> +
> +    val = has_settings ? keep_alive->u.settings.count : 20;
> +    ret = qemu_setsockopt(sock, IPPROTO_TCP, TCP_KEEPCNT, &val, sizeof(val));
> +    if (has_settings && ret < 0) {
> +        error_setg_errno(errp, errno, "Unable to set TCP_KEEPCNT");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  /**
>   * Create a socket and connect it to an address.
>   *
> @@ -468,16 +519,11 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
>          return sock;
>      }
>  
> -    if (saddr->keep_alive) {
> -        int val = 1;
> -        int ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> -                                  &val, sizeof(val));
> -
> -        if (ret < 0) {
> -            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> -            close(sock);
> -            return -1;
> -        }
> +    if (inet_set_keepalive(sock, saddr->has_keep_alive, saddr->keep_alive,
> +                           errp) < 0)
> +    {
> +        close(sock);
> +        return -1;
>      }
>  
>      return sock;
> @@ -677,12 +723,20 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
>      }
>      begin = strstr(optstr, ",keep-alive");
>      if (begin) {
> +        bool val;
> +
>          if (inet_parse_flag("keep-alive", begin + strlen(",keep-alive"),
> -                            &addr->keep_alive, errp) < 0)
> +                            &val, errp) < 0)
>          {
>              return -1;
>          }
> +
>          addr->has_keep_alive = true;
> +        addr->keep_alive = g_new(KeepAliveField, 1);
> +        *addr->keep_alive = (KeepAliveField) {
> +            .type = QTYPE_QBOOL,
> +            .u.enabled = val
> +        };
>      }
>      return 0;
>  }
> -- 
> 2.21.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


