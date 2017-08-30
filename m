Received: from eggs.gnu.org ([2001:4830:134:3::10]:43018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8cz-0005c2-6Q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8cy-0002RD-64
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:26:17 -0400
References: <cover.1504112256.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6eaefaee-a0a4-1828-5aa4-818813046fd0@redhat.com>
Date: Wed, 30 Aug 2017 14:26:02 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fdl4bVbwFf3q7IikCPjveciQbvIJ08BfM"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Live block optional disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, mrezanin@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fdl4bVbwFf3q7IikCPjveciQbvIJ08BfM
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com,
 peterx@redhat.com, mrezanin@redhat.com, jsnow@redhat.com
Message-ID: <6eaefaee-a0a4-1828-5aa4-818813046fd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Live block optional disable
References: <cover.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 12:01 PM, Jeff Cody wrote:
> This series adds a configurable option to disable live block operations=
=2E
>=20
> The default is that live block operations are 'enabled'.
>=20
> Jeffrey Cody (3):
>   configure: Add option in configure to disable live block ops
>   block-jobs: Optionally unregister live block operations
>   hmp: Optionally disable live block operations in HMP monitor

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

However, per the discussion on 2/3, you probably want a v2 of this
series after we land conditional QAPI support first.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Fdl4bVbwFf3q7IikCPjveciQbvIJ08BfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnEUoACgkQp6FrSiUn
Q2qlaQgAh8asFHXp/iqdGrxKemFP38fK3U33EFrSfn4hlzktKhBkHXRJW7oyg3Np
IpfsRwle93T6K+KdpxjoOcAAs/CzV/wJKuVpW8S+FaFPqVw7UlpuBGlGIlURSSdG
Xtpq0oZFiu5n5I2zPY0vSQRnzRHb+NlbEEcTBbA5npskR08wDrBm2TmgXB1DmmL9
ZpYEW5Id1wmOZOf9YYurEYcAc6Hp83ytCDAAKQt1g6vYpvi1k9xBY6hW79QmiCKR
t6kk/r8dXxH9BLYFe0/XYybbgGPwn6VeUdua7Tr4LWDOyvoJt4ApM9sniSBE2MRX
pAr0UmSxl/2TZG9gy5+xb3XXZKlEJA==
=25Dx
-----END PGP SIGNATURE-----

--Fdl4bVbwFf3q7IikCPjveciQbvIJ08BfM--
