Received: from eggs.gnu.org ([2001:4830:134:3::10]:51766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZj9-00067V-Pq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZj2-00055V-2g
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:20:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYZj1-000546-Sc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:20:19 -0400
Received: by mail-wm0-x242.google.com with SMTP id p204so7351430wmg.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:20:19 -0700 (PDT)
Date: Fri, 21 Jul 2017 16:20:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721152016.GI18014@stefanha-x1.localdomain>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-9-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <20170717081152.17153-9-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/9] virtio-crypto: use virtqueue_error
 for errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 10:11:51AM +0200, Ladi Prosek wrote:
> virtqueue_error includes the queue index in the error output and is prefe=
rred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 49 ++++++++++++++++++++++++-----------------=
------
>  1 file changed, 25 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZchuwAAoJEJykq7OBq3PIxlYH/R3pnca7yIi0d6BRVmhm96uf
a6inpQSDoA1uSkvvnAlOk34Ejl1nX5XBenvfvk+fyXp0vqZBtcumPrRlyoK6LAm5
wmwBfCy79PMBiC7G7TG52EnUYfQeOGHViAPCKIv3tf6H5w5xnc8gkRX1QL5Etkqm
d6q/ralltwdi2aG7JuNKEYITtkesDTeV5AKi9Y6HNzyLClDWHwbE75igv1t4aQ3L
nU6/yq2O/edYD4sRGm879QhLKv+Sj1J9kHpjm8uDRAL2qCAxu0PqgAB2RlnD0Je4
Qm6WiQZz1srMGbP06tEBXAZTE7rNF9SH7g/rklhqpIXyQflgHh/nVAlMjytX5/U=
=YNTz
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
