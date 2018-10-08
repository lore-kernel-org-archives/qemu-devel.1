Received: from eggs.gnu.org ([2001:4830:134:3::10]:59616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9Lyp-0006N4-69
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9Lyl-0003xE-8b
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:13:11 -0400
Date: Mon, 8 Oct 2018 13:04:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181008020411.GS7004@umbus.fritz.box>
References: <20180920103243.28474-1-david@redhat.com>
	<20180920103243.28474-18-david@redhat.com>
	<20180924054522.GY30868@umbus.fritz.box>
	<bff1cdbc-8a7c-8d53-47ff-cf17120a4af5@redhat.com>
	<1420151307.15516367.1537782494919.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HywJcj55HbA57jnN"
Content-Disposition: inline
In-Reply-To: <1420151307.15516367.1537782494919.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 17/22] virtio-pmem: prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Richard Henderson <rth@twiddle.net>


--HywJcj55HbA57jnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 05:48:14AM -0400, Pankaj Gupta wrote:
>=20
> > On 24/09/2018 07:45, David Gibson wrote:
> > > On Thu, Sep 20, 2018 at 12:32:38PM +0200, David Hildenbrand wrote:
> > >> From: Pankaj Gupta <pagupta@redhat.com>
> > >>
> > >> This is the current protoype of virtio-pmem. Support will require
> > >> machine changes for the architectures that will support it, so it wi=
ll
> > >> not yet be compiled.
> > >>
> > >> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > >> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memadd=
r",
> > >>   split up patches ]
> > >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > >=20
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > >=20
> > > Seems generally sane.  Is there a (craft?) virtio-pmem spec around to
> > > see what this is actually trying to implement?
> >=20
> > I am not aware of any. The first goal is to get something implemented
> > that works and doesn't break important concepts. E.g. hotplugging memory
> > devices was one of these concepts that Igor saw as a potential problem
> > for getting virtio-pmem upstream.
> >=20
> > But maybe Pankaj already has some draft version of a spec lying around.
>=20
> I have created document but no official spec. Project idea is shared here=
 [1]=20
> and kernel part of series [2]. I will create a spec and share.
>=20
> [1] https://www.spinics.net/lists/kvm/msg153095.html
> [2] https://marc.info/?l=3Dkvm&m=3D153572224719212&w=3D2

Ok.  Because this creates a new interface we could be working with for
a while, I think we do need at least a semi-formal spec - and to get
some review of that spec - before we merge.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HywJcj55HbA57jnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu6uxsACgkQbDjKyiDZ
s5LF4BAAwDKiTt5LVeZeFAiAKSsUo4Zc9uRG9HJy9T34mbzngQJ5/7JBkd+5bytQ
kqJG6manphpDMd1U0R5P+z0xegZicKkulcwjOqvu4NAX/ZyGIiUNk3PE2in12phx
8pmqGu8MvXhnG0X9V+oH9irJQE/fATKFyVRru/VY4jsF5K9wJdYbARcPqdrY8/nN
O2+p4wlgThZIL7aI8vZI2NxMXeXKqCO52gIWFEsUe7ouDCyA2EwvRmNiDZPAqLcg
v6MLHMOCfmlGXMI6qq2lnZ1l8IFmHzh0bdTXAfj79eqdSBcxLyviD4iuPTGmxBIr
RD0/1Ncykn/GGQPWy0GUozorBFzn+voLExbEqCnUDhh1hxcsj+gbO6MRvA//DiR8
YrxvyGXFhehIjaljbYUTO0j9ZMRnxUOmdjstFOLAQbjNl13e3wVslt89a4d09l+S
z6SUCw25QJdz34/mdJfRlAJQ6fX7D9yC/xYh4xnXzDdT8RKmc0Hl8bqp/oOzRwtz
GBcs7tBiY5BRUP1PkTWRxoTKNUWWWaXEJWcMKM2fji3A/s+/dLPgKAXb5oV1pzQp
pyq/IEAR3lZMO5AHMj8DiRPRO9yWH3yvs5Sdlv5jXcX5waJ0ffCpyEuZ/h7Gyebz
pWv56Fxiqg+2w/8nzSS102/11L4EgD8/PXEbcEsY1Zf5nYGRCzc=
=1lix
-----END PGP SIGNATURE-----

--HywJcj55HbA57jnN--
