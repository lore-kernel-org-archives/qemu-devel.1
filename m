Received: from eggs.gnu.org ([209.51.188.92]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1guNdb-0006up-KC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1guNda-0006PI-Dd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:29:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1guNda-0006Fm-3A
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:29:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A26D80E7A
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 20:29:29 +0000 (UTC)
Date: Thu, 14 Feb 2019 20:29:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190214202920.GH2617@work-vm>
References: <20190206110044.21662-1-dgilbert@redhat.com>
	<20190206183521-mutt-send-email-mst@kernel.org>
	<91c1bf04-1b85-8d99-4d48-b8ad80d36314@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91c1bf04-1b85-8d99-4d48-b8ad80d36314@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/9] Network announce changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, germano@redhat.com, quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

* Jason Wang (jasowang@redhat.com) wrote:
>=20
> On 2019/2/7 =E4=B8=8A=E5=8D=887:35, Michael S. Tsirkin wrote:
> > On Wed, Feb 06, 2019 at 11:00:35AM +0000, Dr. David Alan Gilbert (git=
) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > Hi,
> > >    This is a reworking of a few sets of patches from 2017
> > > that were put together by myself, Germano and Vlad that make
> > > the network announce system more flexible.
> > >=20
> > >    Firstly, it's parameterised, so that you can change the number
> > > of packets and the gap between them; the number can be set to 0
> > > to disable announce completely.
> > >=20
> > >    Secondly, you can force an announce by a qmp or hmp command at
> > > any time.  This is useful if you need the guest to do an announce
> > > for a different reason; for example if the management layer
> > > has just juggled some bonding configuration around.
> > series
> >=20
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>=20
> Applied.
>=20
> Thanks

Hi Jason,
  Can you drop the test patch for now (the last one) - I need to
tweak the Makefile so it doesn't try and run on things without
virtio-net.

Dave

>=20
>=20
> >=20
> >=20
> >=20
> >=20
> > >    The packet creation and timing also moves to net/ from migration=
/
> > >=20
> > >    The previous set was:
> > >       https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg0559=
4.html
> > >=20
> > > Dave
> > >=20
> > > v3
> > >    Fixes from Markus's review: blank lines, and json tweaks
> > >=20
> > > v2
> > >    Fix the qmp example
> > >    Typo fixes
> > >=20
> > >=20
> > > Dr. David Alan Gilbert (9):
> > >    net: Introduce announce timer
> > >    migration: Add announce parameters
> > >    virtio-net: Switch to using announce timer
> > >    migration: Switch to using announce timer
> > >    net: Add a network device specific self-announcement ability
> > >    virtio-net: Allow qemu_announce_self to trigger virtio announcem=
ents
> > >    qmp: Add announce-self command
> > >    hmp: Add hmp_announce_self
> > >    tests: Add a test for qemu self announcements
> > >=20
> > >   hmp-commands.hx                |  14 ++++
> > >   hmp.c                          |  33 ++++++++
> > >   hmp.h                          |   1 +
> > >   hw/net/trace-events            |   6 ++
> > >   hw/net/virtio-net.c            |  69 ++++++++++++----
> > >   include/hw/virtio/virtio-net.h |   4 +-
> > >   include/migration/misc.h       |  12 +--
> > >   include/net/announce.h         |  41 ++++++++++
> > >   include/net/net.h              |   2 +
> > >   include/qemu/typedefs.h        |   2 +
> > >   include/sysemu/sysemu.h        |   2 -
> > >   migration/migration.c          | 103 +++++++++++++++++++++++-
> > >   migration/migration.h          |   4 +
> > >   migration/savevm.c             |  72 +----------------
> > >   migration/trace-events         |   1 -
> > >   net/Makefile.objs              |   1 +
> > >   net/announce.c                 | 140 ++++++++++++++++++++++++++++=
+++++
> > >   net/trace-events               |   3 +
> > >   qapi/migration.json            |  53 ++++++++++++-
> > >   qapi/net.json                  |  43 ++++++++++
> > >   tests/Makefile.include         |   2 +
> > >   tests/test-announce-self.c     |  83 +++++++++++++++++++
> > >   tests/test-hmp.c               |   1 +
> > >   23 files changed, 589 insertions(+), 103 deletions(-)
> > >   create mode 100644 include/net/announce.h
> > >   create mode 100644 net/announce.c
> > >   create mode 100644 tests/test-announce-self.c
> > >=20
> > > --=20
> > > 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
