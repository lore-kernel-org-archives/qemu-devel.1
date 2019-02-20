Received: from eggs.gnu.org ([209.51.188.92]:53651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwPg9-0004D7-E6
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwPg8-0000IS-91
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:04:41 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:59764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gwPg7-0000Dx-VW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:04:40 -0500
Received: from player711.ha.ovh.net (unknown [10.109.159.73])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 47AFCF34A3
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:04:31 +0100 (CET)
Date: Wed, 20 Feb 2019 12:04:13 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190220120413.2cb0f80b@bahia.lan>
In-Reply-To: <20190220033053.GO9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190220033053.GO9345@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/6Np=lHsxbH5gwi986kPy7KQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 00/17] spapr: Add support for
 PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

--Sig_/6Np=lHsxbH5gwi986kPy7KQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Feb 2019 14:30:53 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 19, 2019 at 06:17:33PM +0100, Greg Kurz wrote:
> > This allows to hotplug/unplug PHBs. I could successfully test:
> > - using in-kernel XICS, emulated XICS and XIVE
> > - hotplug/unplug with e1000 device to validate LSIs
> > - hotplug/unplug with virtio-net device to validate MSIs
> > - some simple migration scenarios
> >=20
> > Based on David's ppc-for-4.0 branch SHA1: =20
>=20
> Applied!
>=20

Thanks David and everyone who helped !

Cheers,

--
Greg


> >=20
> > 6f585625d0d1 target/ppc: Basic POWER9 bare-metal radix MMU support
> >=20
> > Please comment.
> >=20
> > Changes in v5:
> > - all DRC subtypes generate FDT fragment at configure connector time
> > - Drop all the LSI bitmap and allocation/typing disintricate stuff
> > - set IRQ type in KVM at claim time
> > - fix hotplug call chain
> > - added PHB unplug test to tests/device-plug-test
> >=20
> > Changes in v4:
> > - added a LSI bitmap to XICS
> > - no longer need compat property in XICS
> > - simplified the patches to access the name and the phandle of the
> >   interrupt controller
> > - delay the creation of the PHB drc->fdt to RTAS ibm,configure-connector
> >=20
> > Change in v3:
> > - reworked phandle related code some more
> > - disintricate allocation/"type setting" of interrupts
> > - identify LSIs at machine init
> >=20
> > Changes in v2:
> > - rebased on current ppc-for-4.0
> > - added some preliminary cleanup
> > - call unrealize from realize error path
> > - advertise PHB hotplug in last patch
> > - reworked phandle related code
> > - sync LSIs to KVM
> >  =20
>=20


--Sig_/6Np=lHsxbH5gwi986kPy7KQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxtNC0ACgkQcdTV5YIv
c9buSw/+OxOsK9nPjkWFPkDHiUKuNjrMmvVUeB/p9sTSf3mK3RsNZ3bP9tc5IG5J
CQS+sY6nh8qsx+FXLgJ8sk7bU1fhfIOz4mt0y5F9L4o5gcL1YV/TcRu3UT4niMRZ
8YI4VfEH2J6nJUqHZi7+N/YhXdh+CH7dC+956+wWCAZNI9mub4jaQNE2DIqUDMK1
OZLcqYyZe7tCBAmkr3hNDYvNQ4WMD2BPFxqJ3z3STABkzXd+Y/QcrlO9xAomRNJ4
1NbkxPkzETbQUFiW7WNA9RDv4DcYmjwCJECy0L2AG3CLEBvxdDUrLcsOW6SHTIWt
Dug3Mq1iYzuxVlz8p3Fqoqy5/TJPgZ4xWkg4IqeiCns/FnVsrA01Sx440S/puRan
GL6xG6GhiTPygcnk6jcGBqFRV0OBWJGb2ICB4tODNNN7u9BzKoxYd7+PTZjxcbU7
Y9vxM1p1F9F4rUoE5x09M4kc5RExtafq5OGyK1J7ybSo6ERWzkbjvCezgHJSbFtB
Y1lDTjafC/1XUAnXHka89b/Fspf7z0/J+mjv8gQk1qqMgTmNJlfp6M2TeM2tY5fG
Bj0KurmO8kNZG0gIpPA/Po3OZgXroD3KiqAz0jLKxZSIk0FLHdUipjGk6L+xFtCM
E3dB8WDRtM03JgS2nBHbozwWZnCx6MAW0yBti34sk+t6NdJ7anI=
=uEKo
-----END PGP SIGNATURE-----

--Sig_/6Np=lHsxbH5gwi986kPy7KQ--
