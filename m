Received: from eggs.gnu.org ([2001:4830:134:3::10]:60161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQHio-0007O0-83
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQHil-0007LL-08
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQHik-0007Ki-Qj
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:29:46 -0400
Date: Wed, 28 Jun 2017 15:29:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170628182943.GJ12152@localhost.localdomain>
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
	<20170621140219.4568-3-marcandre.lureau@redhat.com>
	<20170623210845.GA10776@localhost.localdomain>
	<CAJ+F1CLUHM2+hMQqCmN04nwWEMDDDK8104=vK9rnoTsetw9JVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLUHM2+hMQqCmN04nwWEMDDDK8104=vK9rnoTsetw9JVg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

On Tue, Jun 27, 2017 at 08:23:03AM +0000, Marc-Andr=E9 Lureau wrote:
> Hi Eduardo
>=20
> On Fri, Jun 23, 2017 at 11:09 PM Eduardo Habkost <ehabkost@redhat.com>
> wrote:
>=20
> > On Wed, Jun 21, 2017 at 04:02:18PM +0200, Marc-Andr=E9 Lureau wrote:
> > > Add a new memory backend, similar to hostmem-file, except that it
> > > doesn't need to create files. It also enforces memory sealing.
> > >
> > > This backend is mainly useful for sharing the memory with other
> > > processes.
> >
> > How exactly can the memfd be used to share memory?  Is there an exist=
ing
> > mechanism for sharing the memfd file descriptor with another process
>=20
>=20
>=20
> Since there is no backing file, the traditional mechanism is by passing=
 fd,
> via socket ancillary data or forking etc.. Both ivshmem and vhost-user =
have
> such messages, with eventually details for the memory map usage.

The documentation is very similar to memory-backend-file, so it sounded
like there was a generic mechanism to ask QEMU to share the backend FD.
Maybe it would be interesting to mention on which cases the FD can
actually be shared.  Are ivshmem and vhost-user the only existing cases?

>=20
>=20
> > >
> > > Note that Linux supports transparent huge-pages of shmem/memfd memo=
ry
> > > since 4.8. It is relatively easier to set up THP than a dedicate
> > > hugepage mount point by using "madvise" in
> > > /sys/kernel/mm/transparent_hugepage/shmem_enabled.
> > >
> > > Usage:
> > > -object memory-backend-memfd,id=3Dmem1,size=3D1G
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  backends/hostmem-memfd.c | 67
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  backends/Makefile.objs   |  2 ++
> > >  qemu-options.hx          | 11 ++++++++
> > >  3 files changed, 80 insertions(+)
> > >  create mode 100644 backends/hostmem-memfd.c
> > >
> > [...]
> >
> > --
> > Eduardo
> >
> > --
> Marc-Andr=E9 Lureau

--=20
Eduardo
