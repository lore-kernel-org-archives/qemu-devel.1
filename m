Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED6C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2588E2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2588E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46155 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYvX-0008HM-Ef
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:38:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYug-0007nk-S8
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYuf-00072g-Ai
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hYYuc-0006wn-Mh; Wed, 05 Jun 2019 12:37:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2EF53082B5A;
	Wed,  5 Jun 2019 16:37:17 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BEBC6064B;
	Wed,  5 Jun 2019 16:37:13 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:37:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190605163710.GP8956@redhat.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 05 Jun 2019 16:37:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd-client: enable TCP keepalive
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
	den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 09:39:10AM -0500, Eric Blake wrote:
> On 6/5/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> > Enable keepalive option to track server availablity.
> 
> s/availablity/availability/
> 
> Do we want this unconditionally, or should it be an option (and hence
> exposed over QMP)?

I guess this is really a question about what our intended connection
reliability policy should be.

By enabling TCP keepalives we are explicitly making the connection
less reliable by forcing it to be terminated when keepalive
threshold triggers, instead of waiting longer for TCP to recover.

The rationale s that once a connection has been in a hung state for
so long that keepalive triggers, its (hopefully) not useful to the
mgmt app to carry on waiting anyway.

If the connection is terminated by keepalive & the mgmt app then
spawns a new client to carry on with the work, what are the risks
involved ? eg Could packets from the stuck, terminated, connection
suddenly arrive later and trigger I/O with outdated data payload ?

I guess this is no different a situation from an app explicitly
killing the QEMU NBD client process instead & spawning a new one.

I'm still feeling a little uneasy about enabling it unconditionally
though, since pretty much everything I know which supports keepalives
has a way to turn them on/off at least, even if you can't tune the
individual timer settings.

> > Requested-by: Denis V. Lunev <den@openvz.org>
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  block/nbd-client.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/block/nbd-client.c b/block/nbd-client.c
> > index 790ecc1ee1..b57cea8482 100644
> > --- a/block/nbd-client.c
> > +++ b/block/nbd-client.c
> > @@ -1137,6 +1137,7 @@ static int nbd_client_connect(BlockDriverState *bs,
> >  
> >      /* NBD handshake */
> >      logout("session init %s\n", export);
> > +    qio_channel_set_keepalive(QIO_CHANNEL(sioc), true, NULL);
> >      qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
> >  
> >      client->info.request_sizes = true;
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 




Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

