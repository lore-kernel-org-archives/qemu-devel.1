Received: from eggs.gnu.org ([2001:4830:134:3::10]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyBG-00015D-4q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyBB-0005qI-8u
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:21:06 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpyBA-0005pp-TS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:21:01 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t189so65842339wmt.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:21:00 -0700 (PDT)
Date: Mon, 20 Mar 2017 14:20:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320142057.GZ17887@stefanha-x1.localdomain>
References: <20170317094714.32220.9387.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JefYhWJ8RkX3aR0a"
Content-Disposition: inline
In-Reply-To: <20170317094714.32220.9387.malonedeb@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1673722] [NEW] Reading register at offset. It
 is not fully implemented warning make VM impossible to use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1673722 <1673722@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>


--JefYhWJ8RkX3aR0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 09:47:14AM -0000, Julien Duponchelle wrote:
> Hi,
>=20
> Since this commit:
> https://github.com/qemu/qemu/commit/bc0f0674f037a01f2ce0870ad6270a356a7a8=
347
>=20
> We can no longer use the IOSvL2 image from Cisco. The problem is we got a=
 lot of warning message saying:
> e1000: Reading register at offset: 0x00002410. It is not fully implemente=
d.=20
>=20
> User got so much of this warning that they can't use the VM.

CCing the author and maintainers.

DBGOUT() is compiled in by default.  Warnings that can be triggered at a
high rate by the guest should be off by default or use a
printf_once()-style macro so they are only printed once and not again.

Leonid: do you want to adjust e1000 DBGOUT() usage to avoid printing
guest-triggerable messages by default?

Stefan

--JefYhWJ8RkX3aR0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+VJAAoJEJykq7OBq3PIzegH/RgQ5ylTsXaZq6JIsOTqwTP1
3LTC/33lHH2VIt+hYIPNY3yAA5YD7yAGBeE080JNenR+B08Sy5vYfvk4WRrQ/aF6
C9lktepbYs6TNCpD61bA4VFjNd1beCYR6T09SVj5WgoUCiWLaPEjDX5E9fGs4HoN
r+9En0UsB7cKxgi4Q0OoKUIWPhsFcSBQnuZH1bKSht+Yfqnp8Mw7XJr6JiA/k9h4
z8bsC/mqx43zeCMx0e58+9eCkZLML8Fx2Tri+fb8vog2jp76XrEUNraHG3qkqPhb
tDgkB+bTajlV7xdf43RlRzDp1lvNq7PFTe0dBAs2VRVQi4mFi42R4UrDXFHtKyE=
=CiS7
-----END PGP SIGNATURE-----

--JefYhWJ8RkX3aR0a--
