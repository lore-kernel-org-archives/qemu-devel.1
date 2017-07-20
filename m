Received: from eggs.gnu.org ([2001:4830:134:3::10]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYHwx-0001OM-Vd
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYHwt-0003G6-BG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:21:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYHwt-0003F9-1a
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:21:27 -0400
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-2-eblake@redhat.com>
	<87vamnmqab.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5e2e67d-82b6-92cf-715a-2a7129e83df5@redhat.com>
Date: Thu, 20 Jul 2017 15:21:24 -0500
MIME-Version: 1.0
In-Reply-To: <87vamnmqab.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="caMnnODaSiNKbC4N5CRuqxlxFadnmGmDV"
Subject: Re: [Qemu-devel] [PATCH 1/5] qapi: Further enhance visitor virtual
 walk doc example
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
--caMnnODaSiNKbC4N5CRuqxlxFadnmGmDV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <e5e2e67d-82b6-92cf-715a-2a7129e83df5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] qapi: Further enhance visitor virtual
 walk doc example
References: <20170714190827.4083-1-eblake@redhat.com>
 <20170714190827.4083-2-eblake@redhat.com> <87vamnmqab.fsf@dusky.pond.sub.org>
In-Reply-To: <87vamnmqab.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 04:05 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Markus pointed out that the example given for virtual walks did
>> not discuss how to do a virtual walk of an alternate type.  It
>> turns out that for output, we don't need to visit an alternate
>> (just directly visit the type that we want); and for input,
>> visit_start_alternate() is not currently wired up for alternates
>> (it requires a QAPI type, rather than permitting NULL for a
>> virtual walk).  Also, the example was never updated in commit
>> 3b098d5 about where visit_complete() would fit in.  Improve the
>> description and example to give more details along these lines.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> This clashes with some unfinished work I have on alternates.  If I can
> finish it quickly, we can compare and decide whether we still need this=
=2E

It sounds like your stuff is 2.11 material; at this point, I'm trying to
decide which of my patches are still worth 2.10 softfreeze material.
While doc fixes are safe, I'm also fine stating that we don't want
churn, so I'll remove this part of my series from 2.10 consideration,
and like you say, we'll compare against your work in 2.11 later.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--caMnnODaSiNKbC4N5CRuqxlxFadnmGmDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxEMQACgkQp6FrSiUn
Q2o5JQf+PhZIBqoiondEtvq3F1o+iQDuHimErqN0P5AqEZd1PaG2OHH8qXHY1Cw4
WMUUREJxi9LfARfU5Ku7jkejf1lVXyS2rBgzuKP8//DNnWlhONT9a/tkXeeodLCz
x2FFYK0s3RCe7duYEoPQRZBM5N80F9sO7p1RQ3oxScdLv8ZjwvS9hc0AYV3bFIBq
4UVDFn2gxpWZrZywNuBNaikkmWILKeT21tMl3l6FXzDMmk5lAXTNXIrmAf4M0Vi0
5kOyu6W6hIpvm99geWZW/btKizzMY7Fif6+g+dJrASi5MucM0YxHzbSLDwe/RTeD
VLp4VcxBGdMIYzxl2XEfT4boz/yedg==
=96kg
-----END PGP SIGNATURE-----

--caMnnODaSiNKbC4N5CRuqxlxFadnmGmDV--
