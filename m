Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAHMT-0005cu-PW
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAHMQ-00013r-Lm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAHMQ-00013N-DK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:52:34 -0400
References: <20170512155249.8853-1-quintela@redhat.com>
	<20170515135848.GL1201@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <feb33c55-a56e-2a87-eafd-fbbe1f3c982b@redhat.com>
Date: Mon, 15 May 2017 09:52:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170515135848.GL1201@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JLPuKALgw3F7HjG4lXLKxAx3Nujhd9KFH"
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JLPuKALgw3F7HjG4lXLKxAx3Nujhd9KFH
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com
Message-ID: <feb33c55-a56e-2a87-eafd-fbbe1f3c982b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
References: <20170512155249.8853-1-quintela@redhat.com>
 <20170515135848.GL1201@stefanha-x1.localdomain>
In-Reply-To: <20170515135848.GL1201@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 08:58 AM, Stefan Hajnoczi wrote:

>> ----------------------------------------------------------------
>> Juan Quintela (5):
>>       migration: Fix regression with compression threads
>>       migration: Pass Error ** argument to {save,load}_vmstate
>>       ram: Rename RAM_SAVE_FLAG_COMPRESS to RAM_SAVE_FLAG_ZERO
>>       migration: Create block capabilities for shared and enable

We may still end up changing our representation of these capabilities (I
don't think the design discussion has completed) - but as long as we get
it done before 2.10, I don't see a reason to have to unstage the pull
request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JLPuKALgw3F7HjG4lXLKxAx3Nujhd9KFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGcCTAAoJEKeha0olJ0NqWIQH/3w2E7/PhawYQmH4ehbTuZfT
p7qwKTp0zHqQdcNuWazDwY+rqBm70SmCw6SOFZctbf5pFuDuc/U7NF2FpDNyDqao
ku8ZcbOhRSOSdAqjjiek/cub38qBDVJrXXZ5miqKy37e46p3y5yFj6OAL/4fJ3Gw
uCBTRqUjHG7qnqMLmQH9Qii8pmgK6Qhxn2aR4bh7u5dyWEgd/2Kr/l3LP/0jJNmM
RcoiVwU6RDg7zteKC+Lpau6cz3VYbQubjajeEwSj0Ne85yDwOfDnm7s+tBNAKBiJ
oBQKLDjEKXrPgKHPtfZmYsEHWfkKTlPlx91huddjSwIcikLlhSrZx9X/IcfjEPk=
=L8IK
-----END PGP SIGNATURE-----

--JLPuKALgw3F7HjG4lXLKxAx3Nujhd9KFH--
