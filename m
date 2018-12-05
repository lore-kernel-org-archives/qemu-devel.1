Received: from eggs.gnu.org ([2001:4830:134:3::10]:59816)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gUeH9-0000c1-V5
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gUeH5-00057H-Nj
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:00:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:49757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gUeH5-0004t9-9U
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:00:03 -0500
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
Date: Wed, 5 Dec 2018 22:01:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WadgQwF92eHXv32DdFohH00AGwd3KmGY3"
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WadgQwF92eHXv32DdFohH00AGwd3KmGY3
From: Kamil Rytarowski <n54@gmx.com>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
In-Reply-To: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.12.2018 21:43, Ed Maste wrote:
> I'd very much like to have CI coverage for QEMU on FreeBSD, and as of
> yesterday there's a hosted CI service that supports FreeBSD: Cirrus
> CI. They also offer free service for OSS projects. I created a
> .cirrus.yml (shown below) in a QEMU GitHub fork and successfully
> executed a build test.
>=20
> I can submit a patch to add the config file, but wanted to ask for
> advice or comments from those who set up the existing Linux CI first.
> Is there anything I should be aware of or should address? Although
> this is a very basic build / test I believe it will prove quite
> valuable in reducing the latency between a commit and finding an issue
> on FreeBSD.
>=20
> .cirrus.yml:
> freebsd_instance:
>   image: freebsd-12-0-rc3-amd64
>=20
> env:
>   CIRRUS_CLONE_DEPTH: 1
>=20
> task:
>   install_script: pkg install -y git glib gmake perl5 pixman pkgconf
>   script:
>     - mkdir build
>     - cd build
>     - ../configure || { cat config.log; exit 1; }
>     - gmake
>     - gmake check
>=20

There are already FreeBSD, OpenBSD and NetBSD test scripts in the qemu
project.

I'm not sure whether there is any integration with GitHub.


--WadgQwF92eHXv32DdFohH00AGwd3KmGY3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlwIPIwMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZstmQP/RF+KwQH4EloJ+R5JCA7Wz49TB85es/qgTQ/LrhN
1CXuMgwcfBC9CZ4jurSh1BVjXioT5D4Y9DGpf6HtyRtT1if500zH73Dguyj4Zjci
7oCkheQeI1sqLqy4Xd+odIsLTJYdyb4YqNkCamVfip32W5kcwm3uBFbAUpi3n2/I
9mmzu7fUwn+kRow+ahLqA80QinsCdRfrD9i3hNeKOs1HSD1t2QHR9Y6Xy2gQlq5J
Ua3JitJNVh9Uy3UjnHGKst56JYW4WEtzC5VWiSw8MMu6uEm3PDi3Kn4cALX63KVI
7WMWqGyCA9m0Xa08u9OoIW+GZfD7GamdEzey2Fo3rhAFxKfpbtBSzu2xRpnYN7KX
yZ5EBLzEN/7djlem/4l5KEUb46moRAIPs8nVfNs2tntSLcEa4hP3eiWRyh14xyRE
Xe/zlZZypmZWZVQ6Gj3j8/i5Pya9f+CrPUF+uiJToxlCViUmUtzZvCE3xA2Eeg/k
eoe2CceiRY5QIoJxSmmRB7KwZQQx5xWzRq8clbGL49G71hxMSzpBVXYaWESra6HF
MW96hY8Bk8RstkMCIbaIWdiIJ0GXqN3mZD4axn7YuDkFM9hhBYErqiLvYaxeNng4
c0qPEkrwPhbO3dtftBY9lJYVYGB5M4sbcsREuN1XNwEb7nhV+iR2rYv7W20kCJnJ
uPNL
=M4op
-----END PGP SIGNATURE-----

--WadgQwF92eHXv32DdFohH00AGwd3KmGY3--
