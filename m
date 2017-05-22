Received: from eggs.gnu.org ([2001:4830:134:3::10]:37959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpzR-0004pg-Rn
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpzN-00014d-BR
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:15:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpzN-00014V-2D
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:15:21 -0400
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133148eucas1p2c04111d415b1fbd6fb702cfc2a3ed6f9@eucas1p2.samsung.com>
	<1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
	<20170519192327.GX2081@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76614cc4-17e2-20f3-bb77-2144398e39fa@redhat.com>
Date: Mon, 22 May 2017 11:15:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170519192327.GX2081@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eshhasAuh0JABUW43LXoXoDTDqTX7Qjrt"
Subject: Re: [Qemu-devel] [PATCH V5 8/9] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eshhasAuh0JABUW43LXoXoDTDqTX7Qjrt
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com
Message-ID: <76614cc4-17e2-20f3-bb77-2144398e39fa@redhat.com>
Subject: Re: [PATCH V5 8/9] migration: add postcopy total blocktime into
 query-migrate
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170512133148eucas1p2c04111d415b1fbd6fb702cfc2a3ed6f9@eucas1p2.samsung.com>
 <1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
 <20170519192327.GX2081@work-vm>
In-Reply-To: <20170519192327.GX2081@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 02:23 PM, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>> Postcopy total blocktime is available on destination side only.
>> But query-migrate was possible only for source. This patch
>> adds ability to call query-migrate on destination. To distinguish
>> src/dst, state of the MigrationState is using, query-migrate prepares
>> MigrationInfo for source machine only in case of migration's state is =
different
>> than MIGRATION_STATUS_NONE.
>>

>=20
> Lets just check Eric is happy with the qapi side.

I pointed out a couple of things that need to be fixed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eshhasAuh0JABUW43LXoXoDTDqTX7Qjrt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIw6UAAoJEKeha0olJ0NqYEgH/300EyJcx8rI9CCfUpsBc4tK
/81tt/NR9DbCBf66K7P3l+5podJckFqXpJWQPf/2kd/pUGYnvf/nAS9iQjcS8/2J
+Dg2Wj7QnJzi1Ox/z2/3iahkte022OyIahPI3YwPOswCkPPBjmEYF5SOwFjebmoN
sFgXscP0LZfto+Fvw//tiR+3DXUGw+bsVMCGQVVTgKTGnvwBrV8LCTYwUwV8RqYx
jLxYuuMrkjcr1Q9WvK9m3x3CvyuFtCO0Tgl0ib7FGKl0UcwhEwLnx/3zQE8K31uQ
UVRbHq+L/HD3FQNTcSicWJMrq/sgiKq6aP6LP2pgi3Yjx96VU7GHs7/x0Im7UHg=
=8QaL
-----END PGP SIGNATURE-----

--eshhasAuh0JABUW43LXoXoDTDqTX7Qjrt--
