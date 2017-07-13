Received: from eggs.gnu.org ([2001:4830:134:3::10]:33963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVbQq-0001pb-Jg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVbQn-00072J-7w
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:33:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVbQm-000726-VX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:33:13 -0400
References: <cover.1499866456.git.alistair.francis@xilinx.com>
	<87vamxzjln.fsf@dusky.pond.sub.org>
	<CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69e2fa77-5311-9874-34fc-297a062929d4@redhat.com>
Date: Thu, 13 Jul 2017 05:33:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TRIbRo8edkMmBdLjVCtObdVVgmtnrhnJ4"
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>
Cc: philippe@mathieu-daude.net, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TRIbRo8edkMmBdLjVCtObdVVgmtnrhnJ4
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: philippe@mathieu-daude.net,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <69e2fa77-5311-9874-34fc-297a062929d4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
References: <cover.1499866456.git.alistair.francis@xilinx.com>
 <87vamxzjln.fsf@dusky.pond.sub.org>
 <CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
In-Reply-To: <CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 02:08 AM, Alistair Francis wrote:
> On Wed, Jul 12, 2017 at 6:49 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>
>>> QEMU currently has a standard method to report errors with
>>> error_repot(). This ensure a sane and standard format when printing
>>> errors. This series is attempting to extend this functionality for
>>> warnings and information as well.
>>>
>>> This patch renames error_print_loc() function to be more clear, but I=

>>> didn't bother renaming the others. It seems silly to change
>>> error_printf() to error_warning_printf() and printf is already taken =
so
>>> I just left it as is.
>>
>> I can take this through my tree once PATCH 4 got some R-by from PC
>> paintainers.  Whom you again neglected to cc; I just did that for you.=

>> I'll be happy to touch up minor issues like the ones I pointed out for=

>> v4.
>=20
> Thanks for CCing them. I keep assuming git send-email will CC from the
> suggested-by line, but apparently not.

It will, if you add 'git config sendemail.cccmd
"/path/to/scripts/get_maintainer.pl --nogit-fallback --noroles"'

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TRIbRo8edkMmBdLjVCtObdVVgmtnrhnJ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ0xlAAoJEKeha0olJ0Nq248H+wZSYyTJDhBiLP0JEJCthxun
b2jnQhbz7Gj1aX+ilDYmy/xO+vtKohGEHgbjJ8D11I1KqQeTwmSypEb1Xe/kWK4A
FOGLmDzbM408f+QSq8cZFzs/6AsQRtSqsMs1wEskGJmFOodOnA6XJJdNzu+HR/Uz
jeOmyI/Vw67d2MFlo+KRcCFXHn7I0QuTdYaKfBcSvMXOQry+i6GRV1n0VRZ+b7HP
TYbfUi30GLejjuE2bKqqfNcq6UAJWLQ33w3jmZJscikaTTKxSlGeJ3c4LXPi4Jyo
7ibJDtj1+UA4BNGHNmBd0KskG/eBKeNCdYDvmY7eaKm/Qsr2DKBqRfCuIIlGnhI=
=F0/a
-----END PGP SIGNATURE-----

--TRIbRo8edkMmBdLjVCtObdVVgmtnrhnJ4--
