Received: from eggs.gnu.org ([2001:4830:134:3::10]:42587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKc7-0006BS-0m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKc2-0001jJ-CN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpKc2-0001j2-2w
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:38:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28738A9646
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 20:38:21 +0000 (UTC)
References: <20170901153758.8628-1-armbru@redhat.com>
	<20170901153758.8628-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c233ab0-b316-2cc0-ef6c-a9dc562ea5f0@redhat.com>
Date: Tue, 5 Sep 2017 15:38:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170901153758.8628-14-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DQgdqGiOb6q3NjJDs90gQanmiJQ12mNhu"
Subject: Re: [Qemu-devel] [PULL v2 13/47] tests/check-qlit: New,
 covering qobject/qlit.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DQgdqGiOb6q3NjJDs90gQanmiJQ12mNhu
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <7c233ab0-b316-2cc0-ef6c-a9dc562ea5f0@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 13/47] tests/check-qlit: New, covering
 qobject/qlit.c
References: <20170901153758.8628-1-armbru@redhat.com>
 <20170901153758.8628-14-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 10:37 AM, Markus Armbruster wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20170825105913.4060-11-marcandre.lureau@redhat.com>
> [Copyright notice correction squashed in, commit message tweaked]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/Makefile.include |  5 +++-
>  tests/check-qlit.c     | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 tests/check-qlit.c

Adds a new file that is not covered by tests/.gitignore when doing an
in-tree build (and is one of our few check-* names that stands out in
comparison to the bulk of the tests named test-* or *-test).

Of course, the point may be moot if we take the patch for
auto-generating tests/.gitignore on an in-tree build...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DQgdqGiOb6q3NjJDs90gQanmiJQ12mNhu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvCzcACgkQp6FrSiUn
Q2rjpgf/fSVLP4G9RBheUGN9Jo2z1pXdF1ty/cx1XZlCLB4u5BfuLcA+b+Q0DpcZ
mEtdyvhIyUamZpJeJ9zLnzeB8wYuaVKOxXYVtt3Nx8XNT/ldF/O4mIsEC+rRW4Gy
WzjNdEk0AU656OjmUyeKj2De5DZrdb77Ic/jatUizPhV+KSTM2few8tl1F/PnM6g
9bDtcIA38Qlo5YfFyN/a9XzATgCTzwaRqZHDT9ylrnjd/LCCZTk3+Mz5vxPLF6XF
+sZukHMQrcCB0vLoc7pmahETaPELfV0gaMkAOGE3F+HkwtzTwrEKGgFQVYbrrPNN
5WZgPQxAbNIqGug4EcMq0J7nLRrfGw==
=zExE
-----END PGP SIGNATURE-----

--DQgdqGiOb6q3NjJDs90gQanmiJQ12mNhu--
