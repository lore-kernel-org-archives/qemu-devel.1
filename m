Received: from eggs.gnu.org ([2001:4830:134:3::10]:44097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crXZ6-0008Vx-8e
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crXZ3-0004zj-3o
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crXZ2-0004zH-S2
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:20:09 -0400
References: <20170324212115.6772-1-Andrew.Baumann@microsoft.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b72685e-c176-82f1-a540-c2e317f5374f@redhat.com>
Date: Fri, 24 Mar 2017 17:20:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170324212115.6772-1-Andrew.Baumann@microsoft.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8q8Vu0HORCWqbEVB7RXKm8KVF0ka6FRrl"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio: fix vring_align() on
 64-bit win32 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8q8Vu0HORCWqbEVB7RXKm8KVF0ka6FRrl
From: Eric Blake <eblake@redhat.com>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <1b72685e-c176-82f1-a540-c2e317f5374f@redhat.com>
Subject: Re: [PATCH for-2.9 v2] virtio: fix vring_align() on 64-bit win32
 platforms
References: <20170324212115.6772-1-Andrew.Baumann@microsoft.com>
In-Reply-To: <20170324212115.6772-1-Andrew.Baumann@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 04:21 PM, Andrew Baumann wrote:

So is 'win32' really a 64-bit platform, or should the subject be '64-bit
windows'?

> long is 32-bits on win32, which caused the top half of the address to
> be truncated; this patch changes it to use the QEMU_ALIGN_UP macro
> which does not suffer the same problem
>=20
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
>  include/hw/virtio/virtio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8q8Vu0HORCWqbEVB7RXKm8KVF0ka6FRrl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1ZuQAAoJEKeha0olJ0NqrDUIAI9ABTOnGUsucmtUFprzfO5x
p/zVVzMgr6zhxPiCUcSelOBXD8+yXo35xPwiPsYSMqWb6tFs1khHbtrjbFMSMeNS
negl5uDuSMDlIcY3T/mZ2yGjTa8bmHfPe9kzWsb2rsess6CRp2JsXjNWkAm9DSpV
ED3gX27vep1Q9hr45dqK5WnzSRysc/1NODrTGH4QT0r55EHnfEtBJ8J8TFIED0zk
XIhxv2AW1ywlinFzDYLYehJq0jjWuI3ijdxcXCZpRC0brEN+NqKuyD8u6v5aLD/Z
KA4AOv5YRQyH+P7wd0TgTObyu0OBefzZM5K5g/nDHaT3S5lcTOJBx2+cwH7TN0w=
=iIzW
-----END PGP SIGNATURE-----

--8q8Vu0HORCWqbEVB7RXKm8KVF0ka6FRrl--
