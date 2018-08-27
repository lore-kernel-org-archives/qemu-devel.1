Received: from eggs.gnu.org ([2001:4830:134:3::10]:60996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fuJDe-0001p2-K1
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fuJ8Q-0006wr-Uy
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:08:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1fuJ8Q-0006wM-OY
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:08:54 -0400
Date: Mon, 27 Aug 2018 17:08:45 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180827150845.GK122225@angien.pipo.sk>
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Content-Disposition: inline
In-Reply-To: <1535381652-19870-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/4] Remove more deprecated
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 16:54:08 +0200, Thomas Huth wrote:
> These options are deprecated since at least two releases, and nobody
> complained. Time to remove them now.
>=20
> (I'm sending these patches as a series since Paolo asked me to send a PULL
> request on my own for them ... but if one of the subsystems maintainers
> prefers to take the patches through their own tree instead, just let me
> know)
>=20
> Thomas Huth (4):
>   Remove the deprecated -balloon option
>   Remove the deprecated -nodefconfig option
>   Remove the deprecated options -startdate, -localtime and -rtc-td-hack
>   net: Remove the deprecated -tftp, -bootp, -redir and -smb options

Libvirt does not use any of the options above thankfully so a weak-ACK
=66rom the libvirt side.

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluEE/sACgkQHGwCByjY
1GqGoA/+K6y4dGElfnJGWq2s/1YOC3x07HiW2E3Attt2/qm8uRDK0K2SrbWZTBeQ
DELIqzPMb633y6tiCJdEFxxX5c3awgbze4iRNqnTYXmAlp0r0OUqnQkqu3wvanTE
ADaLN13+syyQ9RA7R9haokQDFNd+nTkhEYDFMYm2ZtG8Qk9/vOSqzVkPRnBonCHP
Q1dJwFBN3jzHY2bF80hJfPoW5sOblDNMpSKzOSrUYZyu+AG/ngLqTy3pu7mmGks0
FBgm4EnZ+4O/38wisBzu3hcD+YO267xU6zrb/zqQasA2tcnWhx1g0CCLAL4F+tee
L4Y2uoCaqDkcGrcvcA1dZ4pN0Nl6oaEGgJrBKFsJ+IekIMHCQZiDBtUHpjcqDQFQ
7adc9MYnGLz0CY9fUgDvj5cq4izL67Pysey2NEyT1sRbgDRVF5VYEh25IMU9XvjA
hrtPEJfNTLdWQlhftBf6WbzgQ28FwjEkRi9gohTpQc49J/qlIjEvEHoQ9ifZknwa
JqwiLV1J8nB03p/wiC3D/wWpIMFN7E5GEp0zcAEgneiaXHP+wQ5j72wdwcKniPBk
X4pyGNVF2Hp0z1OwzrryEZGUs6iTZ3/QbyYtGbD2n5MCORz0yPBCSphSq6KHC0nO
u0/8/ttcp/kQVdqX2drsxc2me/M4rZ1g8uGQfBHZ5fbXEr4yeyA=
=VXVx
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
