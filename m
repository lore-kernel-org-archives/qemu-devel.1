Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E04C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617D520673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617D520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpks-0003gj-FA
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iHphO-0000Ps-FH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iHphL-0007qM-23
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iHphH-0007j4-PM; Tue, 08 Oct 2019 09:38:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6D7011A03;
 Tue,  8 Oct 2019 13:38:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-66.ams2.redhat.com [10.36.112.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3100C5C1D4;
 Tue,  8 Oct 2019 13:38:36 +0000 (UTC)
Date: Tue, 8 Oct 2019 14:38:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
Message-ID: <20191008133834.GG1192@redhat.com>
References: <20191007194840.29518-1-eblake@redhat.com>
 <20191008092448.GD1192@redhat.com>
 <04440b88-78f6-e177-924d-e16fc3c29b5c@virtuozzo.com>
 <d4b715de-6d5d-6f43-e845-86ddc01c3eac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4b715de-6d5d-6f43-e845-86ddc01c3eac@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 08 Oct 2019 13:38:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 08:28:16AM -0500, Eric Blake wrote:
> On 10/8/19 4:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> > 08.10.2019 12:24, Daniel P. Berrang=C3=A9 wrote:
> > > On Mon, Oct 07, 2019 at 02:48:40PM -0500, Eric Blake wrote:
> > > > One benefit of --pid-file is that it is easier to probe the file
> > > > system to see if a pid file has been created than it is to probe =
if a
> > > > socket is available for connection. Document that this is an
> > > > intentional feature.
> > >=20
> > > I'm not seeing how checking the pid file is better than checking
> > > the socket directly ? I think it is probably actually worse.
> > >=20
> > > The main problem with the socket is that while we unlink on clean
> > > shutdown, it may still exist in disk if the process has exitted
> > > abnormally.
> > >=20
> > > With the pidfile though we don't ever unlink it, even on clean
> > > shutdown, as we don't use the pid files existance as a mutual
> > > exclusion check. We instead acquire fcntl locks on it.
> > >=20
> > > IOW the pidfile could exist already when qemu-nbd starts up and
> > > will still exist when it quits.
> >=20
> > Good point.
> >=20
> > I was just a bit confused, because pid file is something unrelated to
> > socket, and why use one thing to check the existence of another, if w=
e
> > can directly try to connect.
>=20
> Consider the case of writing a testsuite that involves an nbd client, w=
here
> you want to fire up qemu-nbd as the server.  Checking for a pid file in
> shell is easy, and can be done prior to the point of spawning a client.
> Checking for a successful connect is harder - the shell is not the poin=
t
> that would actually connect, so checking if connect works involves the =
shell
> actually spawning off the child process that attempts the connect.  If =
the
> client itself has a retry builtin, then you don't need to do anything i=
n
> shell - just spawn the client with retry (at which point, the client
> retrying on the connection is smarter than the client retrying on the p=
id
> file).  But pid files are immensely useful when you have a client that =
does
> not have builtin retry, and when writing a testing framework where you =
use
> shell to learn whether it is safe to spawn the client: rather than havi=
ng to
> modify the client or write a shell loop that respawns child attempts, y=
ou
> merely need a shell loop probing for the pid file to exist.

We shouldn't need todo any of those tricks IIUC.  The --fork argument is
supposed to only let the parent process exit once the server is running.

IOW, if you run qemu-nbd --fork, in the foreground, then when execution
continues the sockets should be present & accepting connections. No need
to check for existance of any files or check connecting, etc.


Except that AFAICT, --fork isn't actually implemented with this semantics
in qemu-nbd. It looks like we only listen on the sockets after the parent
has already exited :-( Can we fix that to synchronize wrt socket listener=
s ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

