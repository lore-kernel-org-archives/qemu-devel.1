Received: from eggs.gnu.org ([2001:4830:134:3::10]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctbrr-00037r-MR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctbrq-0001su-LS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:20:07 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <803b1948-3968-7068-8f75-a3d77746ea22@redhat.com>
Date: Thu, 30 Mar 2017 10:19:55 -0500
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nfpLLVebs6ST3RkNrwEqMLbeC05rtgcpS"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 09/10] squash! nbd: Tidy up
 blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nfpLLVebs6ST3RkNrwEqMLbeC05rtgcpS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <803b1948-3968-7068-8f75-a3d77746ea22@redhat.com>
Subject: Re: [RFC v2 for-2.9 09/10] squash! nbd: Tidy up blockdev-add
 interface
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:15 AM, Markus Armbruster wrote:
> Drop backward -drive server.data.* compatibility gunk.  On squash,
> replace commit message's last paragraph "Unfortunately, SocketAddress
> is also visible..." by:

Maybe I should glance at the whole thread before reviewing without
realizing what is coming later ;)

>=20
> Unfortunately, SocketAddress is also visible in -drive since 2.8:
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.data.host=3D=
127.0.0.1,server.data.port=3D12345
>=20
> Nobody should be using it, as it's fairly new and has never been
> documented, so adding still more compatibility gunk to keep it working
> isn't worth the trouble.  You now have to use
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.host=3D127.=
0.0.1,server.port=3D12345

As pointed out on 8/10, it might be worth documenting that while legacy
'port' is optional, the new 'server.port' is mandatory.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c | 41 +----------------------------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)
>=20

When squashed with 8/10, it does make that patch more palatable (all the
concerns I expressed there were ripped out here).  So if no one else has
a strong argument for keeping 'server.data.*' back-compat, then the
squash of 8+9 together can have:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nfpLLVebs6ST3RkNrwEqMLbeC05rtgcpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJY3SIbAAoJEKeha0olJ0NqoMcH+NriDhH/a3Uvd7thugNN+AWW
5lluApRAgP5nGnJ8W5Ez2fLznqwtxoRBTZ795d25U2D67WAi42FOAXN1MGMwMBk7
RyVC30NTQegxf+yzSdDYqG6QY8j2RUiofkeTMlCNQKPZKKhOIL6F4RvEMI485o9+
ZqbAaStFzCqQ1rpKHdJOCue5IqiTDcAAbaAWXDLA8BtXS1TVbpjnbtXWWLe6c/9Y
MlXBTb0Ftx8r9Vaa/cNn37+7QDR8tTdq9QIti8oGnCFScqJ7kzaBFlqeffFVlNAh
un3YrYvUO/xH+yft7bCJ4lwM/+1P99Qq+D4WzW6yxUeJAIk9OTnpje5Xm7nvZA==
=KSR3
-----END PGP SIGNATURE-----

--nfpLLVebs6ST3RkNrwEqMLbeC05rtgcpS--
