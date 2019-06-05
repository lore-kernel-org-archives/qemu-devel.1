Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1EBC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F23206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F23206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYQc-0003HG-EZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:06:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYNk-0001Eg-50
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYNi-0000Rk-P7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hYYNf-0000Ha-FJ; Wed, 05 Jun 2019 12:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AAB730860C6;
	Wed,  5 Jun 2019 16:03:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FB5F1018A2E;
	Wed,  5 Jun 2019 16:03:01 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:02:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190605160258.GK8956@redhat.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605100913.34972-2-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 16:03:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] io/channel: add
 qio_channel_set_keepalive
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 01:09:12PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/io/channel.h | 13 +++++++++++++
>  io/channel-socket.c  | 19 +++++++++++++++++++
>  io/channel.c         | 14 ++++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 59460cb1ec..34d871a414 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -124,6 +124,9 @@ struct QIOChannelClass {
>      int (*io_set_blocking)(QIOChannel *ioc,
>                             bool enabled,
>                             Error **errp);
> +    int (*io_set_keepalive)(QIOChannel *ioc,
> +                            bool enabled,
> +                            Error **errp);
>  
>      /* Optional callbacks */
>      int (*io_shutdown)(QIOChannel *ioc,
> @@ -490,6 +493,16 @@ int qio_channel_set_blocking(QIOChannel *ioc,
>                               bool enabled,
>                               Error **errp);
>  
> +/*
> + * qio_channel_set_keepalive:
> + * @ioc: the channel object
> + * @enabled: the keepalive flag state
> + * @errp: pointer to a NULL-initialized error object
> + */

Missing docs for the return value. SHould be

  "Returns 0 on success, -1 on error."

note we do *not* return "-errno" values in QIOChannel APIs

> +int qio_channel_set_keepalive(QIOChannel *ioc,
> +                              bool enabled,
> +                              Error **errp);
> +

> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index bc5f80e780..5c1ea08660 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -656,6 +656,24 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
>  }
>  
>  
> +static int
> +qio_channel_socket_set_keepalive(QIOChannel *ioc,
> +                                 bool enabled,
> +                                 Error **errp)
> +{
> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> +    int val = enabled;
> +    int ret = qemu_setsockopt(sioc->fd, SOL_SOCKET, SO_KEEPALIVE,
> +                              &val, sizeof(val));
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno, "Unable to set KEEPALIVE");

Add 'return -1' there to be explicit, avoiding need to read up on
whether qemu_setsockopt returns -1 or -errno.  (It returns -1)

> +    }
> +
> +    return ret;
> +}
> +
> +
>  static void
>  qio_channel_socket_set_delay(QIOChannel *ioc,
>                               bool enabled)
> @@ -762,6 +780,7 @@ static void qio_channel_socket_class_init(ObjectClass *klass,
>      ioc_klass->io_writev = qio_channel_socket_writev;
>      ioc_klass->io_readv = qio_channel_socket_readv;
>      ioc_klass->io_set_blocking = qio_channel_socket_set_blocking;
> +    ioc_klass->io_set_keepalive = qio_channel_socket_set_keepalive;
>      ioc_klass->io_close = qio_channel_socket_close;
>      ioc_klass->io_shutdown = qio_channel_socket_shutdown;
>      ioc_klass->io_set_cork = qio_channel_socket_set_cork;
> diff --git a/io/channel.c b/io/channel.c
> index 2a26c2a2c0..0f0b2b7b65 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -265,6 +265,20 @@ int qio_channel_set_blocking(QIOChannel *ioc,
>      return klass->io_set_blocking(ioc, enabled, errp);
>  }
>  
> +int qio_channel_set_keepalive(QIOChannel *ioc,
> +                              bool enabled,
> +                              Error **errp)
> +{
> +    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
> +
> +    if (!klass->io_set_keepalive) {
> +        error_setg(errp, "KEEPALIVE is not supported by IO channel");
> +        return -ENOTSUP;

return -1;

> +    }
> +
> +    return klass->io_set_keepalive(ioc, enabled, errp);
> +}
> +
>  
>  int qio_channel_close(QIOChannel *ioc,
>                        Error **errp)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

