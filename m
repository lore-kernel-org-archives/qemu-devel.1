Received: from eggs.gnu.org ([2001:4830:134:3::10]:48713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWVB4-0007MS-U8
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 17:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWVB4-0004ss-1H
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 17:36:58 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-7-eblake@redhat.com>
	<20180102214316.GC26116@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb4cfc88-4477-eeb5-136a-a827542bd2c2@redhat.com>
Date: Tue, 2 Jan 2018 16:36:47 -0600
MIME-Version: 1.0
In-Reply-To: <20180102214316.GC26116@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1JqzSqbY1RkuykvEjPEoQdZLPRABRz14H"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6 06/20] iscsi: Switch
 iscsi_allocmap_update() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, famz@redhat.com, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1JqzSqbY1RkuykvEjPEoQdZLPRABRz14H
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com,
 famz@redhat.com, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb4cfc88-4477-eeb5-136a-a827542bd2c2@redhat.com>
Subject: Re: [Qemu-block] [PATCH v6 06/20] iscsi: Switch
 iscsi_allocmap_update() to byte-based
References: <20171207203036.14993-1-eblake@redhat.com>
 <20171207203036.14993-7-eblake@redhat.com>
 <20180102214316.GC26116@localhost.localdomain>
In-Reply-To: <20180102214316.GC26116@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2018 03:43 PM, Jeff Cody wrote:
> On Thu, Dec 07, 2017 at 02:30:22PM -0600, Eric Blake wrote:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Convert all uses of
>> the allocmap (no semantic change).  Callers that already had bytes
>> available are simpler, and callers that now scale to bytes will be
>> easier to switch to byte-based in the future.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> ---
>> v3-v5: no change
>> v2: rebase to count/bytes rename
>=20
> Looks like this one will need a rebase, I get conflicts on master (and =
when
> trying to naively rebase your repo's master on qemu master).

Yep, I'm seeing it to when rebasing on top of Kevin's block branch
(currently at 1a63a907 on top of master at 281f3274).  I'll post a v7 soo=
n.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1JqzSqbY1RkuykvEjPEoQdZLPRABRz14H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpMCYAACgkQp6FrSiUn
Q2pSDgf9HMgpVe6+BGkAWCsu7UirzbSAkJbF8t3hCBA2gA98rIsyaWnMNuTYWh02
cQUFtMmspWRCcvGe4ARHIOOoOSiXvL/aF+p0O4wPH5R1SUK/uk28W5kd1vge8/lT
eym/7xZt26cto62jUwYXQ4IxyC0TZSUjFTqW8y+4BULNIVxMfCe/7NVpX620Ty53
Y/wuFUn+A9XzxDutnrmXApObhwBzvWab7gwfBrHnHeQQuWJJoM8/wBsUesDnylZz
AT5RVFYmmsk8D6Veq8TNovR4kgPow1XEL0uY1tdyFbn3hSSTw4sR7mlIVUjxugKI
UC8i0pP0ZDUu9cNt8t7Tr/GxeOiVxA==
=IcyU
-----END PGP SIGNATURE-----

--1JqzSqbY1RkuykvEjPEoQdZLPRABRz14H--
