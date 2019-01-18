Received: from eggs.gnu.org ([209.51.188.92]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkQtU-000224-V8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkQtT-0003ll-Ro
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:56:56 -0500
Date: Fri, 18 Jan 2019 09:56:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190118095652.GA21579@stefanha-x1.localdomain>
References: <cover.1547475602.git.berto@igalia.com>
	<20190116135444.GA16898@stefanha-x1.localdomain>
	<w51d0ov2z9h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <w51d0ov2z9h.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 02:24:10PM +0100, Alberto Garcia wrote:
> On Wed 16 Jan 2019 02:54:44 PM CET, Stefan Hajnoczi wrote:
> > This patch series makes virtio-blk and virtio-scsi more robust,
> > although I haven't checked what happens if the drive is attached to a
> > different IOThread than the device - will the switchover work?
>=20
> You mean if you use x-blockdev-set-iothread with a drive and then attach
> it to a device using a different thread? That seems to work (with my
> patch).

Does it work with a running VM that will do I/O?  If yes, then that's
great and we should merge the virtio-blk/scsi patches to make them
robust for this case.  I'm a little surprised it works though :-)
because the code wasn't designed or tested for this.

Stefan

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQaLjAAoJEJykq7OBq3PIVW8IAJNVRKEIrXC+PSwkBVhf4U4S
wDt+Gjt3kLa/1eXeC4prWt/5w8xo9GXU+ijsp6dkz7zv2Glm3tnjp2/JXNYytWU2
5j13M+DgjzjJawxoQXRUfpv4scrmGN9QFpZMzu9G/l9OF0g/G4F41Y84RF5KCPQl
HzZneGTeG5xGdL2IK0N5Shq5swr2+pAZti+t3nzOgamvygs7pkNdLIr3UwEVeipm
OdOEUvDr5g/cqkkmJyXbrzgIH6zPKOq6mjhHjQykIHYKOQdPkcSEg/sB43b3jWuD
KkD708dFbKHFsVyayJiQ5Qhe06Ut0zKeAhG3JsRuR209uY7b0H9zpeILde99lEI=
=KpGN
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
