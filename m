Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4prP-00050E-7k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4prA-0002Oh-Ay
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:02:13 -0400
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d7d4163-1752-64a1-e5e1-d0b45bd3eb46@redhat.com>
Date: Wed, 18 Oct 2017 10:01:57 -0500
MIME-Version: 1.0
In-Reply-To: <1508336428-20511-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DOqkwRbVgpop33BotLd5WXqkHk5f7oEGh"
Subject: Re: [Qemu-devel] [PATCH 0/2] Enable the simple virtio tests on
 s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DOqkwRbVgpop33BotLd5WXqkHk5f7oEGh
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com,
 Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>
Message-ID: <9d7d4163-1752-64a1-e5e1-d0b45bd3eb46@redhat.com>
Subject: Re: [PATCH 0/2] Enable the simple virtio tests on s390x, too
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1508336428-20511-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 09:20 AM, Thomas Huth wrote:
> First patch introduces the qtest_startf() function that can be used
> to start tests with a printf-like string. This patch was originally
> part of Eric's bigger qtest refactoring series, and I originally wanted=

> to wait 'til it's included in the master branch. But since this did
> not happen yet and QEMU soft-freeze is approaching soon, I decided
> to rather included a slightly simplified version of that patch here
> instead.

Fair enough.  I'm also trying to focus on getting features in before
soft freeze, hence my lack of rebasing the qtest refactoring series in
the meantime.  Arguably (although it is a bit weak) we can claim
testsuite fixes as material that is still relevant after soft freeze as
it does not affect the final installed binaries, as long as they still
go in before hard freeze, but it's hard to say at this point if any of
my qtest refactoring will make 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DOqkwRbVgpop33BotLd5WXqkHk5f7oEGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnbOUACgkQp6FrSiUn
Q2p4QQf7Bzf8qlBKh/N/R1CKm5boTL7a6kpHmstl2wNTR+ZaHuQyABOgunm0bUbN
NSjkTNErJtkWO9G7etKNl21mzKSmTrFSvMEjIEehtL9tUTCkzR0uhhBVaYxDiRHI
V9nyzrKLyBxec4oUlnpPyj6wjKwIj1u++81RTf33qGDlevaf9W0pVNYxsvLzKb6y
vn2zYUM7Tc4oYopu6q/d/KyAe2Mb8q/+dd+xW15eC07HBPeE6d2tB3wQMfJK0O41
ZuIZA1fHDmGdJZhWBJ5aiHCGPsWIU06GnF03N+Fs3GFpVU0jAiUkihJIkDdomAKQ
ZdwB2JOd67WBUv4SIikgbi98/Hl7nw==
=nkro
-----END PGP SIGNATURE-----

--DOqkwRbVgpop33BotLd5WXqkHk5f7oEGh--
