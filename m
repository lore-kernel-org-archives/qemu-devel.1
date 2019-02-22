Received: from eggs.gnu.org ([209.51.188.92]:42860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1gxBbu-00005l-KU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1gxBbr-0005oS-Jr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:15:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1gxBbr-0004Mw-4a
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:15:27 -0500
Date: Fri, 22 Feb 2019 15:09:23 +0100
From: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20190222140923.GA17678@antique-laptop>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<f262ecd7436fade16c88533f52c5ca4a08bc396d.1550698466.git.DirtY.iCE.hu@gmail.com>
	<20190222134042.GV25234@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20190222134042.GV25234@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH v5 03/14] audio: -audiodev
 command line option: documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, "reviewer:Incompatible changes" <libvir-list@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 01:40:42PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 20, 2019 at 10:37:32PM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=
=A1n wrote:
> > This patch adds documentation of an -audiodev command line option, that
> > deprecates the old QEMU_* environment variables for audio backend
> > configuration.  It's syntax is similar to existing options (-netdev,
> > -device, etc):
> >=20
> >   -audiodev driver_name,property=3Dvalue,...
> >=20
> > Although now it's possible to specify multiple -audiodev options on
> > command line, multiple audio backends are not supported yet.
>=20
> So happy to see the audio backends come into the modern world at last !
>=20
> >=20
> > Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> > ---
> >=20
> > Notes:
> >     Changes from v4:
> >    =20
> >     * deprecated QEMU_AUDIO_ env vars
>=20
> Libvirt does currently use these, so we'll need to update libvirt
> code to use the new cli args

Correct, and with this we can finally fix this bug [1] \o/.

Pavel

[1] <https://bugzilla.redhat.com/show_bug.cgi?id=3D1375433>

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlxwApIACgkQUi1kczAH
4Yzhvw/+Live3EGMmLd5MzTj/w+373EkvzvgWOs6jXC/SdIgw8uNIYVhWNbqaJm4
OYumBx2deW2PfGvCjj4V2tTyeVH9vf4vGvVJd7MzNPRUyW0I1sJXaMUh+AzUj+qG
hrKcbj4VomkRptUEvAABeb7gfLFQNsn14jYR7ykkSLpZ2zkmxp5i6XulP0ElBtTd
2Ma8Z1umv2ElG4EnAIweqbT1x96838kffsgmgxv8evnbZveYoJ/GrSFwFtaS9Cpd
O52Ez1QrmA00b7BFUfLB2/LExLQufpdApN5X8/+zoFuEyOsUB5WC8E6ljad5iPAy
X5fFWeuuyz4MIOQOjtuEtw5XunyL4Ga9+0fj+TZPi+WQr/6o2zqOYVAnqmanAj/I
hATBEgCBLqCDy/pHIZR+yOs6wafXvjnlmXQL/vD4m5yB3wtQ09TlM1hgwX+9DHo+
TYrxAxrv/M3uYHTY5ZS/b23BDQNWUFJ30Mo1TUns6sMZ/Sxyr3QZNJHKpv1Nex8D
yb7vlNI598xT/DCzkmhBaN5OHFIG2iji0giF6OgW9933mZa5NOC/nUQv9jGh78eo
Va9Rl5crRTHIs4yp7VFeOAEyLamZFRDx+IjwFyqDpGFuTQhFseqENSaqbaRR+p69
jpaYrJQHQTcN2gHHtbDDyiW/wIgm+m3AqeldF69wY1bMHSn7E58=
=3cCt
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
