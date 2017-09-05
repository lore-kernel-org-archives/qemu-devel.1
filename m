Received: from eggs.gnu.org ([2001:4830:134:3::10]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpEaE-0005X2-La
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpEa5-00034x-6U
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:12:06 -0400
References: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1f3dc26-8499-02ba-9dfc-a2e96e766b79@redhat.com>
Date: Tue, 5 Sep 2017 09:11:53 -0500
MIME-Version: 1.0
In-Reply-To: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bJOmNbG3DJNkxbMDHbKugOLHhIM41Gw89"
Subject: Re: [Qemu-devel] [PATCH] util/qemu-thread-posix.c: Replace OS
 ifdefs with CONFIG_HAVE_SEM_TIMEDWAIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bJOmNbG3DJNkxbMDHbKugOLHhIM41Gw89
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org
Message-ID: <f1f3dc26-8499-02ba-9dfc-a2e96e766b79@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util/qemu-thread-posix.c: Replace OS ifdefs
 with CONFIG_HAVE_SEM_TIMEDWAIT
References: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504613972-15847-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 07:19 AM, Peter Maydell wrote:
> In qemu-thread-posix.c we have two implementations of the
> various qemu_sem_* functions, one of which uses native POSIX
> sem_* and the other of which emulates them with pthread conditions.
> This is necessary because not all our host OSes support
> sem_timedwait().
>=20
> Instead of a hard-coded list of OSes which don't implement
> sem_timedwait(), which gets out of date, make configure
> test for the presence of the function and set a new
> CONFIG_HAVE_SEM_TIMEDWAIT appropriately.
>=20
> In particular, newer NetBSDs have sem_timedwait(), so this
> commit will switch them over to using it. OSX still does
> not have an implementation.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> It would be nice to gradually reduce the number of places
> we do per-OS ifdeffery in favour of checking for the specific
> feature we care about in each case...

Yes, that's always been autoconf's philosophy: feature tests trump
platform tests every time, because platforms can add features over time,
and because an ifdef on a single feature test is easier to read than a
list of platform names.

> Tested on Linux, NetBSD, OSX.
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bJOmNbG3DJNkxbMDHbKugOLHhIM41Gw89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmusKkACgkQp6FrSiUn
Q2oUFgf+I8JiApI4P+Pzxykrl5lVGjzQTMaXmA9pJ+DupHiRyATf3S5zygEUMkZU
Xn85Sniqt/WZNtJ0yMzo8onplqD6aYgCTev4EUs4ci9tHfUyot9SKXBJeJpwXoCX
0PKrMnvU6nOAieUHad8xo8H46l1sv1WwYT31leCdj4r3KpMY4PbmPFo4wmhYg10Q
aqGn4qjnG2FKUkIQM/Asm/xlYMY13HmY4tl32FuiTiH6SxAfanW5/t8hztZA2Oht
IYxvSLuNaBQJjdkTfLdJC/G65TPBoLSw3OhbCBNyaspB8dw71FjgNoAIYJ9XzvgZ
YgBR1dsVrXHczm12/ml6RZ+QWhwImQ==
=SA8i
-----END PGP SIGNATURE-----

--bJOmNbG3DJNkxbMDHbKugOLHhIM41Gw89--
