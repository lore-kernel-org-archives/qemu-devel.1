Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXPrx-0002XN-0H
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXPrv-0006d6-IR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:41:17 -0400
Date: Mon, 25 Jun 2018 13:41:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180625114106.GJ5024@localhost.localdomain>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180625095322.GC18580@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, pkrempa@redhat.com

Am 25.06.2018 um 11:53 hat Daniel P. Berrang=E9 geschrieben:
> On Fri, Jun 22, 2018 at 03:31:46PM +0100, Daniel P. Berrang=E9 wrote:
> > On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
> > > Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:
> > > >=20
> > > >=20
> > > > On 06/22/2018 02:55 PM, Kevin Wolf wrote:
> > > > > Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> > > > >>
> > > > >> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> > > > >>> The -drive option serial was deprecated in QEMU 2.10. It's ti=
me to
> > > > >>> remove it.
> > > > >>>
> > > > >>> Tests need to be updated to set the serial number with -globa=
l instead
> > > > >>> of using the -drive option.
> > > > >>
> > > > >> libvirt 4.5 still creates those (at least on s390x)
> > > > >>
> > > > >>     <disk type=3D'file' device=3D'disk'>
> > > > >>       <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D=
'native' iothread=3D'1'/>
> > > > >>       <source file=3D'/var/lib/libvirt/qemu/image.zhyp137'/>
> > > > >>       <target dev=3D'hda' bus=3D'virtio'/>
> > > > >>       <serial>skel</serial>
> > > > >>       <boot order=3D'1'/>
> > > > >>       <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D=
'0x0000'/>
> > > > >>     </disk>
> > > > >>
> > > > >>
> > > > >> ->=20
> > > > >> [...]
> > > > >> -drive file=3D/var/lib/libvirt/qemu/image.zhyp137,format=3Dqco=
w2,if=3Dnone,id=3Ddrive-virtio-disk0,serial=3Dskel,cache=3Dnone,aio=3Dnat=
ive -device virtio-blk-ccw,iothread=3Diothread1,scsi=3Doff,devno=3Dfe.0.0=
000,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cach=
e=3Don=20
> > > > >> [...]
> > > > >>
> > > > >> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=3D/=
var/lib/libvirt/qemu/image.zhyp137,format=3Dqcow2,if=3Dnone,id=3Ddrive-vi=
rtio-disk0,serial=3Dskel,cache=3Dnone,aio=3Dnative: Block format 'qcow2' =
does not support the option 'serial'
> > > > >> 2018-06-22 11:25:21.098+0000: shutting down, reason=3Dfailed
> > > > >>
> > > > >> So it seems that this breaks s390x.
> > > >=20
> > > > To me it seems that this is also broken on x86.
> > > > >=20
> > > > > Thanks for bringing this up. libvirt should fix this before QEM=
U 3.0 is
> > > > > released.
> > > >=20
> > > > I think this is definitely too short notice. We should not break =
existing
> > > > setups just by insisting that users have to update libvirt when t=
hey update
> > > > QEMU. Yes, this might be our policy, but doing so "just because w=
e can"
> > > > is certainly a very bad attitude. I see no fundamental technical =
reason why
> > > > we should not revert this change.
> > >=20
> > > This was in fact one release longer than our deprecation policy say=
s.
> > > Are we serious about the deprecation policy or aren't we?
> > >=20
> > > I might consider reverting a change if it turned out that this requ=
ires
> > > some massive work in libvirt. But I think this one should be rather=
 easy
> > > to fix in libvirt until 3.0 is released.
> >=20
> > It is probably even possible for us to fix it in our July 1st
> > release
>=20
> Fix posted here:
>=20
> https://www.redhat.com/archives/libvir-list/2018-June/msg01598.html

Thanks!

I'll look into werror/rerror support for usb-storage. It shouldn't be
too hard, though it's strictly speaking a separate problem related to
using -blockdev rather than option deprecation.

If Peter wants to wait for QEMU support before converting werror/rerror
to -device, maybe it would make sense to split your patch for v2 so that
geometry and serial can get fixed right away?

Kevin
