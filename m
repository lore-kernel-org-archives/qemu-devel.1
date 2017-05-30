Received: from eggs.gnu.org ([2001:4830:134:3::10]:34849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFifq-0003MK-Eu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFifm-0003GX-C4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFifm-0003GT-33
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:03:02 -0400
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-3-aurelien@aurel32.net>
	<20170530101746.GA25884@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc4c904d-c794-fd9f-66ec-141861cf0a33@redhat.com>
Date: Tue, 30 May 2017 10:02:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170530101746.GA25884@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KvTKN8oNE4pc2iXJGdtX2ct9qFUw3OWs7"
Subject: Re: [Qemu-devel] [PULL 2/5] target/sh4: fix reset when using a
 kernel and an initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KvTKN8oNE4pc2iXJGdtX2ct9qFUw3OWs7
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <dc4c904d-c794-fd9f-66ec-141861cf0a33@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/5] target/sh4: fix reset when using a kernel
 and an initrd
References: <20170529193016.6888-1-aurelien@aurel32.net>
 <20170529193016.6888-3-aurelien@aurel32.net>
 <20170530101746.GA25884@stefanha-x1.localdomain>
In-Reply-To: <20170530101746.GA25884@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 05:17 AM, Stefan Hajnoczi wrote:
> On Mon, May 29, 2017 at 09:30:13PM +0200, Aurelien Jarno wrote:
>> When a masked exception happens, the SH4 CPU generates a non-masked
>> reset exception, which then jumps to the reset vector at address
>> 0xA0000000. While this is emulated correctly in QEMU, this does not
>> work when using a kernel and initrd as this address then contain an
>> illegal instruction (and there is no guarantee the kernel and initrd
>> haven't been overwritten).
>>

>> +            qemu_system_reset_request();
>> +            return;
>=20
> The qemu_system_reset_request() prototype is changing.  There is a
> conflict with another merged pull request.  Please rebase onto
> https://github.com/stefanha/qemu.git staging.
>=20
> target/sh4/helper.c:102:39: error: too few arguments to function call, =
single argument 'reason' was not specified
>             qemu_system_reset_request();
>             ~~~~~~~~~~~~~~~~~~~~~~~~~ ^

You'll probably want SHUTDOWN_CAUSE_GUEST_RESET as the reason, based on
the changes made to other target/ files.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KvTKN8oNE4pc2iXJGdtX2ct9qFUw3OWs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLYmeAAoJEKeha0olJ0NqCp8IAIL3ASXxT2qbpyIwq1J0OY63
BJ3HnHV7P6i6SJf0SjTc/rfu4txhV/761tc0BOExVtJlVB4WhY8e0/73t4awAtuJ
ZmuIYY54iA9Mlpjc8C2D6XDi4PBxkw9dnVlt0FEhrEYm0DXSz9TG7ZOti2ZYjfsm
8rMooze2ZybSNkUY9hE43V9COgWeHSTdCWYdIZm2KIFx3aGluEQ8Wqsun3NZ8fj1
82jgBK5TTApOeHLjnqbWPAQqsCEuFsIKwosLcxIDQjweP064LoJa7EvKvmwWDoy1
BMfVDsP8+4ANIwgjn3b1rBuez6VWvfENrlpqc7/HdVG5U2s8co2D3mV4kw9yTu0=
=8Ntj
-----END PGP SIGNATURE-----

--KvTKN8oNE4pc2iXJGdtX2ct9qFUw3OWs7--
