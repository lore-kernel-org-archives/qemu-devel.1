Received: from eggs.gnu.org ([2001:4830:134:3::10]:55260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cOqnk-0008MQ-D5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cOqnh-0007vV-BZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:00:44 -0500
Received: from ignoranthack.me ([199.102.79.106]:56362
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cOqnh-0007v4-2U
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:00:41 -0500
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<8760lu65gs.fsf@linaro.org>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <6035f282-ef78-3ccb-1e75-2d00b9fe0d3c@freebsd.org>
Date: Wed, 4 Jan 2017 12:00:34 -0700
MIME-Version: 1.0
In-Reply-To: <8760lu65gs.fsf@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="k2GBQ4cuOfShB40XPooRVmeko9ST9KbQD"
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k2GBQ4cuOfShB40XPooRVmeko9ST9KbQD
From: Sean Bruno <sbruno@freebsd.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <6035f282-ef78-3ccb-1e75-2d00b9fe0d3c@freebsd.org>
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
 <8760lu65gs.fsf@linaro.org>
In-Reply-To: <8760lu65gs.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/04/17 11:32, Alex Benn=C3=A9e wrote:
>=20
> Sean Bruno <sbruno@freebsd.org> writes:
>=20
>> I'm pondering where to start with getting FreeBSD's bsd-user code into=

>> shape so it could actually be reviewed and accepted now that its sort =
of
>> working again (signal handling fixed finally).
>=20
> Also don't forget the parallel_cpus changes which were made for enhance=
d
> atomic support. There was also work in fixing up exclusive_start/end
> which is used for safe work like tb_flush.

Yeah, I ran head first into that wall last month.  :-)

We should be ok at this point as I've merged to master and am keeping up
now.

>=20
>> I almost feel like the existing code should be purged, except that it
>> gives a good history (and this seems lazy to me).
>>
>> As a first pass, I guess, I'd like to at least make i386 user run on
>> x86_64.  What would you folks like to see in a first pass?
>=20
> One thing that bugs me about linux-user is the amount of copy&paste
> repetition that goes on for the main run loop. Perhaps with a clean-up
> of the unused BSD architectures we could explore how a re-factored
> run loop could look with a view to moving to common run-loop code acros=
s
> both?

The bsd-user code does not have that nearly as much.  Hardware
architectures have been moved to seperate dirs and o/s support has been
broken up into seperate dirs.  This has made maintenance and testing
much easier, but not easy enough to get the code into your folk's tree.  =
:-)

>=20
> Apart from syscall mapping and backend calls to the BSD ABI what
> differences are there between the two user-mode implementations?
>=20

Not a substantial amount, IMO.  The setup and tear down are a bit
different, signal handling is a bit different, and as you mention
syscall mapping/backend calls are different.

>>
>> sean
>>
>> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


--k2GBQ4cuOfShB40XPooRVmeko9ST9KbQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhtRlNfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmQaFQf+OiURj3uVfawi/JZGy/urCLFC+FwpqGHeNlRbVvuHNDyZdGgQl6jj8ZRS
kMpQ5OZn0ajQILitkdGtfRo0We1+9aBm4CQ//tisZGtqbCxgPyfbHdmeHDXFneny
1Y2GvN4QP3Oy375B3BGN0YGSJIC76pUadEBW3doH/cMQjRJ4HZ80VS4rJGGQ0GPX
45w9DBnEHcCpUfJTI8n+GbNLBqNJrLFVLPZ9bH4PwwzSpdo8KCTlgRazMJ7cr7d+
85bnHq/h/Pu25/yNqerR2sx7FsjJ5nshoc/XGbxSCZzwMqwmOBXzQ51pkWd8STRv
1LVXt/Tb9oVLf6nWelsqv37EKKrtxA==
=2kNZ
-----END PGP SIGNATURE-----

--k2GBQ4cuOfShB40XPooRVmeko9ST9KbQD--
