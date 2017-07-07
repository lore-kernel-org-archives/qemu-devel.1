Received: from eggs.gnu.org ([2001:4830:134:3::10]:52042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTRW8-0001sr-0k
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTRW4-0000WS-Sg
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:33:48 -0400
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
	<149915849243.6295.4484103824675839071.stgit@frigg.lan>
	<d1a9d3b0-96a3-60e0-270b-3e9ef82cafac@redhat.com>
	<87tw2og0ov.fsf@frigg.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73eddf81-f124-9668-2920-86e6b4873f63@redhat.com>
Date: Fri, 7 Jul 2017 06:33:37 -0500
MIME-Version: 1.0
In-Reply-To: <87tw2og0ov.fsf@frigg.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pocikLA7ArMkC5RqfpIJmMCo7N7gCn2Gj"
Subject: Re: [Qemu-devel] [PATCH v11 6/6] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pocikLA7ArMkC5RqfpIJmMCo7N7gCn2Gj
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>
Message-ID: <73eddf81-f124-9668-2920-86e6b4873f63@redhat.com>
Subject: Re: [PATCH v11 6/6] trace: [trivial] Statically enable all guest
 events
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
 <149915849243.6295.4484103824675839071.stgit@frigg.lan>
 <d1a9d3b0-96a3-60e0-270b-3e9ef82cafac@redhat.com> <87tw2og0ov.fsf@frigg.lan>
In-Reply-To: <87tw2og0ov.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 02:34 AM, Llu=C3=ADs Vilanova wrote:
> Eric Blake writes:
>=20
>> On 07/04/2017 03:54 AM, Llu=C3=ADs Vilanova wrote:
>>> The existing optimizations makes it feasible to have them available o=
n all
>>> builds.
>=20
>> While this change may feel trivial, I think it is a misnomer to includ=
e
>> "[trivial]" in the subject line, and I also think it should not go in
>> through qemu-trivial.  The ideal trivial patch is one that can be
>> applied in isolation, but your patch can only be applied as part of a
>> series that includes the earlier optimizations that made this one poss=
ible.
>=20
> Ok. Does this mean I should send a new series without the trivial tag?

Probably not worth the effort this time around, unless a maintainer
specifically asks for it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pocikLA7ArMkC5RqfpIJmMCo7N7gCn2Gj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX3GRAAoJEKeha0olJ0Nq3WUIALBDdRgU6IhBvkAED4ZNze5b
eLf421D4uMAAzEP6qu+HSYu4ggaxn/seyuqc+bN80VRyfVuN0VnEHhasmmtFsPwC
J/QtQwY2FivDILOALj86CppA5k1UzG3t1ExnDoVH58MH6/QRIqI38OxoIIl3FySp
/bqiWld2HdzDjlGq3rfXtuA0M3/N29ju30SsP1dO7KSXioFAvna8SODgnkRGidwa
Hbc64xkbFLWpEHgGXjRbHSdcgpR8bpjx5eWpKPJ/r8ltZth5AJo7Q/iTNZzLvm5e
WzS4/QxKTXwkTjXZXVhgGdJ2F9/ynb2Ce7rGEneoVAST6Kwq8jOoWt2yv9sl9Tg=
=/CJM
-----END PGP SIGNATURE-----

--pocikLA7ArMkC5RqfpIJmMCo7N7gCn2Gj--
