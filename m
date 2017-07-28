Received: from eggs.gnu.org ([2001:4830:134:3::10]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1davjy-0007z0-Tf
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1davjx-0003jt-KQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:15:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1davjx-0003iJ-7z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:15:01 -0400
Date: Fri, 28 Jul 2017 13:14:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728031443.GB3098@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
	<20170727105348.GG7970@umbus.fritz.box>
	<20170727084733.43038922@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20170727084733.43038922@w520.home>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 08:47:33AM -0600, Alex Williamson wrote:
> On Thu, 27 Jul 2017 20:53:48 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:
> > > On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wr=
ote: =20
> > > > In particular, Mellanox CX4 adapters on PowerNV hosts might not be =
fully
> > > > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > > > DEVICE_DELETED was emitted, leading to detach-device on the libvirt=
 side pretty
> > > > much always crashing the host. =20
> > >=20
> > > My initial naive thought is that if the host kernel can crash then
> > > this is a host kernel bug... shouldn't the host kernel refuse
> > > the subsequent libvirt rebind if it would cause a crash ? =20
> >=20
> > I think so too, but I haven't been able to convince Alex.  Nor
> > find time to fix it in the kernel myself.
>=20
> It's not me you need to convince, it's GregKH[1].  That interpretation
> is that the user bind request is a mandate and we'll fall over
> ourselves to try to do as they ask.  I think the best I might be able
> to do is to kill the QEMU process to avoid compromising the kernel
> rather than killing the kernel after the isolation compromise has
> occurred.  Messing with driver binding is a privileged operation, and
> the kernel believes you get to keep all the pieces when it fails.
> Sorry.  Thanks,

Ah, my mistake.  Well, I guess I'll whinge at GregKH at some point.

Anyway, the basic point remains - I still think we should address this
in the kernel, but that's not going to happen soon.  So we're left
with addressing it in qemu and/or libvirt.  And as others have pointed
out, there are reasons to do that even if the kernel does get changed
to protect itself better here.

>=20
> Alex
>=20
> [1] https://lkml.org/lkml/2017/7/10/728
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6rCEACgkQbDjKyiDZ
s5JT0xAAg0luYoZjGv2or9P19UTvZrAY8BDZmkgmKVzbfafi1Ypq5ertCgsfG1QB
XhLKDqmNXJpSnEDIsS9Vd0oONNXqulkfDWutYNvML5XOMhKEuDbJIgZNiXgX6BRK
7S45EubdLKDzJwMPPjP9md870+91wgQc8vIbMzdzlrdc2tauf/Y+AdC6+DNOWjuP
skijwH6GGLUPyJV6iteaWvfF8LS/EX6YbBXcfWtFJUlaldyaS+wckDK8x9JkZv/1
pgTsxFv+eFJZxj7rNv9OkDV4tv/sazqa8NPCIgobP6CPZHOQD1JGwCzMiP/4fF9r
1wVAqJ4KarCn6qBFyE1Bzl3MFjkBP2hzNIr8TXIeOL8Jmnfz5emDsFuKrV7Ryhxm
mkdAvQkUY5qvktCv1gXdhRh+Hf7jBL0IWHw/ljs/NSDdkKw1JqnXMrDm+clgVuu8
KzEtACjzpx85aUeIukQmTyvmMgYbSAno/HG6PFC4wDoLKNd4Uw0XcX8EfUIs0ZzK
qrPQX0DVpnh8DUTjGDulWjj/qCB/No1NJoNNlf7/YKV2CpRVQFHI7ugyiCyzYZyx
ZGlJ4tDu3kl2C+73JpaitqYlQrD1YESZzCZ3s/PTk45TgWZg+M2evX1monJwJRqH
rU+pGz8dL9NlD6IwK+GIFyAjzC3LsihWRgoI3ohJPa+pC8zMhU8=
=haEo
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
