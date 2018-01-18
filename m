Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ec7aZ-0004Hu-01
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ec7aY-00073a-1N
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:38:31 -0500
Date: Thu, 18 Jan 2018 10:38:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180118103818.GB19831@stefanha-x1.localdomain>
References: <20180117090700.25811-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20180117090700.25811-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: add block_set_io_throttle
 virtio-blk-pci QMP example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 09:07:00AM +0000, Stefan Hajnoczi wrote:
> The block_set_io_throttle command can look up BlockBackends by the
> attached qdev device ID.  virtio-blk-pci is a special case because the
> actual VirtIOBlock device is the "/virtio-backend" child of the PCI
> adapter device.
>=20
> Add a QMP schema example so clients will know how to use
> block_set_io_throttle on the virtio-blk-pci device.
>=20
> The alternative is to implement some sort of aliasing for qmp_get_blk()
> but that is likely to cause confusion and could break future use cases.
> Let's not go there.
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaYHkaAAoJEJykq7OBq3PIRoMIAMhS/V2zSleczoyzJ+fx1j4N
iR8XEmG+x5GZ+ZwBeTv8AZHMZKqzoLKP4dSBN4M5POEOJQy1x1yGtByZmNmkdWzf
ubZ/cfCSYJCr3M8ZZBmHTy/1taykOIOnyxOXReFKMQ923ZeKRamagBlShP3TnHyK
3CdWz5t59SRrHP3AXsJzYwY3nbtyBrJoUedasWIb641IJuzIyah8COgdA9327H/1
DkJs3Fp8uUFYGe6k6vxkUzp+IfAa6MWrdqabvOAWMwyeJzJqRrLpgzB8gAP7UjP+
pBpJWw0paDqvi1XosiPQyPDeOhI9OWI3iH68/WHEiiazzwadJAQOidRtTEskviA=
=8QTD
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
