Received: from eggs.gnu.org ([2001:4830:134:3::10]:51417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3FO-0004Iq-VW
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3FK-0003N8-B7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:04:30 -0400
Date: Tue, 8 Aug 2017 13:04:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808120421.GK16801@stefanha-x1.localdomain>
References: <878tize8k1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Content-Disposition: inline
In-Reply-To: <878tize8k1.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] Unchecked blk_getlength() in device
 models and board code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@suse.de>


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 04:01:18PM +0200, Markus Armbruster wrote:
> blk_getlength() can fail.  I figure the following need fixing:
>=20
> hw/arm/musicpal.c: musicpal_init()

Seems okay:

flash_size =3D blk_getlength(blk);
if (flash_size !=3D 8*1024*1024 && flash_size !=3D 16*1024*1024 &&
    flash_size !=3D 32*1024*1024) {
    fprintf(stderr, "Invalid flash image size\n");
    exit(1);
}

> hw/block/virtio-blk.c: virtio_blk_update_config()

Will send a fix.

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiajFAAoJEJykq7OBq3PIBJ8IAMPs7BtZJ7Pr7eHKXYur34Bz
QvCLYMwvTEgK19ss7z2h0CDVqtKBvcuu+jI7S7b4yWJuOXwNvRFmluBpSNwtVSiL
GNq227xjDvMrO2J+HszE6U7B4R36KTWaObOgXuYN+Db5Rf0Qn7K9SyILLeamlkjA
0rpFm/colX6KyEpcPwczUHIRghGIZAVLPrKrctKDf5AO2XdOuU9TdMAddDHeJoCy
1ATL1FYPF5SdRHxJSxPaA953kr/qkoHF96l7w/ej89kTVpVPEebNnrbBy9wYfkcf
9QGCA/D478TTLoe1BK/2v8wJPXEX7O6i/iG34yzu3VtP7Gjd4H3RWr3nGzIqAlE=
=kOmu
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
