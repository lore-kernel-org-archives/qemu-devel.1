Received: from eggs.gnu.org ([209.51.188.92]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLQpO-0001h1-TZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLQpO-0002uP-21
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hLQpN-0002oC-Pa
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:21:38 -0400
References: <2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<20190429134048.GH7587@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2964b0dd-9e33-9824-3c25-47f0355596d9@redhat.com>
Date: Tue, 30 Apr 2019 13:21:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190429134048.GH7587@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E2TL1nkKYM2ZXpkve0FbEJZWKsItIRwm2"
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Li <wei.d.li@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E2TL1nkKYM2ZXpkve0FbEJZWKsItIRwm2
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Li <wei.d.li@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Message-ID: <2964b0dd-9e33-9824-3c25-47f0355596d9@redhat.com>
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
References: <2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
 <20190401090724.GA643@stefanha-x1.localdomain>
 <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
 <60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
 <898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
 <20190416092042.GB32709@stefanha-x1.localdomain>
 <8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
 <3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
 <20190423120453.GF32465@stefanha-x1.localdomain>
 <44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
 <20190429134048.GH7587@stefanha-x1.localdomain>
In-Reply-To: <20190429134048.GH7587@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/04/19 15:40, Stefan Hajnoczi wrote:
> This isn't fully effective since the guest driver kicks once per
> request.  Therefore QEMU-level batching you mentioned only works if QEM=
U
> is slower at handling virtqueue kicks than the guest is at submitting
> requests.
>=20
> I wonder if this is something that can be improved.

Right, virtscsi_kick_cmd does limit notifications but not submissions.
The SCSI layer does not have separate queue_rq and commit_rqs callbacks.
 That should not be too hard to fix though.

Paolo


--E2TL1nkKYM2ZXpkve0FbEJZWKsItIRwm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlzIL7gACgkQv/vSX3jH
roNfrQgArqtsNcBApkpoh2mCGm5vkIe4Wb2zoihJQBCUc4P3wCBM5Ryi+k7T5yBF
QVSxAMhpfbZER8+6pCXEKp/Vk9eJGoJ+a8KYjYefAQPxUKQb+Gx9Iv0yVcrdES9K
I8ILRYEerMI/rDaUhQGfwXAAbV0vQovHS6LAz8d3haU7XOfAegrYYdb7nQcbSN13
4Obu7K8kNFD9uBMXYWJruam9jzdfaudsbVw5W1RlbrXMw6PZmCiCiZbtMVHTRjJj
PfzLL5fyxQudTkFhch20MMUPL2+bloFccLfbS7W3DJJVzcpL93dMrwZiIhwJA/qa
LlriDiHm9dNxrPik9Pxf6GpZ7r0s9A==
=kzpl
-----END PGP SIGNATURE-----

--E2TL1nkKYM2ZXpkve0FbEJZWKsItIRwm2--
