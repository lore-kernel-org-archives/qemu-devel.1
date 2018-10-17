Received: from eggs.gnu.org ([2001:4830:134:3::10]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gCcpU-0006dS-Rr
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 23:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gCcpT-00079k-L7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 23:49:04 -0400
Date: Wed, 17 Oct 2018 14:31:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181017033115.GC30180@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012132542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20181012132542-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 01:26:45PM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 12, 2018 at 02:24:26PM +1100, David Gibson wrote:
> > The virtio-balloon devices was never really thought out for cases
> > other than 4kiB pagesize on both guest and host.  It works in some
> > cases, but in others can be ineffectual or even cause guest memory
> > corruption.
> >=20
> > This series makes a handful of preliminary cleanups, then makes a
> > change to safely, though not perfectly, handle cases with non 4kiB
> > pagesizes.
>=20
> BTW do you want to add an interface to specify the page size?
> I can see either host or guest or both supporting that.

To make this work, it really has to be advertised by the host.  Only
the host can know what a suitable discard granularity is.  It would
make the balloon more widely usable, however it makes the guest side
driver vastly more complex, since it will need to find contiguous
chunks of memory to discard.

Given the numerous problems with the balloon model (which David
Hildenbrand has and is continuing to point out), I'm not sure it's
work the trouble.

> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>=20
> > David Gibson (5):
> >   virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
> >   virtio-balloon: Corrections to address verification
> >   virtio-balloon: Rework ballon_page() interface
> >   virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
> >   virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size
> >=20
> >  hw/virtio/virtio-balloon.c         | 100 ++++++++++++++++++++++++-----
> >  include/hw/virtio/virtio-balloon.h |   3 +
> >  2 files changed, 87 insertions(+), 16 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGrQMACgkQbDjKyiDZ
s5KSPhAApCz+o0IhEDcbmX/+7SMDAEapjBbjC+9JQaNgSjRTERbzE+JxmIDhTVt9
cYCCvGdNUDvuXabUoDzh5E1eJc3mx5Qpi7jlHrwqKp+GvekfKPlBJ5O/AGMTUL4w
uh1m2j4pY24+RMHsrABX0O+lklkUeg8v4SDtEqYW7nVVcD8nkJ4cAxt3GirBCv+l
fAc136RdeDzh5LC151eL+RpnSSp4tE30efSpZr7AoN5itrObG3Tusd9FDT+Oztf/
kaY9RxDquW+BSV3xQn8/WdsjKuWrQDmh7QfdLMGGm8zuc5S0lZK5eHxwLeUcz68J
zLm/+6iYpyYvM+fC3e4rZHCZVtRoU/dQ5Zd4T37bDNuwUcbkojHayDxivG3iH3ub
DAIVYhJbDOpr68NsYBAgWj9ItJD204cCHfYS1Ae/QAwm+IAnvh190QMOj4J/BYFj
NnFcchNxX3oh9H3aZN8gzCqTr/qT8XR0xVMlDrAjIPphDOLFpS3+SIpNhCZPc3tg
xvMxeGz/D5kQIKr4iUnvytBJg+N5AhJOOq13mQlFWAAo6Rv+w9qzZChPj1g2CYJD
kAIjKWXfm1K/XCAEeSm3/JEUMJRjKpjYzo444uQi97rJlr3pUDv9iYzDIVgDcA0V
WULnVORsn0D2sSFdfGtgcAgl2uouyV/uYpkaH5NXjp50O4abWeE=
=uLiZ
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
