Received: from eggs.gnu.org ([2001:4830:134:3::10]:48537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kjM-0001ga-QW
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kjL-0004Mq-Qd
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:53:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3kjL-0004Mb-L9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:53:47 -0400
References: <1522855165-9959-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <799e1ff8-78de-6bac-a5f5-65d747adfc23@redhat.com>
Date: Wed, 4 Apr 2018 10:53:46 -0500
MIME-Version: 1.0
In-Reply-To: <1522855165-9959-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jFGpH2n1j0HJLqqXs0Wv9wlQZ76nyV2pi"
Subject: Re: [Qemu-devel] [PATCH v2 RFC 0/2] Implement Hex file loader and
 add test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jFGpH2n1j0HJLqqXs0Wv9wlQZ76nyV2pi
From: Eric Blake <eblake@redhat.com>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@gmail.com,
 jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org
Message-ID: <799e1ff8-78de-6bac-a5f5-65d747adfc23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 RFC 0/2] Implement Hex file loader and add
 test case
References: <1522855165-9959-1-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1522855165-9959-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 10:19 AM, Su Hang wrote:
> These series of patchs implement Intel Hexadecimal File loader and
> add QTest testcase to verify the correctness of Loader.
>=20
> v1: Basic version.
> v2: Replace `do{}while(cond);` block with `for(;;)` block to
> suppress code style complain.

Better than rewriting code to work around a false positive is to fix the
false positive in the first place.  And I see you have a patch proposed
for that, but it was still marked RFC; unfortunately, during freeze,
patches that are marked RFC tend to be deferred in favor of patches
marked 'for-2.12' (RFC means the patch may be incomplete, and there's no
rush to get an incomplete patch in before the release, after all).  I'll
reply on that patch, now that it's got my attention; but for this
particular series, I'm more comfortable leaving the review to the
maintainer, modulo one comment:

>=20
> Su Hang (2):
>   Implement .hex file loader
>   Add QTest testcase for the Intel Hexadecimal Object File Loader.
>=20
>  hw/arm/boot.c          |   9 +-
>  hw/core/loader.c       | 280 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  include/hw/loader.h    |  17 +++
>  tests/Makefile.include |   2 +
>  tests/hexloader-test.c |  56 ++++++++++
>  tests/test.hex         |  11 ++
>  6 files changed, 374 insertions(+), 1 deletion(-)
>  create mode 100644 tests/hexloader-test.c
>  create mode 100644 tests/test.hex

This creates new files that are not covered by MAINTAINERS.  Please be
sure to patch MAINTAINERS as well in your v3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jFGpH2n1j0HJLqqXs0Wv9wlQZ76nyV2pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE9QoACgkQp6FrSiUn
Q2oMWgf/fnS1rnUKku6zv4LrQZCFKcQOfOZ+7LycdGBPOigq+twb7f8btYaNxpAV
NDBJ9L8Ze0mnkzftswIV4jZagX+xjy1zIa3cJnvG9qvRAoCSbIHShLuQ/Td39RQP
4/O8DsoH/1CDbFmGfnUyRAknymQ95YV2CWZMT8hLYqGOCBV7s6r29XcrR9aYUO1c
7OWf95de9HT/0uZnTeIboL4MiZ9zR1juvmauMYh5hAKCy0Z0Zt83rC5cu842jpF9
Dt1Mu/HrjY7ylYMJ0wGpzgonm65kxEXBmAbcSaKNK2eUoeNaTxCEynSXVpbBLqPO
DqQ09jqJAx+vribmkcgMvONWQGTOgQ==
=KUZ+
-----END PGP SIGNATURE-----

--jFGpH2n1j0HJLqqXs0Wv9wlQZ76nyV2pi--
