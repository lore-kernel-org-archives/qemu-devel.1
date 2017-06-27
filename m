Received: from eggs.gnu.org ([2001:4830:134:3::10]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPotO-00064n-8s
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPotL-0001cJ-79
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPotK-0001c2-TY
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:42:47 -0400
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
	<b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <443c5550-0627-d680-d7bb-1c8171f0af18@redhat.com>
Date: Tue, 27 Jun 2017 06:42:42 -0500
MIME-Version: 1.0
In-Reply-To: <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M0nEmK9hTOj3PNwBTN9f4EDC6brXcT132"
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M0nEmK9hTOj3PNwBTN9f4EDC6brXcT132
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <443c5550-0627-d680-d7bb-1c8171f0af18@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
References: <20170615163813.7255-1-stefanha@redhat.com>
 <20170615163813.7255-4-stefanha@redhat.com>
 <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
In-Reply-To: <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2017 06:40 AM, Eric Blake wrote:
> On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
>> Avoid duplicating the QEMU command-line.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  tests/qemu-iotests/068 | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>=20
>> +# Give qemu some time to boot before saving the VM state
>> +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
>=20
> Are we sure that 'bash' on PATH is the same as the /bin/bash running th=
e
> script?
>=20
> Also, while bash has more deterministic behavior for 'echo -e' (it is
> non-portable if you are porting a script to other shells), it is still
> possible to set bash to a mode where it does not work (see xhopt

shopt (I can't type first thing in the morning)

> xpg_echo).  I'd much prefer you use 'printf' instead of 'set -e'.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--M0nEmK9hTOj3PNwBTN9f4EDC6brXcT132
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUkSyAAoJEKeha0olJ0NqT1YIAKj+4U6Dag6yMx8ZtqwSA8NI
0bi8oM8NINapsqGLHFoYGMj4EWI2CP9yXNGJjIuN4S/PDf4VzXo1orqPCwz8TV4C
c1HCt2uHUYHtKstrNs0OLgx4Qby8/hMCJsrEr5Dd/VnDPqK2grw8HLM046Sw0O/t
ztnSe35uxKaL9oLvJGT03o74DH0TbBsB71KLSpXnmzEmZotKkR51EhV5BEd48A5X
/+Ay6SwtJcphbDr06ZgHcJmQj2qJsBLaP53Jf2XgxdBsdtjCjUIIBDrEEWVlcfWC
q69sdvlTwlNhp2O8/kdpwDr/t2a6dLjOL86prGwLP5JMGQaKgkt2G5GbXp5V7qc=
=czCZ
-----END PGP SIGNATURE-----

--M0nEmK9hTOj3PNwBTN9f4EDC6brXcT132--
