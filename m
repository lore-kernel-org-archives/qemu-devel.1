Received: from eggs.gnu.org ([209.51.188.92]:35255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmKWm-0000JD-LW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmKWm-00074f-1B
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:33:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gmKWl-00074D-OP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06A6F80F75
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:33:19 +0000 (UTC)
References: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
	<aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <41572c06-75f0-6dab-c544-6e6713824f48@redhat.com>
Date: Wed, 23 Jan 2019 16:33:14 +0100
MIME-Version: 1.0
In-Reply-To: <aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HzifZMG4IHtm0UZ4tuaCr4hwbqRVhOvth"
Subject: Re: [Qemu-devel] Segfaults in chardev due to races
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HzifZMG4IHtm0UZ4tuaCr4hwbqRVhOvth
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <41572c06-75f0-6dab-c544-6e6713824f48@redhat.com>
Subject: Re: [Qemu-devel] Segfaults in chardev due to races
References: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
 <aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
In-Reply-To: <aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.12.18 10:17, Paolo Bonzini wrote:
> On 21/12/18 23:31, Max Reitz wrote:
>> I suppose the issue is that QMP events are sent by one thread, and
>> client disconnects are handled by a different one.  So if a QMP event =
is
>> sent while a client disconnects concurrently, races may occur; and the=

>> only protection against concurrent access appears to be the
>> chr_write_lock, which I don't think is enough.
>=20
> I think disconnection (tcp_chr_disconnect) has to take the
> chr_write_lock too.

That seems to fix the issue for me (can also be reproduced by running
iotest 169 in parallel), but how should this be implemented?  I suppose
tcp_chr_disconnect() can't really take the lock itself, because it's
called by tcp_chr_write() which is invoked with the lock held.

Max


--HzifZMG4IHtm0UZ4tuaCr4hwbqRVhOvth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIiToACgkQ9AfbAGHV
z0AWqAf/R1iT3l3fGHkfsBRFHD5ZZlb+sxZK0UCsimALVwBYsq7/TqSMarh/7bmq
s1P7pKd8+T3w4KwfJX+VIPrqMHZ3H2fsWa12GbI7DIJ8+A6tfUXFn9Sz59/5Gogv
V42AI2oMLEOuBToO2Lf6p3jlrW4uQBnkMC4JJqVxRLG6ugQw2NRHsvCwIwRBPcd4
fTe5BuqQ4M5oVy2zR+X+DlPAiv7z+6KlHPzCIqCvGWTkaAIT/ASAGfR2pahrHZ/e
bHKEZaTO8vXIKmNv1f2XM/QimNjQIlChCvMVccrtzSX+EbkcJ7iC75w2NN031UNs
UFkSV5Pp0oU9M+RowZaCCn0TE5586A==
=D7MF
-----END PGP SIGNATURE-----

--HzifZMG4IHtm0UZ4tuaCr4hwbqRVhOvth--
