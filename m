Received: from eggs.gnu.org ([209.51.188.92]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goIyu-0008Fq-J7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goIyp-0006Es-2G
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:18:32 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:36115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1goIyk-0006Cg-U2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:18:24 -0500
Received: by mail-pg1-x535.google.com with SMTP id n2so8082139pgm.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 18:18:21 -0800 (PST)
Date: Tue, 29 Jan 2019 10:18:15 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129021815.GA3264@stefanha-x1.localdomain>
References: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
Subject: Re: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, pkg-qemu-devel@lists.alioth.debian.org, crobinso@redhat.com


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 06:56:09PM +0000, Peter Maydell wrote:
> (1) configure: My thought is that we should just make
> sphinx-build a requirement for the existing --enable-docs
> switch (as texinfo and pod2man are currently). The
> disadvantage is that we won't support a "build the half
> of the docs you have the tools for and leave the others"
> setup. The advantage, which I think is significant, is that
> distros will naturally be directed to the missing build
> dependency (either they're building with --enable-docs
> and will get the configure message, or they aren't and
> then their build will fail later because of missing docs
> files when they try to put the built files into the package).

I'm CCing Cole (Fedora) and the Debian QEMU team so they can give their
input on this point and your next point.

> (2) What do we actually want to ship?
> That is, what do we want 'make install-doc' to copy into
> the installation directory?
> https://wiki.qemu.org/Features/Documentation
> has a good suggested breakdown of docs for where we
> eventually want to be. I think we probably don't want
> to install the "developer's guide" (docs/devel) on
> end-user systems. The others are presumably OK.
> Currently, we seem to only install manpages and a
> few other things in the 'install-doc' makefile target
> (we don't install a bunch of plain-text user-facing
> docs) so this would be a significant expansion.

I agree, developer documentation is not relevant to end-users.

> (3) Indexes, table-of-contents pages, etc
> Are we aiming to ship these?
> I think that we probably want to have what from
> Sphinx's point of view are multiple separate documents,
> so that they each get their own ToC and index. This
> means we can for instance ship the ToC/index for
> the user docs but not have it contain index entries
> for developer docs.

Indexes sound useful for each separate manual (user, developer, etc).

Stefan

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT7fnAAoJEJykq7OBq3PIDdUIAJueJRKaAHXx25HUUmKYHzoK
8hLM4Ve4AXhvcVf67/U1vpt/+MCq3gzco2917xdKQJnxkZ8sBgsxFIwIHObNYeq4
E+JZCyVWMLJh0xvEK+bIIE3p49BTAXfrZI9xMJKjxBykf98pBa10hlrB/jqDer46
75nAd1ax5MiNxOsfa+QvcNXquuK1GtTGpitpq/p41ojXTAtWzkvKEEb3SmO2NOFz
iTOkgKOAzsCiDNGyQzqXExQjMSfNIY26221hjWLKfNnKujapXUV7gw9baUWIM9bd
lj4wufQ2+0ekvJCQdCefsIQAcuKW6SN2sdMnVW1yStczChpIIikmK+2YCwW/pj0=
=FwRf
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
