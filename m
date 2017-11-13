Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJ0K-0000Yd-1r
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJ0J-0006rF-2y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:58:40 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
Date: Mon, 13 Nov 2017 11:58:30 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nG4GiIc7tSax5QrT9FCC9jd6Xmt7KWkLT"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nG4GiIc7tSax5QrT9FCC9jd6Xmt7KWkLT
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
 <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
In-Reply-To: <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 11:29 AM, Peter Maydell wrote:
> On 13 November 2017 at 17:14, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>> I have a qcow v1 file which I created by mistake (forgetting that
>> you need to tell qemu-img create 'qcow2' and not just 'qcow'),
>> which I want to convert to a v2 file so I can put snapshots into
>> it. But when I try to do this with qemu-img convert it creates a
>> v3 file instead:
>>
>> $ file hda-old.qcow
>> hda-old.qcow: QEMU QCOW Image (v1), 5368709120 bytes
>> $ build/x86/qemu-img convert -O qcow2 hda-old.qcow hda.qcow2
>> $ file hda.qcow2
>> hda.qcow2: QEMU QCOW Image (v3), 5368709120 bytes
>>
>> and if you then try to use that in QEMU it complains:
>>
>> qemu-system-aarch64: -drive if=3Dnone,file=3Dhda.qcow2,format=3Dqcow,i=
d=3Dhd:
>> Unsupported qcow version 3
>=20
> ah, this means it wants "format=3Dqcow2".

Oh, I should have read this followup before writing my other reply.

>=20
> This is pretty confusing, especially the error message, the
> output of "file", and the fact that "format=3Dqcow" can't just
> DTRT if it gets a qcow version 3 (2?), since it can clearly
> identify what it's got.

Indeed, making the qcow driver smart enough to reopen with the qcow2
driver (for both v2 and v3 images) might be an interesting ease-of-use ha=
ck.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nG4GiIc7tSax5QrT9FCC9jd6Xmt7KWkLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ3UYACgkQp6FrSiUn
Q2riZwf/dbsGiTbeAUVB7ikT2cnNyVUbqLmj/4FnJzX1wOduA5TI2nBijauYz+42
8IJxlCJOJfia5UVYEUWZzC2N81KCxJi1NVjY6OhCouRCjAFhMmL2ab/c5oJJUSQd
v7qH/CI4VcP4uBy3FnAwjk9VJR33PWtthHEoWhe9d8VEgwQ7Vdbra5m+E3ThrxRG
RChOkB7nQLe3BVKA5T2MLuaW1rmCxMVvbHkz9po+KFAWUOARQeycjgU7J83g4MR6
sdHvOteQaFtcEtBxpNVrJCG92S6xla7m9M20xLUyWTJelSA9yZyYZk7CYGShYTi9
JQEH2LYnQofrbqHK3NEztVfgfAdLEQ==
=6Uh1
-----END PGP SIGNATURE-----

--nG4GiIc7tSax5QrT9FCC9jd6Xmt7KWkLT--
