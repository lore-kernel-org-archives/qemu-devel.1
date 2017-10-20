Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5ZIO-0005jY-6G
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5ZIL-0005rJ-2y
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:33:12 -0400
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-24-eblake@redhat.com>
	<61e393f8-fcc5-b098-d6f2-160091c448c2@redhat.com>
	<20171020151118.GD3667@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4bbee4b0-5713-a319-9564-fc0c0f123b56@redhat.com>
Date: Fri, 20 Oct 2017 10:32:52 -0500
MIME-Version: 1.0
In-Reply-To: <20171020151118.GD3667@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o8cPUCcEsB9dXiq3n2ts7o5kmdbp7tOxN"
Subject: Re: [Qemu-devel] [PATCH v6 23/24] qcow2: Relax is_zero() assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o8cPUCcEsB9dXiq3n2ts7o5kmdbp7tOxN
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <4bbee4b0-5713-a319-9564-fc0c0f123b56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 23/24] qcow2: Relax is_zero() assertion
References: <20171012034720.11947-1-eblake@redhat.com>
 <20171012034720.11947-24-eblake@redhat.com>
 <61e393f8-fcc5-b098-d6f2-160091c448c2@redhat.com>
 <20171020151118.GD3667@localhost.localdomain>
In-Reply-To: <20171020151118.GD3667@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 10:11 AM, Kevin Wolf wrote:
> Am 12.10.2017 um 15:20 hat Eric Blake geschrieben:
>> On 10/11/2017 10:47 PM, Eric Blake wrote:
>>> Now that bdrv_is_allocated accepts non-aligned inputs, we can
>>> remove the TODO added in earlier refactoring.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> I was a bit too hasty in the copy-and-paste from 22/24 - there is no
>> assertion in this patch, so the subject would be better as:
>>
>> qcow2: Reduce is_zero() rounding
>=20
> In fact, I don't see any assertion being modified in patch 22 either.

Oh, indeed.  Not sure what I was thinking; I guess it's because I added
22 at the same time I added several other TODO assertions to series 1 a
couple months ago, with the plans to relax rounding/assertions as
appropriate later in the series, and then got confused on which things
were being relaxed where ;)

If it's just the subject lines for 22 and 23 that need fixing, I trust
you can do that as maintainer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o8cPUCcEsB9dXiq3n2ts7o5kmdbp7tOxN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqFyQACgkQp6FrSiUn
Q2oBxAf/W1oq8l3t7u7b56HOsnTeP2LJX8i/NuLEeAvy7wddz7mpG8YPodcyKmB+
3tx3trFjQ7Dsat+ul7J17RHw/wV6g0zoVPLmse0AJZ/ovVrMRiybIlr585TtZcZI
cQ/RI2wbi5tR0oY5aZvkbNuWQUnOBibWCPq4+bm6X2f4hquEkIKSqUGPm8gJl24e
3jNg/Ye6lrZgoBObJ5QUnTXMBzfSZDhZI7pxXSSOQdCaN9aXw8hSjdrL9M9hDPQA
WujBE6K33iMPN0yUrqmuAGKA3SzJqGkwcO5OhPvsXQrkjFzFMVfbPJ0vhDH6kT5T
uwVfByX58wztyLl644qrim6sUdcWxA==
=xO8p
-----END PGP SIGNATURE-----

--o8cPUCcEsB9dXiq3n2ts7o5kmdbp7tOxN--
