Received: from eggs.gnu.org ([2001:4830:134:3::10]:41253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eatnV-0007kO-NS
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 20:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eatnU-00037F-LB
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 20:42:49 -0500
Date: Mon, 15 Jan 2018 12:42:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180115014224.GA2027@umbus.fritz.box>
References: <20180114020412.26160-1-f4bug@amsat.org>
	<20180114020412.26160-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20180114020412.26160-4-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] qdev: use
 device_class_set_parent_realize/unrealize/reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2018 at 11:04:12PM -0300, Philippe Mathieu-Daud=E9 wrote:
1;5002;0c> changes generated using the following Coccinelle patch:
>=20
>   @@
>   type DeviceParentClass;
>   DeviceParentClass *pc;
>   DeviceClass *dc;
>   identifier parent_fn;
>   identifier child_fn;
>   @@
>   (
>   +device_class_set_parent_realize(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn =3D dc->realize;
>   ...
>   -dc->realize =3D child_fn;
>   |
>   +device_class_set_parent_unrealize(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn =3D dc->unrealize;
>   ...
>   -dc->unrealize =3D child_fn;
>   |
>   +device_class_set_parent_reset(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn =3D dc->reset;
>   ...
>   -dc->reset =3D child_fn;
>   )
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

PPC parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpcBv8ACgkQbDjKyiDZ
s5KIMBAA2VsQYLz6EUa9ZuCCIlcqDnDfO3iNowUMMIlrJg+Bip5NTLPUb62PgJwi
5BMlEUjaQVD9trevqqQj7oaFMXZQqHEtiXADbvxIiumC+0pQTVlFzztElEAF2Hqd
lZ8TjKnoH5aQwKiU9ukggro6RDKF/S6I5uXGDTNVf41PVld0/gNLlvm5y+wCLIpf
1CcRimM7BMBqsaIfRW1lX+s+9dMJkmcA0eVPz0m0VYSCRSVX+3dW3MbCCsQiw6A8
8iinmSCyTqkLRZv9xtGjYu/riIZIgn91qLCWgmWn5/VnfpfHWReErwz/KQxmaVl/
maeoOjqtX7tlPjMwJIYLl2fz8ip0fU2LP6+HH1w7x5jKuD8AMtaBsKOIksHzCjJE
whfTEo6D3RA/ueBW+3FKMK3XW70a42wHiENy+UagKxXwHRpGae1KshpgFubb/gpw
BFnBeapExqCVZyZnRkdcgbUpEmae0VoOI5BNZbE8/swZKgAp7zzDMFDs5+I/EEEA
gzgcS+7Gz0R8n4N7mr/DCJ1ZFP09k82yIOjxo/VcSWfR4bj28eObJmzfGk21pMsK
4FWXj3msSye6f+mpa6GIPLxuaTVqLtQ565DqQgB2CO5AYDlkzPHCGMfxbT6a7kWe
QqVW/JDI3RM89N4TCPrgFChseb9UMV26Yo9kKWvCAV4CKjkXmeQ=
=QhOf
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
