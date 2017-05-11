Received: from eggs.gnu.org ([2001:4830:134:3::10]:44012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1d8vkk-0007xN-9p
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1d8vkf-0006zw-Vu
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:36:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1d8vkf-0006z1-MV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:36:01 -0400
Message-ID: <1494538554.20270.33.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Thu, 11 May 2017 17:35:54 -0400
In-Reply-To: <CAPcyv4irL+imcaWBtHox9oUatndpRw-3xfxtTcn1NV58iph+og@mail.gmail.com>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
	<20170511181703.GC8701@stefanha-x1.localdomain>
	<CAPcyv4irL+imcaWBtHox9oUatndpRw-3xfxtTcn1NV58iph+og@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-+amXkFCaHJpXiKQp2Jba"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, KVM list <kvm@vger.kernel.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>


--=-+amXkFCaHJpXiKQp2Jba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-05-11 at 12:15 -0700, Dan Williams wrote:
> On Thu, May 11, 2017 at 11:17 AM, Stefan Hajnoczi <stefanha@redhat.co
> m> wrote:
> > On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
> > > We are sharing initial project proposal for
> > > 'KVM "fake DAX" device flushing' project for feedback.
> > > Got the idea during discussion with 'Rik van Riel'.
> >=20
> > CCing NVDIMM folks.
> >=20
> > >=20
> > > Also, request answers to 'Questions' section.
> > >=20
> > > Abstract :
> > > ----------
> > > Project idea is to use fake persistent memory with direct
> > > access(DAX) in virtual machines. Overall goal of project
> > > is to increase the number of virtual machines that can be
> > > run on a physical machine, in order to increase the density
> > > of customer virtual machines.
> > >=20
> > > The idea is to avoid the guest page cache, and minimize the
> > > memory footprint of virtual machines. By presenting a disk
> > > image as a nvdimm direct access (DAX) memory region in a
> > > virtual machine, the guest OS can avoid using page cache
> > > memory for most file accesses.
>=20
> How is this different than the solution that Clear Containers came up
> with?
>=20
> https://lwn.net/Articles/644675/

Clear Containers uses MAP_PRIVATE with read-only
images.

This solution is about making read-write images
work.  When a program in the guest calls fsync,
we need to ensure the data has actually hit the
disk on the host side before fsync returns.

--=20
All rights reversed
--=-+amXkFCaHJpXiKQp2Jba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZFNk6AAoJEM553pKExN6DT+AH+gIF4T1gWc98+Ah/IS62ohYZ
0BUevhwk7lNgtj0v65oH2MQTNrRbtL4rQ0WJ4crBlLCWi0/JAff1Z3W5qdPpHZrv
10yoIVyEiLTQHXfHjBjx0C41ZOFcMqga122bZpspLWhOiuE0ozqad+N4dMHe3oD1
iXjCFWN/KhzDiFhEQxtv0AtSWiUFVb5vgf2xNuK97xkwJv8SragYtmbBDqZ1Bt3X
iG3npLQNIOM8tJfnhm+z2G0xA2Rf683K4zTzGg3+0+dN3xBwSI84x8cxvNdEFCoG
IvXd7ruehWyldzCJjbdAGsXZpRSC19pRWkR4xbY50Bvhcc7iYN5AKBUR6CP4/us=
=5oa2
-----END PGP SIGNATURE-----

--=-+amXkFCaHJpXiKQp2Jba--
