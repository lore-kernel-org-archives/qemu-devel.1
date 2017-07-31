Received: from eggs.gnu.org ([2001:4830:134:3::10]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9ym-0001rR-RZ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9yj-0007m3-Nl
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dc9yj-0007lX-Db
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:39:21 -0400
References: <150127405114.4205.4905957472648540492.malonedeb@gac.canonical.com>
	<87shhd9f89.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce479179-68e6-3a79-01e8-912b6234a2b5@redhat.com>
Date: Mon, 31 Jul 2017 07:39:13 -0500
MIME-Version: 1.0
In-Reply-To: <87shhd9f89.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vnkv5kl76HgCG3IgAfhWG7ooNfm3jbOSs"
Subject: Re: [Qemu-devel] [Bug 1707297] [NEW] qemu became more picky parsing
 -m option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, John Florian <1707297@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vnkv5kl76HgCG3IgAfhWG7ooNfm3jbOSs
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 John Florian <1707297@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org
Message-ID: <ce479179-68e6-3a79-01e8-912b6234a2b5@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1707297] [NEW] qemu became more picky parsing
 -m option
References: <150127405114.4205.4905957472648540492.malonedeb@gac.canonical.com>
 <87shhd9f89.fsf@dusky.pond.sub.org>
In-Reply-To: <87shhd9f89.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 03:34 AM, Markus Armbruster wrote:
> John Florian <1707297@bugs.launchpad.net> writes:
>=20
>> Public bug reported:
>>
>> With qemu-kvm-2.9.0-3.fc26.x86_64 I am no longer to specify the memory=

>> size using something like "-m 1.00000GiB" but with qemu-
>> kvm-2.7.1-7.fc25.x86_64 I could without any problem.  I now get an err=
or
>> message like:
>>
>> qemu-system-x86_64: -m 1.00000GiB: Parameter 'size' expects a non-nega=
tive number below 2^64
>> Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, p=
eta-
>> and exabytes, respectively.
>>
>>
>> Is this expected or a regression?
>=20
> We recognize suffix "G".  Before commit 75cdcd1 (v2.9.0), trailing
> garbage after a recognized suffix was silently ignored.  "1.0G",
> "1.0GiB", "1.0Garbage-trucks-of-RAM" were all the same to QEMU.  No
> more.
>=20
> All clear?

That said, virsh from libvirt manages to recognize 'G' and 'GiB' as
synonyms (powers of 2), as well as 'GB' (powers of 10); we could justify
patching qemu's parser to accept more valid suffixes, particularly since
'GiB' is a typical suffix that has seen use (in spite of it not being
documented).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vnkv5kl76HgCG3IgAfhWG7ooNfm3jbOSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/JPEACgkQp6FrSiUn
Q2p3Egf/V9pLuZ614bm5FqmcuBzj9H4gGx71spL+Bjc+uzny3jAWwVg9LHS7RUIR
7V5V951QLnFEui7BAh/VThHN5VJ3ZVnp+BUwY2Os2xq044DDzM794LDij/KBzUAM
HbJQmzt2D5/q1iaAMXl6FJpqylXqvcXxq8Rw2QNovWWgOnvsPuxZW3Fv1MH+0Jvc
w7yt3eVJ46c7Eps7S7nJ9UP+pV4YXLeOG5cHIlsPuiidxFb17XmS/a7HZyyvizEP
gDO/VEEemPPR9E0b7f+42kp7Z+OkWTPlZb+ciqDetJob9hqVvc07zDj2loPtSNhU
13hLzcBk0obThYStP8VgJTXd1HCeVQ==
=QZ3o
-----END PGP SIGNATURE-----

--vnkv5kl76HgCG3IgAfhWG7ooNfm3jbOSs--
