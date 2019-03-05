Received: from eggs.gnu.org ([209.51.188.92]:39374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1Dyq-00056Z-LR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1Dyo-0004kl-SE
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:35:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1h1Dym-0004XD-Ns
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:35:50 -0500
Date: Tue, 5 Mar 2019 17:29:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190305172905.GD13806@stefanha-x1.localdomain>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
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
To: Wei Li <wei.d.li@oracle.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 09:33:26AM -0800, Wei Li wrote:
> While @Stefan mentioned about additional iothread object support of virti=
o-blk, Is the feature also supported by virtio-scsi? I am trying to explori=
ng the perf multiple IO threads / per VM via followings:
> QMP setup example to create 2 io threads in QEMU, one io thread per devic=
e:
>=20
> (QEMU) object-add qom-type=3Diothread id=3Diothread0
>=20
> (QEMU) object-add qom-type=3Diothread id=3Diothread1
>=20
> =20
>=20
> (QEMU) device_add driver=3Dvirtio-scsi-pci id=3Dtest0 iothread=3Diothread0
>=20
> (QEMU) device_add driver=3Dvirtio-scsi-pci id=3Dtest1 iothread=3Diothread1
>=20
> =20
>=20
> (QEMU) device_add driver=3Dscsi-block drive=3Dnone0 id=3Dv0 bus=3Dtest0.0
>=20
> (QEMU) device_add driver=3Dscsi-block drive=3Dnone1 id=3Dv1 bus=3Dtest1.0

Yes, each virtio-scsi-pci device can be assigned to an iothread.

> You mentioned about the multi-queue devices feature, it seems like the mu=
lti-queue feature will help improve the IOPS of =C2=A0single Device. Could =
you please provide more details?
> What=E2=80=99s the current plan of support multi-queue device? Which rele=
ase will include the support or it has already been included in any existin=
g release newer than 2.9?
> Is there any feature branch which I would get more details about the code=
 and in progress status?

I have CCed Paolo, who has worked on multiqueue block layer support in
QEMU.  This feature is not yet complete.

The virtio-scsi device also supports multiqueue, but the QEMU block
layer will still be a single queue.

Stefan

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcfrHhAAoJEJykq7OBq3PIAvMH/ieGWYrZPGME2Rx7eI894Lpo
ig1Erz/s5EB6Jv4nzRwTjDqiX8OPvNNn+vTxHNEUV5aKvCVFZkPaJXcY8PdKxD8n
6lz3sLHPEaP4fK4zh6UYwn3s10Yyf/fCy7oyldz7HitMB0p0vlzlOSoGWNPBLePU
JdZrcM7tLo8VPkDcFM/hQEn4jBJMc0mseDaB88igBTu+N3812QPFFW2Nn7FI9ddA
gdDaBEuZIVoRvnL5kInYvb/bbwedBeEM/upOYvvCmn6twrLVVatDnoN1UDygmiuz
3Pz0rwIk9A2h+xT5YRmlpQ47nv8jAsT+JVtNGuqc9IaPdtR2Qg88DVmwQYa9HNg=
=SNTB
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
