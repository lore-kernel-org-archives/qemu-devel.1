Received: from eggs.gnu.org ([2001:4830:134:3::10]:47425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZeXr-0000MY-8y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZeXq-0006iO-Fp
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:41:15 -0400
References: <20170721093416.17816-1-stefanha@redhat.com>
	<5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
	<CAFEAcA_njsLSkV1xvQ19j+89=prJGAbktkK9kNiaEQXTUtDkEQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71566060-0670-6b23-372d-322ec64667c6@redhat.com>
Date: Mon, 24 Jul 2017 09:41:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_njsLSkV1xvQ19j+89=prJGAbktkK9kNiaEQXTUtDkEQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="US3qDNSghKOUT4Sb4VNlbxOuCN8Q55acD"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--US3qDNSghKOUT4Sb4VNlbxOuCN8Q55acD
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Ishani Chugh <chugh.ishani@research.iiit.ac.in>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <71566060-0670-6b23-372d-322ec64667c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
References: <20170721093416.17816-1-stefanha@redhat.com>
 <5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
 <CAFEAcA_njsLSkV1xvQ19j+89=prJGAbktkK9kNiaEQXTUtDkEQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_njsLSkV1xvQ19j+89=prJGAbktkK9kNiaEQXTUtDkEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 09:34 AM, Peter Maydell wrote:
> On 24 July 2017 at 15:28, Eric Blake <eblake@redhat.com> wrote:
>> On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
>>> There is not much getting started documentation for qemu-iotests.  Th=
is
>>> patch explains how to create a new test and covers the overall testin=
g
>>> approach.
>>>
>>> +2. Create the test file
>>> +
>>> +Copy an existing test (one that most closely resembles what you wish=
 to test)
>>> +to the new test number:
>>> +
>>> +  cp 001 <test-number>
>>
>> And mark it executable (chmod a+x <test-number>)
>=20
> It should already be executable because the test file being
> copied (001 in this case) is executable, shouldn't it?

Oh, I see what happened.  Rather than dropping to shell 'cp', I copied
via emacs' "ctrl-x ctrl-w" (write-file) and creating a new file name,
and that does not preserve executable bit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--US3qDNSghKOUT4Sb4VNlbxOuCN8Q55acD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2BwAACgkQp6FrSiUn
Q2rmmwgAjomS9tXkt5HGggp6LAI5G37xIPkGinZyOwJGfYJYtX2Ur1OOUVvLlkyA
SZN72ukc3IMkY6lg/t6bgSfuZGmxHaBbMSjiEE896eg5Z/GwLZNSgyCG1Y4MTX2W
hc6zOBFFa0T8Uz608UcJV22K94X8Has0bB8soYP4UnR5MpgsT6noC9Eay53Wn/Bo
dgPX+t46wEK3qQXEy3bdID0vOxGzzQMFL1NFgh3RebfTK27dBfUi2+Hu8btxyTN5
mif8hnupwuESGRzSYTbnHcX7tC1wqb2OquDJfH6OVnRXeCiFKxAQ7mE9rAAfc40/
dKYj4qagfjjtrh7CqKFEhELxhvBCQw==
=q7Ea
-----END PGP SIGNATURE-----

--US3qDNSghKOUT4Sb4VNlbxOuCN8Q55acD--
