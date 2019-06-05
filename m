Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044D2C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D247E2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D247E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXjL-0003Id-5u
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:21:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYXia-0002ne-0z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYXiY-0006Bm-55
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYXiW-00065s-6J
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:20:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CB0530C34ED
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 15:20:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D589051DF3;
	Wed,  5 Jun 2019 15:20:05 +0000 (UTC)
Date: Wed, 5 Jun 2019 16:20:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190605152002.GF8956@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<97b5f189-a75d-3efe-0af6-4570f6d38a58@redhat.com>
	<20190603124652.10b3c0c2@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603124652.10b3c0c2@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 05 Jun 2019 15:20:40 +0000 (UTC)
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
	aadam@redhat.com, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Laine Stump <laine@redhat.com>,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 12:46:52PM -0600, Alex Williamson wrote:
> On Mon, 3 Jun 2019 14:10:52 -0400
> Laine Stump <laine@redhat.com> wrote:
>=20
> > On 6/3/19 4:24 AM, Jens Freimann wrote:
> > > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote: =20
> > >> On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote: =20
> > >>> On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrot=
e: =20
> > >>> > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilber=
t  =20
> > >>> wrote: =20
> > >>> > > * Jens Freimann (jfreimann@redhat.com) wrote: =20
> > >> [...] =20
> > >>> > > > +=C2=A0=C2=A0=C2=A0 }
> > >>> > > > +=C2=A0=C2=A0=C2=A0 if (migration_in_setup(s) && !should_be=
_hidden &&  =20
> > >>> n->primary_dev) { =20
> > >>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_unplug(n->=
primary_dev, &err); =20
> > >>> > >
> > >>> > > Not knowing unplug well; can you just explain - is that devic=
e hard
> > >>> > > unplugged and it's gone by the time this function returns or =
is  =20
> > >>> it still =20
> > >>> > > hanging around for some indeterminate time? =20
> > >>>
> > >>> Qemu will trigger an unplug request via pcie attention button in=20
> > >>> which case
> > >>> there could be a delay by the guest operating system. We could gi=
ve=20
> > >>> it some
> > >>> amount of time and if nothing happens try surpise removal or hand=
le the
> > >>> error otherwise. =20
> > >>
> > >> I'm missing something here:
> > >>
> > >> Isn't the whole point of the new device-hiding infrastructure to
> > >> prevent QEMU from closing the VFIO until migration ended
> > >> successfully? =20
> > >=20
> > > No. The point of hiding it is to only add the VFIO (that is configu=
red
> > > with the same MAC as the virtio-net device) until the
> > > VIRTIO_NET_F_STANDBY feature is negotiated. We don't want to expose=
 to
> > > devices with the same MAC to guests who can't handle it.
> > >  =20
> > >> What exactly is preventing QEMU from closing the host VFIO device
> > >> after the guest OS has handled the unplug request? =20
> > >=20
> > > We qdev_unplug() the VFIO device and want the virtio-net standby de=
vice to
> > > take over. If something goes wrong with unplug or
> > > migration in general we have to qdev_plug() the device back.
> > >=20
> > > This series does not try to implement new functionality to close a
> > > device without freeing the resources.
> > >=20
> > >  From the discussion in this thread I understand that is what libvi=
rt
> > > needs though. Something that will trigger the unplug from the
> > > guest but not free the devices resources in the host system (which =
is
> > > what qdev_unplug() does). Correct?
> > > Why is it bad to fully re-create the device in case of a failed mig=
ration? =20
> >=20
> > I think the concern is that if the device was fully released by qemu=20
> > during migration, it might have already been given to some other/new=20
> > guest during the time that migration is trying to complete. If migrat=
ion=20
> > then fails, you may be unable to restore the guest to the previous st=
ate.
>=20
> Yep, plus I think the memory pinning and IOMMU resources could be a
> variable as well.  Essentially, there's no guaranteed reservation to
> the device or any of the additional resources that the device implies
> once it's released, so we want to keep as much of that on hot-standby
> as we can in case the migration fails.  Unfortunately even just
> unmapping the BARs for a guest-only hot-unplug unmaps those regions
> from the IOMMU, but aside from catastrophic resource issues on the
> host, we can essentially guarantee being able to remap those.  Thanks,

Yes its these other resource allocations that are the problem. Libvirt
can easily ensure that the actual PCI device is not given away to a
second guest until migration completes. The mgmt app above libvirt is
likely ensure this exclusion of PCI devices too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

