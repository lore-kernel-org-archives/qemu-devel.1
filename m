Received: from eggs.gnu.org ([2001:4830:134:3::10]:42965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1e2WAD-00049g-Ej
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1e2WAA-0005MM-AX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:36:09 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:32841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1e2WAA-0005KM-0y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:36:06 -0400
Message-ID: <1507786555.22971.4.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Thu, 12 Oct 2017 07:35:55 +0200
In-Reply-To: <20171005143151.wkxcj5njhevxhnow@eukaryote>
References: <034d01d2d94d$9d6be9d0$d843bd70$@gmail.com>
	<029301d2e062$601f0c30$205d2490$@gmail.com>
	<029401d2e064$87f5ccb0$97e16610$@gmail.com>
	<20171005143151.wkxcj5njhevxhnow@eukaryote>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] FW: Are there any qemu emulated SR-IOV devices?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, mwoodpatrick@gmail.com
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, mst@redhat.com

On Thu, 2017-10-05 at 16:31 +0200, Kashyap Chamarthy wrote:
> [Sorry, I'm a bit late in responding, as I missed this e-mail.]
>=20
> On Thu, Jun 08, 2017 at 07:35:52AM -0700, mwoodpatrick@gmail.com wrote:
> > I wanted to play around with SR-IOV using qemu and was wondering if the=
re
> > are any qemu emulated SR-IOV devices I could experiment with?
>=20
> Near as I know there isn't any existing emulated SR-IOV device in QEMU.
> But yes, an emulated SR-IOV would also be useful for testing purposes
> for projects like OpenStack, without having the need for real hardware.
>=20
> > If not I plan on creating one and would appreciate any pointers to docu=
ments
> > describing how to add an emulated device that supports more than 8 func=
tions
> > and has ARI enabled
>=20
> I'm far from an expert on this area, but just wanted to point out that
> there's some existing support for SR-IOV in QEMU, added via:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0[PATCH v6 0/4] pcie: Add support for Single Root =
I/O Virtualization --
> =C2=A0=C2=A0=C2=A0=C2=A0https://lists.nongnu.org/archive/html/qemu-devel/=
2015-10/msg05155.html
>=20
> Knut Omang (Cced) who added the above support also had some notes here
> on how to implement an SR-IOV capable device.:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0https://lists.nongnu.org/archive/html/qemu-devel/=
2015-10/msg05157.html
> =C2=A0=C2=A0=C2=A0=C2=A0-- pcie: Add some SR/IOV API documentation	in doc=
s/pcie_sriov.txt
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Add a small intro + mini=
mal documentation for how to implement
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SR/IOV support for an emu=
lated device.
>=20
>=20
> [...]

These are not (yet) in QEMU but can still be found here:

https://github.com/knuto/qemu

I try to rebase them from time to time.
The reason why Michael has not accepted them (yet) is to my understanding t=
he lack of
working example devices - correct me if I am wrong.

I did provide the igb device which works as a proof of concept of a device =
with 32 VFs and
use of stride and ARI in that the SR/IOV logic itself can be verified, but =
it is not a
working device, just a quick hack on the e1000 code to make it look like an=
 igb with
SR/IOV support.

But as far as I know, several people have used the SR/IOV patches for their=
 own device
models.=C2=A0

We have a fairly elaborate and complex model (of an Infiniband HCA) that us=
es this, and
that has been used quite extensively, the problem is that the main part of =
the code
implementing the device is inside a simulation model outside of QEMU, just =
communicating=20
PCIe transactions with QEMU over a TCP connection. So it is not that easy t=
o make use of
inside QEMU.=C2=A0I do however want to pursue ways to provide the QEMU side=
 of that
implementation to QEMU, as a tool for other device developers. If there are=
 more people
interested in this domain, maybe we should have a BoF session about it at K=
VM Forum.

Thanks,
Knut
