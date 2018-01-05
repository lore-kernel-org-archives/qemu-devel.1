Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXTJ5-0003VT-Ut
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXTJ2-00031f-70
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:49:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXTJ1-00030P-Uv
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:49:12 -0500
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
	<4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
	<CAHNT7Ntz2C84DYMf+BM8WZ7kwMTuZ3Q5D+VfUxG0O87H6j94XQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <108446a9-e18b-b81a-66a0-058793a32953@redhat.com>
Date: Fri, 5 Jan 2018 08:49:09 -0600
MIME-Version: 1.0
In-Reply-To: <CAHNT7Ntz2C84DYMf+BM8WZ7kwMTuZ3Q5D+VfUxG0O87H6j94XQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k8g58DTn16Z0Hrs4ScAsAd8G5z6DO8a4c"
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k8g58DTn16Z0Hrs4ScAsAd8G5z6DO8a4c
From: Eric Blake <eblake@redhat.com>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>
Message-ID: <108446a9-e18b-b81a-66a0-058793a32953@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
 <1514940265-18093-22-git-send-email-mjc@sifive.com>
 <4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
 <CAHNT7Ntz2C84DYMf+BM8WZ7kwMTuZ3Q5D+VfUxG0O87H6j94XQ@mail.gmail.com>
In-Reply-To: <CAHNT7Ntz2C84DYMf+BM8WZ7kwMTuZ3Q5D+VfUxG0O87H6j94XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 12:47 AM, Michael Clark wrote:

>>
>>> +##
>>> +{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
>>
>> Should this be 'uint64' or other specific type, rather than the generi=
c
>> 'int' (which happens to be 64 bits, but signed)?  Other architectures
>> use 'int' because of history, but we could use this chance to improve
>> things if desired.
>>
>=20
> I'll have to defer to your better judgement as to whether we need to ch=
ange
> this. I like consistency. Is it a change that needs to be made to multi=
ple
> arches? It sounds relatively low risk. You decide.
>=20
> QAPI Schema
> M: Eric Blake <eblake@redhat.com>
> M: Markus Armbruster <armbru@redhat.com>

I'm fine if this patch uses 'int' for consistency, and will wait for
Markus to chime in on whether changing CpuInfo to use specific integer
types in general is worth a separate series later on.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k8g58DTn16Z0Hrs4ScAsAd8G5z6DO8a4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPkGUACgkQp6FrSiUn
Q2rIrQf+OhWBtzEi2WKUSdLjXBzuXoIozm6LF8FJrG0bi2hNAmo/Y9aNkNdMoCzD
D/aNQFD9bJ5oTOvwg2rH4P5MRhJy70X+LYcU4zgyPlBEJP61dgNMaOkINQMvNmo5
r0irRBu9BN2PdsKyDlls/BQzG4v+hFLfpOym4yn4tFknss2X1GYcsIJfJsqm07Dv
rCFW6bNGTjOl8BwyWQfSdgMxAb7AFu0Fz0Tl/O8P4lk+ck+mWhKqmkGb43VG8x43
jbFVKdosH9meAPuZU15wCKDsy+Xs9lPx9t1fI1pmgvTg4sj+BpKC42TbhhTKVM7A
+YpqxiCN1cTAlMhEhmemFZ1fSPrEWA==
=Z01A
-----END PGP SIGNATURE-----

--k8g58DTn16Z0Hrs4ScAsAd8G5z6DO8a4c--
