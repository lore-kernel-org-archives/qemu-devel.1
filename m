Received: from eggs.gnu.org ([2001:4830:134:3::10]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCRaD-0004Jg-HY
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCRa8-0002bf-MM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:44:01 -0500
Date: Wed, 8 Nov 2017 14:43:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171108144351.GB6118@stefanha-x1.localdomain>
References: <20171108032052.20029-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20171108032052.20029-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] Makefile: simpler/faster "make help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 12:20:52AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Using obscure black magic introduced in eaa2ddbb767 :)
>=20
> In an out-of-tree directory, running "../configure && make help" will gen=
erate
> some required files (.mak), then clone some submodules, compile at least
> the capstone submodule, generate QMP and Trace files, and finally display
> the help.
>=20
> On an outdated computer (Sun Blade workstation), running "make help" took
> more than 5h :) With this patch it took roughly 37min.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAxgnAAoJEJykq7OBq3PIdcUH/iZB2q2ZFqsXIQDGUwF6IFNG
sDQAATsZFoVU2AqmuITmKvpXUDKh1pGpA2CDaYKyWCf1q5G6BPt5ycqjKwVc33kC
9R62/ufUj1PxnLWW3CBXx6be/YJ5sdvITwWCTgPpMpJu+ghK8vHmimNvszkHgDh4
4gnptlb8DrH/EOZLJbaNtt5NePjAIooBlxZWc/07+iZgIR12CaHAMOZSyW2CzXnH
NYY6Aj8yPMiwospUSD+xqMJ9I5UuRTGnxN9gPV2dMdu7uypy7i8mGLBEiZ8KPIDY
dk63fS4503v8HDvLtZXNQ/IYrrjDcmusaA5bgaq6R00/Wt2C9ga4QLj1Kpv9ry4=
=AtsM
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
