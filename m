Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E1C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCA226368
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCA226368
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXs04-0000Q5-Tr
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:48:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hXrzD-00004t-31
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hXrzA-0007NJ-0y
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hXrz9-0007KS-Pw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3F6A31628F7
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 18:47:00 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53C765D6A9;
	Mon,  3 Jun 2019 18:46:52 +0000 (UTC)
Date: Mon, 3 Jun 2019 12:46:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laine Stump <laine@redhat.com>
Message-ID: <20190603124652.10b3c0c2@x1.home>
In-Reply-To: <97b5f189-a75d-3efe-0af6-4570f6d38a58@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<97b5f189-a75d-3efe-0af6-4570f6d38a58@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 03 Jun 2019 18:47:06 +0000 (UTC)
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
Cc: pkrempa@redhat.com, berrange@redhat.com,
	Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 14:10:52 -0400
Laine Stump <laine@redhat.com> wrote:

> On 6/3/19 4:24 AM, Jens Freimann wrote:
> > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote: =20
> >> On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote: =20
> >>> On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote: =
=20
> >>> > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert  =
=20
> >>> wrote: =20
> >>> > > * Jens Freimann (jfreimann@redhat.com) wrote: =20
> >> [...] =20
> >>> > > > +=C2=A0=C2=A0=C2=A0 }
> >>> > > > +=C2=A0=C2=A0=C2=A0 if (migration_in_setup(s) && !should_be_hid=
den &&  =20
> >>> n->primary_dev) { =20
> >>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_unplug(n->prim=
ary_dev, &err); =20
> >>> > >
> >>> > > Not knowing unplug well; can you just explain - is that device ha=
rd
> >>> > > unplugged and it's gone by the time this function returns or is  =
=20
> >>> it still =20
> >>> > > hanging around for some indeterminate time? =20
> >>>
> >>> Qemu will trigger an unplug request via pcie attention button in=20
> >>> which case
> >>> there could be a delay by the guest operating system. We could give=20
> >>> it some
> >>> amount of time and if nothing happens try surpise removal or handle t=
he
> >>> error otherwise. =20
> >>
> >> I'm missing something here:
> >>
> >> Isn't the whole point of the new device-hiding infrastructure to
> >> prevent QEMU from closing the VFIO until migration ended
> >> successfully? =20
> >=20
> > No. The point of hiding it is to only add the VFIO (that is configured
> > with the same MAC as the virtio-net device) until the
> > VIRTIO_NET_F_STANDBY feature is negotiated. We don't want to expose to
> > devices with the same MAC to guests who can't handle it.
> >  =20
> >> What exactly is preventing QEMU from closing the host VFIO device
> >> after the guest OS has handled the unplug request? =20
> >=20
> > We qdev_unplug() the VFIO device and want the virtio-net standby device=
 to
> > take over. If something goes wrong with unplug or
> > migration in general we have to qdev_plug() the device back.
> >=20
> > This series does not try to implement new functionality to close a
> > device without freeing the resources.
> >=20
> >  From the discussion in this thread I understand that is what libvirt
> > needs though. Something that will trigger the unplug from the
> > guest but not free the devices resources in the host system (which is
> > what qdev_unplug() does). Correct?
> > Why is it bad to fully re-create the device in case of a failed migrati=
on? =20
>=20
> I think the concern is that if the device was fully released by qemu=20
> during migration, it might have already been given to some other/new=20
> guest during the time that migration is trying to complete. If migration=
=20
> then fails, you may be unable to restore the guest to the previous state.

Yep, plus I think the memory pinning and IOMMU resources could be a
variable as well.  Essentially, there's no guaranteed reservation to
the device or any of the additional resources that the device implies
once it's released, so we want to keep as much of that on hot-standby
as we can in case the migration fails.  Unfortunately even just
unmapping the BARs for a guest-only hot-unplug unmaps those regions
from the IOMMU, but aside from catastrophic resource issues on the
host, we can essentially guarantee being able to remap those.  Thanks,

Alex

