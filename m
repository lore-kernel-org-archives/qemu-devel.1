Received: from eggs.gnu.org ([2001:4830:134:3::10]:55338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNu6-0006fA-7R
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNu2-0002Id-WE
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:49:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqNu2-0002IH-Mv
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:49:02 -0400
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<1489562641.15659.16.camel@redhat.com>
	<1489657576.561.24.camel@nokia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33ee8842-e57d-c637-ae26-e4b89a7c1002@redhat.com>
Date: Tue, 21 Mar 2017 12:48:58 -0500
MIME-Version: 1.0
In-Reply-To: <1489657576.561.24.camel@nokia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oigvj8tR6a1FJxppHJ2EaKhevPgQROIpC"
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janne Huttunen <janne.huttunen@nokia.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oigvj8tR6a1FJxppHJ2EaKhevPgQROIpC
From: Eric Blake <eblake@redhat.com>
To: Janne Huttunen <janne.huttunen@nokia.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <33ee8842-e57d-c637-ae26-e4b89a7c1002@redhat.com>
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
References: <cover.1489494746.git.janne.huttunen@nokia.com>
 <1489510640.8844.18.camel@redhat.com> <1489561105.24841.25.camel@nokia.com>
 <1489562641.15659.16.camel@redhat.com> <1489657576.561.24.camel@nokia.com>
In-Reply-To: <1489657576.561.24.camel@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 04:46 AM, Janne Huttunen wrote:
> On Wed, 2017-03-15 at 08:24 +0100, Gerd Hoffmann wrote:
>>>
>>> The short answer: emulating real hardware.
>>
>> Ok, that is reason enough.
>>
>> Adding bootonceindex everywhere doesn't look like the best plan to me
>> though.  Possibly we can pimp up bootindex in a backward-compatible
>> way?
>> Something like bootindex=3D<normal>[.<once>] ?
>=20
> That would (likely) avoid modifying all devices, but wouldn't
> that make the 'bootindex' property a string (now: 'int32')
> and thus change the QOM API?

Is there any way to make use of an alternate that supports both int and
string simultaneously?  But see also Markus' recent addendum on the
difficulties of supporting multiple types on command-line vs. through QMP=
:

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04125.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oigvj8tR6a1FJxppHJ2EaKhevPgQROIpC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0WeKAAoJEKeha0olJ0NqThQH/2PgcCDeUWZ03uRmxW+5xqCJ
C+6kTzf5dV4VAxEw2ZooFW1an+RWbYEqGJ19k/9VBriXloxjqjZ0m+IJQkdq1WeC
ZU08Qri8xj5dJb7k0xOUZMj85mxOW32hEGIC7/K+Wvm4jsiV3Zh3JyRCV9e03Aew
Fl+apgBMZpWlsZ7ylSoErbWQsw8VYRn7ch72EY5YSXzsdjsdOq/0I0a9L9ICyTox
xBq92sVqbEw7D+og6xTHCVi3dtC657KoWujUCZMl+0qbVHVIhtDr+KGzisqEl/yJ
bXz3IdFW2IJ32UcoISTbrX0yQEHx+N1okzzPfIZx6V8lRGl1Ds8xnjplSFShzdA=
=E7+Z
-----END PGP SIGNATURE-----

--oigvj8tR6a1FJxppHJ2EaKhevPgQROIpC--
