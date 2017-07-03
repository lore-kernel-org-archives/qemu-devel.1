Received: from eggs.gnu.org ([2001:4830:134:3::10]:44551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS2Qw-0003AS-Hr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS2Qv-0008Gy-Pf
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dS2Qv-0008Go-Gl
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:34:37 -0400
Date: Mon, 3 Jul 2017 11:34:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170703143434.GH12152@localhost.localdomain>
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
	<20170621140219.4568-3-marcandre.lureau@redhat.com>
	<20170623210845.GA10776@localhost.localdomain>
	<CAJ+F1CLUHM2+hMQqCmN04nwWEMDDDK8104=vK9rnoTsetw9JVg@mail.gmail.com>
	<20170628182943.GJ12152@localhost.localdomain>
	<CAJ+F1C+79Hfd+7J2nS7=+4awjW6nqGSaVrWDx9P8O-8FCuBsdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+79Hfd+7J2nS7=+4awjW6nqGSaVrWDx9P8O-8FCuBsdQ@mail.gmail.com>
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

On Thu, Jun 29, 2017 at 01:34:22PM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jun 28, 2017 at 8:29 PM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
>=20
> > On Tue, Jun 27, 2017 at 08:23:03AM +0000, Marc-Andr=E9 Lureau wrote:
> > > Hi Eduardo
> > >
> > > On Fri, Jun 23, 2017 at 11:09 PM Eduardo Habkost <ehabkost@redhat.c=
om>
> > > wrote:
> > >
> > > > On Wed, Jun 21, 2017 at 04:02:18PM +0200, Marc-Andr=E9 Lureau wro=
te:
> > > > > Add a new memory backend, similar to hostmem-file, except that =
it
> > > > > doesn't need to create files. It also enforces memory sealing.
> > > > >
> > > > > This backend is mainly useful for sharing the memory with other
> > > > > processes.
> > > >
> > > > How exactly can the memfd be used to share memory?  Is there an
> > existing
> > > > mechanism for sharing the memfd file descriptor with another proc=
ess
> > >
> > >
> > >
> > > Since there is no backing file, the traditional mechanism is by pas=
sing
> > fd,
> > > via socket ancillary data or forking etc.. Both ivshmem and vhost-u=
ser
> > have
> > > such messages, with eventually details for the memory map usage.
> >
> > The documentation is very similar to memory-backend-file, so it sound=
ed
> > like there was a generic mechanism to ask QEMU to share the backend F=
D.
> > Maybe it would be interesting to mention on which cases the FD can
> > actually be shared.  Are ivshmem and vhost-user the only existing cas=
es?
> >
> >
> Actually, vhost-user may be the only way today to get the fd outside of
> qemu process.
>=20
> (ivshmem needs the server to provide the fd)
>=20
> We could quite easily add or extend QMP messages for that in the future=
.
>=20
> Do you want this detail to be written in the commit message or elsewher=
e?

(Sorry for taking so long to reply.)

I think this should be in the documentation of the new option (in
qemu-options.hx).

I don't think it needs lots of extra detail, maybe just change "which
can be used to share the memory with a co-operating external process" to
"which allows QEMU to share the memory with an external process in some
cases (e.g. when using vhost-user)".

--=20
Eduardo
