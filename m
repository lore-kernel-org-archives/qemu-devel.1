Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BFEC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B2820717
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B2820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZqg-0008SH-WB
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:37:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYZpe-0007vM-DZ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYZpc-0007Bz-CX
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hYZpY-00073M-5p; Wed, 05 Jun 2019 13:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31C547EBBD;
	Wed,  5 Jun 2019 17:36:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C207F5D9CC;
	Wed,  5 Jun 2019 17:36:04 +0000 (UTC)
Date: Wed, 5 Jun 2019 18:36:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190605173601.GB13261@redhat.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
	<20190605163710.GP8956@redhat.com>
	<e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
	<19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
	<c0df2189-d90a-8a58-776b-646bbad76976@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0df2189-d90a-8a58-776b-646bbad76976@virtuozzo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 05 Jun 2019 17:36:07 +0000 (UTC)
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 05:28:05PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> 05.06.2019 20:12, Eric Blake wrote:
> > On 6/5/19 12:05 PM, Vladimir Sementsov-Ogievskiy wrote:
> > 
> >>> By enabling TCP keepalives we are explicitly making the connection
> >>> less reliable by forcing it to be terminated when keepalive
> >>> threshold triggers, instead of waiting longer for TCP to recover.
> >>>
> >>> The rationale s that once a connection has been in a hung state for
> >>> so long that keepalive triggers, its (hopefully) not useful to the
> >>> mgmt app to carry on waiting anyway.
> >>>
> >>> If the connection is terminated by keepalive & the mgmt app then
> >>> spawns a new client to carry on with the work, what are the risks
> >>> involved ? eg Could packets from the stuck, terminated, connection
> >>> suddenly arrive later and trigger I/O with outdated data payload ?
> >>
> >> Hmm, I believe that tcp guarantees isolation between different connections
> >>
> >>>
> >>> I guess this is no different a situation from an app explicitly
> >>> killing the QEMU NBD client process instead & spawning a new one.
> >>>
> >>> I'm still feeling a little uneasy about enabling it unconditionally
> >>> though, since pretty much everything I know which supports keepalives
> >>> has a way to turn them on/off at least, even if you can't tune the
> >>> individual timer settings.
> >>
> >> Hm. So, I can add bool keepalive parameter for nbd format with default to true.
> >> And if needed, it may be later extended to be qapi 'alternate' of bool or struct with
> >> three numeric parameters, corresponding to TCP_KEEPCNT, TCP_KEEPIDLE and TCP_KEEPINTVL .
> >>
> >> Opinions?
> > 
> > Adding a bool that could later turn into a qapi 'alternate' for
> > fine-tuning seems reasonable. Defaulting the bool to true is not
> > backwards-compatible; better would be defaulting it to false and letting
> > users opt-in; introspection will also work to let you know whether the
> > feature is present.
> > 
> 
> Ok.
> 
> One more thing to discuss then. Should I add keepalive directly to BlockdevOptionsNbd?
> 
> Seems more useful to put it into SocketAddress, to be reused by other socket users..
> But "SocketAddress" sounds like address, not like address+connection-options. On
> the other hand, structure names are not part of API. So, finally, is InetSocketAddress
> a good place for such thing?

That's an interesting idea. Using InetSocketAddress would mean that we could
get support for this enabled "for free" everywhere in QEMU that uses an
InetSocketAddress as its master config format.

Of course there's plenty of places not using InetSocketAddress that would
still require some glue to wire up the code which converts the custom
format into InetSocketAddress


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

