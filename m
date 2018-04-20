Received: from eggs.gnu.org ([2001:4830:134:3::10]:41194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9VNe-0004yy-MS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9VNb-0003Wd-IS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:43:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9VNb-0003W2-Cm
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:43:07 -0400
References: <20180419223151.623174-1-eblake@redhat.com>
	<20180419223151.623174-2-eblake@redhat.com>
	<87po2u1f3f.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6cbb484e-7f75-5732-5ada-9fcd3a95d00f@redhat.com>
Date: Fri, 20 Apr 2018 07:42:57 -0500
MIME-Version: 1.0
In-Reply-To: <87po2u1f3f.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2b3opfTF9j3kNi9eco7NnoLX1U8a0IUzZ"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: Rename QMP and QGA schema
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2b3opfTF9j3kNi9eco7NnoLX1U8a0IUzZ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <6cbb484e-7f75-5732-5ada-9fcd3a95d00f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: Rename QMP and QGA schema files
References: <20180419223151.623174-1-eblake@redhat.com>
 <20180419223151.623174-2-eblake@redhat.com>
 <87po2u1f3f.fsf@dusky.pond.sub.org>
In-Reply-To: <87po2u1f3f.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2018 03:01 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Having two files in the tree both named qapi-schema.json just adds
>> confusion.  Rename these files to {qmp,qga}-schema to make it
>> obvious which schema is in effect, and relocate qga into the common
>> qapi/ subdirectory.  Update all build rules that refer to the file
>> names, and adjust other documentation and comment references that
>> need to refer to the new file names.
>>
>> Maintainer-wise, this means that qapi/qga-schema.json continues
>> to belong to Michael as QGA maintainer, but now also notifies
>> Markus and Eric as QAPI maintainers, alongside all the other
>> QMP QAPI files, matching how other .json QAPI modules belong
>> to multiple maintainer blurbs.  Also, fix a stale reference to
>> a file removed in commit eb815e248f.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> We have three separate things: QAPI infrastructure, its use in QEMU
> proper, and its use in QGA.  We keep the former two in qapi/, and the
> latter in qga/.

And another thread raised the possibility of firmware.json (or
firmware.qapi, if we like patch 2) being in yet another directory.

>=20
> Giving the two qapi-schema.json different names is fine with me.
> qga-schema.json is an obvious choice.  qmp-schema.json less so, because=

> it's actually used for more than just QMP now.  qemu-schema.json?  Or
> just keep the old name?

qapi-schema.qapi sounds repetitive; qemu-schema.qapi seems reasonable,
if we need it.  Also, remember that we have the QMP command
'query-qmp-schema', so the name qmp-schema makes some sense, even if the
file does cover more than QMP.

>=20
> Splitting qapi/ into infrastructure and use now doesn't seem to be wort=
h
> the bother.  I'd prefer to keep the use for QGA separate, though.  The
> case for moving them together would be stronger if they shared schema
> parts.  Matter of taste, I guess, and that means it's up to the QGA
> maintainer.  Michael?
>=20
> If we decide to keep them separate, but still want MAINTAINERS' QAPI
> Schema stanza to cover QGA, that's a one-liner.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2b3opfTF9j3kNi9eco7NnoLX1U8a0IUzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrZ4FIACgkQp6FrSiUn
Q2rMygf/Z0jb6qEG1mk1FKqu7+atQQERwp2Y3ZXJSzuZcgRQCuNArjAcmfF5JqTS
UCEWmIn0vSk303QuIM8nmSHopEc70CeRVyYA9DOY0wkwi5C+DUEi6J67Irvyy2ZK
oTreQkkXTti7PTb2wYotXWv6xCLE7k2BhnuDhnu9AaKmXe+5e1BaLyUi/V/AIM0T
WTXAycPRL9z1pVzZoQNNfAmo1tsOC21RykqB+9Z0sR0u7xScLlXvPOHJD7h0/WZ2
nNSMq7YfogU2isQ+hkfL9YHln4n8dgdPM2CY8Bcmp9lmzKkocNAzcL7JqYedPVrc
lw2fyjStwUQcRaQDGrLbkBZP/3Fibg==
=YAgE
-----END PGP SIGNATURE-----

--2b3opfTF9j3kNi9eco7NnoLX1U8a0IUzZ--
