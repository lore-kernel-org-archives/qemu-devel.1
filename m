Received: from eggs.gnu.org ([2001:4830:134:3::10]:42277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoY1b-0006Ai-3F
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoY1W-0002pT-6x
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:17:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoY1W-0002pG-2X
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:17:42 -0500
Date: Wed, 21 Feb 2018 17:17:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221171725.GG21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-15-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 14/23] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:48PM +0800, Peter Xu wrote:
> Originally QMP goes through these steps:
>=20
>   JSON Parser --> QMP Dispatcher --> Respond
>       /|\    (2)                (3)     |
>    (1) |                               \|/ (4)
>        +---------  main thread  --------+
>=20
> This patch does this:
>=20
>   JSON Parser     QMP Dispatcher --> Respond
>       /|\ |           /|\       (4)     |
>        |  | (2)        | (3)            |  (5)
>    (1) |  +----->      |               \|/
>        +---------  main thread  <-------+
>=20
> So the parsing job and the dispatching job is isolated now.  It gives us
> a chance in following up patches to totally move the parser outside.
>=20
> The isolation is done using one QEMUBH. Only one dispatcher QEMUBH is
> used for all the monitors.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 178 insertions(+), 23 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajamlAAoJEJykq7OBq3PI7WMH/3qDqU6MY/i2SpABUYR1ljNQ
BctW9756IpQde3LXtyMMzlGaP/zBe78AC9Blg9F9PS2Zixbr+5Ykf/i2BNj27ZZV
DilrMs/3TqIHPHcMyQ+syfetHQzr7xgmIEKy89nLALB51xvP/ZAe88A8GbM2vT/i
bHHJqJN1x6rg0ZGyZY6/nju92pA+7Vn9ht+ro5KSFCzF4+13bLib/U3hwWxldv/l
Gb9HjxGpwds0g+tN9/6n0Tc1Eij+8qH0PGjkE4HdZvWmPAcXCK+EmeUbP3IzD++Q
ABsvo0e0HIYEXURK9PvlidkyvKqDzP6pc2Yy+vVS7+sRSonEIWLU7zdsOKikRhc=
=7K2r
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
