Received: from eggs.gnu.org ([2001:4830:134:3::10]:55169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkW2k-0008Mq-71
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkW2j-0005Oh-8p
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:50:02 -0400
Date: Wed, 23 Aug 2017 19:20:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823092017.GS5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<f34dbaefd1224bca33a9052107cd32b628400106.1503249785.git.balaton@eik.bme.hu>
	<20170823022833.GK5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231104210.76247@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7WENQHN97/U9vH7R"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708231104210.76247@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 11/15] ppc: Add 460EX embedded CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--7WENQHN97/U9vH7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 11:08:16AM +0200, BALATON Zoltan wrote:
> On Wed, 23 Aug 2017, David Gibson wrote:
> > On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> > > Despite its name it is a 440 core CPU
> >=20
> > As I recall 460 was supposed to be a 440 with SMP support.  Except
> > they screwed up the cache coherence, so it's basically unusable for
> > SMP (at least with Linux).  They finally got 440 SMP right in 470
> > IIRC.
> >=20
> > Or are you saying that the 460EX is more 440 like than other 460 cpus?
>=20
> AFAIK this SoC really has a 440 core with some of the embedded devices (s=
uch
> as PCIe and SDRAM controller) similar to real 460 core SoCs, so its name =
is
> a bit misleading. It definitely does not have a 460 CPU core so it's more
> like 440 than other 460 core SoCs.

Ok, noted.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7WENQHN97/U9vH7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmdSM8ACgkQbDjKyiDZ
s5L25w//bsv1Qkjjpvh2AN+AOmLZyOHUv4Jjhugq+07ATHGUayHhKAhe06HwasqZ
Wmuov9UIRnNEp6p8wkPhWtl3W7fH9nBRyFCWDyRt4/8XLdkOLrnxMvDgVjrm2Xip
pI9PYqJtqwJo2vHTml/nK7IFby9gckd7Ic+02dpiCEdy4sZzQYiMd18kn4UFDMTo
sVQjZYUeTsknVR3uf6dRgv/TID/0mhAlOiGKNygAwHwXOLhMVcI8sPFPrg+49UwC
GqeZSSXBXKyawrbhMeeoFMNMcn7xepqLwPTo7RVCJdj13GUjP3XhOBLeqIO/GA6r
SqY9idlSu70v7x1xaBT+JrWsCQWcryAxk88uykFtigSBGqD2CLzKjxCzV3p9y5wg
xZY17xFHd8SJ6e78NtfattUcPlaPzl8jpM5tYgBUpMIXys68B3kDARJ6HL5xm3hS
ERjd3IAwZozr49NZtqksNFUelHX7dx0oVYDoEU/4KkWYd+09eQpHFn1FUIudJW60
HdLEQhIdMPYy38M2rh6Xfg+Swfj7cnmwYfBAf7F8ieHDOKD5bd8zN0IO39ooOaA7
RUR/IhJmzYOfdtWdEk9x+SMf81TYLMwrfTGY+TJnV6UsTgNPNFUetlP5T+FwdCGB
FArJJzMHIhJIKxLfAGz/VKKrBYrDRB7/mlCwAmmeJ2yuOkUDxXM=
=5TWv
-----END PGP SIGNATURE-----

--7WENQHN97/U9vH7R--
