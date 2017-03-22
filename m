Received: from eggs.gnu.org ([2001:4830:134:3::10]:56342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqkVo-0007sG-ED
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqkVl-0005wn-CA
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:57:32 -0400
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
	<1490204908-26567-18-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86365af6-9184-bf7d-8e42-66c120ff8ba3@redhat.com>
Date: Wed, 22 Mar 2017 12:57:26 -0500
MIME-Version: 1.0
In-Reply-To: <1490204908-26567-18-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MFcwHJ1XnM3qpdEidcOn5te501lhOwFxF"
Subject: Re: [Qemu-devel] [PULL v2 for-2.9 17/17] qapi: Fix QemuOpts visitor
 regression on unvisited input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MFcwHJ1XnM3qpdEidcOn5te501lhOwFxF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <86365af6-9184-bf7d-8e42-66c120ff8ba3@redhat.com>
Subject: Re: [PULL v2 for-2.9 17/17] qapi: Fix QemuOpts visitor regression on
 unvisited input
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
 <1490204908-26567-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 12:48 PM, Markus Armbruster wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> An off-by-one in commit 15c2f669e meant that we were failing to
> check for unparsed input in all QemuOpts visitors.  Recent testsuite
> additions show that fixing the obvious bug with bogus fields will
> also fix the case of an incomplete list visit; update the tests to
> match the new behavior.
>=20
> Simple testcase:
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -=
numa node,size=3D1g
>=20
> failed to diagnose that 'size' is not a valid argument to -numa, and
> now once again reports:
>=20
> qemu-system-x86_64: -numa node,size=3D1g: Invalid parameter 'size'
>=20
> See also https://bugzilla.redhat.com/show_bug.cgi?id=3D1434666
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Message-Id: <20170322144525.18964-4-eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [Fixup squashed in]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Fixup squashed into the wrong patch. End result is the same, though, so
not sure if it is worth a v3 pull request.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MFcwHJ1XnM3qpdEidcOn5te501lhOwFxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0rsGAAoJEKeha0olJ0Nq2jAH/iyNd2Tj/nAQlWeYKJkuOgVk
zGVA5DeYW+13jI4GCggI/BTKO7Ckc5U2s2J1p8UNTq4Gk5NTa3hLydcnZN3TELhr
SUEiVwz1zHicbhcczgNrcEqI5S6RAuX2VF4PaM0vf4WhMj0s+1HFW+DTdcA4Dt+A
5H8tN7zEKI4yOH+fTzz1XaUwd5tduoY8CKlDsQaz5jA57W3a7D1E5+FUBtK9Xb/A
fYQkVdiaIO78LJZYoeSgJynOMyfh/Bgr5E1uH/XZ5kEvbd53uxACL2lnrOTKjR/6
sMwEpZB4+pn5MwFbqWA24xK1AzP8Kx2vnkrgExLna391ytQhn74L9JpjaS+0Vgs=
=2fvj
-----END PGP SIGNATURE-----

--MFcwHJ1XnM3qpdEidcOn5te501lhOwFxF--
