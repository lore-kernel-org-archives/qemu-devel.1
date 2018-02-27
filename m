Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqi5w-0000yU-Lj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqi5t-0004dI-Gb
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:27:12 -0500
Date: Tue, 27 Feb 2018 16:27:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180227162706.GE32480@stefanha-x1.localdomain>
References: <1519713884-2346-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <1519713884-2346-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/libqos: Check for valid dev pointer
 when looking for PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 07:44:44AM +0100, Thomas Huth wrote:
> dev could be NULL if the PCI device can not be found due to some
> reasons, so we must not dereference the pointer in this case.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqos/virtio-pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

There is no maintainer for tests/libqos/virtio-pci.c in MAINTAINERS so
I'll take this patch.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalYbaAAoJEJykq7OBq3PIeWYH+wQc1uvX6qBxs7PR/wAKFLcJ
uVXFMxSX1rjTOVtmYqmt6/OvYVBwiichpDPhq8ScG38DRgGuMbysPsOzIRABSTPZ
aKGjmcywA/a2gjzPMDnjaYPJAmOsDbe7BU+AuFRry8AVZNzuq6boJHdKDnF0U5Ok
xonBXSKXvQwcodgai/PdhkTKLXHQ/MmVqn9aohxZDlqQ1c/pSJylWgfZ10/s16jL
lcOJ80sRSOIC1TvUTkB9d9BB110I6u7QByMraV+Q341+kCyHqUAPptfcuCNt92+q
C/MTGTTso2c4CrYylu635pMTzoJXhUVPI85cs2RUA5iQy9j2HtahSX4qGgBFSkY=
=/65K
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
