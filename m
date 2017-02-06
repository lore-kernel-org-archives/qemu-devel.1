Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cap5n-0005JP-T2
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cap5j-0001nB-V1
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:36:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cap5j-0001ms-Ll
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:36:47 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
Date: Mon, 6 Feb 2017 13:36:43 -0600
MIME-Version: 1.0
In-Reply-To: <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vIpxU4wOVQCijKdelRwEuqm6QMbavqEH5"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vIpxU4wOVQCijKdelRwEuqm6QMbavqEH5
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org
Message-ID: <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 05:57 AM, Pradeep Jagadeesh wrote:
> This patchset adds the throttle support for the 9p-local driver.
> For now this functionality can be enabled only through qemu cli options=
=2E
> QMP interface and support to other drivers need further extensions.

This part is a bit scary - if 2.9 is released with just the cli option
and not the QMP interface, then how does someone like libvirt introspect
whether the feature is available for use?

Please make sure we don't reach 2.9 with only a half-baked feature;
whether that means finishing the QMP work or temporarily disabling the
cli additions until a later release can finish the work.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vIpxU4wOVQCijKdelRwEuqm6QMbavqEH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmNBLAAoJEKeha0olJ0NqWj8H/20kpxPApQI+nbh2mN9T7dZe
j6Fw9Fxx9OrAbzS/ORzINB/X2SEb1WfQIcJsUyP41kL8B+jadySfGrDASYI8TYR2
K1RPG3zvcyD5suydQayVXjTlbaALNvgPy+43nQJdqjYT6wYjQ9vbJAkl21QcMAUp
DLx8mCHRquk75eCyj3TUaphA+EMGbgFOlPUhq36EgBwZGOWmPJwGse8K9nF49Dco
IjUf42vpDbowqIhFSstyGV9yGxXDQ994ycI8rtalUtfMAxwG8pc3tw/jJvT6mFLd
BWH2Ox5qNu/W0zmNBx1AyjA7JFd/jgHRJACWS2GrpYw4Vq79kI9A0th1+7vauSE=
=CYjl
-----END PGP SIGNATURE-----

--vIpxU4wOVQCijKdelRwEuqm6QMbavqEH5--
