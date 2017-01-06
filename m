Received: from eggs.gnu.org ([2001:4830:134:3::10]:48375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPWxQ-0000o8-SJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPWxM-0007ir-1Q
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:01:32 -0500
Received: from ignoranthack.me ([199.102.79.106]:52717
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cPWxL-0007ia-SM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:01:27 -0500
References: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
	<d362b1ba-0c36-bc68-44e5-b3e55f3853e9@redhat.com>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <97e4fa7a-2a66-e530-84d1-0c11fa11c305@freebsd.org>
Date: Fri, 6 Jan 2017 09:01:23 -0700
MIME-Version: 1.0
In-Reply-To: <d362b1ba-0c36-bc68-44e5-b3e55f3853e9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="af24IneJ7SDUc1qJB20OWmqW1CjXRtuRT"
Subject: Re: [Qemu-devel] [scripts] default shell/perl locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--af24IneJ7SDUc1qJB20OWmqW1CjXRtuRT
From: Sean Bruno <sbruno@freebsd.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97e4fa7a-2a66-e530-84d1-0c11fa11c305@freebsd.org>
Subject: Re: [Qemu-devel] [scripts] default shell/perl locations
References: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
 <d362b1ba-0c36-bc68-44e5-b3e55f3853e9@redhat.com>
In-Reply-To: <d362b1ba-0c36-bc68-44e5-b3e55f3853e9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/06/17 01:14, Paolo Bonzini wrote:
>=20
>=20
> On 05/01/2017 23:41, Sean Bruno wrote:
>> I don't suppose it would be possible to have configure check/change th=
e
>> interpreter path for scripts so that operating systems that don't have=

>> /usr/bin/perl for example, would work out of the box?
>=20
> We can use
>=20
> #!/bin/sh
> eval 'exec perl -x -wS $0 ${1+"$@"}'
>     if 0;
>=20
> if that works for you.
>=20
> Paolo
>=20
>=20

that would be far superior, thank you.

This at least lets folks with /usr/local/bin/perl in their path, find
and run scripts.

sean


--af24IneJ7SDUc1qJB20OWmqW1CjXRtuRT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhvv1NfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmTD1gf9HOwTivTrqwZiUGxM0rKfebHeEXQ2iD0mjqdxLmjC2wkde8iOHDXUJWNv
t4qiMInoG9Z4+gVnSABGiQ2bE2LW8YM6lyfoj/HI3x25C1XDEECRPb1b7Uh9h0fe
93R0XluzEULtwsDutWRCRDUKcUCR5fdvXM+PZsr5Bh/34oEX/TxYXaiBsVgEYHga
txTpyYqEtXz2nVCFAGFrteHE32hR3E1HqcdRht5Ip0gHMPgOmpCRW+vKz3Mbs8QC
i3I6aIdTayRpdBD+kEpPDpO8puVlubGBKEQR1zQucL7W+KpPDIiCCO6IZ3sJj4uT
fHkzeRhxvYcmhnjLcLqCY/pBw0pr9A==
=kUPq
-----END PGP SIGNATURE-----

--af24IneJ7SDUc1qJB20OWmqW1CjXRtuRT--
