Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fLn1P-0001XL-Md
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fLn1O-00053q-To
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:58:59 -0400
Date: Thu, 24 May 2018 11:58:49 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180524095849.GB18277@paraplu>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
	<20180521201817.GA10382@redhat.com>
	<20180521203322.GU25013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180521203322.GU25013@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Mon, May 21, 2018 at 05:33:22PM -0300, Eduardo Habkost wrote:
> On Mon, May 21, 2018 at 09:18:17PM +0100, Daniel P. Berrang=E9 wrote:

[...]

(Just catching up with this thread.)

[...]

> > > I have very specific goal here: the goal is to make it less
> > > painful to users when OpenStack+libvirt+QEMU switch to using a
> > > different machine-type by default (q35), and/or when guest OSes
> > > stop supporting pc-i440fx.  I assume this is a goal for OpenStack
> > > as well.
> > >=20
> > > We can make the solution to be more extensible and solve other
> > > problems as well, but my original goal is the one above.
> >=20
> > Configuring the machine type is just one thing that users
> > would do with OpenStack though.  A simple example might be
> >=20
> >     openstack image set \
> >          --property hw_disk_bus=3Dscsi \
> > 	 --property hw_vif_model=3De1000e

[...]

> > Setting a non-default machine type is one extra prop
> >=20
> >     openstack image set \
> >          --property hw_machine_type=3Dq35
> >          --property os_distro=3Dfedora26
>=20
> Nice.  Are these just hypothetical examples, or something that
> already works?

No, not hypothetical -- they actually work _today_, and customers
actively use it in production as we speak.  Machine type could be set in
two ways in OpenStack.  One is as Dan noted above, which is *per* disk
image.  The other is per Compute node (where QEMU instances are
launched), via setting a config attribute in a file
(/etc/nova/nova.conf):

        [libvirt]
        ...
        hw_machine_type=3Dx86_64=3Dpc-q35-2.9

The above means _all_ QEMU instances launched on that Compute node will
get 'pc-q35-2.9' machine type.

[...]

--=20
/kashyap
