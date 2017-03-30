Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctaoT-0003mO-Px
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctaoP-0002Jk-KV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctaoP-0002JU-Cp
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:12:29 -0400
References: <20170330071437.1125.65090.malonedeb@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a1781f3-2921-10b6-aec3-23d35f074481@redhat.com>
Date: Thu, 30 Mar 2017 09:12:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170330071437.1125.65090.malonedeb@gac.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ewANngDiBbC3E4FnO4LuEt5eGcWqetdOM"
Subject: Re: [Qemu-devel] [Bug 1677492] [NEW] block_set_io_throttle
 complaints Need exactly one of 'device' and 'id'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1677492 <1677492@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ewANngDiBbC3E4FnO4LuEt5eGcWqetdOM
From: Eric Blake <eblake@redhat.com>
To: Bug 1677492 <1677492@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <7a1781f3-2921-10b6-aec3-23d35f074481@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1677492] [NEW] block_set_io_throttle complaints
 Need exactly one of 'device' and 'id'
References: <20170330071437.1125.65090.malonedeb@gac.canonical.com>
In-Reply-To: <20170330071437.1125.65090.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 02:14 AM, dE wrote:
> Public bug reported:
>=20
> All of sudden, after a qemu update, block_set_io_throttle does not work=

> anymore.
>=20
> Full command to QEMU monitor --
>=20
> (qemu) block_set_io_throttle db 0 0 0 0 0 0
> Need exactly one of 'device' and 'id'
>=20
> The help text still point to the same old syntax, which no longer works=
=2E

Broken in 2.8, fixed here (will be in 2.9):

commit 3f35c3b166c18043596768448e5d91b5d52f8353
Author: Eric Blake <eblake@redhat.com>
Date:   Fri Jan 20 17:03:59 2017 -0600

    hmp: fix block_set_io_throttle

    Commit 7a9877a made the 'device' parameter to BlockIOThrottle
    optional, favoring 'id' instead.  But it forgot to update the
    HMP usage to set has_device, which makes all attempts to change
    throttling via HMP fail with "Need exactly one of 'device' and 'id'"

    CC: qemu-stable@nongnu.org
    Signed-off-by: Eric Blake <eblake@redhat.com>
    Message-Id: <20170120230359.4244-1-eblake@redhat.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ewANngDiBbC3E4FnO4LuEt5eGcWqetdOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3RJLAAoJEKeha0olJ0NqMncIAKJFY1WPv7cFMuilld73n123
hXVG9LTPtcNn5BzXYoGhyrdywLbR41ozGIY1M8HCfU+DgFwXUH84NUddUeoegcJO
XYZa/DgegaDUfxLBwFgyufgjUaDoWGUnb2iwDhHxia9nilqY8ko89HOGHxgA4m18
59X6GMPTYCJOxSFxV6IlJWcML1JJnfTPZn+lrLpZMwdiiwwc6gU6RGuFn9QbT8FR
ZeG0a47v50lgkm9J0QsJ1uB6NERax9M738aLbHhc75S/1AfZN2HuKGQ+kmlOySPW
Rapwdf9rOiZQWlF1VEVDtxeXw3g05Fz6pNTj5DtCeTAcg556GiEG4JFqSZfFzGs=
=CIjS
-----END PGP SIGNATURE-----

--ewANngDiBbC3E4FnO4LuEt5eGcWqetdOM--
