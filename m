Received: from eggs.gnu.org ([2001:4830:134:3::10]:35486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqUS-0005HX-CQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqUP-0004MM-8s
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXqUO-0004Kr-V2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:13 -0400
References: <201707191247531805742@zte.com.cn>
	<20170719061651.GE2757@localhost.localdomain>
	<20170719121628.GI2103@work-vm>
	<20170719124147.GH2757@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
Date: Wed, 19 Jul 2017 10:02:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170719124147.GH2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nJ3CduO3JuNSlAnhBGwMTSOOWNVixg8fx"
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: wang.yi59@zte.com.cn, liu.yunh@zte.com.cn, qemu-devel@nongnu.org, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net, "libvir-list@redhat.com" <libvir-list@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nJ3CduO3JuNSlAnhBGwMTSOOWNVixg8fx
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: wang.yi59@zte.com.cn, liu.yunh@zte.com.cn, qemu-devel@nongnu.org,
 pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net,
 "libvir-list@redhat.com" <libvir-list@redhat.com>
Message-ID: <f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
References: <201707191247531805742@zte.com.cn>
 <20170719061651.GE2757@localhost.localdomain> <20170719121628.GI2103@work-vm>
 <20170719124147.GH2757@localhost.localdomain>
In-Reply-To: <20170719124147.GH2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding libvirt]

On 07/19/2017 07:41 AM, Eduardo Habkost wrote:

>> virsh  qemu-monitor-command --domain rhel6.8 --hmp --cmd "cpu 1"
>> virsh  qemu-monitor-command --domain rhel6.8 --hmp --cmd "info lapic"
>> dumping local APIC state for CPU 0
>=20
> Right, the "cpu" command is useless inside a
> 'human-monitor-command' QMP command.  The 'cpu-index' argument
> should be used instead. should make "cpu" print an error if ran
> inside 'human-monitor-command' instead of silently pretend it
> worked.
>=20
> If virsh doesn't support the 'cpu-index' argument to
> 'human-monitor-command',

It doesn't.  Perhaps we should add that as a future libvirt-qemu.so API
addition, although it's probably easier to just use QMP than HMP when
using 'virsh qemu-monitor-command' if HMP doesn't do what you want.

> it's possible to work around that
> limitation by building your own QMP command.  e.g.:
>=20
>   # virsh qemu-monitor-command f26test '{"execute":"human-monitor-comma=
nd", "arguments":{"command-line":"info lapic", "cpu-index":1}}' | jq -r '=
=2Ereturn'

Indeed, there's the use of QMP to work around the HMP deficiency.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nJ3CduO3JuNSlAnhBGwMTSOOWNVixg8fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvdGwACgkQp6FrSiUn
Q2raJQf+JIqAq+yX1txQddTakMcQU+jcUXUHUoJD14By6AT20oLN8MRHNkiu4spo
TnIN++TZXu6thPDpVglxhQsEGxEEti39+Ja0OzE07oBC5ydltum5WDvpiItK8y9l
UYPwV3i03DbenebYOljhTbAtpF04qTGkVkaiqr6kZl5HIYObAJJ+hweraTgWgnqq
7ceaIyl45KTYnRLNSU+1xeFPRfZgKlPX4sP4quatZOywWeLPZfDZbvfWPv8S3nMK
3E3hr5saBiExTGRgzONVpwJsJfrYRkwN7HFqJZjCjBx8OERoBUOhbaf0foTg9XDw
RS7pS//71/46R4rAAFeLqX2kiNsinA==
=yUil
-----END PGP SIGNATURE-----

--nJ3CduO3JuNSlAnhBGwMTSOOWNVixg8fx--
