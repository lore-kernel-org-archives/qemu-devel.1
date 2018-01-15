Received: from eggs.gnu.org ([2001:4830:134:3::10]:51566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb50v-0006aa-Vs
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb50r-0001Mm-1l
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:41:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eb50q-0001KV-Rm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:41:20 -0500
Date: Mon, 15 Jan 2018 13:41:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180115134109.GF13238@stefanha-x1.localdomain>
References: <20180112141745.28389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20180112141745.28389-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] ucontext: annotate coroutine stack for
 ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 03:17:45PM +0100, Marc-Andr=E9 Lureau wrote:
> It helps ASAN to detect more leaks on coroutine stacks, as found in
> the following patch.
>=20
> A similar work would need to be done for sigaltstack & windows fibers
> to have similar coverage. Since ucontext is preferred, I didn't bother
> checking the other coroutine implementations for now.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/compiler.h   |  4 ++++
>  util/coroutine-ucontext.c | 48 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  .travis.yml               |  3 ++-
>  configure                 | 41 ++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 93 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaXK91AAoJEJykq7OBq3PIAz4IAK0PwxgA2rQew5r/rOTGn95z
FoAmXQzmH+m3wbLA1/B9J7afVK/Gps7q8GRmBCIfHQLaRq/ztPuiebDmFv3vwsWx
dlIyvIEC41ZdA2LaNc3s9shwWfOaRwF6nd6JLM4/77Rut9riJx4lggFZKOOFk+rF
o3Y6FM/COZS+FDnqaPgSTPSVcEhju9U63DLhthk9bluYd0F21F8A1VnU7CHielNd
a7hXGcJMzVDUb2kp65gMuCC1bpBx7CXNXenYX2NhINH81dXh7HbQTX6PU0nA6FXa
ub6FmoKQuFMRR4AyENCYUsLkF48evRDQjFZtBacLSlCLOpFvFBNl630WHD6Chbg=
=k5d9
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
