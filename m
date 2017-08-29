Received: from eggs.gnu.org ([2001:4830:134:3::10]:55887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmnsi-0005cn-NS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmnsh-0000Mv-M2
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:17:08 -0400
References: <20170829165058.8229-1-kchamart@redhat.com>
	<CAJSP0QUSXyb8MNVf6Tq8hLgb2wVWLX6GVAPgG-mmrGCxAEOcXg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <defa8205-e31e-9199-c929-f2e22849e8c7@redhat.com>
Date: Tue, 29 Aug 2017 16:16:54 -0500
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUSXyb8MNVf6Tq8hLgb2wVWLX6GVAPgG-mmrGCxAEOcXg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JdTAfmD3fQk72HU9lGFoTRM9XNFaLEjqK"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] qemu-iotests: Extend
 non-shared storage migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JdTAfmD3fQk72HU9lGFoTRM9XNFaLEjqK
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <defa8205-e31e-9199-c929-f2e22849e8c7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] qemu-iotests: Extend
 non-shared storage migration test (194)
References: <20170829165058.8229-1-kchamart@redhat.com>
 <CAJSP0QUSXyb8MNVf6Tq8hLgb2wVWLX6GVAPgG-mmrGCxAEOcXg@mail.gmail.com>
In-Reply-To: <CAJSP0QUSXyb8MNVf6Tq8hLgb2wVWLX6GVAPgG-mmrGCxAEOcXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 12:42 PM, Stefan Hajnoczi wrote:
> On Tue, Aug 29, 2017 at 5:50 PM, Kashyap Chamarthy <kchamart@redhat.com=
> wrote:
>> This is the follow-up patch that was discussed[*] as part of feedback =
to
>> qemu-iotest 194.
>>

>> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
>> ---
>> Changes in v3:
>>  - Wait for migration to complete before issuing `block-job-cancel`
>>    (StefanH)
>>  - Wait for the event BLOCK_JOB_COMPLETED on the source before stoppin=
g
>>    the NBD server on the destination (StefanH)
>>
>> Changes in v2:
>>  - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED (EricB=
)
>> ---
>>  tests/qemu-iotests/194     | 23 +++++++++++++++++------
>>  tests/qemu-iotests/194.out | 11 ++++++++---
>>  2 files changed, 25 insertions(+), 9 deletions(-)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks; I've added this to my NBD queue (pull request to come shortly
after 2.11 release is finalized), since the test uses NBD.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JdTAfmD3fQk72HU9lGFoTRM9XNFaLEjqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml2cYACgkQp6FrSiUn
Q2oSzQf/XMgPvCJ+gcomEBZUfwsf9B6wFaNdxh49Z9wdyFySpI37fyCgNktZ41NV
65r4bcqTtdjAtrNRNgMHwO42qp8vUZP4SrJxY/ymgKjxxshhkk8Q266Fs8mF//Au
pos7lIGyenj1DuqgXVWBH3orwwPae39kIR9KaeYYBrf8uOps+bA3dDI8JLR7Z6J+
FefDwgFO+G8y1je251FOWoX4zJtcVC8Rr1BKoAGjJb2sU03zb1uPRGcZoqCkWqzF
MPpzeyss50V6cGRbgaSUZDP4ujLJXYZL3hqNjgD6eiARtwzcEO3c1eJdpS2yupQK
eb2uoJ/9DvnFPSHTwCy8M37uuZ+rlQ==
=rpPl
-----END PGP SIGNATURE-----

--JdTAfmD3fQk72HU9lGFoTRM9XNFaLEjqK--
