Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC285C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9448320866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9448320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYgT-0006lY-Tr
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:22:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYeN-0005Ug-Ts
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYeM-0003xm-3H
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:20:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYYeI-0003tv-Ak
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:20:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 795FD30917EF
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 16:20:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7039216581;
	Wed,  5 Jun 2019 16:20:02 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:19:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laine Stump <laine@redhat.com>
Message-ID: <20190605161959.GM8956@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<20190603193648.GQ22103@habkost.net>
	<20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
	<037855ae-1c21-53a1-8ebb-fcc677d751d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <037855ae-1c21-53a1-8ebb-fcc677d751d9@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 05 Jun 2019 16:20:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
	aadam@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, Jens Freimann <jfreimann@redhat.com>,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 12:04:28PM -0400, Laine Stump wrote:
> On 6/4/19 9:43 AM, Jens Freimann wrote:
> > On Mon, Jun 03, 2019 at 04:36:48PM -0300, Eduardo Habkost wrote:
> > > On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
> > > > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
> > > > > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > > > > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin =
wrote:
> > > > > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan
> > > > Gilbert wrote:
> > > > > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > > Why is it bad to fully re-create the device in case of a failed
> > > > migration?
> > >=20
> > > Bad or not, I thought the whole point of doing it inside QEMU was
> > > to do something libvirt wouldn't be able to do (namely,
> > > unplugging the device while not freeing resources).=C2=A0 If we are
> > > doing something that management software is already capable of
> > > doing, what's the point?
> >=20
> > Event though management software seems to be capable of it, a failove=
r
> > implementation has never happened.
>=20
> I'm pretty sure RHV/oVirt+vdsm has implemented it and it is even being =
used
> in production. Of course it requires a bond/team device to be configure=
d in
> the guest OS, but the part about auto-detaching the VF before migration=
,
> then reattaching a similar VF on the destination is all done by vdsm. (=
Don't
> misunderstand this as discouraging this new method! Just wanted to set =
the
> record straight.)

OpenStack will detach/reattach PCI devices around a save-to-disk, but
does not currently do that for live migration, but easily could do. The
blocker why they've not done that is the issue around exposing to the
guest which pairs of devices are intended to be used together in the
bond.

OpenStack could have defined a way to express that, but it would be
specific to OpenStack which is not very desirable. Standardization
of how to express the relationship between the pair of devices would
be very desirable, allowing the host side solution to be done in either
QEMU or the mgmt app as they see fit.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

