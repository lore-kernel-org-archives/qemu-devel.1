Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8iWb-0003iC-1W
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8iWa-0007Nx-8z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:33:09 -0400
Date: Wed, 18 Apr 2018 10:32:44 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180418103244.6c65fa60.olaf@aepfle.de>
In-Reply-To: <20180418081311.27803-1-olaf@aepfle.de>
References: <20180418081311.27803-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/u=NnQqes0uyiGNyvv1=8SbP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] roms/ipxe: use configured compiler for
 ipxe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>, "open list:All patches
	CC here" <qemu-devel@nongnu.org>

--Sig_/u=NnQqes0uyiGNyvv1=8SbP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 18 Apr 2018 10:13:10 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> configure allows to run a dedicated compiler binary, which is stored in
> CC and HOST_CC variables, and overrides the default 'cc' command.
> This command however is not used when building ipxe from source.
> "make -C roms pxerom" invokes ...

Scratch that patch. make -C operates just below 'roms/' and does not use
results from configure. The CC variable built into make(1) happens to be cc.

Olaf

--Sig_/u=NnQqes0uyiGNyvv1=8SbP
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWtcCrAAKCRBdQqD6ppg2
fg/ZAJ9GKcdLcXaxAI+D8CF7DfoeDxBEVwCg63bNQy6HJCSVYPwsPUMs5y5wcCU=
=rTPu
-----END PGP SIGNATURE-----

--Sig_/u=NnQqes0uyiGNyvv1=8SbP--
