Received: from eggs.gnu.org ([2001:4830:134:3::10]:57602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAKI-0003g4-Lr
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAKD-000718-OA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:40:34 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQAKD-00070h-C5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:40:29 -0400
Received: by mail-wr0-x242.google.com with SMTP id d2-v6so2041679wrm.10
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:40:29 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:40:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605114025.GC11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-3-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-3-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 2/7] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:10:24PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> As more flag parameters besides the existing 'share' are going to be
> added to following functions
>   memory_region_init_ram_from_file
>   qemu_ram_alloc_from_fd
>   qemu_ram_alloc_from_file
> let's switch them to use the 'flags' parameters so as to ease future
> flag additions.
>=20
> The existing 'share' flag is converted to the RAM_SHARED bit in ram_flags,
> and other flag bits are ignored by above functions right now.
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  backends/hostmem-file.c |  3 ++-
>  exec.c                  | 10 +++++-----
>  include/exec/memory.h   |  8 ++++++--
>  include/exec/ram_addr.h | 25 +++++++++++++++++++++++--
>  memory.c                |  8 +++++---
>  numa.c                  |  2 +-
>  6 files changed, 42 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFnapAAoJEJykq7OBq3PILZIH/Rw7IFp5HkGOxAwkLR/aBUIv
e7CHwYPmN6k3k8DrHcpaQDDeljVBknKzce1UqXqQS6VUyeW3y1g2eq2IW1bTA8Dx
RTIDiF8G+dUxJxjKzzOd3hF1BLxhZtKOiGp7aOKpzWr9Ko0PQqXoOv6kb/F3bVUE
g0uUIRwMZzqvGDjW+KZr+Bsb/gFS8ejFddWTuUnxODQAqdtvXi8iQxWun13yx14+
Tldicu+9pvxgAgXkDmU4Df9BI+UFJihyxRZtlfYnM5Oy723U0/jY04/4EkAXFzOs
7XID9JLR0DUjDlswXNJQHF3GSsm3Jn76cBWs9RYMwfsbDX6u1YVpp3qZn9XRp78=
=kpWW
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
