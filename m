Received: from eggs.gnu.org ([2001:4830:134:3::10]:49584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eBmg1-0001r1-AV
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eBmfx-0000bA-EL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:03:17 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eBmfx-0000Zd-80
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:03:13 -0500
Received: by mail-wm0-x241.google.com with SMTP id n74so11746841wmi.1
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 11:03:13 -0800 (PST)
Date: Mon, 6 Nov 2017 19:03:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171106190308.GJ4557@stefanha-x1.localdomain>
References: <150963549061.4171.11895725981979057755.malonedeb@gac.canonical.com>
	<150994423312.8654.11697877487416250001.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Content-Disposition: inline
In-Reply-To: <150994423312.8654.11697877487416250001.malone@wampee.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1729623] Re: test-aio-multithread fails with
 'Co-routine re-entered recursively'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1729623 <1729623@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 04:57:13AM -0000, R.Nageswara Sastry wrote:
> I could re-produce using the following command,
>=20
> # MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gtes=
ter -k --verbose -m=3Dquick tests/test-aio-multithread
> TEST: tests/test-aio-multithread... (pid=3D116074)
>   /aio/multi/lifecycle:                                                OK
>   /aio/multi/schedule:                                                 Co=
-routine re-entered recursively
> FAIL
> GTester: last random seed: R02Seb8ebc3a9c10406e7725cdff556c14e4
> (pid=3D116088)
>   /aio/multi/mutex/contended:                                          OK
>   /aio/multi/mutex/handoff:                                            OK
>   /aio/multi/mutex/mcs:                                                OK
>   /aio/multi/mutex/pthread:                                            OK
> FAIL: tests/test-aio-multithread
> [root@zzfp365-lp1 qemu]# echo $?
> 1
>=20
> No important dmesg messages.
>=20
> Trying with gdb

Thanks, the backtrace was useful.  I have sent a patch and CCed you.

Stefan

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaALHsAAoJEJykq7OBq3PIfG0H/0VOf9zegGQtix5zZ36vkFz0
TzDCFjDugng7eGXHKR8qHZ8BCNYkU95knKmfHQrzvr+4gLh5ehm4OMQD2ShI7qTZ
3o35rz6f/X4t+Lpg05OC7Bgj+zUe2zTe6U2tqC+sm+DsGFiNjdh46QFcYARlYy2T
ZZVqaXJSZXS6YNCcr8ZrI3DfUA5wF6INZzadJHSJxaHpGXSDvSCUFLx76BmdMs2K
BPe+mWPZr+kP2EZDcUJ5lsbha2EwZ1FO/joW/6TBWBh0gYY19+IwHDpl0mlw+4GT
2JcI35R7k/X85AdnN1H+taqr/17QxxqsY0ywpW6bOjCeP7IIveI9DiGrZlqCYbQ=
=LKHg
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
