Received: from eggs.gnu.org ([2001:4830:134:3::10]:41475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9fz-0003Ax-P6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9fv-0006xD-4T
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db9fu-0006wO-RY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:07:47 -0400
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
	<1501249552-788-3-git-send-email-armbru@redhat.com>
	<20170728171731.GB3008@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c246b4bf-cb19-3348-9bdc-83409162abfc@redhat.com>
Date: Fri, 28 Jul 2017 13:07:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170728171731.GB3008@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JlxNvQHoQEB3ahw9rECQ2al5Jm3AE0pn7"
Subject: Re: [Qemu-devel] [PATCH 2/3] COLO: Define COLOMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JlxNvQHoQEB3ahw9rECQ2al5Jm3AE0pn7
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-ID: <c246b4bf-cb19-3348-9bdc-83409162abfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] COLO: Define COLOMode without QAPI
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
 <1501249552-788-3-git-send-email-armbru@redhat.com>
 <20170728171731.GB3008@work-vm>
In-Reply-To: <20170728171731.GB3008@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 12:17 PM, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
>> COLOMode is defined in the QAPI schema, but not used there.  Of the
>> stuff QAPI generates for it only the typedef is actually used.  Use of=

>> QAPI is pointless and only complicates things, so don't.
>=20
> Hmm, in one of the old COLO worlds I have, there's code to emit an even=
t
> on exiting from COLO and that event includes the mode it was in.
>=20
> If the intent is to bring that or similar back then it would be worth
> keeping.

We can always revert the removal once there is a user.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JlxNvQHoQEB3ahw9rECQ2al5Jm3AE0pn7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7fW8ACgkQp6FrSiUn
Q2pq8Af/bUzS4IKiJ4I0Sry/7M7BV6D8jhYrqQXLZzJKeVHmTHC8A6vRO6VaibgD
cF81IJuRD4jMWkrIJYKsowlOU2RdUcrH/1zDh9yjPzzXuhviFHtCa2LyqU7I5xwT
dpV1Ta63lcSbIHgU49bPNkNp+HC6dnBjbDFmCkDQ6MWGSi0GCsX2FrzrAKkEvVrJ
Qjcow+P9TWLJre9QHDDoCgkFpSW3c9OzNXNBb7Ix/QPvmPrEYRDyEgr6t5ZP5TBf
iXqZL+wdV+/FQ4+gtEMlUih3Mbe+b0sWQnvghh8yWJMZv4f3eMgHRnJG8DEam6RA
l4d0iLRjTldOP8tm4VwmqkjVOY4uWg==
=ZEPn
-----END PGP SIGNATURE-----

--JlxNvQHoQEB3ahw9rECQ2al5Jm3AE0pn7--
