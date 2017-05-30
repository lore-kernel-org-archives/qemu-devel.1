Received: from eggs.gnu.org ([2001:4830:134:3::10]:59955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFgeE-0001cX-2C
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFgeA-0006J2-Vy
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFgeA-0006Ix-Ml
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:53:14 -0400
References: <20170526054013.299-1-n54@gmx.com>
	<20170530062022.5841-1-n54@gmx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
Date: Tue, 30 May 2017 07:53:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170530062022.5841-1-n54@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cVKH9V8iW4vKqMREltqLeLpLaEjH0HWnC"
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, armbru@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cVKH9V8iW4vKqMREltqLeLpLaEjH0HWnC
From: Eric Blake <eblake@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 f4bug@amsat.org
Message-ID: <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
References: <20170526054013.299-1-n54@gmx.com>
 <20170530062022.5841-1-n54@gmx.com>
In-Reply-To: <20170530062022.5841-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 01:20 AM, Kamil Rytarowski wrote:
> Currently ivshmem requires eventfd() which is Linux specific.
> Do not and build it unconditionally on every Linux/BSD/Solaris.
>=20
> This patch indirectly fixes build failure on NetBSD, where these tools
> additionally require -lrt for shm_open(3). In future there should be
> added support for NetBSD and the linking addressed appropriately.

Is this a v2 patch? If so, it's best to repost it as a new top-level
thread rather than buried in reply to your v1 patch.  Also, be sure to
include v2 in the subject line ('git send-email -v2' works wonders for
that).

>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---

It also helps in a v2 submission to list here, after the --- separator,
how it differs from v1.

More submission hints at http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cVKH9V8iW4vKqMREltqLeLpLaEjH0HWnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLWs2AAoJEKeha0olJ0NqXqsH/2/Gda1a6q27zDUgb1BUtSp3
QITDoF/iD9npLJLTfnQA19EIJJLGOyNp0+sHwL2pJdY27S0KrqVGQUt/T4TazTcw
YmVXbQewGkLWt5Kk5Ey3GgB8Ql1CIiGHYnDCqv+iiEMCPe3/aQUjkqfHxD7HiEty
SdJl5avlikQVFqG72gmX9GS80cXwOjniMi9T7Ld9AvEyZUz5BrwgQDlS3AxgIyrT
km7jdpD2HjOa6Kt3xv8bKLk2TXIa6NAwL/SZL46LN2dyM+bIyQyQcEzl6jBM/Itx
/pHyIFF0LyQI8C+HBA94IgD+S8XKSAV7S2SWHXbCEOwCq/LfRQgBa80pnnGEHeA=
=5bPR
-----END PGP SIGNATURE-----

--cVKH9V8iW4vKqMREltqLeLpLaEjH0HWnC--
