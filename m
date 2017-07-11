Received: from eggs.gnu.org ([2001:4830:134:3::10]:53363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUs44-0006jg-6y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUs43-0005Ko-FY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:06:44 -0400
Date: Tue, 11 Jul 2017 11:05:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711100535.GM17792@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
	<20170710150707.GK14195@stefanha-x1.localdomain>
	<61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CiRFyVmOOJ3DkBX"
Content-Disposition: inline
In-Reply-To: <61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 3/6] block: Introduce
 bdrv_dma_map and bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Karl Rister <krister@redhat.com>


--6CiRFyVmOOJ3DkBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 05:08:56PM +0200, Paolo Bonzini wrote:
> On 10/07/2017 17:07, Stefan Hajnoczi wrote:
> > On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
> >> Allow block driver to map and unmap a buffer for later I/O, as a perfo=
rmance
> >> hint.
> > The name blk_dma_map() is confusing since other "dma" APIs like
> > dma_addr_t and dma_blk_io() deal with guest physical addresses instead
> > of host addresses.  They are about DMA to/from guest RAM.
> >=20
> > Have you considered hiding this cached mapping in block/nvme.c so that
> > it isn't exposed?  block/nvme.c could keep the last buffer mapped and
> > callers would get the performance benefit without a new blk_dma_map()
> > API.
>=20
> One buffer is enough for qemu-img bench, but not for more complex cases
> (e.g. fio).

I don't see any other blk_dma_map() callers.

Stefan

--6CiRFyVmOOJ3DkBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZKLvAAoJEJykq7OBq3PI0qkH/j34k6Cml4TgQf0TFfWZBHCy
5zzpYZGLF/EZQzLISm0druXn7OuIlsTkGw05PVIqHnYKWqYl4lMQaIfm02LYGVOJ
9cyf+rPTW93zvwnA1M5z5vxVYo+i3PpucZXTowpygzWlckd2P+Tp0Lys7lZeOuIC
F8pyA9DAspC1TtaxlntnDjbezHWuM2q7Kt8WaFkc1bFoOKe4uhNwOZ6remOydLU6
nEPQkRRPGFdwbS/9W352gVWQ6yuOMJ2L2rzOefuLvKFmmsfOcAgDh3LpTXHUZ7IO
J1Mnfin9GZ+8CaleWZDdBHZS1+SV3AYqAukAskwMXo6C4hWdGCUuDJyvQt1BvLA=
=rKtr
-----END PGP SIGNATURE-----

--6CiRFyVmOOJ3DkBX--
