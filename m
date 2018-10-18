Received: from eggs.gnu.org ([2001:4830:134:3::10]:57863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gDACQ-00070l-0S
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gDACO-00047U-QU
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:26:57 -0400
Date: Thu, 18 Oct 2018 16:26:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181018152630.GA3442@stefanha-x1.localdomain>
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<71d3b9366dc8e7f0dab1f290d5944cb84e3cc876.1539860473.git.artem.k.pisarenko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <71d3b9366dc8e7f0dab1f290d5944cb84e3cc876.1539860473.git.artem.k.pisarenko@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] Introduce attributes to qemu timer
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:29PM +0600, Artem Pisarenko wrote:
> Attributes are simple flags, associated with individual timers for their =
whole lifetime.
> They intended to be used to mark individual timers for special handling b=
y various qemu features which have integration into qemu-timer.
> New/init functions family in timer interface updated and refactored (new =
'attribute' argument added, timer_list replaced with timer_list_group+type =
combinations, comments improved to avoid info duplication).
> Also existing aio interface extended with attribute-enabled variants of f=
unctions, which create/initialize timers.
>=20
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
>=20
> Notes:
>     v3:
>     - attributes has been properly incapsulated to qemu-timer (as suggest=
ed by Stefan Hajnoczi)
>     - attributes definition and docs refactored to avoid extra enum and u=
se simple macros with explicit bit positions (as suggested by Stefan Hajnoc=
zi and Paolo Bonzini)
>     - fixed old "QEMU_TIMER_ATTR(id)" notation (in comments) left from in=
itial patch version
>    =20
>     v2:
>     - timer creation/initialize functions reworked and and their unnecess=
ary variants removed (as Paolo Bonzini suggested)
>     - also their comments improved to avoid info duplication
>=20
>  include/block/aio.h       |  59 ++++++++++++++++++++++---
>  include/qemu/timer.h      | 110 +++++++++++++++++++++++-----------------=
------
>  tests/ptimer-test-stubs.c |  13 ++++--
>  util/qemu-timer.c         |  13 ++++--
>  4 files changed, 125 insertions(+), 70 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbyKYmAAoJEJykq7OBq3PILBkIALYxT8+9bw0r0f1scd9DITA0
1Le/LX3TqrugD63SNigsu38nAiXfqkrWiXESt90xpP3X8B8NpXyEEK/rSZ6SCba3
X7p9eighYnSeYLxui3PtmgInWMkU5JWmdrvi05X/c08crIkUx1iuNpfARohOXOAP
dfp03kiXr5/FaQy3uC/nZxDIcdahHz0A3YpjSw0bJ+OJgMJdGuDLbTJ7tmVCqf0p
3zp2n1/i7age8dsqf+FBe3BaDKB4V7bDoRoXIc1d5ots5MyLdnEOxbO/3eAX9eXh
D7VPRKP36H5ixIpvZF7v9UBYvF4pHPV1iLo4sGvoT7PcEBrE4IT6xe7czSEqhS8=
=9eca
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
