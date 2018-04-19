Received: from eggs.gnu.org ([2001:4830:134:3::10]:34532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I9G-0002lO-KH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9I9C-0006yp-Fh
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:35:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9I9C-0006vl-AM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:35:22 -0400
References: <20180212072207.9367-1-armbru@redhat.com>
	<20180212072207.9367-15-armbru@redhat.com>
	<CAMxuvaxFtRUrzJsgyG+sF+ZyppB=dZx_UW=Jjw6tuWpj1O92sw@mail.gmail.com>
	<87muzzingj.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5cd1476-87b6-a629-290c-70d97a5bbc80@redhat.com>
Date: Thu, 19 Apr 2018 17:35:18 -0500
MIME-Version: 1.0
In-Reply-To: <87muzzingj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lp1A89c2C0zq46MMRNafOyPGHiqz9YQSE"
Subject: Re: [Qemu-devel] [PATCH RFC 14/14] qapi: Add #if conditions to
 commands, events, types, visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lp1A89c2C0zq46MMRNafOyPGHiqz9YQSE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <b5cd1476-87b6-a629-290c-70d97a5bbc80@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 14/14] qapi: Add #if conditions to
 commands, events, types, visitors
References: <20180212072207.9367-1-armbru@redhat.com>
 <20180212072207.9367-15-armbru@redhat.com>
 <CAMxuvaxFtRUrzJsgyG+sF+ZyppB=dZx_UW=Jjw6tuWpj1O92sw@mail.gmail.com>
 <87muzzingj.fsf@dusky.pond.sub.org>
In-Reply-To: <87muzzingj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2018 12:13 PM, Markus Armbruster wrote:

[reviving this RFC]

>=20
> For what it's worth, I disliked the decorator magic enough to write thi=
s
> series.
>=20
>>                Furthermore, I don't fancy much having to redo and tune=

>> the generation *again* to fix the inden, extra-spaces etc that were
>> fixed after several revisions (it takes hours to get there, it's
>> boring). Can't we go first with my approach and then look at replacing=

>> it? Can't one add a "FIXME: replace the decorator with something less
>> magic" at ifcond_decorator definition for now? Is this code so
>> critical that it has to be the way you want in the first place? The
>> approach to take it first and improve it worked very well for
>> qapi2texi, it just took a few more days for you (and reviewers) to
>> improve it. I'd suggest we work that way instead of having me rewrite
>> and rewrite until you are happy (which is something I can't do right
>> without many painful iterations for you and me).
>=20
> This is up to the backup QAPI maintainer now :)

Except my (cop-out?) decision was that it was not 2.12 material, so now
that 2.13 is opening up it's somewhat back to you...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Lp1A89c2C0zq46MMRNafOyPGHiqz9YQSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrZGaYACgkQp6FrSiUn
Q2pltAf9HWYmvZcpnWP6y1e32IyD7Wf7+HULdWv8jplb4binEEyZRDSVmd961hQ0
Oo9f3+vr02HOT96fMElrXBvegomCRcw1D3r1v0NC7+IEUTZ8RqUzDYiU5zC5uyJb
dYhUGDsEYz6PypSyuwC87g0UMdhqVuFDD1OL9g3EqhP+13xsG2GHXQLV+D5HD/No
6QfnwSS3niMKPUfYCNilQkVrBUvygDiS0jMNjckuBXVoMYCZAr4DXfCH4q1S36CP
I/B6P703dMw2Vh5KvWnfDvnFrEm9dR2HKKcaj95janopn2Au+laDDnvkG8y3HXIt
SrBz9Fh0ZMi8sLh1YMek0a0kYCSZUw==
=5nIL
-----END PGP SIGNATURE-----

--Lp1A89c2C0zq46MMRNafOyPGHiqz9YQSE--
