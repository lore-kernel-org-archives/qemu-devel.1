Received: from eggs.gnu.org ([209.51.188.92]:51340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@shelob.surriel.com>) id 1ghQGw-0008As-K9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@shelob.surriel.com>) id 1ghQGv-0003J5-Ry
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:40:42 -0500
Received: from shelob.surriel.com ([96.67.55.147]:50932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@shelob.surriel.com>)
	id 1ghQGt-0002yJ-S1
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:40:40 -0500
Message-ID: <026dfd4c4f257a73063bd2f627cff5d7d4f17a60.camel@surriel.com>
From: Rik van Riel <riel@surriel.com>
Date: Wed, 09 Jan 2019 21:40:02 -0500
In-Reply-To: <20190110012617.GA4205@dastard>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-LQK7nuYVGuXcRCl7nOgd"
Mime-Version: 1.0
Sender: riel@shelob.surriel.com
Subject: Re: [Qemu-devel] [PATCH v3 0/5] kvm "virtio pmem" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Chinner <david@fromorbit.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com, jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, rjw@rjwysocki.net


--=-LQK7nuYVGuXcRCl7nOgd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-01-10 at 12:26 +1100, Dave Chinner wrote:
> On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> >  This patch series has implementation for "virtio pmem".=20
> >  "virtio pmem" is fake persistent memory(nvdimm) in guest=20
> >  which allows to bypass the guest page cache. This also
> >  implements a VIRTIO based asynchronous flush mechanism. =20
>=20
> Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> like a good idea, but.....
>=20
> This means the guest VM can now run timing attacks to observe host
> side page cache residency, and depending on the implementation I'm
> guessing that the guest will be able to control host side page
> cache eviction, too (e.g. via discard or hole punch operations).

Even if the guest can only access its own disk image,
using its own page cache pages, Pankaj's patches could
still be a win because they allow the host kernel to
easily evict page cache pages without doing IO.

Evicting page cache pages that live inside a guest
involves something like swapping, ballooning, or some
sort of callback into the guest to figure out whether
a page is clean.

Evicting page cache pages that live in the host, OTOH...

--=20
All Rights Reversed.

--=-LQK7nuYVGuXcRCl7nOgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlw2sIIACgkQznnekoTE
3oMcsgf+NyjlTUYANTAxmyHg64xxfsGA+vKv5CRnV/QQ27Ph4mzP4N8MOIco/6P0
P13ign7T/4KhpY8OmuMPD3yTeKxHcEgYVBXeXjVPYEBfzFstweKo+IKIMvhqmzxG
3rLff6o0aOs36yVmI7ezNwwYjMJ9wt3Vl5FYunDM19dajj7FXwSfHoVzResayMF/
+xT2DyT8PC2nX0wSF9iYrznOvakWNFrIfPGmi4HiYdHPfefuIhMHPnvl0W4Pq3cP
MJj07tJKuO34/wcsDOxWECwy+0U1zGFKi87+N2VONYB1SkeCCfmPtAlSk7pCFF2R
MeDzTqwmnamGMBZBAvL5UdPjxyt5Xg==
=t5QH
-----END PGP SIGNATURE-----

--=-LQK7nuYVGuXcRCl7nOgd--
