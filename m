Received: from eggs.gnu.org ([2001:4830:134:3::10]:57419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNgaj-0006zu-EW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNgai-0004L1-FK
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:31:17 -0400
Date: Tue, 29 May 2018 16:31:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180529153103.GB2575@work-vm>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180524111713.GA4660@redhat.com> <20180529140316.GA2578@work-vm>
	<20180529141411.GZ8988@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180529141411.GZ8988@localhost.localdomain>
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
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Tue, May 29, 2018 at 03:03:16PM +0100, Dr. David Alan Gilbert wrote:
> > * Richard W.M. Jones (rjones@redhat.com) wrote:
> > > On Fri, May 18, 2018 at 06:09:56PM +0100, Daniel P. Berrang=E9 wrot=
e:
> > > > The closest to a cross-hypervisor standard is OVF which can store
> > > > metadata about required hardware for a VM. I'm pretty sure it doe=
s
> > > > not have the concept of machine types, but maybe it has a way for
> > > > people to define metadata extensions. Since it is just XML at the
> > > > end of the day, even if there was nothing official in OVF, it wou=
ld
> > > > be possible to just define a custom XML namespace and declare a
> > > > schema for that to follow.
> > >=20
> > > I have a great deal of experience with the OVF "standard".
> > > TL;DR: DO NOT USE IT.
> >=20
> > In addition to the detail below, from reading DMTF's OVF spec (DSP024=
3 v
> > 2.1.1) I see absolutely nothing specifying hardware type.
> > Sure it can specify size of storage, number of ether cards, MAC
> > addresses for them etc - but I don't see any where specify the type o=
f=20
> > emualted system.
>=20
> Maybe the VirtualHardwareSection/System/vssd:VirtualSystemType
> element could be used for that.  (DSP0243 v2.1.1, line 650).

Ah yes, you're right; they hadn't bothered putting that in any of the
examples.  A quick search suggests VMWare use that as 'vmx-10' or
'vmx-12' as a 'hardware faimily'.

> But based on Richard's feedback, I think we shouldn't even try to
> use it.

Right; although if we have a key/value system, then if the key/value
structures we used happened to match up with OVMF if they made sense
then I guess it would make conversions easy.

Dave

> --=20
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
