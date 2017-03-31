Received: from eggs.gnu.org ([2001:4830:134:3::10]:45073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctzGD-0005Yc-OV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctzGC-0005D2-Sc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:18:49 -0400
Date: Fri, 31 Mar 2017 17:18:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170331161839.GA18974@stefanha-x1.localdomain>
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
	<20170331134033.GY3709@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20170331134033.GY3709@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 10:40:33AM -0300, Eduardo Habkost wrote:
> On Fri, Mar 31, 2017 at 10:27:44AM -0300, Philippe Mathieu-Daud=E9 wrote:
> > Hi,
> >=20
> > Eduardo you seem skilled regarding Coccinelle scripts, is it possible to
> > write one to find those overflows?
>=20
> Probably not. AFAIK, Coccinelle rules are based on local code
> syntax only. This means it doesn't know the data type of
> expressions like (s->tracks).

I'm surprised by that statement.  Coccinelle isn't a text matcher, it's
a proper C compiler frontend that parses the all code in the compilation
unit.  Therefore it must have the type information even for s->tracks.

Disclaimer: This should in no way be considered a volunteer offer to
write cocci scripts now or at any time in the future :).  I'm not fluent
in the semantic patch syntax.

Stefan

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY3oFfAAoJEJykq7OBq3PI8sEIAIziTfWcXTMEiAVLM+lhFTHx
cKwokgaw0XJWZasjHuL0J+LzaltHxaxJqvNJBQ8zbgab2B3iptNXaytwGLFYT0AX
K6JsZgYanUbW2VjJZ1ZHabCKppXbMtPOwgCZyv2M/dzVieVaOCAza0KtEpFecFyM
gcti05y0nhqmnnPIunOikhGPw7hihaisOS9FVoMR2XolbxxHyXsuUBuHEmnJNKgh
/rwWpkmBRBFYkHcBTONGgY03nKRmyBteNdpXjh+s4ASvMhvHeVOmGfklWgKmXdkF
scxjx61b7so+gTBLcOrgum67swzyi3a5Hq/BlRtzPlRFGYLXRz2quD/PUUR2iW8=
=CLmp
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
