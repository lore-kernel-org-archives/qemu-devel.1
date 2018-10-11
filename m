Received: from eggs.gnu.org ([2001:4830:134:3::10]:36348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gAWLb-0000qd-Ji
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gAWLa-0004Sy-UR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:29:31 -0400
Date: Thu, 11 Oct 2018 10:29:17 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181011082917.GI2052@andariel.pipo.sk>
References: <20181009193524.19052-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline
In-Reply-To: <20181009193524.19052-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 21:35:20 +0200, Kevin Wolf wrote:
> Peter, would this provide what libvirt urgently needs for backing files
> vs. the commit block job?

This looks fine for us with one exception. I'd prefer if the curl driver
implemented this too so that we don't have to hardcode the readonly flag
for that as well.

With CURL based backend backing an image I get:

-blockdev {"driver":"http","url":"example.com","node-name":"libvirt-2-storage","discard":"unmap","auto-read-only":true}: curl block device does not support writes

I've tested it with libvirt's usage of -blockdev together with
block-commit and also with read-only-NBD backed images and everything
seems to work well for me. I'll report back once I give it more testing.

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlu/CdoACgkQHGwCByjY
1Grq5g/+LaBz52/xQeDK3hU4CPpt+WH+OQ4ijC5pDbZLP26iBPFVXeRqx5YbiuXl
nYrLyogWPzQBXaqIi7WGOUTbUxkOhKVs61tOz3vTok9S7jc55JkWoejQHMOWaRv0
Nj4A+SifzmetztXJsbT+lBiJOYX9RguwBgYipP7NcXRF5fPzdBdSaBhp/Y7ENss2
WJeH0KzRHuYmF3jBG8Ndn14e7Z36rDs8p1l3tda9vSKisw4i28jk1kefXFxdgNbP
W5qMHjRFSXPOFgM8arm1fPL8omrds50nMLfTxJ4jOtGAFd46TWCXbNJzyzU+amsG
3pvxXG/uDrx6WwcCSuDm71rxmlIGbFZQvsizGtYsbKz859k5LuvNBG4e4y5NtGLI
gnSmHK/jfgcsFITKXg3A8z9CabCkCEYBnXnlw1PHuVIVGkiwTjBYEGQSFNG1O+RT
9XFkxcZlQVLmkYQDTCTbSqCroXu9VAyCy0VuGXzNNxaT27/wA4yFaDGGpIupWzh6
shXRr5errWj8rZZlL3yvGSYJjBa/fGTZLrKg2VsZqnZfvNVWq/VyZEc6D86k+bjP
lHCCaTTsv/U+SUTIY7MnlsM/hu29KvGsGtpeOFRXFDZ7rl2Z3msIF+CRqsaD/V7c
yZE9M8rF1qDAU2C4dV6jTOy1/sLA68Zg6GkiD7P0xi4S+rBKRqg=
=0JnT
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
