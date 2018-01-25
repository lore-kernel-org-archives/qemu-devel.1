Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeoBm-0002oa-Lu
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeoBi-0003sl-Li
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:32:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eeoBi-0003s9-DY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:31:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 147896517E
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 20:31:57 +0000 (UTC)
References: <20180125175949.7780-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b960664b-114d-60c9-e6a3-f69acb61e6c4@redhat.com>
Date: Thu, 25 Jan 2018 14:31:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180125175949.7780-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5UXpjZC3RI5X90fa9e9FJ0xx24wZQc1RU"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5UXpjZC3RI5X90fa9e9FJ0xx24wZQc1RU
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <b960664b-114d-60c9-e6a3-f69acb61e6c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] coroutine-lock: polymorphic CoQueue
References: <20180125175949.7780-1-pbonzini@redhat.com>
In-Reply-To: <20180125175949.7780-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 11:59 AM, Paolo Bonzini wrote:
> There are cases in which a queued coroutine must be restarted from
> non-coroutine context (with qemu_co_enter_next).  In this cases,
> qemu_co_enter_next also needs to be thread-safe, but it cannot use a
> CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
> right now is rolling its own list of Coroutines) and will happen in
> Fam's NVMe driver as well.
>=20
> This series extracts the idea of a polymorphic lockable object
> from my "scoped lock guard" proposal, and applies it to CoQueue.
> The implementation of QemuLockable is similar to C11 _Generic, but
> redone using the preprocessor and GCC builtins for compatibility.
>=20
> In general, while a bit on the esoteric side, the functionality used
> to emulate _Generic is fairly old in GCC, and the builtins are already
> used by include/qemu/atomic.h; the series was tested with Fedora 27 (bo=
ot
> Damn Small Linux via http) and CentOS 6 (compiled only).
>=20
> Paolo
>=20
> v1->v2: fix typos and copyright year
>=20
> v2->v3: add tests, fix brown paper bag bug, avoid -Waddress errors

I spotted a few typos, but did not rigorously test it enough to leave
R-b.  At any rate, writing polymorphic code in C is an interesting
exercise, so it was fun learning from this thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5UXpjZC3RI5X90fa9e9FJ0xx24wZQc1RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpqPrkACgkQp6FrSiUn
Q2oqNAf+N+wiHOUDt5LheQQyB2BNrM8+232w6iFYsE6Q8eXUwkDhDXdJXkelUp88
uH56/GzDVxM9gJf+WPQKRsGkv11WkgJXSGNnOT9AyVddTRRRCyX9VHs5aLHfzNoU
SZlNalqlZsXa7kTM06grRF1He7BytG06KaRGEaquy+2Gxm27C7xYjzFedqjFEpS5
5T7/u0KFpYagbiM4MT4r69LyIdiygvF1MiErRsK8hyQGd7C+T6hkFGc+pAaR+n3N
6Xc3Pxfcf5SJX5z5kR/Khm5ri8I9rbpCgPhlB9I3isub07nGAMHiXPlS3Ks3vAsi
HoMvsuTmjlM5VJ0ovgkcGcsWaCJj9g==
=OcOm
-----END PGP SIGNATURE-----

--5UXpjZC3RI5X90fa9e9FJ0xx24wZQc1RU--
