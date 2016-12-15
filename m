Received: from eggs.gnu.org ([2001:4830:134:3::10]:45346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHUux-0003Lq-UX
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHUuu-00088t-Pb
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHUuu-00088L-Hp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:13:44 -0500
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<20161215080452.GE26169@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63cae630-b193-0074-8aac-68fef47ec691@redhat.com>
Date: Thu, 15 Dec 2016 13:13:37 +0100
MIME-Version: 1.0
In-Reply-To: <20161215080452.GE26169@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SkcbtHCLl1iwhpqpc45b7wsRCESjc7DAM"
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SkcbtHCLl1iwhpqpc45b7wsRCESjc7DAM
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
Message-ID: <63cae630-b193-0074-8aac-68fef47ec691@redhat.com>
Subject: Re: Lock contention in QEMU
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
 <20161214193107.GB20648@stefanha-x1.localdomain>
 <CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
 <20161215080452.GE26169@stefanha-x1.localdomain>
In-Reply-To: <20161215080452.GE26169@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 15/12/2016 09:04, Stefan Hajnoczi wrote:
>> Does this feature only work for VirtIO? Does it work for SCSI or IDE?
> This only works for virtio-blk and virtio-scsi.  The virtio-scsi
> dataplane support is more recent and I don't remember if it is complete=
=2E
> I've CCed Fam and Paolo who worked on virtio-scsi dataplane.
>=20
> Now that you have mentioned that you aren't using virtio devices, there=

> is another source of lock contention that you will encounter.  I/O
> request submission takes place in the vcpu thread when ioeventfd is not=

> used.  Only virtio uses ioeventfd so your current QEMU configuration is=

> unable to let the vcpu continue execution during I/O request submission=
=2E
>=20
> If you care about performance then using virtio devices is probably the=

> best choice.  Try comparing against virtio-scsi dataplane - you should
> see a lot less jitter.

Yes, virtio-scsi dataplane is complete.

Paolo


--SkcbtHCLl1iwhpqpc45b7wsRCESjc7DAM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYUojxAAoJEL/70l94x66DtAIH/Aj36NabGI5n5ZXs1e38UDRd
gRbegzfromDZROdElYuoscjPRVBUEVNmTW/JU0qN+p9tbl34Vsgx/13OTN/uQOH9
ooDD8H0dQQa/6P+uG81JyNgxqD5sFSz+TS7jXorYODIzC+6xWcHlP2BqO2NnbKpO
RiczHIgGSzQDDugjQV4PGxXxh/XfDVLafr27M/DDTZnB0mBTcQAdsfSyMQHDvNHf
4AOWH8IoUmAGxVSS4wWdjEItuL/KsGCEjYPYA5tjaRuI81dmilDpXXCdf7KL3NlP
j24Hey50UYBSHeKv+/exkUboisT+Imp0Ctva/pmLaMHwOHBMhoU9Jf8zxMWTBdU=
=Q3lF
-----END PGP SIGNATURE-----

--SkcbtHCLl1iwhpqpc45b7wsRCESjc7DAM--
