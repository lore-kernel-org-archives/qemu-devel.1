Received: from eggs.gnu.org ([209.51.188.92]:33329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h1RLI-0001OR-OV
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h1RLI-00076w-3K
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:51:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1h1RLH-00075V-Sd
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:51:56 -0500
Date: Wed, 6 Mar 2019 08:41:48 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190306074148.GA9131@angien.pipo.sk>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
	<20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
	<81d22ed88833ed22a1c3781c3c0c1eafad99b280.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <81d22ed88833ed22a1c3781c3c0c1eafad99b280.camel@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Max@angien.pipo.sk, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2019 at 16:56:43 +0100, Andrea Bolognani wrote:
> On Tue, 2019-03-05 at 15:38 +0100, Gerd Hoffmann wrote:

[...]

> So I agree neither scenario is exactly perfect, but I still think
> adding non-transitional alias devices would overall be more
> user-friendly.

I don't think it makes sense to add it at the qemu level. From libvirt's
point of view users should be shielded from any qemu impl detail or
inconsistency as libvirt is the 'user friendly'[1] layer. In qemu the
devices would be the same and thus does not make sense to do that
because it would be more confusing.

You can argue that we should add the alias at the libvirt level though.

[1] Yes. I'm aware that statement is quite ironical.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlx/ebcACgkQHGwCByjY
1GqVrg/+ImyhJjurtHoBpSxOwF2pORF2F+P449vuwShXimNeab2NS6uZPz3e9otg
hdJf+veO3WJPzwX/zktzDmulRuM5Wq2muTGyHFWrBz4MGPlm8jsmom9/DrcoDwvq
58XHTEL/e24cUEPOLlhCRY6XZZniMBPecFsqaqSfSGmPT+HO53crtNqXjL2hb036
gSPL+8/BAcXGcYx/BjOR0uUU6YDxvWFSxl4yndM68pZgiyl6R5ATEvTmgbfofY3s
THAnQs7ncAQZNOkFpmHvqmLPgf4M/K3uX732o64Xf3Au3vm9csAfMed2sV/FGo5e
7EEMuS5GqZGxEhLKXWD3T2tAFoEBvE1VUlQ94bWGlF+GXBOsK+hy2CTi1Hi9wO1e
PYfJaLo8nsLqx+DPcCWG01wAxuUEGilKBZJTbPYTcL5PY7O6a8gQWh8kaFAqq/pZ
GX1DfveY7TfaTFQPYFIMmz7+uRm0qCG3OiYIneFGYx3exsuUora9PIKbTFK3xdle
4ts46wJJre8AN6gY6mBqs4paOSwL4T1wmzRwmvQuR1/SRvx55q0WUwkDvD0Ybawz
rhstuFALYs2HcOWVoTEJZa+YqxBD4CB47HwTScSOovMVTnYTqHrIlv6Ki3o1UtZn
eJ2ZVPd4TKU6I1eftAeLLqHfkfi7aFD4dxV3tBIlII/ssNJ2+S4=
=6zFi
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
