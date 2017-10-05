Received: from eggs.gnu.org ([2001:4830:134:3::10]:45053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07RH-0003Xu-IH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07RG-0004sd-MT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:47:51 -0400
References: <20171004014347.25099-1-eblake@redhat.com>
	<20171004014347.25099-6-eblake@redhat.com>
	<20171005144119.GG10969@stefanha-x1.localdomain>
	<36585356-7cb7-30c7-bfe4-db6a56796b1d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fca3f8ba-f891-9973-b4ee-4391053e5378@redhat.com>
Date: Thu, 5 Oct 2017 09:47:33 -0500
MIME-Version: 1.0
In-Reply-To: <36585356-7cb7-30c7-bfe4-db6a56796b1d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XM6uK8jeqNIqgB7UG7N3qKUlnS1icbaS8"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] iotests: Add test 197 for covering
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XM6uK8jeqNIqgB7UG7N3qKUlnS1icbaS8
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <fca3f8ba-f891-9973-b4ee-4391053e5378@redhat.com>
Subject: Re: [PATCH v2 5/5] iotests: Add test 197 for covering copy-on-read
References: <20171004014347.25099-1-eblake@redhat.com>
 <20171004014347.25099-6-eblake@redhat.com>
 <20171005144119.GG10969@stefanha-x1.localdomain>
 <36585356-7cb7-30c7-bfe4-db6a56796b1d@redhat.com>
In-Reply-To: <36585356-7cb7-30c7-bfe4-db6a56796b1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 09:44 AM, Eric Blake wrote:
>>
>> Aside from the 2GB request issue:
>=20
> I'm wondering if it is easy enough to just capture the qemu-io output
> into a temporary holding area, grep that for success or OOM, then skip
> the test on OOM (for small machines) or log the success (for beefy
> spots), so that at least the test will not hold up CI efforts on small
> machines.

Or, maybe we add a new group designation in qemu-iotests/group, maybe
named "hugemem", and tag all tests that require large amounts of memory
to succeed; then we teach the patchew automation to pass '-x hugemem'
when running ./check.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XM6uK8jeqNIqgB7UG7N3qKUlnS1icbaS8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWRgUACgkQp6FrSiUn
Q2p3ZQf/RDer0lQGcRy5yJEYwUuHWWnNpjr6h92y4qwImPMzucucI/l5jEuJyMNI
0JPFr4Yxh6+boRFok5o2dM8AUYXdAKYrAt38W9mqLMYzkw1b+xB9ZNpsTI9IKh0E
RA5rVTRwBHmccs5dFFv72UGxuyje9gzefHZgV63dcNWI9MzZ/ABic2RQLBpKTXke
rWQJC5ZGsIswACPjKaAqnedEmwYvAcSa2LpxlW8q2ASEpRuAl8zdNSfv5O5tdZ8w
hv+X0pLONYE6malt+YFEuewW8WwR78RXbYWRBcWMwWNYVgY7rApIovfOH6ss1qoM
sxvR5dJNpob8M1Y5jFYtjHrfY8kymQ==
=ykPO
-----END PGP SIGNATURE-----

--XM6uK8jeqNIqgB7UG7N3qKUlnS1icbaS8--
