Received: from eggs.gnu.org ([2001:4830:134:3::10]:50464)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dhuce-0000RM-FU
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dhucb-0002rj-Pk
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:28:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:64043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dhucb-0002qw-FS
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:28:17 -0400
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-3-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <2e9a08ae-6e11-2e74-75ca-312412a4896a@gmx.com>
Date: Wed, 16 Aug 2017 11:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170816072104.24420-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QvHSj81ex90ltUW7uIcPBiWS9nNdaqBmC"
Subject: Re: [Qemu-devel] [PATCH RFC 2/9] qemu.py: Add variable vga type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QvHSj81ex90ltUW7uIcPBiWS9nNdaqBmC
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <2e9a08ae-6e11-2e74-75ca-312412a4896a@gmx.com>
Subject: Re: [PATCH RFC 2/9] qemu.py: Add variable vga type
References: <20170816072104.24420-1-famz@redhat.com>
 <20170816072104.24420-3-famz@redhat.com>
In-Reply-To: <20170816072104.24420-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.2017 09:20, Fam Zheng wrote:
> Some guests behave differently when no VGA is detected. Add a variable
> to allow override the "none" default.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/qemu.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 880e3e8219..e5f314efdb 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -39,6 +39,7 @@ class QEMUMachine(object):
>          self._iolog =3D None
>          self._socket_scm_helper =3D socket_scm_helper
>          self._debug =3D debug
> +        self._vga =3D "none"
> =20
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
> @@ -111,7 +112,7 @@ class QEMUMachine(object):
>              moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._monitor_ad=
dress
>          return ['-chardev', moncdev,
>                  '-mon', 'chardev=3Dmon,mode=3Dcontrol',
> -                '-display', 'none', '-vga', 'none']
> +                '-display', 'none', '-vga', self._vga]
> =20
>      def _pre_launch(self):
>          self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addres=
s, server=3DTrue,
>=20

Not sure if this is related but OpenBSD ships with a patch for vga
(cherry-picked from qemu-devel):

http://cvsweb.openbsd.org/cgi-bin/cvsweb/ports/emulators/qemu/patches/pat=
ch-roms_vgabios_vgabios_c?annotate=3D1.1


--QvHSj81ex90ltUW7uIcPBiWS9nNdaqBmC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZlA3nAAoJEEuzCOmwLnZsJLgQAMIro4x8PZEu9HmTpzJLAFtZ
x2s5Ov1bUlGCFVHbhxm3hcvSdSfVb99kBSIxkPgaFqH3cFfCp6/Nrz6s/ukdb95k
NJEx8mzHUI/yoS9l2YQ0nRuSYoxh73q7THhh0fMCU/ev9yw67EtSrnRRUw1tRzgR
6kx1nzB+N26NGkKeY9/ojJvcCcFHCMtWo+MjKybYC1TV1TPUU7Vb/R8BWG/zD6Eg
qPRRKw/dK6syTqflrI1qhRuVlY/mup0pQOByGcac23KIwY0cVOd9EhUplTW8FPEC
AKSexjl8gWRSD8ERay9V2tuymhjUpJjAtKaUtT8xJSUOby2VC+DNRYHP4IcHpoX5
MCqgOTPqJ7Bo4ZuApwcRsTUF2+1xwn3VhzA/xmE9g5+DRvQfj43jX10C3rcmBxsH
Lr3dHQM8Px/NNyRFZcfQcKT69TpSi2tK5gZAzhhZ3/XLM+/4djyKaIzGcbz4cPez
nK9HnbWpE1w2+Yax/88HibkNoS7T0r66QjXbRQPcxlcxzJsZBb9iOP7QxIlkdO/3
Vm5vtfEQUq7GYkRFyU4Sph+YfBu9X9V1KB0+OjduooGI3Kdtt46jJSJtn4ZvTWoC
t0cvZ0FVUzy1qWqrNRRFfXZ8ux/FQIWtzaCtpKOwEWmbrJG+HmyK2CBPbP+yrGAp
nBcJN9ptR1Vywy5j0ywH
=PTXf
-----END PGP SIGNATURE-----

--QvHSj81ex90ltUW7uIcPBiWS9nNdaqBmC--
