Received: from eggs.gnu.org ([2001:4830:134:3::10]:54535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gX4wI-0005wB-Ic
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gX4w5-00044J-N6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:52:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gX4w3-00042V-Lc
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:52:25 -0500
Date: Wed, 12 Dec 2018 13:52:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181212135203.GD2370@work-vm>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181212123059.GD31033@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181212123059.GD31033@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Dec 10, 2018 at 05:31:44PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Hi,
> >   This is the first RFC for the QEMU side of 'virtio-fs';
> > a new mechanism for mounting host directories into the guest
> > in a fast, consistent and secure manner.  Our primary use
> > case is kata containers, but it should be usable in other scenarios
> > as well.
> >=20
> > There are corresponding patches being posted to Linux kernel,
> > libfuse and kata lists.
> >=20
> > For a fuller design description, and benchmark numbers, please see
> > Vivek's posting of the kernel set here:
> >=20
> > https://marc.info/?l=3Dlinux-kernel&m=3D154446243024251&w=3D2
> >=20
> > We've got a small website with instructions on how to use it, here:
> >=20
> > https://virtio-fs.gitlab.io/
> >=20
> > and all the code is available on gitlab at:
> >=20
> > https://gitlab.com/virtio-fs
> >=20
> > QEMU's changes
> > --------------
> >=20
> > The QEMU changes are pretty small;=20
> >=20
> > There's a new vhost-user device, which is used to carry a stream of
> > FUSE messages to an external daemon that actually performs
> > all the file IO.  The FUSE daemon is an external process in order to
> > achieve better isolation for security and resource control (e.g. numb=
er
> > of file descriptors) and also because it's cleaner than trying to
> > integrate libfuse into QEMU.
>=20
> Overall I like the virtio-fs architecture more than the virtio-vsock+NF=
S
> approach, as virtio-fs feels simpler and closer to virtio-9p with the
> latter's proxy backends.
>=20
> I never really liked the idea of having to mess around with the host
> NFS server to exposed filesystems to guests, as that's systemwide
> service.  The ability to have an isolated virtio-fs backend process
> per filesystem share per guest is simpler from a mgmt pov.
>=20
> One think I would like to see though is a general purpose, production
> quality backend impl that is shipped by the QEMU project.  It is fine
> if projects like Kata want to write a custom impl tailored to their
> specific needs, but I think QEMU should have something as standard that
> isn't just demoware.=20

Our patches sent to libfuse may provide that - after we tidy them up a
bit more; but it is the result of adding the fuse example code to qemu's
contrib vhost-user example code.    Given that this is the intersection
of so many projects I'm not sure I care which project distributes a
working implementation.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
