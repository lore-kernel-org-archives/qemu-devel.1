Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BF5C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE5B22CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE5B22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Vna-0007KF-KH
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i5Vmu-0006om-3z
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i5Vms-0001Wo-RG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i5Vmp-0001TM-Jw; Wed, 04 Sep 2019 09:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4CC710C6973;
 Wed,  4 Sep 2019 13:57:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DA565D704;
 Wed,  4 Sep 2019 13:57:16 +0000 (UTC)
Date: Wed, 4 Sep 2019 14:57:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190904135714.GB24521@redhat.com>
References: <20190820104836.3093-1-quintela@redhat.com>
 <20190820104836.3093-5-quintela@redhat.com>
 <22efeb99-70d7-13dc-407e-b6fcbce31797@redhat.com>
 <87blw0kxly.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blw0kxly.fsf@trasno.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 04 Sep 2019 13:57:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/5] socket: Add num connections to
 qio_net_listener_open_sync()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 04, 2019 at 03:19:21PM +0200, Juan Quintela wrote:
> Eric Blake <eblake@redhat.com> wrote:
> > On 8/20/19 5:48 AM, Juan Quintela wrote:
> >> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  blockdev-nbd.c            | 2 +-
> >>  chardev/char-socket.c     | 2 +-
> >>  include/io/net-listener.h | 2 ++
> >>  io/net-listener.c         | 3 ++-
> >>  migration/socket.c        | 2 +-
> >>  qemu-nbd.c                | 2 +-
> >>  ui/vnc.c                  | 4 ++--
> >>  7 files changed, 10 insertions(+), 7 deletions(-)
> >
> > Just now noticing this one, even though the pull request is already s=
ent...
> >
> >>=20
> >> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> >> index 7a71da447f..c621686131 100644
> >> --- a/blockdev-nbd.c
> >> +++ b/blockdev-nbd.c
> >> @@ -101,7 +101,7 @@ void nbd_server_start(SocketAddress *addr, const=
 char *tls_creds,
> >>      qio_net_listener_set_name(nbd_server->listener,
> >>                                "nbd-listener");
> >> =20
> >> -    if (qio_net_listener_open_sync(nbd_server->listener, addr, errp=
) < 0) {
> >> +    if (qio_net_listener_open_sync(nbd_server->listener, addr, 1, e=
rrp) < 0) {
> >>          goto error;
> >>      }
> >
> > Does this interfere with the ability to have more than one client
> > connect to an NBD server during pull-mode incremental backup?  Or can
> > you still have multiple simultaneous clients, provided that the serve=
r
> > has finished accepting the connection from the first before the secon=
d
> > one starts?
>=20
> It is exactly the same than the old code.  Old code always use one.  We
> need to have more than one for multifd.
>=20
> Once told that, if the connections don't start "very" simultaneosly
> (i..e. With multifd we start <num channels> connections in paraller),
> you will never notice that the backlog is one (sie of queue of pending
> connections nowadays).

If incremental backup needs multiple concurrent connections, then
you certainly *do* want to increase this value to something other
than 1, or you will get random failures. As Juan says, this is a
pre-existing problem with NBD though.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

